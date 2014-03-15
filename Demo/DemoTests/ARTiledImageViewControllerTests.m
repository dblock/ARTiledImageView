//
//  ARTiledImageTests.m
//  ARTiledImage
//
//  Created by Daniel Doubrovkine on 3/15/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARTiledImageDemoViewController.h"

SpecBegin(ARTiledImageDemoViewController)

beforeAll(^{
    setGlobalReferenceImageDir(FB_REFERENCE_IMAGE_DIR);
});

__block ARTiledImageDemoViewController *vc = nil;

beforeEach(^{
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    vc = [[ARTiledImageDemoViewController alloc] init];
    window.rootViewController = vc;
    expect(vc.view).willNot.beNil();
    [window makeKeyAndVisible];
});

it(@"displays map", ^AsyncBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long) NULL), ^(void) {
        [NSThread sleepForTimeInterval:3.0];
        expect(vc.view).to.haveValidSnapshotNamed(@"default");
        done();
    });
});

SpecEnd

