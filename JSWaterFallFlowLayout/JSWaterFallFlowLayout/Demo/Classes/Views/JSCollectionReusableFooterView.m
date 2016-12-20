//
//  JSCollectionReusableFooterView.m
//  JSWaterFallFlowLayout
//
//  Created by ShenYj on 2016/12/19.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSCollectionReusableFooterView.h"



@implementation JSCollectionReusableFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareView];
    }
    return self;
}

- (void)prepareView {
    self.backgroundColor = [UIColor purpleColor];
    [self addSubview:self.indicatorView];
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *centerY_indicatorV = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraint:centerY_indicatorV];
    NSLayoutConstraint *centerX_indicatorV = [NSLayoutConstraint constraintWithItem:self.indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self addConstraint:centerX_indicatorV];
    
}


- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _indicatorView;
}

@end
