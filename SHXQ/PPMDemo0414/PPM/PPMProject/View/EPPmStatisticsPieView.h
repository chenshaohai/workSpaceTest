//
//  EPPmStatisticsPieView.h
//  2-13view
//
//  Created by luchanghao on 17/2/14.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,EPPmPieViewType){
    
    EPPmPieViewType_Task,   //按任务数
    EPPmPieViewType_Workload    //按工作量
    
};


@protocol EPPmStatisticsPieViewDelegate <NSObject>

-(void)pieIndexClick:(NSInteger)index;

@end

@interface EPPmStatisticsPieView : UIView

@property(nonatomic,weak)id<EPPmStatisticsPieViewDelegate>delegate;


-(instancetype)initWithFrame:(CGRect)frame andType:(EPPmPieViewType)type;

@end
