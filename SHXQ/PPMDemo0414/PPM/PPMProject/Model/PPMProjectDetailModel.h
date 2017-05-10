//
//  PPMProjectDetailModel.h
//  PPM
//
//  Created by lu_ios on 17/4/17.
//  Copyright © 2017年 e-lead. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    PPMProjectDetailDegreeLow = 0, //等级低
    PPMProjectDetailDegreeNormal = 1,  //等级中
    PPMProjectDetailDegreeHigh = 2  //等级高
}PPMProjectDetailDegreeType;

@interface PPMProjectDetailModel : NSObject
/**
 *  部门
 */
@property(nonatomic,copy)NSString *depart;
/**
 *  编号
 */
@property(nonatomic,copy)NSString *number;

/**
 *  小部门
 */
@property(nonatomic,copy)NSString *departSecond;

/**
 *  责任人
 */
@property(nonatomic,copy)NSString *manName;

/**
 *  计划
 */
@property(nonatomic,strong)NSArray *planData;

/**
 *  计划frame
 */
@property(nonatomic,assign)CGRect planDataFrame;
/**
 *  计划宽度
 */
@property(nonatomic,assign)CGFloat planDataWidth;
/**
 *  执行
 */
@property(nonatomic,strong)NSArray *executeData;

/**
 *  执行frame
 */
@property(nonatomic,assign)CGRect executeDataFrame;
/**
 *  执行宽度
 */
@property(nonatomic,assign)CGFloat executeDataWidth;

/**
 *  红线frame
 */
@property(nonatomic,assign)CGRect redLineFrame;

/**
 *   风险等级
 */
@property(nonatomic,assign)PPMProjectDetailDegreeType degreeTpye;

/**
 *   详情文字
 */
@property(nonatomic,copy)NSString *detailText;


/**
 *  底部文字的高度
 */
@property(nonatomic,assign)CGFloat highDetailText;


+ (id)modelWithDic:(NSDictionary *)dic;
- (id)initWithDic:(NSDictionary *)dic;
@end
