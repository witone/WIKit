//
//  WIProgressView.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WIProgressViewStyle) {
    WIProgressViewStyleDefault  = 0,    // 方形
    WIProgressViewStyleCircle   = 1,     // 圆角
};

@interface WIProgressView : UIView

- (instancetype)initWithProgressViewStyle:(WIProgressViewStyle)style;

@property(nonatomic) float progress;

@property(nonatomic, strong, nullable) UIColor *progressTintColor;
@property(nonatomic, strong, nullable) UIColor *trackTintColor;
@property(nonatomic) WIProgressViewStyle progressViewStyle;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
