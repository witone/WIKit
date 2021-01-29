//
//  WIProgressView.m
//  WIKit
//
//  Created by zyp on 01/29/2021.
//  Copyright (c) 2021 zyp. All rights reserved.
//

#import "WIProgressView.h"
#import "UIView+wi.h"
#import "CALayer+wi.h"

@interface WIProgressView ()

@property (nonatomic, strong) CALayer *mProgressLayer;

@end

@implementation WIProgressView

- (instancetype)initWithProgressViewStyle:(WIProgressViewStyle)style {
    if (self = [super initWithFrame:CGRectZero]) {
        [self setDefaultParameters];
        self.progressViewStyle = style;
        [self initView];
    }
    return self;
}

-(instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setDefaultParameters];
        [self initView];
    }
    return self;
}

- (void)setDefaultParameters {
    self.trackTintColor = UIColor.whiteColor;
    self.progressTintColor = UIColor.blueColor;
}

-(void)initView {
    [self.layer addSublayer:self.mProgressLayer];
}

-(void)layoutSubviews {
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat bordwidth = self.layer.borderWidth;
    self.mProgressLayer.frame = CGRectMake(0, bordwidth, CGRectGetWidth(self.bounds)*self.progress, height - bordwidth*2);
    if (self.progressViewStyle == WIProgressViewStyleDefault) {
        [self.mProgressLayer wi_radiusWithRadius:0 corner:UIRectCornerAllCorners];
        [self wi_radiusWithRadius:0 corner:UIRectCornerAllCorners];
    }else {
        [self.mProgressLayer wi_radiusWithRadius:(height - bordwidth*2)/2 corner:UIRectCornerAllCorners];
        [self wi_radiusWithRadius:height/2 corner:UIRectCornerAllCorners];
    }
}

-(void)setProgressTintColor:(UIColor *)progressTintColor {
    _progressTintColor = progressTintColor;
    self.mProgressLayer.backgroundColor = progressTintColor.CGColor;
}

-(void)setProgress:(float)progress {
    _progress = progress;
    [self layoutSubviews];
}

- (void)setProgress:(float)progress animated:(BOOL)animated {
    self.progress = progress;
    [self layoutSubviews];
}

-(void)setTrackTintColor:(UIColor *)trackTintColor {
    _trackTintColor = trackTintColor;
    self.backgroundColor = trackTintColor;
}

-(CALayer *)mProgressLayer {
    if (!_mProgressLayer) {
        _mProgressLayer = [CALayer layer];
    }
    return _mProgressLayer;
}

@end
