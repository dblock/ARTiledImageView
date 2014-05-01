# ARTiledImageView

[![Build Status](https://travis-ci.org/dblock/ARTiledImageView.png?branch=master)](https://travis-ci.org/dblock/ARTiledImageView)
[![Version](http://cocoapod-badges.herokuapp.com/v/ARTiledImageView/badge.png)](http://cocoadocs.org/docsets/ARTiledImageView)
[![Platform](http://cocoapod-badges.herokuapp.com/p/ARTiledImageView/badge.png)](http://cocoadocs.org/docsets/ARTiledImageView)

## Demo

![animated](Screenshots/goya3.gif)

[Francisco De Goya Y Lucientes, Señora Sabasa Garcia, ca. 1806/1811](https://artsy.net/artwork/francisco-jose-de-goya-y-lucientes-senora-sabasa-garcia), courtesy of the National Gallery of Art, Washington D.C., via [Artsy](https://artsy.net).

## Usage

``` objc
ARWebTiledImageDataSource *ds = [[ARWebTiledImageDataSource alloc] init];
// height of the full zoomed in image
ds.maxTiledHeight = 2933;
// width of the full zommed in image
ds.maxTiledWidth = 2383;
// width of the full zommed in image
ds.minTileLevel = 10;
// maximum tile level
ds.maxTileLevel = 15;
// side of a square tile
ds.tileSize = 512;
// tile format
ds.tileFormat = @"jpg";
// location of tiles, organized in subfolders, one per level
ds.tileBaseURL = [NSURL URLWithString:@"https://raw.github.com/dblock/ARTiledImageView/master/Demo/Tiles/SenoraSabasaGarcia/tiles"];
// make sure to retain the datasource
_dataSource = ds;

ARTiledImageScrollView *sv = [[ARTiledImageScrollView alloc] initWithFrame:self.view.bounds];
// set datasource
sv.dataSource = ds;
// default background color
sv.backgroundColor = [UIColor grayColor];
// default stretched placeholder image
sv.backgroundImageURL = [NSURL URLWithString:@"https://raw.github.com/dblock/ARTiledImageView/master/Demo/Tiles/SenoraSabasaGarcia/large.jpg"];
// display tile borders, for debugging
sv.displayTileBorders = NO;

// add as a subview to another view
[self.view addSubview:sv];
```

## Tiles and Data Sources

A typical organization for deep zoom map tiles consists of a folder for each zoom level and individual JPG files for each tile. You can see an example of such files [here](Demo/Tiles/SenoraSabasaGarcia/tiles). ARTiledImageView comes with a local [ARLocalTiledImageDataSource](Classes/ARLocalTiledImageDataSource.h), which retrieves tile files from local storage, and a remote [ARWebTiledImageDataSource](Classes/ARWebTiledImageDataSource.h) data source, which retrieves map tiles from a remote URL and stores them in *Library/Caches* (NSCachesDirectory).

You can generate tiles using [dzt](https://github.com/dblock/dzt) or any other tool listed with the [OpenSeadragon](http://openseadragon.github.io/examples/creating-zooming-images) project.

## Installation

ARTiledImageView is available through [CocoaPods](http://cocoapods.org), to install it simply add the following line to your Podfile:

    pod "ARTiledImageView"

## Testing

Try it out with CocoaPods also,

    pod try "ARTiledImageView"

## Credits

ARTiledImageView was originally written by [@orta](https://github.com/orta), with contributions from [@speednoisemovement](https://github.com/speednoisemovement) and [@dblock](https://github.com/dblock). Some of the implementation in [ARTiledImageScrollView](Classes/ARTiledImageScrollView.m) comes from [NAMapKit](https://github.com/neilang/NAMapKit).

## Copyright & License

ARTiledImageView is (c) [Artsy Inc.](http://artsy.net), available under the MIT license.

See the [LICENSE](LICENSE) file for more information.

