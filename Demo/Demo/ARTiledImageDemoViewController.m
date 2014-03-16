//
//  ARTiledImageViewViewController.m
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARTiledImageDemoViewController.h"
#import "ARTiledImageScrollView.h"
#import "ARWebTiledImageDataSource.h"

@interface ARTiledImageDemoViewController ()
@property (nonatomic, readonly) ARTiledImageScrollView *imageScrollView;
@end

@implementation ARTiledImageDemoViewController

- (void)setDisplayTileBorders:(BOOL)displayTileBorders
{
    self.imageScrollView.displayTileBorders = displayTileBorders;
    _displayTileBorders = displayTileBorders;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    ARWebTiledImageDataSource *webTileImageDataSource = [[ARWebTiledImageDataSource alloc] init];
    webTileImageDataSource.maxTiledHeight = self.tiledSize.height;
    webTileImageDataSource.maxTiledWidth = self.tiledSize.width;
    webTileImageDataSource.minTileLevel = self.minTileLevel;
    webTileImageDataSource.maxTileLevel = self.maxTileLevel;
    webTileImageDataSource.tileSize = 512;
    webTileImageDataSource.tileFormat = @"jpg";
    webTileImageDataSource.tileBaseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/tiles", self.tilesURL.absoluteString]];

    ARTiledImageScrollView *imageScrollView = [[ARTiledImageScrollView alloc] initWithFrame:self.view.bounds];
    imageScrollView.dataSource = webTileImageDataSource;
    imageScrollView.backgroundColor = [UIColor grayColor];
    imageScrollView.backgroundImageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/large.jpg", self.tilesURL.absoluteString]];
    imageScrollView.displayTileBorders = self.displayTileBorders;
    _imageScrollView = imageScrollView;

    [self.view addSubview:imageScrollView];
}


- (void)viewDidAppear:(BOOL)animated
{
    [self.imageScrollView zoomToFit:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (BOOL)automaticallyAdjustsScrollViewInsets
{
    return NO;
}

@end
