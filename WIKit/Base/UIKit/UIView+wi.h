//
//  UIView+wi.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (wi)

@property (nonatomic) CGFloat wi_left;
@property (nonatomic) CGFloat wi_top;
@property (nonatomic) CGFloat wi_right;
@property (nonatomic) CGFloat wi_bottom;
@property (nonatomic) CGFloat wi_width;
@property (nonatomic) CGFloat wi_height;
@property (nonatomic) CGFloat wi_centerX;
@property (nonatomic) CGFloat wi_centerY;
@property (nonatomic) CGPoint wi_origin;
@property (nonatomic) CGSize  wi_size;

@property (nullable, nonatomic) UIViewController *wi_viewController;

- (instancetype)wi_initWithSize:(CGSize)size;

- (void)wi_radiusWithRadius:(CGFloat)radius corner:(UIRectCorner)corner;

- (void)wi_setLayerShadow:(nullable UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

- (UIImage *)wi_snapshotImage;

- (UIImage *)wi_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

- (void)wi_removeAllSubviews;

@end

NS_ASSUME_NONNULL_END
