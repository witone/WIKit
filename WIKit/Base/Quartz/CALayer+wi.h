//
//  CALayer+wi.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (wi)

@property (nonatomic) CGFloat wi_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat wi_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat wi_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat wi_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat wi_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat wi_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGPoint wi_center;      ///< Shortcut for center.
@property (nonatomic) CGFloat wi_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat wi_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint wi_origin;      ///< Shortcut for frame.origin.
@property (nonatomic, getter=wi_frameSize, setter=setWi_frameSize:) CGSize  wi_size; ///< Shortcut for frame.size.

@property (nonatomic) CGFloat wi_transformRotation;     ///< key path "tranform.rotation"
@property (nonatomic) CGFloat wi_transformRotationX;    ///< key path "tranform.rotation.x"
@property (nonatomic) CGFloat wi_transformRotationY;    ///< key path "tranform.rotation.y"
@property (nonatomic) CGFloat wi_transformRotationZ;    ///< key path "tranform.rotation.z"
@property (nonatomic) CGFloat wi_transformScale;        ///< key path "tranform.scale"
@property (nonatomic) CGFloat wi_transformScaleX;       ///< key path "tranform.scale.x"
@property (nonatomic) CGFloat wi_transformScaleY;       ///< key path "tranform.scale.y"
@property (nonatomic) CGFloat wi_transformScaleZ;       ///< key path "tranform.scale.z"
@property (nonatomic) CGFloat wi_transformTranslationX; ///< key path "tranform.translation.x"
@property (nonatomic) CGFloat wi_transformTranslationY; ///< key path "tranform.translation.y"
@property (nonatomic) CGFloat wi_transformTranslationZ; ///< key path "tranform.translation.z"

/**
 Shortcut to set the layer's shadow
 
 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)wi_setLayerShadow:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius;

- (void)wi_radiusWithRadius:(CGFloat)radius;
- (void)wi_radiusWithRadius:(CGFloat)radius corner:(UIRectCorner)corner;

/**
 Remove all sublayers.
 */
- (void)wi_removeAllSublayers;

- (void)wi_setBorderColor:(UIColor *)color;

- (UIImage *)wi_snapshotImage;

@end

NS_ASSUME_NONNULL_END
