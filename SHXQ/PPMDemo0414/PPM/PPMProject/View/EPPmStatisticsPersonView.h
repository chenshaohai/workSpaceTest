//
//  EPPmStatisticsPersonView.h
//  2-13view
//
//  Created by luchanghao on 17/2/14.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,EPPmPersonViewType){
    
    EPPmPersonViewType_Task,  //按任务数
    EPPmPersonViewType_Workload   //按工作量
    
};

//typedef void(^StatisticsPersonViewBlock)(CGFloat);
//
//@interface EPPmStatisticsPersonView : UIView
//@property (nonatomic, copy) StatisticsPersonViewBlock block;
//
//-(instancetype)initWithFrame:(CGRect)frame andType:(EPPmPersonViewType)type;
//
//@end




@interface EPPmStatisticsPersonLineModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *totalStr;
@property (nonatomic, assign) long BGWidth;
@property (nonatomic, assign) long lightwidth;
@property (nonatomic, strong) UIColor *BGColor;
@property (nonatomic, strong) UIColor *hightLightColor;


@property (nonatomic, assign) CGFloat done;
@property (nonatomic, assign) CGFloat doing;
@property (nonatomic, assign) CGFloat todo;

@end


@interface EPPmStatisticsPersonLine : UITableViewCell
@property (nonatomic, strong) EPPmStatisticsPersonLineModel *model;
@end
