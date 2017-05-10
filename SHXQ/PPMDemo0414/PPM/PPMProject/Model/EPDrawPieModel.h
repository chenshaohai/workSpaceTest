//
//  EPDrawPieModel.h
//  2-13view
//
//  Created by luchanghao on 17/2/14.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EPDrawPieModel : NSObject
//赋值
@property (nonatomic, strong) NSMutableArray *valueArray;
@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat lineWidth;

-(void)setForFrame;
//计算
@property (nonatomic, strong) NSMutableArray *angleArray;
@property (nonatomic, strong) NSMutableArray *startAngleArray;
@end
