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
@property (nonatomic, readonly) ARTiledImageScrollView *scrollView;
@property (nonatomic, readonly) ARWebTiledImageDataSource *dataSource;
@end

@implementation ARTiledImageDemoViewController

- (void)setDisplayTileBorders:(BOOL)displayTileBorders
{
    self.scrollView.displayTileBorders = displayTileBorders;
    _displayTileBorders = displayTileBorders;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    ARWebTiledImageDataSource *ds = [[ARWebTiledImageDataSource alloc] init];
    ds.maxTiledHeight = self.tiledSize.height;
    ds.maxTiledWidth = self.tiledSize.width;
    ds.minTileLevel = self.minTileLevel;
    ds.maxTileLevel = self.maxTileLevel;
    ds.tileSize = 512;
    ds.tileFormat = @"jpg";
    ds.tileBaseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/tiles", self.tilesURL.absoluteString]];
    _dataSource = ds;

    ARTiledImageScrollView *sv = [[ARTiledImageScrollView alloc] initWithFrame:self.view.bounds];
    sv.dataSource = ds;
    sv.backgroundColor = [UIColor grayColor];
    sv.backgroundImageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/large.jpg", self.tilesURL.absoluteString]];
    sv.displayTileBorders = self.displayTileBorders;
    _scrollView = sv;

    [self.view addSubview:self.scrollView];
}


- (void)viewDidAppear:(BOOL)animated
{
    [self.scrollView zoomToFit:animated];
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
