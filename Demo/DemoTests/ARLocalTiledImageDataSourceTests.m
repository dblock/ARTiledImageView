//
//  ARLocalTiledImageDataSourceTests.m
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 3/15/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARLocalTiledImageDataSource.h"

SpecBegin(ARLocalTiledImageDataSourceTests)

__block ARLocalTiledImageDataSource *ds = nil;

beforeEach(^{
    ds = [[ARLocalTiledImageDataSource alloc] init];
    ds.maxTiledHeight = 5389;
    ds.maxTiledWidth = 5000;
    ds.minTileLevel = 11;
    ds.maxTileLevel = 13;
    ds.tileSize = 512;
    ds.tileFormat = @"jpg";
    ds.tileBasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Tiles/Armory2014/tiles"];
});

it(@"tiledImageView:imageTileForLevel:level:x:y:", ^{
    // tile level doesn't exist
    expect([ds tiledImageView:nil imageTileForLevel:5 x:1 y:2]).to.beNil();
    // tile level exists
    expect([ds tiledImageView:nil imageTileForLevel:12 x:1 y:2]).to.beKindOf([UIImage class]);
});

it(@"imageSizeForImageView:", ^{
    expect([ds imageSizeForImageView:nil]).to.equal(CGSizeMake(5000, 5389));
});

it(@"tileSizeForImageView:", ^{
    expect([ds tileSizeForImageView:nil]).to.equal(CGSizeMake(512, 512));
});

it(@"minimumImageZoomLevelForImageView:", ^{
    expect([ds minimumImageZoomLevelForImageView:nil]).to.equal(11);
});

it(@"maximumImageZoomLevelForImageView:", ^{
    expect([ds maximumImageZoomLevelForImageView:nil]).to.equal(13);
});

SpecEnd
