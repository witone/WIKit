//
//  UIImage+wi.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (wi)

+ (UIImage *)wi_imageWithColor:(UIColor *)color;
+ (UIImage *)wi_imageWithColor:(UIColor *)color size:(CGSize)size;
+ (nullable UIImage *)wi_imageWithColor:(UIColor *)color size:(CGSize)size isRound:(BOOL)isRound;

- (nullable UIImage *)wi_scaleToSize:(CGSize)size;

- (UIImage *)wi_fixOrientation;

@end

NS_ASSUME_NONNULL_END
