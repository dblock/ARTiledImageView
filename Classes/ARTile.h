//
//  ARTile.h
//  ARTiledImageView
//
//  Created by Daniel Doubrovkine on 4/1/14.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ARTile : NSObject

@property (nonatomic, assign) CGRect tileRect;
@property (nonatomic, strong) UIImage *tileImage;

- (instancetype)initWithImage:(UIImage *)anImage rect:(CGRect)rect;
- (void)drawInRect:(CGRect)rect blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

@end
