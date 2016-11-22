//
//  ARLocalTiledImageDataSource.m
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARLocalTiledImageDataSource.h"
#import "ARTiledImageView.h"

@implementation ARLocalTiledImageDataSource

- (id)init
{
    self = [super init];
    if (self) {
        _extralVisualLevel = 1;
    }
    return self;
}

- (UIImage *)tiledImageView:(ARTiledImageView *)imageView imageTileForLevel:(NSInteger)level x:(NSInteger)x y:(NSInteger)y
{
#define _PATH(_LEV, X, Y)   [NSString stringWithFormat:@"%@/%@/%@_%@.%@", self.tileBasePath, @(_LEV), @(X), @(Y), self.tileFormat];
    
    if (level <= self.maxTileLevel) {
        NSString *filename = _PATH(level, x, y);
        return [UIImage imageWithContentsOfFile:filename];
    }
    
    NSInteger gap = level - _maxTileLevel;
    NSInteger glen = _tileSize >> gap;
    NSInteger nm = 1<<gap;
    NSInteger xoff=(x%nm)*glen, yoff=(y%nm)*glen;
    
    NSString *filename = _PATH(_maxTileLevel, (x>>gap), (y>>gap));
    UIImage *oImg = [UIImage imageWithContentsOfFile:filename];
    
    CGImageRef imgRef = CGImageCreateWithImageInRect(oImg.CGImage, (CGRect){xoff, yoff, glen, glen});
    oImg = [[UIImage alloc] initWithCGImage:imgRef];
    CGImageRelease(imgRef);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(_tileSize, _tileSize), YES, 1.);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    [oImg drawInRect:CGRectMake(0,0,_tileSize,_tileSize)];
    UIImage *nImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return nImg;
#undef _PATH
}


- (CGSize)imageSizeForImageView:(ARTiledImageView *)imageView
{
    return CGSizeMake(self.maxTiledWidth<<_extralVisualLevel, self.maxTiledHeight<<_extralVisualLevel);
}


- (CGSize)tileSizeForImageView:(ARTiledImageView *)imageView
{
    return CGSizeMake(self.tileSize, self.tileSize);
}


- (NSInteger)minimumImageZoomLevelForImageView:(ARTiledImageView *)imageView
{
    return self.minTileLevel;
}


- (NSInteger)maximumImageZoomLevelForImageView:(ARTiledImageView *)imageView
{
    return self.maxTileLevel + _extralVisualLevel;
}

- (void)setExtralVisualLevel:(NSInteger)extralVisualLevel {
    _extralVisualLevel = extralVisualLevel;
}

@end
