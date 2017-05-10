//
//  EPCardTabModel.m
//  E-Platform
//
//  Created by xsccoco on 2016/10/17.
//  Copyright © 2016年 MEAGUT. All rights reserved.
//

#import "EPCardTabModel.h"
//#import "EPCardManagerBaseModel.h"

@interface EPCardTabModel ()
@property (nonatomic, strong) NSArray *cardDics;
@property (nonatomic, weak)   id target;
@end

@implementation EPCardTabModel

+ (instancetype)modelWithDic:(NSDictionary *)dic target:(id)target
{
    return [[self alloc]initWithDic:dic target:target];
}

- (instancetype)initWithDic:(NSDictionary *)dic target:(id)target
{
    self = [super init];
    if (self && dic && [dic isKindOfClass:[NSDictionary class]]) {
        self.tabTitle = [NSString stringWithFormat:@"%@",dic[@"tabTitle"]];
        self.navTitle = [NSString stringWithFormat:@"%@",dic[@"navTitle"]];
        self.imgUrl = [NSString stringWithFormat:@"%@",dic[@"imgUrl"]];
        self.selectImgUrl = [NSString stringWithFormat:@"%@",dic[@"selectImgUrl"]];
        self.cards = [[NSMutableArray alloc]init];
        self.cardDics = dic[@"cards"];
        self.target = target;
        
        //研发移动化添加字段
        if (dic[@"contentViewType"] && [dic[@"contentViewType"] isKindOfClass:[NSString class]]) {
            [self resetContentViewType:dic[@"contentViewType"]];
        }else
        {
            //排除未定义的view
//            self.contentViewType = 10000;
        }
        
        if (dic[@"isNavTitleView"] && [dic[@"isNavTitleView"] isEqualToString:@"1"]) {
            self.isNavTitleView = YES;
            self.navTitles = dic[@"navTitles"];
            self.navContentViewTypes = dic[@"navContentViewTypes"];
            self.selectNavIndex = [dic[@"selectNavIndex"] integerValue];
        }
       
    }
    return self;
}

- (EPRMContentViewType)resetContentViewType:(NSString *)contentViewType
{
    if ([contentViewType isEqualToString:@"EPPmplanView"]) {
        self.contentViewType = EPRMContentViewType_Pmplan;
    }else if ([contentViewType isEqualToString:@"EPPmStatisticsView"])
    {
        self.contentViewType = EPRMContentViewType_PmStatistics;
    }else if ([contentViewType isEqualToString:@"EPDpProjectView"])
    {
        self.contentViewType = EPRMContentViewType_DpProject;
    }else if ([contentViewType isEqualToString:@"EPDpRiskView"])
    {
        self.contentViewType = EPRMContentViewType_DpRisk;
    }else if ([contentViewType isEqualToString:@"EPDpWeeklyView"])
    {
        self.contentViewType = EPRMContentViewType_DpWeekly;
    }else if ([contentViewType isEqualToString:@"EPDpProblemView"])
    {
        self.contentViewType = EPRMContentViewType_DpProblem;
    }else if ([contentViewType isEqualToString:@"EPDpResourceView"])
    {
        self.contentViewType = EPRMContentViewType_DpResource;
    }else if ([contentViewType isEqualToString:@"EPPmRiskView"])
    {
        self.contentViewType = EPRMContentViewType_PmRisk;
    }else if ([contentViewType isEqualToString:@"EPPmProblemView"])
    {
        self.contentViewType = EPRMContentViewType_PmProblem;
    }else if ([contentViewType isEqualToString:@"EPPmDynamicWeeklyView"])
    {
        self.contentViewType = EPRMContentViewType_PmWeekly;
    }else if ([contentViewType isEqualToString:@"EPMePartTaskView"])
    {
        self.contentViewType = EPRMContentViewType_MeTask;
    }else if ([contentViewType isEqualToString:@"EPMeWeeklyView"])
    {
        self.contentViewType = EPRMContentViewType_MeWeekly;
    }else if ([contentViewType isEqualToString:@"EPMeQuestionView"])
    {
        self.contentViewType = EPRMContentViewType_MeProblem;
    }else if ([contentViewType isEqualToString:@"EPMeMyFileView"])
    {
        self.contentViewType = EPRMContentViewType_MeProject;
    }else if ([contentViewType isEqualToString:@"EPMeCooperationView"])
    {
        self.contentViewType = EPRMContentViewType_MeCooperation;
    }else if ([contentViewType isEqualToString:@"EPObPartProjectView"])
    {
        self.contentViewType = EPRMContentViewType_ObProject;
    }else if ([contentViewType isEqualToString:@"EPPmProjectView"])
    {
        self.contentViewType = EPRMContentViewType_PmProject;
    }else if ([contentViewType isEqualToString:@"EPObStatisticsView"])
    {
        self.contentViewType = EPRMContentViewType_ObStatistics;
    }
    
    
    
    
    return self.contentViewType;
}

- (void)getCardsDatas
{
    if (self.cardDics && [self.cardDics isKindOfClass:[NSArray class]]) {
        self.hasCards = YES;
        for (NSInteger i = 0; i < self.cardDics.count; i++) {
//            EPCardManagerBaseModel *model = [EPCardManagerBaseModel modelWithDic:self.cardDics[i] target:self.target];
//            [self.cards addObject:model];
        }
    }
}
@end
