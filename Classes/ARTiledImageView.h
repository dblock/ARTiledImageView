//
//  ARTiledImageView.h
//  ARTiledImage
//
//  Created by Orta Therox on 2014/01/30.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARTiledImageViewDataSource.h"

/**
 *  A tiled image view.
 */
@interface ARTiledImageView : UIView

// Initialize with a data source.
- (id)initWithDataSource:(NSObject <ARTiledImageViewDataSource> *)dataSource;
// Cancel any pending tile downloads.
- (void)cancelConcurrentDownloads;

// Tiled images data source.
@property (readonly, nonatomic) NSObject <ARTiledImageViewDataSource> *dataSource;
// Display tiled borders for debugging.
@property (readwrite, nonatomic, assign) BOOL displayTileBorders;
// Current image zoom level.
@property (readonly, nonatomic) NSInteger currentZoomLevel;


@end
