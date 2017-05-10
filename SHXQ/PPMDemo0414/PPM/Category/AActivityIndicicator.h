//
//  AActivityIndicicator.h
//  自定义加载中
//
//  Created by FRadmin on 16/7/30.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface AActivityIndicicator : UIView
@property (strong,nonatomic) UIColor * color;
-(instancetype)init;
-(void)start;
-(void)stop;
@end
