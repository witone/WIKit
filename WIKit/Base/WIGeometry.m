//
//  WIGeometry.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "WIGeometry.h"
#import <UIKit/UIKit.h>

UIEdgeInsets WISafeAreaInsets() {
    static UIEdgeInsets __efSafeAreaInsets = {0, 0, 0, 0};
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
            __efSafeAreaInsets = mainWindow.safeAreaInsets;
        }
    });
    return __efSafeAreaInsets;
}

BOOL WIIsNotchDevice() {
    static BOOL __efIsIphoneX;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __efIsIphoneX = WISafeAreaInsets().bottom>0;
    });
    return __efIsIphoneX;
}

CGFloat WIScreenScale() {
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return scale;
}

CGSize WIScreenSize() {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height < size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size;
}

CGFloat WIStatusBarHeight() {
    static CGFloat height;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        height = UIApplication.sharedApplication.statusBarFrame.size.height;
    });
    return height;
}
