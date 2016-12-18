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

// 重用标识
static NSString *const reuseIdentifier = @"waterFallFlowLayout";

@interface ViewController () <UICollectionViewDataSource>

/** 数据容器 */
@property (nonatomic) NSArray *goodsDatas;
/** CollectionView */
@property (nonatomic) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self prepareView];
}

- (void)prepareView {
    
    [self.collectionView registerClass:[JSWaterFallCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.view.backgroundColor = [UIColor whiteColor];
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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[JSWaterFallFlowLayout alloc] init]];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
