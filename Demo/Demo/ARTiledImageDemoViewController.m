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
#import "ARLocalTiledImageDataSource.h"

@interface ARTiledImageDemoViewController ()
@property (nonatomic, readonly) ARTiledImageScrollView *scrollView;
@property (nonatomic, readonly) NSObject<ARTiledImageViewDataSource> *dataSource;
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

    if (self.tilesPath) {
        ARLocalTiledImageDataSource *localDataSource = [[ARLocalTiledImageDataSource alloc] init];
        localDataSource.tileBasePath = [self.tilesPath stringByAppendingPathComponent:@"tiles"];
        localDataSource.maxTiledHeight = self.tiledSize.height;
        localDataSource.maxTiledWidth = self.tiledSize.width;
        localDataSource.minTileLevel = self.minTileLevel;
        localDataSource.maxTileLevel = self.maxTileLevel;
        localDataSource.tileSize = 512;
        localDataSource.tileFormat = @"jpg";
        _dataSource = localDataSource;
    } else {
        ARWebTiledImageDataSource *webDataSource = [[ARWebTiledImageDataSource alloc] init];
        webDataSource.tileBaseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/tiles", self.tilesURL.absoluteString]];
        webDataSource.maxTiledHeight = self.tiledSize.height;
        webDataSource.maxTiledWidth = self.tiledSize.width;
        webDataSource.minTileLevel = self.minTileLevel;
        webDataSource.maxTileLevel = self.maxTileLevel;
        webDataSource.tileSize = 512;
        webDataSource.tileFormat = @"jpg";
        _dataSource = webDataSource;
    }
    
    ARTiledImageScrollView *sv = [[ARTiledImageScrollView alloc] initWithFrame:self.view.bounds];
    sv.dataSource = self.dataSource;
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
