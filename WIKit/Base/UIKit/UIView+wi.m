//
//  UIView+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "UIView+wi.h"
#import "WIGeometry.h"
#import "objc/runtime.h"

@implementation UIView (wi)

- (CGFloat)wi_left {
    return self.frame.origin.x;
}

- (void)setWi_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)wi_top {
    return self.frame.origin.y;
}

- (void)setWi_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)wi_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setWi_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)wi_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setWi_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)wi_width {
    return self.frame.size.width;
}

- (void)setWi_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)wi_height {
    return self.frame.size.height;
}

- (void)setWi_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)wi_centerX {
    return self.center.x;
}

- (void)setWi_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)wi_centerY {
    return self.center.y;
}

- (void)setWi_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)wi_origin {
    return self.frame.origin;
}

- (void)setWi_origin:(CGPoint)wi_origin {
    CGRect frame = self.frame;
    frame.origin = wi_origin;
    self.frame = frame;
}

- (CGSize)wi_size {
    return self.frame.size;
}

- (void)setWi_size:(CGSize)wi_size {
    CGRect frame = self.frame;
    frame.size = wi_size;
    self.frame = frame;
}

- (UIViewController *)wi_viewController {
    UIViewController *vc = objc_getAssociatedObject(self, @selector(wi_viewController));
    if (!vc) {
        for (UIView *view = self; view; view = view.superview) {
            UIResponder *nextResponder = [view nextResponder];
            if ([nextResponder isKindOfClass:[UIViewController class]]) {
                UIViewController *pvc = (UIViewController *)nextResponder;
                [self setWi_viewController:pvc];
                return pvc;
            }
        }
        return nil;
    }
    return vc;
}

-(void)setWi_viewController:(UIViewController * _Nullable)wi_viewController {
    objc_setAssociatedObject(self, @selector(wi_viewController), wi_viewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (instancetype)wi_initWithSize:(CGSize)size {
    return [self initWithFrame:CGRectMakeWithSize(size)];
}

- (void)wi_radiusWithRadius:(CGFloat)radius {
    [self wi_radiusWithRadius:radius corner:UIRectCornerAllCorners];
}

- (void)wi_radiusWithRadius:(CGFloat)radius corner:(UIRectCorner)corner {
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radius;
        self.layer.maskedCorners = (CACornerMask)corner;
        self.layer.masksToBounds = YES;
    } else {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
    }
}

- (void)wi_setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (UIImage *)wi_snapshotImage {
    return [self wi_snapshotImage:self.opaque];
}

- (UIImage *)wi_snapshotImage:(BOOL)opaque {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIImage *)wi_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates {
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        return [self wi_snapshotImage];
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (void)wi_removeAllSubviews {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

-(void)wi_addTarget:(id)target action:(SEL)selector {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
    [self addGestureRecognizer:tapGestureRecognizer];
    [self setUserInteractionEnabled:YES];
}

@end
