//
//  ARTiledImageViewTests.m
//  Demo
//
//  Created by Ash Furrow on 2014-08-14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import <ARTiledImageView/ARTiledImageView.h>
#import <ARTiledImageView/ARLocalTiledImageDataSource.h>

SpecBegin(ARTiledImageView)

__block ARLocalTiledImageDataSource *ds = nil;

beforeEach(^{
    ds = [[ARLocalTiledImageDataSource alloc] init];
    ds.maxTiledHeight = 400;
    ds.maxTiledWidth = 500;
});

it(@"ensures a minimum image size", ^{
    CGSize minimumSize = CGSizeMake(600, 700);
    ARTiledImageView *imageView = [[ARTiledImageView alloc] initWithDataSource:ds minimumSize:minimumSize];
    expect(imageView.frame.size).to.equal(minimumSize);
});

SpecEnd
