//
//  CTDAvenueFRNodataView.h
//  CTDAvenueCI
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 CTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANodataView : UIView
@property (nonatomic,copy)NSString *tishiString;
@property (nonatomic,strong)UIColor *backgroundColor;

@property (nonatomic,strong)UIImage *noDataImage;
#pragma 显示刷新按钮   默认显示
/**
 *  显示刷新按钮 默认显示
 */
@property (nonatomic,assign)BOOL showRefreshButton;

@property (nonatomic, weak)UIButton *refreshButton;
/**
 * 刷新按钮点击  回调
 */
@property (nonatomic, copy) void (^refreshButtonClick) (ANodataView *noDataView,UIButton *refreshButton);
@end
