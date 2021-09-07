//
//  NSURL+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "NSURL+wi.h"

@implementation NSURL (wi)

+ (nullable NSURL *)wi_URLWithString:(nonnull NSString *)string {
    NSURL *url = [NSURL URLWithString:string];
    if (url == nil) {
        url = [NSURL URLWithString:[NSURL wi_urlQueryEncode:string]];
    }
    if (url == nil) {//保底
        NSString *resultStr = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        url = [NSURL URLWithString:resultStr];
    }
    return url;
}

+ (NSString *)wi_urlQueryEncode:(NSString *)urlString {
    //NSString *resultString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *charactersToEscape = @"\"%<>[\\]^`{|} ";
    NSCharacterSet *urlQueryAllowedCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *resultString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:urlQueryAllowedCharacterSet];
    return resultString;
}

+ (NSDictionary *)wi_paramsInURL:(NSURL *)url {
    NSMutableDictionary *paramer = [[NSMutableDictionary alloc]init];
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [paramer setObject:obj.value forKey:obj.name];
    }];
    return paramer;
}

@end
