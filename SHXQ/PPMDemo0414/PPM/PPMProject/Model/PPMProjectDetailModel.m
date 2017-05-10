//
//  PPMProjectDetailModel.m
//  PPM
//
//  Created by lu_ios on 17/4/17.
//  Copyright © 2017年 e-lead. All rights reserved.
//

#import "PPMProjectDetailModel.h"
#import "PPMProgressModel.h"
#import "NSString+Size.h"
@implementation PPMProjectDetailModel

+(id)modelWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        _depart = dic[@"depart"]?dic[@"depart"]:@"";
        _number = dic[@"number"]?dic[@"number"]:@"";
        _departSecond = dic[@"departSecond"]?dic[@"departSecond"]:@"";
        _manName = dic[@"manName"]?dic[@"manName"]:@"";
        
       //初始宽度
        CGFloat minWidth = 50;
        //间距
        CGFloat padding = 15;
        //左边右间距
#warning todo
//        CGFloat leftRightPadding = 20;
        CGFloat leftRightPadding = 10;
        //每天占的宽度
        CGFloat everyDayWidth = 2.0;
        //计划和执行上下间距
        CGFloat planAndExcutePadding = 4;
        
        //PPMProgressModel的高度
        CGFloat progressModelHigh = 40;
        
        NSArray *planData = dic[@"planData"]?dic[@"planData"]:nil;
        NSMutableArray *planArray = [NSMutableArray array];
        int i = 0;
        CGFloat  planX = leftRightPadding;
        CGFloat  planY = 30;
        for (NSDictionary *planDict in planData) {
            PPMProgressModel *projectModel = [PPMProgressModel modelWithDic:planDict];
            CGFloat width = minWidth + projectModel.totalDay * everyDayWidth;
            CGRect progressFrame = CGRectMake(planX, planY, width, progressModelHigh);
            projectModel.progressFrame = progressFrame;
            [planArray addObject:projectModel];
            
            i++;
            //不是最后一个
            if (i < planData.count) {
                //计算下一个的x   初始尺寸 ＋ 宽度 ＋ 间距
                planX = planX + width + padding;
                //最后一个
            }else{
                //初始尺寸 ＋ 宽度 ＋ 右边间距
                planX = planX + width + leftRightPadding;
            }
        }
        _planDataWidth = planX;
        
        _planDataFrame = CGRectMake(0, planY, _planDataWidth, progressModelHigh);
        
        _planData = planArray;
        
        
        NSArray *executeData = dic[@"executeData"]?dic[@"executeData"]:nil;
        NSMutableArray *executeArray = [NSMutableArray array];
        int j = 0;
        CGFloat  executeX = leftRightPadding;
        CGFloat  executeY = planY + progressModelHigh +  planAndExcutePadding;
        for (NSDictionary *executeDict in executeData) {
            PPMProgressModel *projectModel = [PPMProgressModel modelWithDic:executeDict];
            CGFloat width = minWidth + projectModel.totalDay * everyDayWidth;
            CGRect progressFrame = CGRectMake(executeX, executeY, width, progressModelHigh);
            projectModel.progressFrame = progressFrame;
            [executeArray addObject:projectModel];
            
            j++;
            //不是最后一个
            if (j < executeData.count) {
                //计算下一个的x   初始尺寸 ＋ 宽度 ＋ 间距
                executeX = executeX + width + padding;
                //最后一个
            }else{
                //初始尺寸 ＋ 宽度
                executeX = executeX + width;
            }
        }
        _executeDataWidth = executeX;
        
        _executeDataFrame = CGRectMake(0, executeY, _executeDataWidth, progressModelHigh);
        
        
        
        _redLineFrame = CGRectMake(executeX, planY + progressModelHigh / 3 , 0.5, progressModelHigh * 4 / 3 + planAndExcutePadding);
        
        _executeData = executeArray;
        
      NSString *degree = dic[@"degree"]?dic[@"degree"]:@"";
        if ([degree isEqual:@"low"]) {
            _degreeTpye = PPMProjectDetailDegreeLow;
        }else if([degree isEqual:@"normal"]){
            _degreeTpye = PPMProjectDetailDegreeNormal;
        }else{
            _degreeTpye = PPMProjectDetailDegreeHigh;
        }
        
        
        //底部相关细节
        _detailText = dic[@"detailText"]?dic[@"detailText"]:@"";
        CGSize size = [NSString sizeWithText:_detailText font:MyFont(12) maxWidth:kViewWidth - 48];
        // 上下留 10的高度
        _highDetailText = size.height + 20;
        
    }
    return self;
}
@end
