//
//  ARTiledImageViewView.h
//  ARTiledImageView
//
//  Created by Orta Therox on 2014/01/30.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARTiledImageViewDataSource.h"

/**
 *  A tiled image view for going inside UIScrollViews
 *  pulling in images asynchronously or from local caches.
 */

@interface ARTiledImageView : UIView

- (id)initWithFrame:(CGRect)frame __attribute__((unavailable("Please use initWithDataSource:")));

/// Initialize with a data source.
- (id)initWithDataSource:(NSObject <ARTiledImageViewDataSource> *)dataSource;

/// Cancel any pending tile downloads.
- (void)cancelConcurrentDownloads;

/// Tiled image data source.
@property (readonly, nonatomic, weak) NSObject <ARTiledImageViewDataSource> *dataSource;

/// Display tiled borders for debugging.
@property (readwrite, nonatomic, assign) BOOL displayTileBorders;

/// Current image zoom level based on the DeepZoom algorithm.
@property (readonly, nonatomic, assign) NSInteger currentZoomLevel;


@end
