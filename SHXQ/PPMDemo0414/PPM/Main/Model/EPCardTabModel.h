//
//  EPCardTabModel.h
//  E-Platform
//
//  Created by xsccoco on 2016/10/17.
//  Copyright © 2016年 MEAGUT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,EPRMContentViewType) {
    EPRMContentViewType_DpProject,       //部门负责人-项目
    EPRMContentViewType_DpRisk,          //部门负责人-风险
    EPRMContentViewType_DpWeekly,        //部门负责人-周报
    EPRMContentViewType_DpProblem,       //部门负责人-问题
    EPRMContentViewType_DpResource,      //部门负责人-资源
    
    EPRMContentViewType_Pmplan,          //项目管理-计划
    EPRMContentViewType_PmStatistics,    //项目管理-统计
    EPRMContentViewType_PmRisk,          //项目管理-风险
    EPRMContentViewType_PmWeekly,        //项目管理-周报
    EPRMContentViewType_PmProblem,       //项目管理-问题
    EPRMContentViewType_PmProject,       //项目管理-项目
    
    EPRMContentViewType_MeTask,          //项目成员-任务
    EPRMContentViewType_MeProblem,       //项目成员-问题
    EPRMContentViewType_MeWeekly,        //项目成员-周报
    EPRMContentViewType_MeProject,       //项目成员-项目
    EPRMContentViewType_MeCooperation,   //项目成员-协作
    
    EPRMContentViewType_ObProject,       //观察者-项目
    EPRMContentViewType_ObStatistics,    //观察者-统计
    
};

@interface EPCardTabModel : NSObject
@property (nonatomic, copy)   NSString *tabTitle;
@property (nonatomic, copy)   NSString *navTitle;
@property (nonatomic, copy)   NSString *imgUrl;
@property (nonatomic, copy)   NSString *selectImgUrl;
@property (nonatomic, strong) NSMutableArray  *cards;

@property (nonatomic, assign) BOOL hasCards;    //标记是否已经加载过卡片数据
@property (nonatomic, assign) BOOL isSelect;    //选中的item

////研发自动化相关字段
@property (nonatomic, assign) BOOL isNavTitleView;
@property (nonatomic, strong) NSArray *navTitles;
@property (nonatomic, strong) NSArray *navContentViewTypes;
@property (nonatomic, assign) NSInteger selectNavIndex;
@property (nonatomic, assign) EPRMContentViewType contentViewType;


+ (instancetype)modelWithDic:(NSDictionary *)dic target:(id)target;
- (void)getCardsDatas;
//- (EPRMContentViewType)resetContentViewType:(NSString *)contentViewType;
@end
