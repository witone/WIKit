//
//  UIViewController+wi.h
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (wi)

- (nullable UIViewController *)wi_visibleVCIfExist;

+ (nullable UIViewController *)wi_currentVC;

- (void)dissmissSelfAnimated:(BOOL)flag completion:(nullable void (^)(void))completion;

- (void)launchViewController:(UIViewController *)viewController animated: (BOOL)flag completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
