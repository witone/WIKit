//
//  UITabBar+wi.m
//  FBSnapshotTestCase
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "UITabBar+wi.h"
#import <objc/runtime.h>

static NSString * const wiBadgeViewInitedKey = @"wiBadgeViewInited";
static NSString * const wiBadgeDotViewsKey = @"wiBadgeDotViewsKey";
static NSString * const wiBadgeNumberViewsKey = @"wiBadgeNumberViewsKey";
static NSString * const wiTabIconWidth = @"wiTabIconWidth";
static NSString * const wiBadgeTop = @"wiBadgeTop";

@implementation UITabBar (wi)

-(void)setTabIconWidth:(CGFloat)width{
    [self setValue:@(width) forUndefinedKey:wiTabIconWidth];
}

-(void)setBadgeTop:(CGFloat)top{
    [self setValue:@(top) forUndefinedKey:wiBadgeTop];
}

-(void)setBadgeStyle:(WIBadgeStyle)type value:(NSInteger)badgeValue atIndex:(NSInteger)index{
    if( ![[self valueForKey:wiBadgeViewInitedKey] boolValue] ){
        [self setValue:@(YES) forKey:wiBadgeViewInitedKey];
        [self addBadgeViews];
    }
    NSMutableArray *badgeDotViews = [self valueForKey:wiBadgeDotViewsKey];
    NSMutableArray *badgeNumberViews = [self valueForKey:wiBadgeNumberViewsKey];
    
    [badgeDotViews[index] setHidden:YES];
    [badgeNumberViews[index] setHidden:YES];
    
    if(type == WIBadgeStyleRedDot){
        [badgeDotViews[index] setHidden:NO];
        
    }else if(type == WIBadgeStyleNumber){
        [badgeNumberViews[index] setHidden:NO];
        UILabel *label = badgeNumberViews[index];
        [self adjustBadgeNumberViewWithLabel:label number:badgeValue];
        
    }else if(type == WIBadgeStyleNone){
    }
}

-(void)addBadgeViews {
    id idIconWith = [self valueForKey:wiTabIconWidth];
    CGFloat tabIconWidth = idIconWith ? [idIconWith floatValue] : 32;
    id idBadgeTop = [self valueForKey:wiBadgeTop];
    CGFloat badgeTop = idBadgeTop ? [idBadgeTop floatValue] : 11;
    
    NSInteger itemsCount = self.items.count;
    CGFloat itemWidth = self.bounds.size.width / itemsCount;
    
    //dot views
    NSMutableArray *badgeDotViews = [NSMutableArray new];
    for(int i = 0;i < itemsCount;i ++){
        UIView *redDot = [UIView new];
        redDot.bounds = CGRectMake(0, 0, 10, 10);
        redDot.center = CGPointMake(itemWidth*(i+0.5)+tabIconWidth/2, badgeTop);
        redDot.layer.cornerRadius = redDot.bounds.size.width/2;
        redDot.clipsToBounds = YES;
        redDot.backgroundColor = [UIColor redColor];
        redDot.hidden = YES;
        [self addSubview:redDot];
        [badgeDotViews addObject:redDot];
    }
    [self setValue:badgeDotViews forKey:wiBadgeDotViewsKey];
    
    //number views
    NSMutableArray *badgeNumberViews = [NSMutableArray new];
    for(int i = 0;i < itemsCount;i ++){
        UILabel *redNum = [UILabel new];
        redNum.layer.anchorPoint = CGPointMake(0, 0.5);
        redNum.bounds = CGRectMake(0, 0, 20, 14);
        redNum.center = CGPointMake(itemWidth*(i+0.5)+tabIconWidth/2-10, badgeTop);
        redNum.layer.cornerRadius = redNum.bounds.size.height/2;
        redNum.clipsToBounds = YES;
        redNum.backgroundColor = [UIColor redColor];
        redNum.hidden = YES;

        redNum.textAlignment = NSTextAlignmentCenter;
        redNum.font = [UIFont systemFontOfSize:12];
        redNum.textColor = [UIColor whiteColor];
        
        [self addSubview:redNum];
        [badgeNumberViews addObject:redNum];
    }
    [self setValue:badgeNumberViews forKey:wiBadgeNumberViewsKey];
}

-(void)adjustBadgeNumberViewWithLabel:(UILabel *)label number:(NSInteger)number{
    [label setText:(number > 99 ? @"..." : @(number).stringValue)];
    if(number < 10){
        label.bounds = CGRectMake(0, 0, 14, 14);
    }else if(number < 99){
        label.bounds = CGRectMake(0, 0, 20, 14);
    }else{
        label.bounds = CGRectMake(0, 0, 20, 14);
    }
}

-(id)valueForUndefinedKey:(NSString *)key{
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    objc_setAssociatedObject(self, (__bridge const void *)(key), value, OBJC_ASSOCIATION_COPY);
}

@end
