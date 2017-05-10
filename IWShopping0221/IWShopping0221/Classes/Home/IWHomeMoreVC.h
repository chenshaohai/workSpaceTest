//
//  IWHomeMoreVC.h
//  IWShopping0221
//
//  Created by MacBook on 2017/2/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWHomeMoreVC : UIViewController
// id
@property (nonatomic,copy)NSString *regionId;
// 搜索内容
@property (nonatomic,copy)NSString *content;
// 首页点击搜索跳转
@property (nonatomic,assign)BOOL isHome;
@end
