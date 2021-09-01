//
//  NSDictionary+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "NSDictionary+wi.h"
#import "NSObject+wi.h"

@implementation NSDictionary (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#ifndef DEBUG
        [NSDictionary wi_swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) with:@selector(safe_dictionaryWithObjects:forKeys:count:)];
#endif
    });
}

/// 避免这种crash：@{@"key1": nilObj, @"key2": @"obj2"};
+ (instancetype)safe_dictionaryWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt {
    id nObjects[cnt];
    id nKeys[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i] && keys[i]) {
            nObjects[j] = objects[i];
            nKeys[j] = keys[i];
            j++;
        }
    }
    return [self safe_dictionaryWithObjects:nObjects forKeys:nKeys count:j];
}

@end

@implementation NSMutableDictionary (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#ifndef DEBUG
        Class dictCls = NSClassFromString(@"__NSDictionaryM");
        [dictCls wi_swizzleClassMethod:@selector(setObject:forKey:) with:@selector(safe_setObject:forKey:)];
        [dictCls wi_swizzleClassMethod:@selector(removeObjectForKey:) with:@selector(safe_removeObjectForKey:)];

        //setObject:forKeyedSubscript:
        if (@available(iOS 11.0,*)) {
            [dictCls wi_swizzleClassMethod:@selector(setObject:forKeyedSubscript:) with:@selector(safe_setObject:forKeyedSubscript:)];
        }
#endif
    });
}
/// 避免这种crash：[myDict setObject:nilObj forKey:@"your_key"];
- (void)safe_setObject:(id)obj forKey:(id<NSCopying>)key {
    if (!obj||!key) return;
    @try {
        [self safe_setObject:obj forKey:key];
    } @catch (NSException *exception) {
        [NSObject wi_recordException:exception];
    }
}

-(void)safe_removeObjectForKey:(id)key {
    if (!key) return;
    @try {
        [self safe_removeObjectForKey:key];
    } @catch (NSException *exception) {
        [NSObject wi_recordException:exception];
    }
}

#pragma mark - setObject:forKeyedSubscript:
- (void)safe_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!obj||!key) return;
    @try {
        [self safe_setObject:obj forKeyedSubscript:key];
    } @catch (NSException *exception) {
        [NSObject wi_recordException:exception];
    }
}

@end

@implementation NSDictionary (wi)

-(NSString *)wi_jsonString {
    NSString *jsonString;
    NSUInteger count = self.count;
    if (count > 0) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
        jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
