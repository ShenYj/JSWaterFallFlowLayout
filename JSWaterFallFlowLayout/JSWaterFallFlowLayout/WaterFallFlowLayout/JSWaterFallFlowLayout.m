//
//  JSWaterFallFlowLayout.m
//  JSWaterFallFlowLayout
//
//  Created by ShenYj on 2016/12/18.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "JSWaterFallFlowLayout.h"

@interface JSWaterFallFlowLayout ()

/** 存放改变后的控件属性 */
@property (nonatomic) NSMutableArray <UICollectionViewLayoutAttributes *>*itemAttributesArr;

@end

@implementation JSWaterFallFlowLayout


- (void)prepareLayout {
    [super prepareLayout];
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *itemAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.itemAttributesArr addObject:itemAttributes];
    }
}


/** 返回区域内控件共有的属性 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.itemAttributesArr;
}

/** 返回具体Item的属性 */
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //return [super layoutAttributesForItemAtIndexPath:indexPath]; 修改frame
    UICollectionViewLayoutAttributes *itemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    // 宽: CollectionView宽 - sectionLeftInset - sectionRightInset - cell的间距 * (item列数 - 1) / item的列数
    CGFloat attributeWidth = self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing*(self.itemColCount-1);
    // 高: CollectionView的高度/CollectionView的宽度 --> 宽高比例 * item计算后的宽度
    CGFloat attributeHeight = [self.dataSource percentageOfWaterFallFlawLayout:self withItemAtIndexPath:indexPath];
    // X: SectionLeft间距 + 变量 * (item宽度 + item内间距)
    CGFloat attributeCoordinateX = self.sectionInset.left + indexPath.item % self.itemColCount * (self.minimumInteritemSpacing + attributeWidth);
    // Y: SectionTop间距 + 变量 * (item高度 + item行间距)
    CGFloat attributeCoordinateY = self.sectionInset.top + indexPath.item / self.itemColCount * (self.minimumLineSpacing + attributeHeight);
    // 根据计算后的 x,y,w,h 重新设置Frame属性
    itemAttributes.frame = CGRectMake(attributeCoordinateX, attributeCoordinateY, attributeWidth, attributeHeight);
    return itemAttributes;
}

#pragma mark
#pragma mark - lazy

- (NSMutableArray <UICollectionViewLayoutAttributes *>*)itemAttributesArr {
    if (!_itemAttributesArr) {
        _itemAttributesArr = [NSMutableArray array];
    }
    return _itemAttributesArr;
}
/** ItemColCount默认值 */
- (NSInteger)itemColCount {
    if (_itemColCount == 0) {
        _itemColCount = 3;
    }
    return _itemColCount;
}

@end
