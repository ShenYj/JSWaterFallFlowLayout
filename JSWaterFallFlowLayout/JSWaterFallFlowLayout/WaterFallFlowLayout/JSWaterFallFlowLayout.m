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
/** 每个控件的宽度 */
@property (nonatomic,assign) CGFloat itemAttributeWidth;
/** 记录上一个控件的最大Y值 */
@property (nonatomic) NSMutableArray *tempItemAttributeArrMaxY;
/** 当前最大Y值 */
@property (nonatomic,assign) CGFloat currentMaxY;

@end

@implementation JSWaterFallFlowLayout


- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
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
    // return [super layoutAttributesForItemAtIndexPath:indexPath]; 修改frame
    UICollectionViewLayoutAttributes *itemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    // 宽: (CollectionView宽 - sectionLeftInset - sectionRightInset - cell的间距 * (item列数 - 1) )/ item的列数
    CGFloat attributeWidth = self.itemAttributeWidth;
    // 高: 图片的高度/图片的宽度 --> 宽高比例 * item计算后的宽度
    CGFloat attributeHeight = [self.dataSource percentageOfWaterFallFlawLayout:self withItemAtIndexPath:indexPath] * attributeWidth;
    // X: SectionLeft间距 + 变量 * (item宽度 + item内间距)
    CGFloat attributeCoordinateX = self.sectionInset.left + indexPath.item % self.itemColCount * (self.minimumInteritemSpacing + attributeWidth);
    // Y: 得到该coloum中上一个控件的最大的Y + 行间距
    CGFloat lastObjectMaxY = [self.tempItemAttributeArrMaxY[indexPath.item % self.itemColCount] doubleValue];
    CGFloat attributeCoordinateY = lastObjectMaxY + self.minimumLineSpacing;
    // 根据计算后的 x,y,w,h 重新设置Frame属性
    itemAttributes.frame = CGRectMake(attributeCoordinateX, attributeCoordinateY, attributeWidth, attributeHeight);
    // 记录当前coloum上控件的最大Y值
    self.tempItemAttributeArrMaxY[indexPath.item % self.itemColCount] = @(CGRectGetMaxY(itemAttributes.frame));
    
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

- (CGFloat)itemAttributeWidth {
    if (_itemAttributeWidth == 0) {
        // 宽: (CollectionView宽 - sectionLeftInset - sectionRightInset - cell的间距 * (item列数 - 1)) / item的列数
        _itemAttributeWidth = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing*(self.itemColCount-1)) / self.itemColCount;
    }
    return _itemAttributeWidth;
}

- (NSMutableArray *)tempItemAttributeArrMaxY {
    if (!_tempItemAttributeArrMaxY) {
        _tempItemAttributeArrMaxY = [NSMutableArray array];
        for (int i = 0; i < self.itemColCount; i++) {
            [_tempItemAttributeArrMaxY addObject:@0];
        }
    }
    return _tempItemAttributeArrMaxY;
}

@end
