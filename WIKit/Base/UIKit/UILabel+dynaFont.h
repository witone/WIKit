//
//  UILabel+dynaFont.h
//  WIKit
//
//  自定义动态字体
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WIFontSizeModel) {
    WIFontSizeModelDefault    = 0, //默认模式
    WIFontSizeModelSmall      = 1, //小字体
    WIFontSizeModelBig        = 2, //大字体
};

typedef struct __attribute__((objc_boxable)) DynamicFontSize {
    CGFloat def,small,big;
} DynaFontSize;

CG_INLINE DynaFontSize DynaFontSizeMake(CGFloat def, CGFloat small, CGFloat big) {
    DynaFontSize fontSize = {def, small, big};
    return fontSize;
};

UIKIT_EXTERN NSString *NSStringFromInt(DynaFontSize fontSize);
UIKIT_EXTERN DynaFontSize DynaFontSizeFromString(NSString *string);

FOUNDATION_EXPORT NSNotificationName const WIDynamicChangeFontSizeNotification;

#define fontModel WIFontSizeModelDefault //默认字体模式

typedef void (^FontSizeChangeBlock)(WIFontSizeModel model);

@interface UILabel (dynaFont)

//以下两种方法二选一
@property(nonatomic)DynaFontSize dyna_fontSize;
@property(nonatomic,copy) FontSizeChangeBlock dyna_fontSizeBlock;

@end
