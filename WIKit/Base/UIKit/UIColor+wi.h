//
//  UIColor+wi.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <UIKit/UIKit.h>

//绝对色
#define WIWhiteColor            [UIColor colorWithRed:1 green:1 blue:1 alpha:1]
#define WIBlackColor            [UIColor colorWithRed:0 green:0 blue:0 alpha:1]

//动态色
#define WIDynaWhiteColor        WIDynamicColorWithHex(@"FFFFFF")
#define WIDynaBlackColor        WIDynamicColorWithHex(@"000000")


#define WIColorMake(r, g, b)                [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define WIColorMakeWithRGBA(r, g, b, a)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0]

#define WIColorWithHex(hexStr)              [UIColor wi_colorWithHexStr:hexStr]
#define WIDynamicColorWithHex(defaultHex)   [UIColor wi_dynamicColorWithHexStr:defaultHex]
#define WIDynamicColorWithHex2(defaultHex, darkHex) [UIColor wi_dynamicColorWithHexStr:defaultHex darkHexStr:darkHex]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (wi)

@property(class, nonatomic, readonly) UIColor *wi_dynamicWhiteColor;
@property(class, nonatomic, readonly) UIColor *wi_dynamicBlackColor;

//颜色动态反转
+(UIColor *)wi_dynamicColorWithHexStr:(NSString *)defaultHexStr;
//颜色动态改变
+(UIColor *)wi_dynamicColorWithHexStr:(NSString *)defaultHexStr darkHexStr:(NSString *)darkHexStr;

//颜色严格按照输入参数显示
+(UIColor *)wi_colorWithHexStr:(NSString *)HexString;

@end

NS_ASSUME_NONNULL_END
