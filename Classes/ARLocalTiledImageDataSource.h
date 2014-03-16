//
//  ARLocalTiledImageDataSource.h
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARTiledImageViewDataSource.h"

/**
 *  An implementation of the ARTiledImageViewDataSource protocol that supports retrieving tiles from local storage.
 */
@interface ARLocalTiledImageDataSource : NSObject <ARTiledImageViewDataSource>

/// Maximum height of the tiled image.
@property (nonatomic) NSInteger maxTiledHeight;
/// Maximum width of the tiled image.
@property (nonatomic) NSInteger maxTiledWidth;

/// Maximum tile width or height. Tiles are square except on edges.
@property (nonatomic) NSInteger tileSize;
/// The path from which to retrieve tiles.
@property (nonatomic, copy) NSString *tileBasePath;
/// Tile format, eg. "jpg".
@property (nonatomic, copy) NSString *tileFormat;

/// Maximum tile level.
@property (nonatomic) NSInteger maxTileLevel;
/// Minimum tile level.
@property (nonatomic) NSInteger minTileLevel;

@end
