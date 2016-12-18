//
//  JSWaterFallFlowLayout.m
//  JSWaterFallFlowLayout
//
//  Created by ShenYj on 2016/12/18.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSWaterFallFlowLayout.h"

@interface JSWaterFallFlowLayout ()

@property (nonatomic,weak) JSGoodsModel *goods;

@end

@implementation JSWaterFallFlowLayout

- (instancetype)initWithGoods:(JSGoodsModel *)goods {
    self = [super init];
    if (self) {
        self.goods = goods;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = CGSizeMake(200, 280);
    
}

@end
