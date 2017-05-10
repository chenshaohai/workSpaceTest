//
//  EPPmStatisticsView.m
//  2-13view
//
//  Created by luchanghao on 17/2/14.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import "EPPmStatisticsView.h"
#import "UIView+Frame.h"
#import "EPPmStatisticsPieView.h"
#import "EPObPartProjectViewCell.h"
#import "PPMProjectDetailVC.h"
#import "PPMTopButton.h"
#import "NSString+Size.h"
#import "EPPmStatisticsPersonView.h"
//第一个表格的tag
#define kFirstTableViewTag  1281
//ScrollViewTag
#define kScrollViewTag  1681
@interface EPPmStatisticsView ()<UITableViewDelegate,UITableViewDataSource,EPPmStatisticsPieViewDelegate>

@property(nonatomic,strong)UIButton *firstBtn; //申请按钮
@property(nonatomic,strong)UIButton *secondBtn; //审批按钮
@property(nonatomic,strong)UIView *blueLine; //蓝色线

@property(nonatomic,strong)UIScrollView* scrollView;

@property(nonatomic,strong)UITableView *firstTableView; //申请表格
@property(nonatomic,strong)UITableView *secondTableView; //审核表格
@property(nonatomic,strong)NSMutableArray *firstArray; //第一个数组
@property(nonatomic,strong)NSMutableArray *secondArray; //审核数组

@property (nonatomic, strong) EPPmStatisticsPieView *pieView;
//圆环第一个数组
@property (nonatomic, strong)NSMutableArray *dataArrayOne;
//圆环第二个数组
@property (nonatomic, strong)NSMutableArray *dataArrayTwo;
@end

@implementation EPPmStatisticsView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_HEX(0xf5f5f5);
        [self requestDatas];
        [self configSubviews];
        self.firstBtn.selected = NO;
        self.secondBtn.selected = NO;
        [self firstBtnClick];
    }
    return self;
}

-(void)requestDatas{

    _firstArray = [NSMutableArray array];
    _dataArrayOne = [NSMutableArray array];
    _dataArrayTwo = [NSMutableArray array];
    
    
    NSArray *dictArray1 = @[
                           @{
                               @"headImageName":@"project_image03",
                                @"topLabelText":@"专显VIP客户项目",
                                @"numberText":@"编号:TM070RVZG01",
                               @"adminText":@"部门:专显研发中心",
                               @"scheduleText":@"负责人:徐光宇"
                               },
                           @{
                               @"headImageName":@"project_image03",
                           @"topLabelText":@"移动智能终端-重要项目",
                           @"numberText":@"编号:TM070RVZG01-00",
                           @"adminText":@"部门:移动智能终端研发中心",
                           @"scheduleText":@"负责人:王娜"
                           },

                           @{
                               @"headImageName":@"project_image03",
                           @"topLabelText":@"移动智能终端-重要项目",
                           @"numberText":@"编号:TM070RVZG01-01",
                           @"adminText":@"部门:移动智能终端研发中心",
                           @"scheduleText":@"负责人:袁安河"
                           },

                           @{
                               @"headImageName":@"project_image03",
                           @"topLabelText":@"移动智能终端-重要项目",
                           @"numberText":@"编号:TM070RVZG01-02",
                           @"adminText":@"部门:移动智能终端研发中心",
                           @"scheduleText":@"负责人:宁旭阁"
                           },

                           @{
                               @"headImageName":@"project_image03",
                           @"topLabelText":@"移动智能终端-重要项目",
                           @"numberText":@"编号:TM070RVZG01",
                           @"adminText":@"部门:移动智能终端研发中心",
                           @"scheduleText":@"负责人:龙超"
                           },

                           @{
                               @"headImageName":@"project_image03",
                           @"topLabelText":@"专显VIP客户项目",
                           @"numberText":@"编号:TM070RVZG01",
                           @"adminText":@"部门:专显研发中心",
                           @"scheduleText":@"负责人:徐光宇"
                           },

                           @{
                               @"headImageName":@"project_image03",
                           @"topLabelText":@"移动智能终端-重要项目",
                           @"numberText":@"编号:TM070RVZG01",
                           @"adminText":@"部门:移动智能终端研发中心",
                           @"scheduleText":@"负责人:龙超"
                           },

                           @{
                               @"headImageName":@"project_image03",
                           @"topLabelText":@"专显VIP客户项目",
                           @"numberText":@"编号:TM070RVZG01",
                           @"adminText":@"部门:专显研发中心",
                           @"scheduleText":@"负责人:徐光宇"
                           },

                           @{
                               @"headImageName":@"project_image03",
                           @"topLabelText":@"移动智能终端-重要项目",
                           @"numberText":@"编号:TM070RVZG01",
                           @"adminText":@"部门:移动智能终端研发中心",
                           @"scheduleText":@"负责人:龙超"
                           }
                           ];
    
    
    NSArray *dictArray = @[
                           @{
                               @"headImageName":@"project_image03",
                               @"topLabelText":@"专显VIP客户项目",
                               @"numberText":@"编号:TM070RVZG01",
                               @"adminText":@"部门:专显研发中心",
                               @"scheduleText":@"负责人:徐光宇"
                               },
                           @{
                               @"headImageName":@"project_image03",
                               @"topLabelText":@"移动智能终端-重要项目",
                               @"numberText":@"编号:TM070RVZG01-00",
                               @"adminText":@"部门:移动智能终端研发中心",
                               @"scheduleText":@"负责人:王娜"
                               },
                           
                           @{
                               @"headImageName":@"project_image03",
                               @"topLabelText":@"移动智能终端-重要项目",
                               @"numberText":@"编号:TM070RVZG01-01",
                               @"adminText":@"部门:移动智能终端研发中心",
                               @"scheduleText":@"负责人:袁安河"
                               },
                           ];
    
    
    for (NSDictionary *dic in dictArray) {
        EPObPartProjectViewModel *model = [[EPObPartProjectViewModel alloc]initWithDic:dic];
        [self.firstArray addObject:model];
        [self.dataArrayOne addObject:model];
    }
    
    for (NSDictionary *dic in dictArray1) {
        EPObPartProjectViewModel *model = [[EPObPartProjectViewModel alloc]initWithDic:dic];
        
        [self.dataArrayTwo addObject:model];
    }
  
    [self.firstTableView reloadData];
    
    [self setupSecondArray];
}

-(void)setupSecondArray{
    NSArray *array = @[
                       
                       @{@"detail" :  @[
                                 @{
                                     @"count" : @5632,
                                     @"kind" : @"Task-done",
                                     },
                                 @{
                                     @"count" : @55,
                                     @"kind" : @"Story",
                                     }
                                 ],
                         @"uid" : @"aa",
                         @"uname" : @"TM070RVZG01",
                         },
                       @{ @"detail" :   @[
                                  @{ @"count" :@4413,
                                     @"kind" : @"Task-done",
                                     },
                                  @{ @"count" : @8,
                                     @"kind" : @"Task-doing",
                                     }
                                  ],
                          @"uid" : @"5ba3656ffcd211e6adf800163e04dabe",
                          @"uname" : @"TM070RVZG01-00",
                          },
                       @{ @"detail" :             @[
                                  @{ @"count" : @5,
                                     @"kind" : @"Task-doing",
                                     },
                                  @{ @"count" : @3988,
                                     @"kind" : @"Task-done",
                                     }
                                  ],
                          @"uid" : @"5ba745dffcd211e6adf800163e04dabe",
                          @"uname" : @"TM070RVZG01-01",
                          },
                       @{ @"detail" :             @[
                                  @{ @"count" : @3591,
                                     @"kind" : @"Task-done",
                                     },
                                  @{ @"count" : @7,
                                     @"kind" : @"Task-doing",
                                     }
                                  ],
                          @"uid" : @"5ba7ae37fcd211e6adf800163e04dabe",
                          @"uname" : @"TM070RVZG01-03",
                          },
                       @{ @"detail" :             @[
                          @{ @"count" : @23,
                             @"kind" : @"Task-doing",
                             },
                          @{ @"count" : @0,
                             @"kind" : @"Task-todo",
                             },
                          @{ @"count" : @1668,
                             @"kind" : @"Task-done",
                             }
                          ],
                          @"uid" : @"5ba804a0fcd211e6adf800163e04dabe",
                          @"uname" : @"TM235110AIHSUGNA1 I-1",
                          }
                    ];
    
    
    
    self.secondArray = [NSMutableArray array];
    int maxNum = 0;
    CGFloat width = SCREEN_WIDTH - 16*2;
    
    for (NSDictionary *dict in array) {
        EPPmStatisticsPersonLineModel *model =  [[EPPmStatisticsPersonLineModel alloc] init];
        model.title = [dict getSafeStringWithKey:@"uname"];
        model.BGColor = COLOR_HEX(0xdedede);
        model.hightLightColor = COLOR_HEX(0x84d947);
        
        if (dict[@"detail"]
            &&[dict[@"detail"] isKindOfClass:[NSArray class]])
        {
            NSArray *infoArray = dict[@"detail"];
            CGFloat done = 0.0;
            CGFloat doing = 0.0;
            CGFloat todo = 0.0;
            for (NSDictionary *detailDict in infoArray) {
                if ([[detailDict getSafeStringWithKey:@"kind"] isEqualToString:@"Task-done"])
                {
                    done = [[detailDict getSafeStringWithKey:@"count"] floatValue];
                }
                else if ([[detailDict getSafeStringWithKey:@"kind"] isEqualToString:@"Task-doing"])
                {
                    doing = [[detailDict getSafeStringWithKey:@"count"] floatValue];
                }
                else if ([[detailDict getSafeStringWithKey:@"kind"] isEqualToString:@"Task-todo"])
                {
                    todo = [[detailDict getSafeStringWithKey:@"count"] floatValue];
                }
                
                CGFloat all = done + doing + todo;
                if (all>maxNum) {
                    maxNum = all;
                }
                model.done = done;
                model.doing = doing;
                model.todo = todo;
            }
        }
        [_secondArray addObject:model];
    }
    
    for (EPPmStatisticsPersonLineModel *model in _secondArray) {
        CGFloat all = model.done + model.doing + model.todo;
        CGFloat aa = all/maxNum;
        model.BGWidth = aa * width;
        model.lightwidth = model.done/maxNum *width;
        model.totalStr = [NSString stringWithFormat:@"%.0f/%.0f",model.done,all];
    }
    
    
}
#pragma mark - 初始化
-(void)configSubviews{
    [self configHeadView];
    [self configScrollView];
}
//头部视图
-(void)configHeadView{
    UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
    headView.backgroundColor = [UIColor whiteColor];
    [self addSubview:headView];
    
    _firstBtn = [[PPMTopButton alloc]init];
    _firstBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.5 - 0.5, 47.5);
    [_firstBtn setBackgroundColor:[UIColor clearColor]];
    [_firstBtn setTitleColor:COLOR_HEX(0x999999) forState:UIControlStateNormal];
    [_firstBtn setTitleColor:COLOR_HEX(0x2dc8c7) forState:UIControlStateSelected];
    _firstBtn.selected = YES;
    _firstBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_firstBtn setTitle:@"统计" forState:UIControlStateNormal];
    _firstBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_firstBtn addTarget:self action:@selector(firstBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_firstBtn];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_firstBtn.frame), 12, 0.5, 24)];
    line.backgroundColor = COLOR_HEX(0xdedede);
    [headView addSubview:line];
    
    _secondBtn = [[PPMTopButton alloc]init];
    //    [_reviewBtn setImage:[UIImage imageNamed:@"PPMBlueDown"] forState:UIControlStateSelected];
    _secondBtn.frame = CGRectMake(SCREEN_WIDTH*0.5, 0, SCREEN_WIDTH*0.5, 47.5);
    [_secondBtn setBackgroundColor:[UIColor clearColor]];
    [_secondBtn setTitleColor:COLOR_HEX(0x999999) forState:UIControlStateNormal];
    [_secondBtn setTitleColor:COLOR_HEX(0x2dc8c7) forState:UIControlStateSelected];
    _secondBtn.selected = NO;
    _secondBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_secondBtn setTitle:@"TopView" forState:UIControlStateNormal];
    _secondBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_secondBtn addTarget:self action:@selector(secondBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_secondBtn];
    
    
    UIView *lineDown = [[UIView alloc]initWithFrame:CGRectMake(0,47.5, SCREEN_WIDTH, 0.5)];
    lineDown.backgroundColor = COLOR_HEX(0xdedede);
    [headView addSubview:lineDown];
    //蓝线
    CGSize size = [NSString sizeWithText:@"我的审批" font:[UIFont systemFontOfSize:16] maxHeight:48];
    _blueLine = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH*0.5-size.width)/2, 48-2, size.width, 2)];
    _blueLine.backgroundColor = COLOR_HEX(0x2ec7c9);
    [headView addSubview:self.blueLine];
}
//scrollView
-(void)configScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 48, SCREEN_WIDTH, self.height-48)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    _scrollView.tag = kScrollViewTag;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, self.height-48);
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    
    _scrollView.backgroundColor = COLOR_HEX(0xf5f5f5);
    
    [_scrollView addSubview:self.firstTableView];
    [_scrollView addSubview:self.secondTableView];
    
}

-(UITableView *)firstTableView{
    if (!_firstTableView) {
//        _firstTableView = [[UITableView alloc] initWithFrame:self.bounds];
        _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height - 48)];
        _firstTableView.delegate = self;
        _firstTableView.dataSource = self;
        _firstTableView.top = 0;
        _firstTableView.tag = kFirstTableViewTag;
        _firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _firstTableView.backgroundColor = COLOR_HEX(0xf5f5f5);
        
    }
    return _firstTableView;
}

-(UITableView *)secondTableView{
    if (!_secondTableView) {
        _secondTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _scrollView.height) style:UITableViewStylePlain];
        _secondTableView.tag = 1282;
        _secondTableView.delegate = self;
        _secondTableView.dataSource = self;
        //去掉多余的行
        _secondTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _secondTableView.backgroundColor = COLOR_HEX(0xf5f5f5);
        
        UILabel *titleLab =  [[UILabel alloc] initWithFrame:(CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 50))];
        titleLab.text = @"价值排名预估TOP5(单位:万元)";
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = COLOR_HEX(0x333333);
        titleLab.backgroundColor = [UIColor whiteColor];
        titleLab.font = [UIFont systemFontOfSize:12];
        
        _secondTableView.tableHeaderView = titleLab;
    }
    return _secondTableView;
}

#pragma mark - 点击事件
#pragma mark  申请
-(void)firstBtnClick{
    if (self.firstBtn.isSelected)
        return;
    [UIView animateWithDuration:0.3 animations:^{
        self.blueLine.left = (SCREEN_WIDTH*0.5-self.blueLine.width)/2;
        self.scrollView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        self.firstBtn.selected = YES;
        self.secondBtn.selected = NO;
    }];
    
    [self.firstTableView reloadData];
}
#pragma mark  审核
-(void)secondBtnClick{
    if (self.secondBtn.isSelected)
        return;
    [UIView animateWithDuration:0.3 animations:^{
        self.blueLine.left = (SCREEN_WIDTH*0.5-self.blueLine.width)/2+SCREEN_WIDTH*0.5;
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    } completion:^(BOOL finished) {
        self.firstBtn.selected = NO;
        self.secondBtn.selected = YES;
    }];
    
    [self.secondTableView reloadData];
    
}

//让底部的线条跟随scrollView滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag != kScrollViewTag) {
        return;
    }
    
    self.blueLine.left = (SCREEN_WIDTH*0.5-self.blueLine.width)/2 +scrollView.contentOffset.x/SCREEN_WIDTH*((SCREEN_WIDTH*0.5-self.blueLine.width)+self.blueLine.width);
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.tag != kScrollViewTag) {
        return;
    }
    
    CGFloat index = scrollView.contentOffset.x / SCREEN_WIDTH;
    if (index == 0 ) {
        self.firstBtn.selected = YES;
        self.secondBtn.selected = NO;
        [self.firstTableView reloadData];
    }else{
        self.firstBtn.selected = NO;
        self.secondBtn.selected = YES;
        [self.secondTableView reloadData];
    }
    
}

-(EPPmStatisticsPieView *)pieView{
    if (!_pieView) {
        _pieView = [[EPPmStatisticsPieView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 180 + 36)) andType:EPPmPieViewType_Task];
        _pieView.top = 0;
    }
    return _pieView;
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == kFirstTableViewTag) {
    return _firstArray.count + 1;
    }else{
    return _secondArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == kFirstTableViewTag) {
        if (indexPath.row == 0) {
            NSString *CellIdentifier = @"obPartViewFirstCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                
                [cell.contentView addSubview:self.pieView];
                self.pieView.delegate = self;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            return cell;
        }else{
            
            NSString *obPartViewcellCellIdentifier = @"obPartViewcell";
            EPObPartProjectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:obPartViewcellCellIdentifier ];
            if (cell == nil) {
                cell = [[EPObPartProjectViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:obPartViewcellCellIdentifier];
                
            }
            
            cell.model = _firstArray[indexPath.row - 1];
            cell.backgroundColor = [UIColor whiteColor];
            
            cell.hiddenDownLine = NO;
            if (indexPath.row == _firstArray.count)
                cell.hiddenDownLine = YES;
            
            return cell;
        }
    }else{
        
        EPPmStatisticsPersonLine *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[EPPmStatisticsPersonLine alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model =  _secondArray[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == kFirstTableViewTag) {
    if (indexPath.row == 0) {
        return 180 + 36;
    }
    return 80;
    }else{
     return 60;
    }
}
#pragma mark  cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == kFirstTableViewTag) {
        
        
        if (indexPath.row == 0)
            return;
        
        EPObPartProjectViewModel *model = _firstArray[indexPath.row - 1];
        PPMProjectDetailVC *detailVC = [[PPMProjectDetailVC alloc]init];
        
        [self.weakVC.navigationController pushViewController:detailVC animated:YES];
    }else{
//        EPObPartProjectViewModel *model = _secondArray[indexPath.row];
        PPMProjectDetailVC *detailVC = [[PPMProjectDetailVC alloc]init];
        
        [self.weakVC.navigationController pushViewController:detailVC animated:YES];
        
        
    }
}
#pragma mark 圆环点击代理
-(void)pieIndexClick:(NSInteger)index{
    if (index == 0) {
        self.firstArray = _dataArrayOne;
    }else{
    self.firstArray = _dataArrayTwo;
    }
    [self.firstTableView reloadData];
}

@end












