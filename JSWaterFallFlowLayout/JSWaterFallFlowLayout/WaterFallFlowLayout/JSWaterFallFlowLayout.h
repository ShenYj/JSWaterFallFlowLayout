//
//  JSWaterFallFlowLayout.h
//  JSWaterFallFlowLayout
//
//  Created by ShenYj on 2016/12/18.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSWaterFallFlowLayout;

@protocol JSWaterFallFlowLayoutDataSource <NSObject>

@required
/** 获取图片的宽高比例 */
- (CGFloat)percentageOfWaterFallFlawLayout:(JSWaterFallFlowLayout *)waterFallFlowLayout withItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface JSWaterFallFlowLayout : UICollectionViewFlowLayout

/** item列数 ,每行Item的个数(默认为3) */
@property (nonatomic,assign) NSInteger itemColCount;

/** 代理对象 */
@property (nonatomic,weak) id <JSWaterFallFlowLayoutDataSource> dataSource;


@end
