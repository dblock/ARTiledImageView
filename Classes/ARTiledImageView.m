//
//  ARTiledImageViewView.m
//  ARTiledImageView
//
//  Created by Orta Therox on 2014/01/29.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARTiledImageView.h"
#import "ARTile.h"
#import <QuartzCore/CATiledLayer.h>
#import <SDWebImage/UIImageView+WebCache.h>

// ARTiledImageView responds to rectangle repaint, figures out which tile
// to download from that rectangle and downloads tiles asynchronously.
// It will cache images in SDWebCache and optionally store images locally.

@interface ARTiledImageView ()
@property (nonatomic, assign) NSInteger maxLevelOfDetail;
@property (atomic, strong, readonly) NSCache *tileCache;
@property (atomic, readonly) NSMutableDictionary *downloadOperations;
@end

@implementation ARTiledImageView

- (id)initWithDataSource:(NSObject <ARTiledImageViewDataSource> *)dataSource;
{
    self = [super init];
    if (!self) return nil;

    self.backgroundColor = [UIColor clearColor];
    _dataSource = dataSource;

    CATiledLayer *layer = (id) [self layer];
    layer.tileSize = [_dataSource tileSizeForImageView:self];

    NSInteger min = [_dataSource minimumImageZoomLevelForImageView:self];
    NSInteger max = [_dataSource maximumImageZoomLevelForImageView:self];
    layer.levelsOfDetail = max - min + 1;

    self.maxLevelOfDetail = max;

    CGSize imagesize = [dataSource imageSizeForImageView:self];
    self.frame = CGRectMake(0, 0, imagesize.width, imagesize.height);

    _tileCache = [[NSCache alloc] init];
    _downloadOperations = [[NSMutableDictionary alloc] init];

    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    //
    // See http://openradar.appspot.com/8503490
    // Get the scale from the context by getting the current transform matrix, then asking for its "a" component, which is one of the two scale components.
    // We need to also ask for the "d" component as it might not be precisely the same as the "a" component, even at the "same" scale.
    //

    CGFloat _scaleX = CGContextGetCTM(context).a;
    CGFloat _scaleY = CGContextGetCTM(context).d;

    CATiledLayer *tiledLayer = (CATiledLayer *) [self layer];
    CGSize tileSize = tiledLayer.tileSize;

    //
    // Even at scales lower than 100%, we are drawing into a rect in the coordinate system of the full
    // image. One tile at 50% covers the width (in original image coordinates) of two tiles at 100%.
    // So at 50% we need to stretch our tiles to double the width and height; at 25% we need to stretch
    // them to quadruple the width and height; and so on.
    //
    // (Note that this means that we are drawing very blurry images as the scale gets low. At 12.5%,
    // our lowest scale, we are stretching about 6 small tiles to fill the entire original image area.
    // But this is okay, because the big blurry image we're drawing here will be scaled way down before
    // it is displayed.)
    //

    tileSize.width /= _scaleX;
    tileSize.height /= -_scaleY;

    NSInteger firstCol = floor(CGRectGetMinX(rect) / tileSize.width);
    NSInteger lastCol = floor((CGRectGetMaxX(rect) - 1) / tileSize.width);
    NSInteger firstRow = floorf(CGRectGetMinY(rect) / tileSize.height);
    NSInteger lastRow = floorf((CGRectGetMaxY(rect) - 1) / tileSize.height);

    NSInteger level = self.maxLevelOfDetail + roundf(log2f(_scaleX));
    _currentZoomLevel = level;

    BOOL isRemote = [self.dataSource respondsToSelector:@selector(tiledImageView:urlForImageTileAtLevel:x:y:)];
    NSMutableDictionary *requestURLs = isRemote ? [NSMutableDictionary dictionary] : nil;
    
    for (NSInteger row = firstRow; row <= lastRow; row++) {
        for (NSInteger col = firstCol; col <= lastCol; col++) {

            CGRect tileRect = CGRectMake(tileSize.width * col, tileSize.height * row, tileSize.width, tileSize.height);
            UIImage *tileImage = [self.dataSource tiledImageView:self imageTileForLevel:level x:col y:row];

            NSString *tileCacheKey = [NSString stringWithFormat:@"%@/%@_%@", @(level), @(col), @(row)];
            ARTile *tile = [self.tileCache objectForKey:tileCacheKey];
            if (!tile) {
                tileRect = CGRectIntersection(self.bounds, tileRect);
                tile = [[ARTile alloc] initWithImage:tileImage rect:tileRect];
                [self.tileCache setObject:tile forKey:tileCacheKey cost:level];
            }

            if (!tile.tileImage && tileImage) {
                tile.tileImage = tileImage;
            }

            if (!tile.tileImage) {
                if (isRemote) {
                    NSURL *tileURL = [self.dataSource tiledImageView:self urlForImageTileAtLevel:level x:col y:row];
                    [requestURLs setValue:tileURL forKey:tileCacheKey];
                }
            } else {
                [tile drawInRect:tile.tileRect blendMode:kCGBlendModeNormal alpha:1];
                if (self.displayTileBorders) {
                    [[UIColor greenColor] set];
                    CGContextSetLineWidth(context, 6.0);
                    CGContextStrokeRect(context, tileRect);
                }
            }
        }
    }

    if (requestURLs.count) {
        [self downloadAndRedrawTilesWithURLs:requestURLs];
    }
}


+ (Class)layerClass
{
    return [CATiledLayer class];
}


- (void)setContentScaleFactor:(CGFloat)contentScaleFactor
{
    // Make retina perform as expected
    [super setContentScaleFactor:1.f];
}


- (void)downloadAndRedrawTilesWithURLs:(NSDictionary *)urls
{
    __weak typeof (self) wself = self;

    for (NSString *tileCacheKey in urls.keyEnumerator) {
        NSURL *tileURL = [urls objectForKey:tileCacheKey];
        
        @synchronized (self.downloadOperations) {
            if ([self.downloadOperations objectForKey:tileCacheKey]) {
                continue;
            }
        }

        id <SDWebImageOperation> operation = nil;
        operation = [SDWebImageManager.sharedManager downloadWithURL:tileURL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
            if (!wself || !finished) {
                return;
            }

            if (error) {
                // TODO: we want to mke sure this doesn't happen multiple times
                [wself performSelector:_cmd withObject:urls afterDelay:1];
                return;
            }

            void (^block)(void) = ^{
                __strong typeof (wself) sself = wself;
                if (!sself) {
                    return;
                }

                if (image) {
                    ARTile *tile = [sself.tileCache objectForKey:tileCacheKey];
                    if (!tile) {
                        return;
                    }

                    tile.tileImage = image;
                    [sself setNeedsDisplayInRect:tile.tileRect];

                    // Overwrite the existing object in cache now that we have a real cost
                    NSInteger cost = image.size.height * image.size.width * image.scale;
                    [sself.tileCache setObject:tile forKey:tileCacheKey cost:cost];

                    if ([sself.dataSource respondsToSelector:@selector(tiledImageView:didDownloadTiledImage:atURL:)]) {
                        [sself.dataSource tiledImageView:self didDownloadTiledImage:image atURL:tileURL];
                    }
                }

                @synchronized (sself.downloadOperations) {
                    [sself.downloadOperations removeObjectForKey:tileCacheKey];
                }
            };

            if ([NSThread isMainThread]) {
                block();
            } else {
                dispatch_sync(dispatch_get_main_queue(), block);
            }
        }];

        @synchronized (self.downloadOperations) {
            [self.downloadOperations setObject:operation forKey:tileCacheKey];
        }
    }
}

- (void)dealloc
{
    [self cancelConcurrentDownloads];
    [_tileCache removeAllObjects];
}


- (void)cancelConcurrentDownloads
{
    @synchronized (self.downloadOperations) {
        for (id <SDWebImageOperation> operation in self.downloadOperations.objectEnumerator) {
            if (operation) {
                [operation cancel];
            }
        }

        [self.downloadOperations removeAllObjects];
    }
}

@end
