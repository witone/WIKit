//
//  NSURL+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "NSURL+wi.h"
#import "NSString+wi.h"

@implementation NSURL (wi)

+ (nullable NSURL *)wi_URLWithString:(nonnull NSString *)string {
    NSURL *url = [NSURL URLWithString:string];
    if (url == nil) {
        NSString *strTemp = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        url = [NSURL URLWithString:strTemp];
    }
    return url;
}

+ (NSDictionary *)paramsInURL:(NSURL *)url {
    NSMutableDictionary *paramer = [[NSMutableDictionary alloc]init];
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [paramer setObject:obj.value forKey:obj.name];
    }];
    return paramer;
}

@end
