//
//  EPRMNavSelectView.h
//  E-Platform
//
//  Created by Apple on 2017/2/14.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EPRMNavSelectViewDelegate <NSObject>

- (void)clickNavItemWithIndex:(NSInteger)index;

@end

@interface EPRMNavSelectView : UIView
@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic, weak) id<EPRMNavSelectViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles selectIndex:(NSInteger)selectIndex;
- (void)show;
- (void)dismiss;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)reloadDataWithTitles:(NSArray *)titles selectIndex:(NSInteger)selectIndex;
@end

@interface EPRMNavSelectViewCell : UITableViewCell
- (void)fillDataWithTitle:(NSString *)title isSelect:(BOOL)isSelect;
@end
