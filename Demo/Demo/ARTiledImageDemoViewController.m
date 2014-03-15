//
//  ARTiledImageViewController.m
//  ARTiledImage
//
//  Created by Daniel Doubrovkine on 3/10/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARTiledImageDemoViewController.h"
#import "ARTiledImageScrollView.h"
#import "ARWebTiledImageDataSource.h"

@interface ARTiledImageDemoViewController ()
@property(nonatomic, readonly) ARTiledImageScrollView *imageScrollView;
@end

@implementation ARTiledImageDemoViewController

-(void)setDisplayTileBorders:(BOOL)displayTileBorders
{
    self.imageScrollView.displayTileBorders = displayTileBorders;
    _displayTileBorders = displayTileBorders;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    ARWebTiledImageDataSource *webTileImageDataSource = [[ARWebTiledImageDataSource alloc] init];
    webTileImageDataSource.maxTiledHeight = 5389;
    webTileImageDataSource.maxTiledWidth = 5000;
    webTileImageDataSource.minTileLevel = 11;
    webTileImageDataSource.maxTileLevel = ceil(log(MAX(webTileImageDataSource.maxTiledWidth, webTileImageDataSource.maxTiledHeight))/log(2));
    webTileImageDataSource.tileSize = 512;
    webTileImageDataSource.tileFormat = @"jpg";
    webTileImageDataSource.tileBaseURL = [NSURL URLWithString:@"https://raw.github.com/dblock/ARTiledImageView/master/Demo/Tiles/Armory2014/tiles"];
    
    ARTiledImageScrollView *imageScrollView = [[ARTiledImageScrollView alloc] initWithFrame:self.view.bounds];
    imageScrollView.dataSource = webTileImageDataSource;
    imageScrollView.backgroundColor  = [UIColor grayColor];
    imageScrollView.backgroundImageURL = [NSURL URLWithString:@"https://raw.github.com/dblock/ARTiledImageView/master/Demo/Tiles/Armory2014/large.jpg"];
    imageScrollView.displayTileBorders = self.displayTileBorders;
    _imageScrollView = imageScrollView;

    [self.view addSubview:imageScrollView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.imageScrollView zoomToFit:animated];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
