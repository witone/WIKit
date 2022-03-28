//
//  UIViewController+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "UIViewController+wi.h"

@implementation UIViewController (wi)

- (nullable UIViewController *)wi_visibleVCIfExist {
    if (self.presentedViewController) {
        return [self.presentedViewController wi_visibleVCIfExist];
    }
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        return [((UINavigationController *)self).visibleViewController wi_visibleVCIfExist];
    }
    
    if ([self isKindOfClass:[UITabBarController class]]) {
        return [((UITabBarController *)self).selectedViewController wi_visibleVCIfExist];
    }

    return self;
}

+ (nullable UIViewController *)wi_currentVC {
    UIViewController *rootVC = UIApplication.sharedApplication.delegate.window.rootViewController;
    UIViewController *visibleVC = [rootVC wi_visibleVCIfExist];
    return visibleVC;
}

- (void)dismissAnimated:(BOOL)flag completion:(void (^)(void))completion {
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:flag];
        if (completion) completion();
    }else {
        [self dismissViewControllerAnimated:flag completion:completion];
    }
}

- (void)launchViewController:(UIViewController *)viewController animated: (BOOL)flag completion:(void (^)(void))completion {
    if (self.navigationController) {
        [self.navigationController pushViewController:viewController animated:flag];
        if (completion) completion();
    }else {
        [self presentViewController:viewController animated:flag completion:completion];
    }
}

@end
