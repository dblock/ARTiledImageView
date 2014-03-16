//
//  ARTiledImageViewController.h
//  ARTiledImage
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARTiledImageDemoViewController : UIViewController

@property(nonatomic, assign) BOOL displayTileBorders;
@property(nonatomic, readwrite) NSURL *tilesURL;
@property(nonatomic, readwrite) CGSize tiledSize;
@property(nonatomic, readwrite) NSInteger minTileLevel;
@property(nonatomic, readwrite) NSInteger maxTileLevel;

@end
