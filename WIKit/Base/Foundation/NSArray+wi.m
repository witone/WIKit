//
//  NSArray+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "NSArray+wi.h"
#import "NSObject+wi.h"

@implementation NSArray (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#ifndef DEBUG
        [NSArray wi_swizzleClassMethod:@selector(arrayWithObjects:count:) with:@selector(safe_arrayWithObjects:count:)];

        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        Class __NSArray0 = NSClassFromString(@"__NSArray0");

        //objectsAtIndexes:
        [NSArray wi_swizzleInstanceMethod:@selector(objectsAtIndexes:) with:@selector(safe_objectsAtIndexes:)];

        //objectAtIndexedSubscript:
        [NSArray wi_swizzleInstanceMethod:@selector(objectAtIndexedSubscript:) with:@selector(safe_objectAtIndexedSubscript:)];
        if (@available(iOS 11.0,*)) {
            [__NSArrayI wi_swizzleInstanceMethod:@selector(objectAtIndexedSubscript:) with:@selector(__NSArrayIAvoidCrashObjectAtIndexedSubscript:)];
        }
        //objectAtIndex:
        [__NSArrayI wi_swizzleInstanceMethod:@selector(objectAtIndex:) with:@selector(__NSArrayIAvoidCrashObjectAtIndex:)];
        [__NSSingleObjectArrayI wi_swizzleInstanceMethod:@selector(objectAtIndex:) with:@selector(__NSSingleObjectArrayIAvoidCrashObjectAtIndex:)];
        [__NSArray0 wi_swizzleInstanceMethod:@selector(objectAtIndex:) with:@selector(__NSArray0AvoidCrashObjectAtIndex:)];
#endif
    });
}

- (id)safe_objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    } else {
        return [self objectAtIndex:index];
    }
}

/// 避免这种crash:@[@"aa", nilObj]
+ (instancetype)safe_arrayWithObjects:(const id [])objects count:(NSUInteger)cnt {
    id nObjects[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i]) {
            nObjects[j] = objects[i];
            j++;
        }
    }
    return [self safe_arrayWithObjects:nObjects count:j];
}

#pragma mark - objectAtIndexedSubscript:
- (id)__NSArrayIAvoidCrashObjectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;
    @try {
        object = [self __NSArrayIAvoidCrashObjectAtIndexedSubscript:idx];
    } @catch (NSException *exception) { //异常处理...
        [NSObject wi_recordException:exception];
    } @finally {
        return object;
    }
}

#pragma mark - objectsAtIndexes:
- (NSArray *)safe_objectsAtIndexes:(NSIndexSet *)indexes {
    NSArray *returnArray = nil;
    @try {
        returnArray = [self safe_objectsAtIndexes:indexes];
    } @catch (NSException *exception) { //异常处理...
        [NSObject wi_recordException:exception];
    } @finally {
        return returnArray;
    }
}

#pragma mark - objectAtIndex:
//__NSArrayI  objectAtIndex:
- (id)__NSArrayIAvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self __NSArrayIAvoidCrashObjectAtIndex:index];
    } @catch (NSException *exception) { //异常处理...
        [NSObject wi_recordException:exception];
    } @finally {
        return object;
    }
}

//__NSSingleObjectArrayI objectAtIndex:
- (id)__NSSingleObjectArrayIAvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self __NSSingleObjectArrayIAvoidCrashObjectAtIndex:index];
    } @catch (NSException *exception) { //异常处理...
        [NSObject wi_recordException:exception];
    } @finally {
        return object;
    }
}

//__NSArray0 objectAtIndex:
- (id)__NSArray0AvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self __NSArray0AvoidCrashObjectAtIndex:index];
    } @catch (NSException *exception) {//异常处理...
        [NSObject wi_recordException:exception];
    } @finally {
        return object;
    }
}

@end


@implementation NSMutableArray (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#ifndef DEBUG
        Class arrayCls = NSClassFromString(@"__NSArrayM");

        //insertObject:atIndex:
        [arrayCls wi_swizzleInstanceMethod:@selector(insertObject:atIndex:) with:@selector(safe_insertObject:atIndex:)];

        //setObject:atIndex:
        [arrayCls wi_swizzleInstanceMethod:@selector(setObject:atIndex:) with:@selector(safe_setObject:atIndex:)];

        //setObject:atIndexedSubscript:
        [arrayCls wi_swizzleInstanceMethod:@selector(setObject:atIndexedSubscript:) with:@selector(safe_setObject:atIndexedSubscript:)];

        //objectAtIndex:
        [arrayCls wi_swizzleInstanceMethod:@selector(objectAtIndex:) with:@selector(safe_objectAtIndex:)];

        //removeObjectAtIndex:
        [arrayCls wi_swizzleInstanceMethod:@selector(removeObjectAtIndex:) with:@selector(safe_removeObjectAtIndex:)];

        //objectAtIndexedSubscript
        if (@available(iOS 11.0,*)) {
            [arrayCls wi_swizzleInstanceMethod:@selector(objectAtIndexedSubscript:) with:@selector(safe_objectAtIndexedSubscript:)];
        }
#endif
    });
}

/// 避免这种crash: [myArray addObject:nilObj];
- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject) return;
    [self safe_insertObject:anObject atIndex:index];
}

/// 避免这种crash: [myArray addObject:nilObj];
- (void)safe_setObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject) return;
    [self safe_setObject:anObject atIndex:index];
}

///  避免这种crash: myArray[0] = nilObj;
- (void)safe_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (obj == nil ||self.count < idx) return;
    if (idx == self.count) {
        [self addObject:obj];
    } else {
        [self replaceObjectAtIndex:idx withObject:obj];
    }
}

#pragma mark - removeObjectAtIndex:
- (void)safe_removeObjectAtIndex:(NSUInteger)index {
    @try {
        [self safe_removeObjectAtIndex:index];
    } @catch (NSException *exception) { //异常处理...
        [NSObject wi_recordException:exception];
    } @finally {
    }
}

#pragma mark - objectAtIndex:
- (id)safe_objectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self safe_objectAtIndex:index];
    }@catch (NSException *exception) {//异常处理...
        [NSObject wi_recordException:exception];
    } @finally {
        return object;
    }
}

#pragma mark - objectAtIndexedSubscript:
- (id)safe_objectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;
    @try {
        object = [self safe_objectAtIndexedSubscript:idx];
    } @catch (NSException *exception) { //异常处理...
        [NSObject wi_recordException:exception];
    } @finally {
        return object;
    }
}

@end

@implementation NSArray (wi)

-(NSArray *)wi_removeDupWithKey:(NSString *)key ascending:(BOOL)ascending {
    if (!self) {
        return nil;
    }else if(self.count<=1){
        return self;
    }/* else if(![self.firstObject objectForKey:key]){
        return array;
    }*/else{
        @try {
            NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
            NSArray *sortArray = [self sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
            NSMutableArray *result = [NSMutableArray arrayWithObject:sortArray[0]];
            @autoreleasepool {
                for (int i = 0; i<sortArray.count-1; i++) {
                    NSObject *tempObj = sortArray[i+1];
                    NSString *time1 = [[sortArray[i] valueForKey:key] description];
                    NSString *time2 = [[tempObj valueForKey:key] description];;
                    if (time1 && [time1 isEqualToString:time2]) {
                        continue;
                    }else{
                        if ([result containsObject:tempObj]) {
                            continue;
                        }else {
                            [result addObject:tempObj];
                        }
                    }
                }
            }
            return result.copy;
        } @catch (NSException *exception) {
            [NSObject wi_recordException:exception];
            return self;
        }
    }
}

-(NSArray *)wi_sortWithKey:(NSString *)key ascending:(BOOL)ascending {
    if (!self) {
        return nil;
    }else if(self.count<=1){
        return self;
    }else{
        @try {
            NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
            return [self sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
        } @catch (NSException *exception) {
            [NSObject wi_recordException:exception];
            return self;
        }
    }
}

@end
