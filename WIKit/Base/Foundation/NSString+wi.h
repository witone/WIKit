//
//  NSString+wi.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static inline NSString *WIStringFromInt(int intValue) {
    return [NSString stringWithFormat:@"%i",intValue];
}

static inline NSString *WIStringFromBOOL(BOOL boolValue) {
    return (boolValue == YES) ? @"YES" : @"NO";
}

static inline NSString *WIStringFromFloat(float floatValue) {
    return [NSString stringWithFormat:@"%f",floatValue];
}

@interface NSString (wi)

/**
 判断字符是否为空

 @param str str
 @return YES:空字符 NO:非空字符
 */
+(BOOL)wi_checkStrIsNull:(NSString *)str;

/**
 判断字符是否非空
 
 @param str str
 @return YES:非空字符 NO:空字符
 */
+(BOOL)wi_checkStrNotNull:(NSString *)str;

/**
判断是否非空
 
@return YES:非空字符 NO:空字符
*/
-(BOOL)wi_isNotNull;

-(BOOL)wi_isNumber;

-(BOOL)wi_isContainZH_CN;
-(BOOL)wi_isContain:(NSString *)str;
-(BOOL)wi_isContainIgnoreCase:(NSString *)str;
-(BOOL)wi_isEqual:(NSString *)str;
-(BOOL)wi_isEqualIgnoreCase:(NSString *)str;

-(BOOL)wi_isPureInt;
-(BOOL)wi_isPureFloat;
-(BOOL)wi_isPureLongLong;
-(BOOL)wi_isPureDouble;

-(int)wi_intValue;
-(int)wi_intValue:(int)defVal;
-(float)wi_floatValue;
-(float)wi_floatValue:(float)defVal;
-(long)wi_longValue;
-(long long)wi_longLongValue;
-(long)wi_longLongValue:(long)defVal;
-(double)wi_doubleValue;
-(double)wi_doubleValue:(double)defVal;

//区分中英文字符
-(NSUInteger)wi_zh_length;
-(NSString *)wi_zh_substringToIndex:(NSUInteger)to;
-(NSString *)wi_zh_substringFromIndex:(NSUInteger)from;
-(NSString *)wi_zh_substringWithRange:(NSRange)range;

-(NSString *)wi_md5EncodedString;

-(NSString *)wi_stringByURLEncode;
-(NSString *)wi_stringByURLDecode;

-(BOOL)wi_containsIgnoreCase:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
