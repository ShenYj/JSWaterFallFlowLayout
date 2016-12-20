//
//  ViewController.m
//  JSWaterFallFlowLayout
//
//  Created by ShenYj on 2016/12/18.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSGoodsModel.h"
#import "JSWaterFallCollectionViewCell.h"
#import "JSWaterFallFlowLayout.h"
#import "JSCollectionReusableFooterView.h"

// 重用标识
static NSString *const reuseIdentifier = @"waterFallFlowLayout";
static NSString *const reuseFooterIdentifier = @"footerIdentifier";

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate,JSWaterFallFlowLayoutDataSource>

/** 数据容器 */
@property (nonatomic) NSArray *goodsDatas;
/** 瀑布流布局 */
@property (nonatomic) JSWaterFallFlowLayout *waterFallFlowLayout;
/** CollectionView */
@property (nonatomic) UICollectionView *collectionView;
/** 记录FooterView,用以判断是否刷新条件之一 */
@property (nonatomic,weak) JSCollectionReusableFooterView *footerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self prepareView];
}

- (void)prepareView {
    
    [self.collectionView registerClass:[JSWaterFallCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[JSCollectionReusableFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooterIdentifier];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"瀑布流演示";
    [self.view addSubview:self.collectionView];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    NSLayoutConstraint *left_CV = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    [self.view addConstraint:left_CV];
    NSLayoutConstraint *top_CV = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self.view addConstraint:top_CV];
    NSLayoutConstraint *right_CV = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [self.view addConstraint:right_CV];
    NSLayoutConstraint *bottom_CV = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view addConstraint:bottom_CV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark - JSWaterFallFlowLayoutDataSource
- (CGFloat)percentageOfWaterFallFlawLayout:(JSWaterFallFlowLayout *)waterFallFlowLayout withItemAtIndexPath:(NSIndexPath *)indexPath {
    JSGoodsModel *goodsModel = self.goodsDatas[indexPath.item];
    return goodsModel.height.floatValue / goodsModel.width.floatValue;
}

#pragma mark
#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSWaterFallCollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    collectionViewCell.goods = self.goodsDatas[indexPath.item];
    return collectionViewCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    JSCollectionReusableFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooterIdentifier forIndexPath:indexPath];
    self.footerView = footerView;
    return footerView;
}

#pragma mark
#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.footerView && !self.footerView.indicatorView.isAnimating) {
        [self.footerView.indicatorView startAnimating];
    }
}

#pragma mark
#pragma mark - lazy

- (NSArray *)goodsDatas {
    if (_goodsDatas == nil) {
        NSArray *goodsArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"waterFall.plist" ofType:nil]];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in goodsArr) {
            JSGoodsModel *goods = [JSGoodsModel goodsWithDict:dict];
            [tempArr addObject:goods];
        }
        _goodsDatas = tempArr.copy;
    }
    return _goodsDatas;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.waterFallFlowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (JSWaterFallFlowLayout *)waterFallFlowLayout {
    if (!_waterFallFlowLayout) {
        _waterFallFlowLayout = [[JSWaterFallFlowLayout alloc] init];
        _waterFallFlowLayout.dataSource = self;
    }
    return _waterFallFlowLayout;
}

@end
