//
//  UILabel+wi.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (wi)

/**
 设置文本,并指定行间距

 @param text 文本内容
 @param lineSpacing 行间距
 */
-(void)wi_setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing;

+(CGFloat)wi_getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;

/**
获取文字宽度

@param info 文本内容
@param font 字体
*/
+(CGFloat)wi_sizeWithInfo:(NSString *)info withFont:(UIFont *)font;

/**
获取文字高度

@param info 文本内容
@param font 字体
*/
+(CGFloat)wi_sizeWithInfo:(NSString *)info withWidth:(CGFloat)width withFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
