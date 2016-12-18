//
//  JSWaterFallCollectionViewCell.m
//  JSWaterFallFlowLayout
//
//  Created by ShenYj on 2016/12/18.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSWaterFallCollectionViewCell.h"

@interface JSWaterFallCollectionViewCell ()

@property (nonatomic) UIImageView *goodsImageView;
@property (nonatomic) UILabel *goodsPriceLabel;

@end

@implementation JSWaterFallCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareView];
    }
    return self;
}

- (void)prepareView {
    
    [self.contentView addSubview:self.goodsImageView];
    [self.contentView addSubview:self.goodsPriceLabel];
    self.goodsImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.goodsPriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    
    NSLayoutConstraint *top_IV = [NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.contentView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1
                                                               constant:0
                                  ];
    [self.contentView addConstraint:top_IV];
    NSLayoutConstraint *left_IV = [NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1
                                                                constant:0
                                   ];
    [self.contentView addConstraint:left_IV];
    NSLayoutConstraint *right_IV = [NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                attribute:NSLayoutAttributeRight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.contentView
                                                                attribute:NSLayoutAttributeRight
                                                               multiplier:1
                                                                 constant:0
                                    ];
    [self.contentView addConstraint:right_IV];
    NSLayoutConstraint *bottom_IV = [NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1
                                                                  constant:0
                                     ];
    [self.contentView addConstraint:bottom_IV];
    
    NSLayoutConstraint *bottom_L = [NSLayoutConstraint constraintWithItem:self.goodsPriceLabel
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.contentView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1
                                                                 constant:0
                                    ];
    [self.contentView addConstraint:bottom_L];
    NSLayoutConstraint *left_L = [NSLayoutConstraint constraintWithItem:self.goodsPriceLabel
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.contentView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1
                                                               constant:0
                                  ];
    [self.contentView addConstraint:left_L];
    NSLayoutConstraint *right_L = [NSLayoutConstraint constraintWithItem:self.goodsPriceLabel
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1
                                                                constant:0
                                   ];
    [self.contentView addConstraint:right_L];
    NSLayoutConstraint *height_L = [NSLayoutConstraint constraintWithItem:self.goodsPriceLabel
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1
                                                                 constant:40
                                    ];
    [self.contentView addConstraint:height_L];

}

- (void)setGoods:(JSGoodsModel *)goods {
    _goods = goods;
    self.goodsImageView.image = goods.iconImage;
    self.goodsPriceLabel.text = goods.price;
}

#pragma mark
#pragma mark - lazy

- (UIImageView *)goodsImageView {
    if (_goodsImageView == nil) {
        _goodsImageView = [[UIImageView alloc] init];
    }
    return _goodsImageView;
}

- (UILabel *)goodsPriceLabel {
    if (_goodsPriceLabel == nil) {
        _goodsPriceLabel = [[UILabel alloc] init];
        _goodsPriceLabel.textColor = [UIColor purpleColor];
        _goodsPriceLabel.font = [UIFont systemFontOfSize:12];
        _goodsPriceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _goodsPriceLabel;
}

@end
