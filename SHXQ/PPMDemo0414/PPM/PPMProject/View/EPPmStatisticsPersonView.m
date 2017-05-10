//
//  EPPmStatisticsPersonView.m
//  2-13view
//
//  Created by luchanghao on 17/2/14.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import "EPPmStatisticsPersonView.h"
#import "UIView+Frame.h"
//#import "EPRequestAdapter.h"


//@interface EPPmStatisticsPersonView()
//<
//UITableViewDelegate,
//UITableViewDataSource,
//EPRequestAdapterDelegate
//>
//@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSMutableArray *dataArray;
//@property (nonatomic, strong) EPRequestAdapter *requestManager;
//
//@property(nonatomic,assign)EPPmPersonViewType type;
//
//@end
//
//@implementation EPPmStatisticsPersonView
//
//-(instancetype)initWithFrame:(CGRect)frame andType:(EPPmPersonViewType)type{
//    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = COLOR_HEX(0xffffff);
//        self.type = type;
//        
//        [self setup];
//        [self setupData];
//    }
//    return self;
//
//}
//
//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = COLOR_HEX(0xffffff);
//        [self setup];
//        [self setupData];
//    }
//    return self;
//}
//
//-(void)setup{
//    UILabel *titleLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 15))];
//    titleLab.top = 42/3;
//    [self addSubview:titleLab];
//    if (self.type == EPPmPersonViewType_Task) {
//        titleLab.text = @"按负责人统计任务进展状态";
//    }else{
//        titleLab.text = @"按负责人统计工作量进展状态";
//    }
//    titleLab.textAlignment = NSTextAlignmentCenter;
//    titleLab.textColor = COLOR_HEX(0x333333);
//    titleLab.font = [UIFont systemFontOfSize:12];
//    
//    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, self.height - titleLab.bottom -49))];
//    _tableView.top = titleLab.bottom +30;
//    [self addSubview:_tableView];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.bounces = NO;
//    [_tableView reloadData];
//
//}
//
//-(void)setupData{
//    
//    self.requestManager = [[EPRequestAdapter alloc] init];
//    
//    if (self.type == EPPmPersonViewType_Task) {
//        //    NSDictionary *json = @{@"id":@"468505fffd5311e6adf800163e04dabe"};
//        NSDictionary *json = @{@"id":[EPCommon getProjectId]};
//        [_requestManager getTokenWithUrl:getPROJECT_TASK_COMPLETION_STATISTICS_API hasCache:NO params:@{@"param":[json JSONString]} code:getPROJECT_TASK_COMPLETION_STATISTICS_API target:self];
//    }else{
//        NSDictionary *json1 = @{@"id":[EPCommon getProjectId]};
//        [_requestManager getTokenWithUrl:getPROJECT_WORKLOAD_COMPLETION_STATISTICS_API hasCache:NO params:@{@"param":[json1 JSONString]} code:getPROJECT_WORKLOAD_COMPLETION_STATISTICS_API target:self];
//    }
//    
//}
//
//-(void)requestSuccess:(NSDictionary *)dictionary code:(NSString *)code{
//    if ([code isEqualToString:getPROJECT_TASK_COMPLETION_STATISTICS_API])
//    {
//        if (dictionary
//            &&[dictionary isKindOfClass:[NSDictionary class]])
//        {
//            if (dictionary[@"code"]
//                &&[[dictionary getSafeStringWithKey:@"code"] isEqualToString:@"1"]) {
//                if (dictionary[@"object"]
//                    &&[dictionary[@"object"] isKindOfClass:[NSDictionary class]])
//                {
//                    NSDictionary *objDict = dictionary[@"object"];
//                    if (objDict[@"users"]
//                        &&[objDict[@"users"] isKindOfClass:[NSArray class]])
//                    {
//                        [self makeData:objDict[@"users"]];
//                    }
//                }
//            }
//        }
//    }else if ([code isEqualToString:getPROJECT_WORKLOAD_COMPLETION_STATISTICS_API]){
//        if (dictionary
//            &&[dictionary isKindOfClass:[NSDictionary class]])
//        {
//            if (dictionary[@"code"]
//                &&[[dictionary getSafeStringWithKey:@"code"] isEqualToString:@"1"]) {
//                if (dictionary[@"object"]
//                    &&[dictionary[@"object"] isKindOfClass:[NSDictionary class]])
//                {
//                    NSDictionary *objDict = dictionary[@"object"];
//                    if (objDict[@"users"]
//                        &&[objDict[@"users"] isKindOfClass:[NSArray class]])
//                    {
//                        [self makeData:objDict[@"users"]];
//                    }
//                }
//            }
//        }
//    }
//    
//}
//
//-(void)makeData:(NSArray *)array{
//    self.dataArray = [NSMutableArray array];
//    int maxNum = 0;
//    CGFloat width = SCREEN_WIDTH - 16*2;
//    
//    for (NSDictionary *dict in array) {
//        EPPmStatisticsPersonLineModel *model =  [[EPPmStatisticsPersonLineModel alloc] init];
//        model.title = [dict getSafeStringWithKey:@"uname"];
//        model.BGColor = COLOR_HEX(0xdedede);
//        model.hightLightColor = COLOR_HEX(0x84d947);
//        
//        if (dict[@"detail"]
//            &&[dict[@"detail"] isKindOfClass:[NSArray class]])
//        {
//            NSArray *infoArray = dict[@"detail"];
//            CGFloat done = 0.0;
//            CGFloat doing = 0.0;
//            CGFloat todo = 0.0;
//            for (NSDictionary *detailDict in infoArray) {
//                if ([[detailDict getSafeStringWithKey:@"kind"] isEqualToString:@"Task-done"])
//                {
//                    done = [[detailDict getSafeStringWithKey:@"count"] floatValue];
//                }
//                else if ([[detailDict getSafeStringWithKey:@"kind"] isEqualToString:@"Task-doing"])
//                {
//                    doing = [[detailDict getSafeStringWithKey:@"count"] floatValue];
//                }
//                else if ([[detailDict getSafeStringWithKey:@"kind"] isEqualToString:@"Task-todo"])
//                {
//                    todo = [[detailDict getSafeStringWithKey:@"count"] floatValue];
//                }
//                
//                CGFloat all = done + doing + todo;
//                if (all>maxNum) {
//                    maxNum = all;
//                }
//                model.done = done;
//                model.doing = doing;
//                model.todo = todo;
//            }
//        }
//        [_dataArray addObject:model];
//    }
//    
//    for (EPPmStatisticsPersonLineModel *model in _dataArray) {
//        CGFloat all = model.done + model.doing + model.todo;
//        CGFloat aa = all/maxNum;
//        model.BGWidth = aa * width;
//        model.lightwidth = model.done/maxNum *width;
//        model.totalStr = [NSString stringWithFormat:@"%.0f/%.0f",model.done,all];
//    }
//    
//    _tableView.height = 40 * _dataArray.count;
//    self.height = _tableView.bottom;
//    if (_block) {
//        _block(self.height);
//    }
//    
//    [_tableView reloadData];
//    
////    EPPmStatisticsPersonLineModel *model =  [[EPPmStatisticsPersonLineModel alloc] init];
////    model.title = @"刘婷";
////    model.BGColor = COLOR_HEX(0xdedede);
////    model.hightLightColor = COLOR_HEX(0x84d947);
////    model.BGWidth = width;
////    model.lightwidth = 270.0/360 * model.BGWidth;
////    model.totalStr = @"270/360";
//}
//
//
//-(void)requestFailed:(NSError *)error code:(NSString *)code{
//    
//}
//
//
//
//
//
//
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _dataArray.count;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    EPPmStatisticsPersonLine *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[EPPmStatisticsPersonLine alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView willDisplayCell:(EPPmStatisticsPersonLine *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    cell.model = _dataArray[indexPath.row];
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return  40;
//}
//
//
//@end





@implementation  EPPmStatisticsPersonLineModel

@end





@interface EPPmStatisticsPersonLine ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) long BGWidth;
@property (nonatomic, assign) long lightwidth;
@property (nonatomic, strong) UIColor *BGColor;
@property (nonatomic, strong) UIColor *hightLightColor;


@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIView *BGView;
@property (nonatomic, strong) UIView *lightView;
@property (nonatomic, strong) UILabel *totalLab;
@end

@implementation EPPmStatisticsPersonLine

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    self.titleLab = [[UILabel alloc] initWithFrame:(CGRectMake(16, 0, 150, 15))];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.textColor = COLOR_HEX(0x666666);
    _titleLab.font = [UIFont systemFontOfSize:12];
    [self addSubview:_titleLab];
    
    self.totalLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 100, 15))];
    _totalLab.right = SCREEN_WIDTH - 16;
    _totalLab.font = MyFont(11);
    _totalLab.textColor = COLOR_HEX(0x666666);
    [self addSubview:_totalLab];
    _totalLab.textAlignment = NSTextAlignmentRight;
    
    self.BGView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 0, 6))];
    _BGView.layer.cornerRadius = 3;
    _BGView.left = _titleLab.left;
    _BGView.top = _titleLab.bottom +5;
    
    [self addSubview:_BGView];

    self.lightView = [[UIView alloc] initWithFrame:_BGView.frame];
    _lightView.layer.cornerRadius = 3;

    [self addSubview:_lightView];

}


-(void)setModel:(EPPmStatisticsPersonLineModel *)model{
    _model = model;
    _titleLab.text = model.title;
    _BGView.backgroundColor = model.BGColor;
    _lightView.backgroundColor = model.hightLightColor;

    _BGView.width = model.BGWidth;
    _lightView.width = model.lightwidth;
    _totalLab.text = model.totalStr;
    
#warning todo
    _BGView.backgroundColor = [UIColor clearColor];
    _totalLab.text = [NSString stringWithFormat:@"%d",(int)model.done];
    
}

@end











