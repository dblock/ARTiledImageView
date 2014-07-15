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

__block ARTiledImageDemoViewController *vc = nil;

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

describe(@"centered zooming", ^{

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

describe(@"fits", ^{

    it(@"fills vertically by default", ^AsyncBlock {
        [vc.scrollView zoomToFit:NO];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long) NULL), ^(void) {
            [NSThread sleepForTimeInterval:2.0];
            expect(vc.view).to.recordSnapshotNamed(@"fills vertically by default");
            done();
        });
    });

    it(@"fills horizontally if set to UIViewContentModeScaleAspectFit", ^AsyncBlock {
        vc.scrollView.contentMode = UIViewContentModeScaleAspectFit;
        [vc.scrollView setMaxMinZoomScalesForCurrentBounds];
        [vc.scrollView zoomToFit:NO];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long) NULL), ^(void) {
            [NSThread sleepForTimeInterval:2.0];
            expect(vc.view).to.recordSnapshotNamed(@"fills horizontally by default changing contentMode");
            done();
        });
    });
    
});


SpecEnd
