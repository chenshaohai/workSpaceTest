//
//  EPObStatisticsView.m
//  E-Platform
//
//  Created by 许立强 on 17/3/3.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import "EPObStatisticsView.h"
#import "PPMMyApplyCell.h"
#import "PPMTopButton.h"
#import "EPApproveDetailVC.h"

@interface EPObStatisticsView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIButton* applyBtn; //申请按钮
@property(nonatomic,strong)UIButton* reviewBtn; //审批按钮
@property(nonatomic,strong)UIView* blueLine; //蓝色线

@property(nonatomic,strong)UIScrollView* scrollView;

@property(nonatomic,strong)UITableView *applyTableView; //申请表格
@property(nonatomic,strong)UITableView *reviewTableView; //审核表格
@property(nonatomic,strong)NSArray *applyArray; //申请数组
@property(nonatomic,strong)NSArray *reviewArray; //审核数组
@end

@implementation EPObStatisticsView
-(NSArray *)reviewArray{
    if (!_reviewArray) {
        _reviewArray = @[
                         
                            @{ @"iconColor":COLOR_HEX(0xff6a67),
                                 @"name":@"CELL/背光异物",
                                 @"class":@"Mura",
                                 @"state":@"责任人"
                                 },
                             @{
                                 @"iconColor":COLOR_HEX(0xf8d02),
                                 @"name":@"面板不良，不良数量100",
                                 @"class":@"面板不良",
                                 @"state":@"标准化及流程审核者"
                                 },
                             
                             @{
                                 @"iconColor":COLOR_HEX(0x60dd9e),
                                 @"name":@"CELL/背光异物",
                                 @"class":@"包装异常",
                                 @"state":@"标准化执行者"
                                 },
                             ];
    }
    
    return _reviewArray;
}
-(NSArray *)applyArray{
    if (!_applyArray) {
        _applyArray = @[
                        @{
                            @"iconColor":COLOR_HEX(0xff6a67),
                            @"name":@"面板不良，不良数量100",
                            @"class":@"面板不良",
                            @"state":@"标准化及流程审核者"
                            },
                        @{
                            @"iconColor":COLOR_HEX(0xf8d02),
                            @"name":@"CELL/背光异物",
                            @"class":@"Mura",
                            @"state":@"责任人"
                            },
                        @{
                            @"iconColor":COLOR_HEX(0x60dd9e),
                            @"name":@"CELL/背光异物",
                            @"class":@"包装异常",
                            @"state":@"标准化执行者"
                            },
                        @{
                            @"iconColor":COLOR_HEX(0x60dd9e),
                            @"name":@"单个暗点",
                            @"class":@"显示异常",
                            @"state":@"标准化及流程审核者"
                            },
                        @{
                            @"iconColor":COLOR_HEX(0x60dd9e),
                            @"name":@"面板不良，不良数量500",
                            @"class":@"包装异常",
                            @"state":@"流程审核者"
                            },
                        @{
                            @"iconColor":COLOR_HEX(0xff6a67),
                            @"name":@"电脑故障，开发无法正常工作",
                            @"class":@"显示异常",
                            @"state":@"标准化审核者"
                            }
                        ];
    }
    
    return _applyArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_HEX(0xf5f5f5);
        
        self.backgroundColor = [UIColor grayColor];
        [self requestDatas];
        [self configSubviews];
        
        self.applyBtn.selected = NO;
         self.reviewBtn.selected = NO;
        [self applyclick];
        
    }
    return self;
}


//请求数据
-(void)requestDatas{
#warning 接口加载数据
//    self.applyArray;
//    self.reviewArray;
    
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
    
    _applyBtn = [[PPMTopButton alloc]init];
//    [_applyBtn setImage:[UIImage imageNamed:@"PPMBlueDown"] forState:UIControlStateSelected];
    _applyBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.5 - 0.5, 47.5);
    [_applyBtn setBackgroundColor:[UIColor clearColor]];
    [_applyBtn setTitleColor:COLOR_HEX(0x999999) forState:UIControlStateNormal];
    [_applyBtn setTitleColor:COLOR_HEX(0x2dc8c7) forState:UIControlStateSelected];
    _applyBtn.selected = YES;
    _applyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_applyBtn setTitle:@"我的申请" forState:UIControlStateNormal];
    _applyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_applyBtn addTarget:self action:@selector(applyclick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_applyBtn];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_applyBtn.frame), 12, 0.5, 24)];
    line.backgroundColor = COLOR_HEX(0xdedede);
    [headView addSubview:line];
    
    _reviewBtn = [[PPMTopButton alloc]init];
//    [_reviewBtn setImage:[UIImage imageNamed:@"PPMBlueDown"] forState:UIControlStateSelected];
    _reviewBtn.frame = CGRectMake(SCREEN_WIDTH*0.5, 0, SCREEN_WIDTH*0.5, 47.5);
    [_reviewBtn setBackgroundColor:[UIColor clearColor]];
    [_reviewBtn setTitleColor:COLOR_HEX(0x999999) forState:UIControlStateNormal];
    [_reviewBtn setTitleColor:COLOR_HEX(0x2dc8c7) forState:UIControlStateSelected];
    _reviewBtn.selected = NO;
    _reviewBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_reviewBtn setTitle:@"我的审批" forState:UIControlStateNormal];
    _reviewBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_reviewBtn addTarget:self action:@selector(reviewBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_reviewBtn];
    
    
    UIView *lineDown = [[UIView alloc]initWithFrame:CGRectMake(0,47.5, SCREEN_WIDTH, 0.5)];
    lineDown.backgroundColor = COLOR_HEX(0xdedede);
    [headView addSubview:lineDown];
    
    
    CGSize size = [self sizeWithText:@"我的审批" font:[UIFont systemFontOfSize:16] maxHeight:48];
    
    _blueLine = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH*0.5-size.width)/2, 48-2, size.width, 2)];
    _blueLine.backgroundColor = COLOR_HEX(0x2ec7c9);
    [headView addSubview:self.blueLine];
    
    
}

//scrollView
-(void)configScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 48, SCREEN_WIDTH, self.height-48)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    _scrollView.tag = 101;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, self.height-48);
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    
    _scrollView.backgroundColor = COLOR_HEX(0xf5f5f5);
    
    [_scrollView addSubview:self.applyTableView];
    [_scrollView addSubview:self.reviewTableView];

}
-(UITableView *)applyTableView{
    if (!_applyTableView) {
        _applyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _scrollView.height) style:UITableViewStylePlain];
        _applyTableView.tag = 1234;
        _applyTableView.delegate = self;
        _applyTableView.dataSource = self;
        //去掉多余的行
        _applyTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _applyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _applyTableView.backgroundColor = COLOR_HEX(0xf5f5f5);
    }

    return _applyTableView;
}
-(UITableView *)reviewTableView{
    if (!_reviewTableView) {
        _reviewTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _scrollView.height) style:UITableViewStylePlain];
        _reviewTableView.tag = 1235;
        _reviewTableView.delegate = self;
        _reviewTableView.dataSource = self;
        //去掉多余的行
        _reviewTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _reviewTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
       _reviewTableView.backgroundColor = COLOR_HEX(0xf5f5f5);
    }
    return _reviewTableView;
}

#pragma mark - 点击事件
#pragma mark  申请
-(void)applyclick{
    if (self.applyBtn.isSelected)
        return;
    [UIView animateWithDuration:0.3 animations:^{
        self.blueLine.left = (SCREEN_WIDTH*0.5-self.blueLine.width)/2;
        self.scrollView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        self.applyBtn.selected = YES;
        self.reviewBtn.selected = NO;
    }];
    
    [self.applyTableView reloadData];
}
#pragma mark  审核
-(void)reviewBtnClick{
    if (self.reviewBtn.isSelected)
        return;
    [UIView animateWithDuration:0.3 animations:^{
        self.blueLine.left = (SCREEN_WIDTH*0.5-self.blueLine.width)/2+SCREEN_WIDTH*0.5;
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    } completion:^(BOOL finished) {
        self.applyBtn.selected = NO;
        self.reviewBtn.selected = YES;
    }];
    
     [self.reviewTableView reloadData];
    
}

//让底部的线条跟随scrollView滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag != 101) {
        return;
    }
    
    self.blueLine.left = (SCREEN_WIDTH*0.5-self.blueLine.width)/2 +scrollView.contentOffset.x/SCREEN_WIDTH*((SCREEN_WIDTH*0.5-self.blueLine.width)+self.blueLine.width);
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.tag != 101) {
        return;
    }
    
    CGFloat index = scrollView.contentOffset.x / SCREEN_WIDTH;
    if (index == 0 ) {
        self.applyBtn.selected = YES;
        self.reviewBtn.selected = NO;
        [self.applyTableView reloadData];
    }else{
        self.applyBtn.selected = NO;
        self.reviewBtn.selected = YES;
        [self.reviewTableView reloadData];
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 1234)
        return self.applyArray.count;
    return self.reviewArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PPMMyApplyCell  *cell = [PPMMyApplyCell cellWithTableView:tableView];
    NSDictionary *modelDic = nil;
    if (tableView.tag == 1234){
        modelDic = self.applyArray[indexPath.row];
        
        cell.hiddenDownLine = NO;
        if (indexPath.row == _applyArray.count - 1)
            cell.hiddenDownLine = YES;
    }else{
        modelDic = self.reviewArray[indexPath.row];
        cell.hiddenDownLine = NO;
        if (indexPath.row == _reviewArray.count - 1)
            cell.hiddenDownLine = YES;
    }
    cell.modelDic = modelDic;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1234) { //我的申请
        
        NSDictionary *modeDic =    self.applyArray[indexPath.row];
        
        EPApproveDetailVC* vc = [[EPApproveDetailVC alloc]init];
        [self.weakVC.navigationController pushViewController:vc animated:YES];
        
        return;
    }
     //我的审核
    NSDictionary *modeDic =    self.reviewArray[indexPath.row];
    
    EPApproveDetailVC* vc = [[EPApproveDetailVC alloc]init];
    [self.weakVC.navigationController pushViewController:vc animated:YES];
    
}


// 根据指定文本,字体和最大高度计算尺寸
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxHeight:(CGFloat)height
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}

// 根据指定文本,字体和最大宽度计算尺寸
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}


@end



