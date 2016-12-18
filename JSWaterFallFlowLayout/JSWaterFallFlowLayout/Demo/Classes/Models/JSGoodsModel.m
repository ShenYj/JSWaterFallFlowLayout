//
//  JSGoodsModel.m
//  JSWaterFallFlowLayout
//
//  Created by ShenYj on 2016/12/18.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSGoodsModel.h"

@implementation JSGoodsModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)goodsWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
