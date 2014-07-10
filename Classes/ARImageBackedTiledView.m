//
//  ARImageBackedTiledView.h
//  Artsy Folio
//
//  Created by Orta on 10/07/2014.
//  Copyright (c) 2014 http://artsy.net. All rights reserved.
//

#import "ARImageBackedTiledView.h"

@implementation ARImageBackedTiledView

- (instancetype)initWithTiledImageView:(ARTiledImageView *)tiledImageView;
{
    self = [super initWithFrame:tiledImageView.bounds];
    if (!self) return nil;

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:tiledImageView.bounds];
    _imageView = imageView;
    [self addSubview:imageView];

    _tiledImageView = tiledImageView;
    [self addSubview:tiledImageView];

    return self;
}

@end
