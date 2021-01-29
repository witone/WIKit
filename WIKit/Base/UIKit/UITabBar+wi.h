//
//  UITabBar+wi.h
//  FBSnapshotTestCase
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WIBadgeStyle){
    WIBadgeStyleRedDot,
    WIBadgeStyleNumber,
    WIBadgeStyleNone
};

@interface UITabBar (wi)

/**
 *设置tab上icon的宽度，用于调整badge的位置
 */
- (void)setTabIconWidth:(CGFloat)width;

/**
 *设置badge的top
 */
- (void)setBadgeTop:(CGFloat)top;

/**
 *设置badge样、数字
 */
- (void)setBadgeStyle:(WIBadgeStyle)stype value:(NSInteger)badgeValue atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
