//
//  ARTile.h
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 4/1/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// Class to represent a tiles positioning and image

@interface ARTile : NSObject

/// Where does the tile sit on the frame
@property (nonatomic, assign) CGRect tileRect;

/// UIImage to draw at `tileRect`
@property (nonatomic, strong) UIImage *tileImage;

/// Preferred initializer
- (instancetype)initWithImage:(UIImage *)anImage rect:(CGRect)rect;

/// Draw Tile into a context
- (void)drawInRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

@end
