//
//  NSString+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "NSString+wi.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSString (wi)

+(BOOL)wi_checkStrIsNull:(NSString *)str {
    BOOL result = YES;
    if (str && str.length>0) {
        result = NO;
    }
    return result;
}

+(BOOL)wi_checkStrNotNull:(NSString *)str {
    return ![NSString wi_checkStrIsNull:str];
}

-(BOOL)wi_isNotNull {
    if(!self ||self.length<=0) {
        return NO;
    } else {
        return YES;
    }
}

//是否都是数字
-(BOOL)wi_isNumber {
    if(!self.wi_isNotNull) return NO;
    for (int i = 0; i < self.length; i++) {
        int a = [self characterAtIndex:i];
        if (a < 48 || a > 57) return NO;
    }
    return YES;
}

//是否包含中文
-(BOOL)wi_isContainZH_CN {
    if(!self.wi_isNotNull) return NO;
    for (int i = 0; i < [self length]; i++) {
        int a = [self characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)wi_isContain:(NSString *)str {
    if(!self.wi_isNotNull || !str.wi_isNotNull) return NO;
    NSRange range = [self rangeOfString:str];
    return range.length>0 ? YES : NO;
}

-(BOOL)wi_isContainIgnoreCase:(NSString *)str {
    if(!self.wi_isNotNull || !str.wi_isNotNull) return NO;
    return [self.lowercaseString wi_isContain:str.lowercaseString];
}

-(BOOL)wi_isEqual:(NSString *)str {
    if(!self.wi_isNotNull || !str.wi_isNotNull) return NO;
    return ([self compare:str] == NSOrderedSame) ? YES : NO;
}

-(BOOL)wi_isEqualIgnoreCase:(NSString *)str {
    if(!self.wi_isNotNull || !str.wi_isNotNull) return NO;
    return [self.lowercaseString wi_isEqual:str.lowercaseString];
}

-(BOOL)wi_isPureInt {
    if(!self.wi_isNotNull) return NO;
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

-(BOOL)wi_isPureFloat {
    if(!self.wi_isNotNull) return NO;
    NSScanner *scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

-(BOOL)wi_isPureLongLong {
    if(!self.wi_isNotNull) return NO;
    NSScanner *scan = [NSScanner scannerWithString:self];
    long long val;
    return [scan scanLongLong:&val] && [scan isAtEnd];
}

-(BOOL)wi_isPureDouble {
    if(!self.wi_isNotNull) return NO;
    NSScanner *scan = [NSScanner scannerWithString:self];
    double val;
    return [scan scanDouble:&val] && [scan isAtEnd];
}

-(int)wi_intValue {
    return [self wi_intValue:0];
}

-(int)wi_intValue:(int)defVal {
    if(!self.wi_isNotNull || !self.wi_isPureInt) return defVal;
    return [self intValue];
}

-(float)wi_floatValue {
    return [self wi_floatValue:0.0f];
}

-(float)wi_floatValue:(float)defVal {
    if(!self.wi_isNotNull || !self.wi_isPureFloat) return defVal;
    return [self floatValue];
}

-(long)wi_longValue {
    return (long)[self wi_longLongValue:0];
}

-(long long)wi_longLongValue {
    return [self wi_longLongValue:0];
}

-(long)wi_longLongValue:(long)defVal {
    if(!self.wi_isNotNull || !self.wi_isPureLongLong) return defVal;
    return (long)[self longLongValue];
}

-(double)wi_doubleValue {
    return [self wi_doubleValue:0.0f];
}

-(double)wi_doubleValue:(double)defVal {
    if(!self.wi_isNotNull || !self.wi_isPureDouble) return defVal;
    return [self doubleValue];
}

-(NSUInteger)wi_zh_length {
    return [self dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)].length;
}

-(NSString *)wi_zh_substringToIndex:(NSUInteger)to {
    NSData * data = [[self dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)] subdataWithRange:NSMakeRange(0, to)];
    return [[NSString alloc] initWithData:data encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
}

-(NSString *)wi_zh_substringFromIndex:(NSUInteger)from {
    NSData *oriData = [self dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    if (from>=oriData.length) {
        return self;
    }
    return [[NSString alloc] initWithData:[oriData subdataWithRange:NSMakeRange(from, oriData.length-1)] encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
}

-(NSString *)wi_zh_substringWithRange:(NSRange)range {
    NSData *oriData = [self dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    return [[NSString alloc] initWithData:[oriData subdataWithRange:range] encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
}

- (NSString *)wi_md5EncodedString {
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;

}

-(NSString *)wi_stringByURLEncode {
    static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
    
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
    static NSUInteger const batchSize = 50;
    
    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;
    
    while (index < self.length) {
        NSUInteger length = MIN(self.length - index, batchSize);
        NSRange range = NSMakeRange(index, length);
        // To avoid breaking up character sequences such as 👴🏻👮🏽
        range = [self rangeOfComposedCharacterSequencesForRange:range];
        NSString *substring = [self substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];
        
        index += range.length;
    }
    return escaped;
}

-(NSString *)wi_stringByURLDecode {
    return [self stringByRemovingPercentEncoding];
}

-(BOOL)wi_containsIgnoreCase:(NSString *)str {
    if(!self.wi_isNotNull || !str.wi_isNotNull) {
        return NO;
    }
    NSString *selfTemp = [self lowercaseString];
    NSString *strTemp = [str lowercaseString];
    NSRange range = [selfTemp rangeOfString:strTemp];
    return range.length;
}

@end


@implementation NSString (json)

-(id)wi_handleJsonString {
    if (!self.wi_isNotNull) return nil;

    NSString *jsonStr = self;
    if ([self hasPrefix:@"\""]) {
        jsonStr = [self substringWithRange:NSMakeRange(1, self.length-2)];
    }
    
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) NSLog(@"json解析失败：%@",err);
    return result;
}

-(NSDictionary *)wi_dicWithJsonString {
    if (!self.wi_isNotNull) return nil;

    NSString *jsonStr = self;
    if ([self hasPrefix:@"\""]) {
        jsonStr = [self substringWithRange:NSMakeRange(1, self.length-2)];
    }
    
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&err];
    if(err) NSLog(@"json解析失败：%@",err);
    return dic;
}

@end
