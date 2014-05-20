//
//  ARTiledImageViewTests.m
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 3/15/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARTiledImageDemoViewController.h"

SpecBegin(ARTiledImageDemoViewController)

__block ARTiledImageDemoViewController *vc = nil;

describe(@"remote", ^{
    beforeEach(^{
        UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        vc = [[ARTiledImageDemoViewController alloc] init];
        // https://artsy.net/artwork/francisco-jose-de-goya-y-lucientes-senora-sabasa-garcia
        // (Courtesy National Gallery of Art, Washington)
        vc.tilesURL = [NSURL URLWithString:@"https://raw.github.com/dblock/ARTiledImageView/master/Tiles/SenoraSabasaGarcia"];
        vc.tiledSize = CGSizeMake(2383, 2933);
        vc.minTileLevel = 11;
        vc.maxTileLevel = 12;
        window.rootViewController = vc;
        expect(vc.view).willNot.beNil();
        [window makeKeyAndVisible];
    });
    
    it(@"displays map", ^AsyncBlock {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long) NULL), ^(void) {
            [NSThread sleepForTimeInterval:3.0];
            expect(vc.view).to.haveValidSnapshotNamed(@"remote");
            expect(vc.scrollView.tileZoomLevel).to.equal(11);
            done();
        });
    });
});

describe(@"local", ^{
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
    
    it(@"displays map", ^AsyncBlock {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long) NULL), ^(void) {
            [NSThread sleepForTimeInterval:2.0];
            expect(vc.view).to.haveValidSnapshotNamed(@"local");
            done();
        });
    });
});


SpecEnd

