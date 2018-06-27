//
//  ARTiledImageViewViewController.h
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

@class ARTiledImageScrollView;

@interface ARTiledImageDemoViewController : UIViewController

@property (readwrite, nonatomic, strong) NSURL *tilesURL;
@property (readwrite, nonatomic, copy) NSString *tilesPath;

@property (readwrite, nonatomic, assign) BOOL displayTileBorders;
@property (readwrite, nonatomic, assign) CGSize tiledSize;
@property (readwrite, nonatomic, assign) NSInteger minTileLevel;
@property (readwrite, nonatomic, assign) NSInteger maxTileLevel;

@property (nonatomic, readonly) ARTiledImageScrollView *scrollView;

@end
