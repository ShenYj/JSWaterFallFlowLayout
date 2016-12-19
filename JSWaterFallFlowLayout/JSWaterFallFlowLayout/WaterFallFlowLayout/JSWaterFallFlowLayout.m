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
/** 记录每一列中上一个控件的最大Y值的数组 */
@property (nonatomic) NSMutableArray *tempItemAttributeArrMaxY;
/** 当前最大Y值,用来计算CollectionView ContentSize */
@property (nonatomic,assign) CGFloat currentMaxY;
/** 当前控件中最小的Y值, 决定下一个控件在最小Y值这一列中的位置 */
@property (nonatomic,assign) CGFloat currentMinY;
/** 最小Y值所在的列数,决定下一个控件排列的列数 */
@property (nonatomic,assign) NSInteger currentMinYCol;

@end

@implementation JSWaterFallFlowLayout

/** 设置布局 */
- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 遍历所有Item,取出公共属性,存放到数组中,用以修改Frame
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *itemAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.itemAttributesArr addObject:itemAttributes];
    }
    // 添加FooterView (section为1组的情况下,而Item始终未0)
    NSIndexPath *footerViewIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    UICollectionViewLayoutAttributes *footerViewAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:footerViewIndexPath];
    // 需要设置下Frame,并且在自定义Layout的情况下,所有值都有意义
    self.footerReferenceSize = CGSizeMake(self.collectionView.bounds.size.width, self.footerViewHeight);
    footerViewAttributes.hidden = NO;
    footerViewAttributes.frame = CGRectMake(0, self.currentMaxY , self.collectionView.bounds.size.width, self.footerReferenceSize.height);
    [self.itemAttributesArr addObject:footerViewAttributes];
    
}

/** 返回区域内控件共有的属性 (包含HeaderView和FooterView) */
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
    // Y: 取出每一列中记录下来的控件,在最小Y值的列上添加此控件 (先计算Y轴坐标,调用self.currentMinY,计算出当前最小的列数self.currentMinYCol)
    CGFloat attributeCoordinateY = self.currentMinY + self.minimumLineSpacing;
    // X: SectionLeft间距 + Y坐标最小的列数 * (item宽度 + item内间距)
    CGFloat attributeCoordinateX = self.sectionInset.left + self.currentMinYCol * (self.minimumInteritemSpacing + attributeWidth);
    // 根据计算后的 x,y,w,h 重新设置Frame属性
    itemAttributes.frame = CGRectMake(attributeCoordinateX, attributeCoordinateY, attributeWidth, attributeHeight);
    // 记录当前coloum上控件的最大Y值 (更新数组中,当前列上的元素)
    self.tempItemAttributeArrMaxY[self.currentMinYCol] = @(CGRectGetMaxY(itemAttributes.frame));
    
    return itemAttributes;
}

/** CollectionView的滚动区域 */
- (CGSize)collectionViewContentSize {
    // 组头的高度 + 顶部的组内间距 + 最大Y值 + 底部的组内间距 + 组尾的高度
    return CGSizeMake(0, self.headerReferenceSize.height + self.sectionInset.top + self.currentMaxY + self.sectionInset.bottom + self.footerReferenceSize.height);
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

- (CGFloat)currentMinY {
    _currentMinY = MAXFLOAT;
    [self.tempItemAttributeArrMaxY enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj doubleValue] < _currentMinY) {
            _currentMinY = [obj doubleValue];
            // 记录当前最小Y值所在的列数
            self.currentMinYCol = idx;
        }
    }];
    return _currentMinY;
}

// 获取最大Y轴坐标,计算ContentSize
- (CGFloat)currentMaxY {
    _currentMaxY = 0.f;
    for (NSNumber *number in self.tempItemAttributeArrMaxY) {
        _currentMaxY = ( _currentMaxY > number.doubleValue ) ? _currentMaxY : number.doubleValue;
    }
    return _currentMaxY;
}

- (CGFloat)footerViewHeight {
    if (_footerViewHeight == 0) {
        _footerViewHeight = 60.f;
    }
    return _footerViewHeight;
}

@end
