//
//  UIColor+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "UIColor+wi.h"

@implementation UIColor (wi)

+(UIColor *)wi_dynamicColorWithHexStr:(NSString *)defaultHexStr darkHexStr:(NSString *)darkHexStr {
    if (@available(iOS 13.0,*)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && darkHexStr.length>=6) {
                return WIColorWithHex(darkHexStr);
            }else {
                return WIColorWithHex(defaultHexStr);
            }
        }];
    }else {
        return WIColorWithHex(defaultHexStr);
    }
}

+(UIColor *)wi_dynamicColorWithHexStr:(NSString *)defaultHexStr {
    if ([defaultHexStr length] < 6) return [UIColor blackColor];
    if ([defaultHexStr hasPrefix:@"0x"]) defaultHexStr = [defaultHexStr substringFromIndex:2];
    if ([defaultHexStr hasPrefix:@"#"]) defaultHexStr = [defaultHexStr substringFromIndex:1];

    unsigned int red,green,blue,alph;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[defaultHexStr substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[defaultHexStr substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[defaultHexStr substringWithRange:range]] scanHexInt:&blue];
    range.location = 6;
    
    alph = 255;
    if (defaultHexStr.length == 8) {
        [[NSScanner scannerWithString:[defaultHexStr substringWithRange:range]] scanHexInt:&alph];
    }
    if (@available(iOS 13.0,*)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return WIColorMakeWithRGBA((255.0-red), (255.0-green), (255.0-blue),alph);
            }else {
                return WIColorMakeWithRGBA(red, green, blue,alph);
            }
        }];
    }else {
        return WIColorMakeWithRGBA(red, green, blue,alph);
    }
}

+(UIColor *)wi_colorWithHexStr:(NSString *)HexString {
    if ([HexString length] < 6) return [UIColor blackColor];
    if ([HexString hasPrefix:@"0x"]) HexString = [HexString substringFromIndex:2];
    if ([HexString hasPrefix:@"#"]) HexString = [HexString substringFromIndex:1];

    unsigned int red,green,blue,alph;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[HexString substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[HexString substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[HexString substringWithRange:range]] scanHexInt:&blue];
    range.location = 6;
    
    alph = 255;
    if (HexString.length == 8) {
        [[NSScanner scannerWithString:[HexString substringWithRange:range]] scanHexInt:&alph];
    }
    
    return WIColorMakeWithRGBA(red, green, blue,alph);
}

+(UIColor *)wi_dynamicWhiteColor {
    return WIDynamicColorWithHex(@"FFFFFF");
}

+(UIColor *)wi_dynamicBlackColor {
    return WIDynamicColorWithHex(@"000000");
}

@end
