//
//  ARTiledImageViewScrollView.m
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARTiledImageScrollView.h"
#import "ARTiledImageView.h"
#import "ARTiledImageViewDataSource.h"
#import <SDWebImage/UIImageView+WebCache.h>

const CGFloat ARTiledImageScrollViewDefaultZoomStep = 1.5;

@implementation ARTiledImageScrollView

- (void)setDataSource:(NSObject <ARTiledImageViewDataSource> *)dataSource
{
    _dataSource = dataSource;
    [self setup];
}


- (void)setZoomScale:(CGFloat)zoomScale
{
    [super setZoomScale:zoomScale];
}

- (void)setup
{
    ARTiledImageView *tiledImageView = [[ARTiledImageView alloc] initWithDataSource:self.dataSource];

    ARImageBackedTiledView *imageBackedTileView = [[ARImageBackedTiledView alloc] initWithTiledImageView:tiledImageView];
    [self addSubview:imageBackedTileView];
    _imageBackedTiledImageView = imageBackedTileView;

    [self setMaxMinZoomScalesForCurrentBounds];

    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.delegate = self;
    self.centerOnZoomOut = YES;

    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self addGestureRecognizer:doubleTap];
    _doubleTapGesture = doubleTap;

    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    [twoFingerTap setNumberOfTouchesRequired:2];
    [self addGestureRecognizer:twoFingerTap];
    _twoFingerTapGesture = twoFingerTap;

    [self.panGestureRecognizer addTarget:self action:@selector(mapPanGestureHandler:)];
}


- (void)setDisplayTileBorders:(BOOL)displayTileBorders
{
    self.tiledImageView.displayTileBorders = displayTileBorders;
    _displayTileBorders = displayTileBorders;
}


- (void)setMaxMinZoomScalesForBounds:(CGRect)bounds
{
    CGSize boundsSize = bounds.size;
    CGSize imageSize = [self.dataSource imageSizeForImageView:nil];

    // Calculate min/max zoomscale.
    CGFloat xScale = boundsSize.width / imageSize.width; // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height; // the scale needed to perfectly fit the image height-wise

    CGFloat minScale = 0;
    if (self.contentMode == UIViewContentModeScaleAspectFit) {
        minScale = MIN(xScale, yScale);
    } else {
        minScale = MAX(xScale, yScale);
    }

    CGFloat maxScale = 1.0;

    // Don't let minScale exceed maxScale.
    // If the image is smaller than the screen, we don't want to force it to be zoomed.
    if (minScale > maxScale) {
        minScale = maxScale;
    }

    self.maximumZoomScale = maxScale * 0.6;
    self.minimumZoomScale = minScale;

    self.originalSize = imageSize;
    self.contentSize = boundsSize;
}


- (void)zoomToFit:(BOOL)animate
{
    [self setZoomScale:self.minimumZoomScale animated:animate];
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (self.tileZoomLevel != self.tiledImageView.currentZoomLevel) {
        _tileZoomLevel = self.tiledImageView.currentZoomLevel;
        [self tileZoomLevelDidChange];
    }

    [self centerContent];
}


- (void)tileZoomLevelDidChange
{

}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    BOOL zoomedOut = self.zoomScale == self.minimumZoomScale;
    if (!CGPointEqualToPoint(self.centerPoint, CGPointZero) && !zoomedOut) {
        [self centerOnPoint:self.centerPoint animated:NO];
    }
    [self centerContent];
}


- (void)setBackgroundImageURL:(NSURL *)backgroundImageURL
{
    [self.backgroundImageView setImageWithURL:backgroundImageURL];
    _backgroundImageURL = backgroundImageURL;
}


- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    [self.backgroundImageView setImage:backgroundImage];
    _backgroundImage = backgroundImage;
}


- (void)mapPanGestureHandler:(UIPanGestureRecognizer *)panGesture
{
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        _centerPoint = CGPointZero;
    }
}


- (void)centerOnPoint:(CGPoint)point animated:(BOOL)animate
{
    CGFloat x = (point.x * self.zoomScale) - (self.frame.size.width / 2.0f);
    CGFloat y = (point.y * self.zoomScale) - (self.frame.size.height / 2.0f);
    [self setContentOffset:CGPointMake(round(x), round(y)) animated:animate];
    _centerPoint = point;
}


- (CGPoint)zoomRelativePoint:(CGPoint)point
{
    CGFloat x = (self.contentSize.width / self.originalSize.width) * point.x;
    CGFloat y = (self.contentSize.height / self.originalSize.height) * point.y;
    return CGPointMake(round(x), round(y));
}


#pragma mark - Orientation

- (void)centerContent {
    if (!self.centerOnZoomOut) { return; }

    CGFloat top = 0, left = 0;
    if (self.contentSize.width < self.bounds.size.width) {
        left = (self.bounds.size.width-self.contentSize.width) * 0.5f;
    }
    if (self.contentSize.height < self.bounds.size.height) {
        top = (self.bounds.size.height-self.contentSize.height) * 0.5f;
    }
    self.contentInset = UIEdgeInsetsMake(top, left, top, left);
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageBackedTiledImageView;
}


- (CGFloat)zoomLevel
{
    return self.zoomScale / self.maximumZoomScale;
}


#pragma mark - Tap to Zoom

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer
{
    // Double tap zooms in, but returns to normal zoom level if it reaches max zoom.
    if (self.zoomScale >= self.maximumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else {
        // The location tapped becomes the new center
        CGPoint tapCenter = [gestureRecognizer locationInView:self.tiledImageView];
        CGFloat newScale = MIN(self.zoomScale * (self.zoomStep ? : ARTiledImageScrollViewDefaultZoomStep), self.maximumZoomScale);
        CGRect maxZoomRect = [self rectAroundPoint:tapCenter atZoomScale:newScale];
        [self zoomToRect:maxZoomRect animated:YES];
    }
}


- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer
{
    // Two-finger tap zooms out, but returns to normal zoom level if it reaches min zoom.
    CGFloat newScale = self.zoomScale <= self.minimumZoomScale ? self.maximumZoomScale : self.zoomScale / (self.zoomStep ? : ARTiledImageScrollViewDefaultZoomStep);
    [self setZoomScale:newScale animated:YES];
}


- (CGRect)rectAroundPoint:(CGPoint)point atZoomScale:(CGFloat)zoomScale
{
    // Define the shape of the zoom rect.
    CGSize boundsSize = self.bounds.size;

    // Modify the size according to the requested zoom level.
    // For example, if we're zooming in to 0.5 zoom, then this will increase the bounds size by a factor of two.
    CGSize scaledBoundsSize = CGSizeMake(boundsSize.width / zoomScale, boundsSize.height / zoomScale);

    return CGRectMake(point.x - scaledBoundsSize.width / 2,
            point.y - scaledBoundsSize.height / 2,
            scaledBoundsSize.width,
            scaledBoundsSize.height);
}


- (ARTiledImageView *)tiledImageView
{
    return self.imageBackedTiledImageView.tiledImageView;
}


- (UIImageView *)backgroundImageView
{
    return self.imageBackedTiledImageView.imageView;
}


@end
