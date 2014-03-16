//
//  ARMasterViewControllerTests.m
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 3/15/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARMasterViewController.h"

SpecBegin(ARMasterViewController)

beforeAll(^{
    setGlobalReferenceImageDir(FB_REFERENCE_IMAGE_DIR);
});

it(@"displays the master menu", ^{
    ARMasterViewController *vc = [[ARMasterViewController alloc] initWithNibName:@"ARMasterViewController" bundle:nil];
    expect(vc.view).willNot.beNil();
    expect(vc.view).to.haveValidSnapshotNamed(@"default");
});

SpecEnd
