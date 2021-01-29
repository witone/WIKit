//
//  UIScrollView+wi.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "UIScrollView+wi.h"
#import "NSObject+wi.h"
#import "objc/runtime.h"

static NSString *wiGestureDelegateKey = @"wiGestureDelegateKey";

@implementation UIScrollView (wi)

- (id<WIScrollViewGestureDelegate>)wi_gestureDelegate {
    return objc_getAssociatedObject(self, &wiGestureDelegateKey);
}

-(void)setWi_gestureDelegate:(id<WIScrollViewGestureDelegate>)wi_gestureDelegate {
    __weak __typeof(&*self) weakSelf = self;
    [self setWi_block:^{
        objc_setAssociatedObject(weakSelf, &wiGestureDelegateKey, nil, OBJC_ASSOCIATION_ASSIGN);
    }];
    objc_setAssociatedObject(self, &wiGestureDelegateKey, wi_gestureDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.wi_gestureDelegate && [self.wi_gestureDelegate respondsToSelector:@selector(scrollView:gestureRecognizerShouldBegin:)]) {
        return [self.wi_gestureDelegate scrollView:self gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.wi_gestureDelegate && [self.wi_gestureDelegate respondsToSelector:@selector(scrollView:gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)]) {
        return [self.wi_gestureDelegate scrollView:self gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    return NO;
}

- (void)wi_scrollToTop {
    [self wi_scrollToTopAnimated:YES];
}

- (void)wi_scrollToBottom {
    [self wi_scrollToBottomAnimated:YES];
}

- (void)wi_scrollToLeft {
    [self wi_scrollToLeftAnimated:YES];
}

- (void)wi_scrollToRight {
    [self wi_scrollToRightAnimated:YES];
}

- (void)wi_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)wi_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)wi_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)wi_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end
