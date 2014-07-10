//
//  ARTiledImageScrollViewSpec.m
//  Demo
//
//  Created by Orta on 10/07/2014.
//  Copyright 2014 Artsy. All rights reserved.
//


#import <ARTiledImageView/ARLocalTiledImageDataSource.h>
#import <ARTiledImageView/ARTiledImageScrollView.h>
#import "ARTiledImageDemoViewController.h"

SpecBegin(ARTiledImageScrollView)

__block ARLocalTiledImageDataSource *dataSource;
__block CGRect frame;

before(^{
    dataSource = [[ARLocalTiledImageDataSource alloc] init];
    NSString *tiles = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Tiles/SenoraSabasaGarcia"];
    dataSource.tileBasePath = [tiles stringByAppendingPathComponent:@"tiles"];
    dataSource.maxTiledHeight = 2933;
    dataSource.maxTiledWidth = 2383;
    dataSource.minTileLevel = 11;
    dataSource.maxTileLevel = 12;
    dataSource.tileSize = 512;
    dataSource.tileFormat = @"jpg";

    frame = CGRectMake(0, 0, 320, 480);
});

__block ARTiledImageDemoViewController *vc = nil;

describe(@"centered zooming", ^{
    beforeEach(^{
        UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        vc = [[ARTiledImageDemoViewController alloc] init];
        vc.tilesPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Tiles/Armory2014"];
        vc.tiledSize = CGSizeMake(5000, 5389);
        vc.minTileLevel = 11;
        vc.maxTileLevel = 13;
        window.rootViewController = vc;
        expect(vc.view).willNot.beNil();
        [window makeKeyAndVisible];
    });

    it(@"centers by default", ^AsyncBlock {
        [vc.scrollView setMinimumZoomScale:0.01];
        [vc.scrollView setZoomScale:0.2 animated:NO];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long) NULL), ^(void) {
            [NSThread sleepForTimeInterval:2.0];
            expect(vc.view).to.recordSnapshotNamed(@"centered-zooming-displays-map");
            done();
        });
    });

    it(@"centers by to the top if needed", ^AsyncBlock {
        [vc.scrollView setMinimumZoomScale:0.01];
        [vc.scrollView setCenterOnZoomOut:NO];
        [vc.scrollView setZoomScale:0.2 animated:NO];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long) NULL), ^(void) {
            [NSThread sleepForTimeInterval:2.0];
            expect(vc.view).to.recordSnapshotNamed(@"top-aligned-zooming-displays-map");
            done();
        });
    });

});

SpecEnd
