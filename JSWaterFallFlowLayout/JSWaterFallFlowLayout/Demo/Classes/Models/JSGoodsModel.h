//
//  JSGoodsModel.h
//  JSWaterFallFlowLayout
//
//  Created by ShenYj on 2016/12/18.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSGoodsModel : NSObject

/** 图片高度 */
@property (nonatomic) NSNumber *height;
/** 图片宽度 */
@property (nonatomic) NSNumber *width;
/** 图片地址 */
@property (nonatomic,copy) NSString *icon;
/** 商品价格 */
@property (nonatomic,copy) NSString *price;

/** 实例方法&类方法 */
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)goodsWithDict:(NSDictionary *)dict;

@end
