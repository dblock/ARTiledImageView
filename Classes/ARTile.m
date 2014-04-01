//
//  ARTile.m
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 4/1/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import "ARTile.h"

@implementation ARTile

- (instancetype)initWithImage:(UIImage *)anImage rect:(CGRect)rect
{
    self = [super init];
    if (self == nil) return nil;
    
    _tileImage = anImage;
    _tileRect = rect;
    
    return self;
}

- (void)drawInRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha
{
    [self.tileImage drawInRect:rect blendMode:blendMode alpha:alpha];
}

@end

