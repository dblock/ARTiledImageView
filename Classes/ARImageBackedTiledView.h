//
//  ARImageBackedTiledView.m
//  ARTiledImageView
//
//  Created by Orta on 10/07/2014.
//  Copyright (c) 2014 http://artsy.net. All rights reserved.
//

#import "ARTiledImageView.h"

/// Allows you to have a background image over which you tile
/// on top of. Simply a wrapper for two views.

@interface ARImageBackedTiledView : UIView

/// Requires being created with a tiled view for sizing.
- (instancetype)initWithTiledImageView:(ARTiledImageView *)tiledImageView;

/// Accessor for the front tiled image view.
@property (nonatomic, weak, readonly) ARTiledImageView *tiledImageView;

/// Accessor for the background image view.
@property (nonatomic, weak, readonly) UIImageView *imageView;

@end
