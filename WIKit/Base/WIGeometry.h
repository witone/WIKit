//
//  WIGeometry.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGeometry.h>

UIKIT_EXTERN UIEdgeInsets WISafeAreaInsets(void);
/** 是否刘海屏设备 */
UIKIT_EXTERN BOOL WIIsNotchDevice(void);
/** 获取屏幕密度*/
UIKIT_EXTERN CGFloat WIScreenScale(void);
UIKIT_EXTERN CGSize WIScreenSize(void);
UIKIT_EXTERN CGFloat WIStatusBarHeight(void);

static inline CGFloat WICGFloatFromPixel(CGFloat value) {
    return value / WIScreenScale();
}

CG_INLINE CGRect CGRectMakeWithSize(CGSize size) {
    return CGRectMake(0, 0, size.width, size.height);
}

#define wiScreenWidth   WIScreenSize().width
#define wiScreenHeight  WIScreenSize().height
