//
//  ViewController.m
//  JSWaterFallFlowLayout
//
//  Created by ShenYj on 2016/12/18.
//  Copyright © 2016年 ShenYj. All rights reserved.
//

#import "ViewController.h"
#import "JSGoodsModel.h"

@interface ViewController ()

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
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    }
    return _collectionView;
}

@end
