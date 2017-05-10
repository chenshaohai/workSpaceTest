//
//  PPMProgressModel.h
//  PPM
//
//  Created by lu_ios on 17/4/14.
//  Copyright © 2017年 e-lead. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    PPMProgressPlan = 0, //计划
    PPMProgressExecute = 1  //实际
}PPMProgressType;

@interface PPMProgressModel : NSObject
/**
 *  开始日期
 */
@property(nonatomic,copy)NSString *startDay;
/**
 *  结束日期
 */
@property(nonatomic,copy)NSString *endDay;

/**
 *  模型类型  计划  实际
 */
@property(nonatomic,assign)PPMProgressType progressType;

/**
 *  天数  宽度
 */
@property(nonatomic,assign)NSInteger totalDay;

/**
 *  标题
 */
@property(nonatomic,copy)NSString *title;

/**
 *  frame
 */
@property(nonatomic,assign)CGRect progressFrame;

+ (id)modelWithDic:(NSDictionary *)dic;
- (id)initWithDic:(NSDictionary *)dic;
@end
