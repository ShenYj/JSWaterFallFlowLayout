//
//  JSWaterFallFlowLayout.h
//  JSWaterFallFlowLayout
//
//  Created by ShenYj on 2016/12/18.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSGoodsModel.h"

@interface JSWaterFallFlowLayout : UICollectionViewFlowLayout

/** item列数 ,每行Item的个数(默认为3) */
@property (nonatomic,assign) NSInteger itemColCount;

@end
