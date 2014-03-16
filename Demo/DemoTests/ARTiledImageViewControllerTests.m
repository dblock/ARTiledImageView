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
    // https://artsy.net/artwork/francisco-jose-de-goya-y-lucientes-senora-sabasa-garcia
    // (Courtesy National Gallery of Art, Washington)
    vc.tilesURL = [NSURL URLWithString:@"https://raw.github.com/dblock/ARTiledImageView/master/Demo/Tiles/SenoraSabasaGarcia"];
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
        expect(vc.view).to.haveValidSnapshotNamed(@"default");
        done();
    });
});

SpecEnd

