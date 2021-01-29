//
//  UILabel+dynaFont.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "UILabel+dynaFont.h"
#import "objc/runtime.h"

NSString *NSStringFromInt(DynaFontSize fontSize) {
    return [NSString stringWithFormat:@"%f-%f-%f",fontSize.def,fontSize.small,fontSize.big];
}

DynaFontSize DynaFontSizeFromString(NSString *string) {
    NSArray<NSString *> *fontSizeArr = [string componentsSeparatedByString:@"-"];
    return DynaFontSizeMake(fontSizeArr.firstObject.floatValue, fontSizeArr[1].floatValue, fontSizeArr.lastObject.floatValue);
}

NSNotificationName const WIDynamicChangeFontSizeNotification = @"WIDynamicChangeFontSizeNotification";

@implementation UILabel (dynaFont)

- (DynaFontSize)dyna_fontSize {
    NSString *fontSizeStr = objc_getAssociatedObject(self, @selector(dyna_fontSize));
    return DynaFontSizeFromString(fontSizeStr);
}

-(void)setDyna_fontSize:(DynaFontSize)dyna_fontSize {
    NSString *fontSizeStr = NSStringFromInt(dyna_fontSize);
    objc_setAssociatedObject(self, @selector(dyna_fontSize), fontSizeStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addDynamicChangeFontSizeNotification];
    [self setDynamicFontOfSize:fontModel];
}

-(FontSizeChangeBlock)dyna_fontSizeBlock {
    return objc_getAssociatedObject(self, @selector(dyna_fontSizeBlock));;
}

-(void)setDyna_fontSizeBlock:(FontSizeChangeBlock)dyna_fontSizeBlock {
    objc_setAssociatedObject(self, @selector(dyna_fontSizeBlock), dyna_fontSizeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addDynamicChangeFontSizeNotification];
    self.dyna_fontSizeBlock(fontModel);
}

-(void)addDynamicChangeFontSizeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WIDynamicChangeFontSizeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setGlobalFont:) name:WIDynamicChangeFontSizeNotification object:nil];
}

- (void)setGlobalFont:(NSNotification *)notification {
//    if ([self isKindOfClass:NSClassFromString(@"UITextFieldLabel")] || [self isKindOfClass:NSClassFromString(@"UIButtonLabel")]) {
//        return;
//    }
    WIFontSizeModel model = ((NSNumber *)notification.object).integerValue;
    if (self.dyna_fontSizeBlock) {
        self.dyna_fontSizeBlock(model);
    }else {
        [self setDynamicFontOfSize:model];
    }
}

-(void)setDynamicFontOfSize:(WIFontSizeModel)model {
    switch ((int)model) {
        case WIFontSizeModelSmall:
            self.font = [UIFont systemFontOfSize:self.dyna_fontSize.small];
            break;
        case WIFontSizeModelBig:
            self.font = [UIFont systemFontOfSize:self.dyna_fontSize.big];
            break;
        default:
            self.font = [UIFont systemFontOfSize:self.dyna_fontSize.def];
            break;
    }
}

@end
