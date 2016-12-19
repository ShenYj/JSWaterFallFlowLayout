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
        UICollectionViewLayoutAttributes *itemAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
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
    CGFloat attributeHeight;
    CGFloat attributeCoordinateX;
    CGFloat attributeCoordinateY;
    
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
