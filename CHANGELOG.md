## 1.2.1 (13/08/2014)

* Added initializer to `ARTiledImageView` to specify a minimum size for the image - [@ashfurrow](http://github.com/AshFurrow).

## 1.2.0 (15/07/2014)

* [#5](https://github.com/dblock/ARTiledImageView/issues/5): Improved centering behavior when zooming out - [@orta](https://github.com/orta).
* [#5](https://github.com/dblock/ARTiledImageView/issues/5): Fixed zoom animations behavior with a backing image view - [@orta](https://github.com/orta).
* [#5](https://github.com/dblock/ARTiledImageView/issues/5): Exposed the double tap gesture on ARTiledImageScrollView - [@orta](https://github.com/orta).
* [#7](https://github.com/dblock/ARTiledImageView/issues/7): Fixed `[ARTiledImageScrollView setMaxMinZoomScalesForCurrentBounds]` to work with `contentMode` - [@orta](https://github.com/orta).

## 1.1.1 (5/29/2014)

* [#2](https://github.com/dblock/ARTiledImageView/issues/2): Fixed crash in `[ARTiledImageView downloadAndRedrawTilesWithURLs:]`, (ARTiledImageView.m:154) - [@dblock](https://github.com/dblock).

## 1.1.0 (5/1/2014)

* Added `ARTiledImageScrollView.backgroundImage` - [@dblock](https://github.com/dblock).
* Exposed `ARTile`, drawing now goes through `ARTile#drawInRect` - [@dblock](https://github.com/dblock).

## 1.0.0 (3/15/2014)

* Initial public release - [@dblock](https://github.com/dblock).
