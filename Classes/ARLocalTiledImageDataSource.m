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

- (UIImage *)tiledImageView:(ARTiledImageView *)imageView imageTileForLevel:(NSInteger)level x:(NSInteger)x y:(NSInteger)y
{
    NSString *filename = [NSString stringWithFormat:@"%@/%@/%@_%@.%@", self.tileBasePath, @(level), @(x), @(y), self.tileFormat];
    return [UIImage imageWithContentsOfFile:filename];
}


- (CGSize)imageSizeForImageView:(ARTiledImageView *)imageView
{
    return CGSizeMake(self.maxTiledWidth, self.maxTiledHeight);
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
    return self.maxTileLevel;
}

@end
