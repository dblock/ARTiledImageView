//
//  ARTiledImageViewScrollView.h
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARTiledImageViewDataSource.h"

@interface ARTiledImageScrollView : UIScrollView <UIScrollViewDelegate>

/// Current tile zoom level.
@property (nonatomic, readonly, assign) NSInteger tileZoomLevel;

/// Convert a point at full zoom scale to the same one at the current zoom scale.
- (CGPoint)zoomRelativePoint:(CGPoint)point;

/// Center image on a given point.
- (void)centerOnPoint:(CGPoint)point animated:(BOOL)animate;

/// Zoom the image to fit the current display.
- (void)zoomToFit:(BOOL)animate;

/// Callback for when the tile zoom level has changed.
- (void)tileZoomLevelDidChange;

/// The data source for image.
@property (readwrite, nonatomic, weak) NSObject <ARTiledImageViewDataSource> *dataSource;

/// Display tile borders, usually for debugging purposes.
@property (readwrite, nonatomic, assign) BOOL displayTileBorders;

/// Set a background image, displayed while tiles are being downloaded.
@property (readwrite, nonatomic) NSURL *backgroundImageURL;

/// Set a background image, displayed while tiles are being downloaded.
@property (readwrite, nonatomic) UIImage *backgroundImage;

/// Point on which to center the map by default, removed when panned.
@property (nonatomic, assign) CGPoint centerPoint;

/// Size of the view, typically the full size of the background image.
@property (nonatomic, assign) CGSize originalSize;

/// Amount by which to zoom in or zoom out with every double-tap, default is 1.5f.
@property (nonatomic, assign) CGFloat zoomStep;

@end
