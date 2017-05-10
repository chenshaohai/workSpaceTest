//
//  EPCardTabBar.h
//  E-Platform
//
//  Created by xsccoco on 2016/10/17.
//  Copyright © 2016年 MEAGUT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EPCardTabBarDelegate <NSObject>

- (void)clickTabItemWithIndex:(NSInteger)index;

@end

@interface EPCardTabBar : UIView
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectItem;
@property (nonatomic, weak) id<EPCardTabBarDelegate> delegate;
@property (nonatomic, strong) NSArray *datas;
- (void)loadDataWithDatas:(NSArray *)datas;
- (void)chageSelectStatus;
@end
