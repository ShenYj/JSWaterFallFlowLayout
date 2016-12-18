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
    self.goodsImageView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
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
    NSLayoutConstraint *rigth_IV = [NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                attribute:NSLayoutAttributeRight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.contentView
                                                                attribute:NSLayoutAttributeRight
                                                               multiplier:1
                                                                 constant:0
                                    ];
    [self.contentView addConstraint:rigth_IV];
    NSLayoutConstraint *bottom_IV = [NSLayoutConstraint constraintWithItem:self.goodsImageView
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1
                                                                  constant:0
                                     ];
    [self.contentView addConstraint:bottom_IV];
    
    
    

}

- (void)setGoods:(JSGoodsModel *)goods {
    _goods = goods;
    self.goodsImageView.image = goods.iconImage;
    self.goodsPriceLabel.text = @"1111";
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
        _goodsPriceLabel.font = [UIFont systemFontOfSize:10];
        _goodsPriceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _goodsPriceLabel;
}

@end
