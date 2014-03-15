//
//  ARWebTiledImageDataSourceTests.m
//  ARTiledImage
//
//  Created by Daniel Doubrovkine on 3/15/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARWebTiledImageDataSource.h"

SpecBegin(ARWebTiledImageDataSourceTests)

__block ARWebTiledImageDataSource *ds = nil;

beforeEach(^{
    ds = [[ARWebTiledImageDataSource alloc] init];
    ds.maxTiledHeight = 5389;
    ds.maxTiledWidth = 5000;
    ds.minTileLevel = 11;
    ds.maxTileLevel = 13;
    ds.tileSize = 512;
    ds.tileFormat = @"jpg";
    ds.tileBaseURL = [NSURL URLWithString:@"https://example.com/tiles"];
});

it(@"tiledImageView:urlForImageTileAtLevel:level:x:y:", ^{
    expect([ds tiledImageView:nil urlForImageTileAtLevel:1 x:2 y:3]).to.equal([NSURL URLWithString:@"https://example.com/tiles/1/2_3.jpg"]);
});

pending(@"tiledImageView:imageTileForLevel:level:x:y:", ^{

});

pending(@"didDownloadTiledImage:atURL:", ^{
    
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
