//
//  EPCardTabBar.m
//  E-Platform
//
//  Created by xsccoco on 2016/10/17.
//  Copyright © 2016年 MEAGUT. All rights reserved.
//

#import "EPCardTabBar.h"
#import "EPCardTabCell.h"

NSString * const collectionViewId = @"cardChangeCollectionViewId";

@interface EPCardTabBar () <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation EPCardTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EPCardTabCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewId forIndexPath:indexPath];
    if (self.datas.count > indexPath.row) {
        cell.model = self.datas[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectItem = indexPath.item;
    [self chageSelectStatus];
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTabItemWithIndex:)]) {
        [self.delegate clickTabItemWithIndex:indexPath.item];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH / (self.datas.count), TABBAR_HEIGHT);
}

#pragma mark - UICollectionViewDelegateFlowLayout

#pragma mark -lazyload
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        [_collectionView registerClass:[EPCardTabCell class] forCellWithReuseIdentifier:collectionViewId];
        _collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT);
        _collectionView.backgroundColor = COLOR_RGB(27, 33, 51);
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [UICollectionViewFlowLayout new];
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;

    }
    return _layout;
}

#pragma mark - 加载数据
- (void)loadDataWithDatas:(NSArray *)datas
{
    self.datas = datas;
    [self.collectionView reloadData];
}

- (void)chageSelectStatus
{
    for (NSInteger i = 0; i < self.datas.count; i++) {
        EPCardTabModel *model = self.datas[i];
        if (i == _selectItem) {
            model.isSelect = YES;
        }else
        {
            model.isSelect = NO;
        }
    }
    
    [self.collectionView reloadData];
}


@end
