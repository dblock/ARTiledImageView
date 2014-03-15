//
//  ARTiledImageScrollView.h
//  ARTiledImage
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARTiledImageViewDataSource.h"

@interface ARTiledImageScrollView : UIScrollView<UIScrollViewDelegate>

// Calculate the point on the screen from a point on the original image at the current zoom level.
-(CGPoint)zoomRelativePoint:(CGPoint)point;
// Center map on a given point.
-(void)centerOnPoint:(CGPoint)point animated:(BOOL)animate;
// Zoom the view to fit the current display.
- (void)zoomToFit:(BOOL)animate;

@property (readwrite, nonatomic) NSObject<ARTiledImageViewDataSource> *dataSource;
// Display tile borders, usually for debugging purposes.
@property (readwrite, nonatomic, assign) BOOL displayTileBorders;
// Set a background image, displayed while tiles are being downloaded.
@property (readwrite, nonatomic) NSURL *backgroundImageURL;
// Current map zoom level.
@property (nonatomic, readonly) CGFloat zoomLevel;
// Point on which to center the map by default.
@property (nonatomic, assign) CGPoint centerPoint;
// Size of the view, typically the full size of the background image.
@property (nonatomic, assign) CGSize originalSize;
// Amount by which to zoom in or zoom out with every double-tap, default is 1.5f.
@property (nonatomic, assign) CGFloat zoomStep;
@end
