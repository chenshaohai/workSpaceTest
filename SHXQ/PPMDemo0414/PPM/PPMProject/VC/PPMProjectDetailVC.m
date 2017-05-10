//
//  PPMProjectDetailVC.m
//  PPM
//
//  Created by lu_ios on 17/4/14.
//  Copyright © 2017年 e-lead. All rights reserved.
//

#import "PPMProjectDetailVC.h"
#import "PPMProjectDetailCell.h"

#import "PPMProjectDetailModel.h"

@interface PPMProjectDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,assign)NSInteger selectRow;
@end

@implementation PPMProjectDetailVC
-(NSArray *)dataArray{
    if (!_dataArray) {
        NSArray *data = @[
                       @{
                           @"degree":@"low",
                           @"detailText":@"风险等级：低 内容：项目进展可控",
                           @"depart":@"移动智能终端-重要项目",
                           @"number":@"TM070RVZG01",
                           @"departSecond":@"移动智能终端研发中心",
                           @"manName":@"徐光宇",
                           @"planData":@[
                                   @{
                                        @"startDay":@"08-07",
                                        @"endDay":@"09-07",
                                        @"progressType":@"plan",
                                        @"totalDay":@"30",
                                        @"title":@"DR0 RFQ"
                                        },
                                   @{
                                       @"startDay":@"09-08",
                                       @"endDay":@"11-08",
                                       @"progressType":@"plan",
                                       @"totalDay":@"60",
                                       @"title":@"DR1 Planning"
                                       },
                                   @{
                                       @"startDay":@"11-09",
                                       @"endDay":@"03-09",
                                       @"progressType":@"plan",
                                       @"totalDay":@"120",
                                       @"title":@"DR2 ES"
                                       },
                                   @{
                                       @"startDay":@"03-10",
                                       @"endDay":@"06-10",
                                       @"progressType":@"plan",
                                       @"totalDay":@"90",
                                       @"title":@"DR3 MP"
                                       }
                           ],
                           @"executeData":@[
                                   @{
                                       @"startDay":@"08-07",
                                       @"endDay":@"09-17",
                                       @"progressType":@"execute",
                                       @"totalDay":@"40",
                                       @"title":@"DR0 RFQ"
                                       },
                                   @{
                                       @"startDay":@"09-18",
                                       @"endDay":@"11-18",
                                       @"progressType":@"execute",
                                       @"totalDay":@"60",
                                       @"title":@"DR1 Planning"
                                       },
                                   @{
                                       @"startDay":@"11-19",
                                       @"endDay":@"12-19",
                                       @"progressType":@"execute",
                                       @"totalDay":@"30",
                                       @"title":@"DR2 ES"
                                       },
                                   
                                   ]
                           },
                       @{
                           @"degree":@"normal",
                           @"detailText":@"风险等级：中 内容：整体稳定性不足",
                           @"depart":@"移动智能终端-重要项目",
                           @"number":@"TM070RVZG01-00",
                           @"departSecond":@"移动智能终端研发中心",
                           @"manName":@"王娜",
                           @"planData":@[
                                   @{
                                       @"startDay":@"08-07",
                                       @"endDay":@"09-07",
                                       @"progressType":@"plan",
                                       @"totalDay":@"30",
                                       @"title":@"DR0 RFQ"
                                       },
                                   @{
                                       @"startDay":@"09-08",
                                       @"endDay":@"11-08",
                                       @"progressType":@"plan",
                                       @"totalDay":@"60",
                                       @"title":@"DR1 Planning"
                                       },
                                   @{
                                       @"startDay":@"11-09",
                                       @"endDay":@"03-09",
                                       @"progressType":@"plan",
                                       @"totalDay":@"120",
                                       @"title":@"DR2 ES"
                                       },
                                   @{
                                       @"startDay":@"03-10",
                                       @"endDay":@"06-10",
                                       @"progressType":@"plan",
                                       @"totalDay":@"90",
                                       @"title":@"DR3 MP"
                                       }
                                   ],
                           @"executeData":@[
                                   @{
                                       @"startDay":@"08-07",
                                       @"endDay":@"09-02",
                                       @"progressType":@"execute",
                                       @"totalDay":@"25",
                                       @"title":@"DR0 RFQ"
                                       },
                                   @{
                                       @"startDay":@"09-03",
                                       @"endDay":@"11-03",
                                       @"progressType":@"execute",
                                       @"totalDay":@"60",
                                       @"title":@"DR1 Planning"
                                       },
                                   @{
                                       @"startDay":@"11-04",
                                       @"endDay":@"01-04",
                                       @"progressType":@"execute",
                                       @"totalDay":@"60",
                                       @"title":@"DR2 ES"
                                       },
                                   
                                   ]
                           },@{
                           @"degree":@"high",
                           @"detailText":@"风险等级：高  内容：面板不良率偏高",
                           @"depart":@"移动智能终端-重要项目",
                           @"number":@"TM070RVZG01-01",
                           @"departSecond":@"专显研发中心",
                           @"manName":@"袁安河",
                           @"planData":@[
                                   @{
                                       @"startDay":@"08-07",
                                       @"endDay":@"09-07",
                                       @"progressType":@"plan",
                                       @"totalDay":@"30",
                                       @"title":@"DR0 RFQ"
                                       },
                                   @{
                                       @"startDay":@"09-08",
                                       @"endDay":@"11-08",
                                       @"progressType":@"plan",
                                       @"totalDay":@"60",
                                       @"title":@"DR1 Planning"
                                       },
                                   @{
                                       @"startDay":@"11-09",
                                       @"endDay":@"03-09",
                                       @"progressType":@"plan",
                                       @"totalDay":@"120",
                                       @"title":@"DR2 ES"
                                       },
                                   @{
                                       @"startDay":@"03-10",
                                       @"endDay":@"06-10",
                                       @"progressType":@"plan",
                                       @"totalDay":@"90",
                                       @"title":@"DR3 MP"
                                       }
                                   ],
                           @"executeData":@[
                                   @{
                                       @"startDay":@"08-07",
                                       @"endDay":@"09-27",
                                       @"progressType":@"execute",
                                       @"totalDay":@"50",
                                       @"title":@"DR0 RFQ"
                                       },
                                   @{
                                       @"startDay":@"09-28",
                                       @"endDay":@"11-28",
                                       @"progressType":@"execute",
                                       @"totalDay":@"60",
                                       @"title":@"DR1 Planning"
                                       },
                                   @{
                                       @"startDay":@"11-29",
                                       @"endDay":@"03-29",
                                       @"progressType":@"execute",
                                       @"totalDay":@"120",
                                       @"title":@"DR2 ES"
                                       },
                                   
                                   ]
                           },
                       ];
        
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *dataDic in data) {
            PPMProjectDetailModel *model =  [PPMProjectDetailModel modelWithDic:dataDic];
            
            [dataArray addObject:model];
        }
        _dataArray = dataArray;
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_HEX(0xf5f5f5);
    self.title = @"TopView";
    
    self.selectRow = -1;
    
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
////设置样式
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}
//
////设置是否隐藏
//- (BOOL)prefersStatusBarHidden {
//    //    [super prefersStatusBarHidden];
//    return NO;
//}
//
////设置隐藏动画
//- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
//    return UIStatusBarAnimationNone;
//}

#pragma mark  改变子布局
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    float height =bounds.size.height - 64;
    float width = bounds.size.width;
    NSLog(@"width:%f",width);
    NSLog(@"height:%f",height);
    
    if (width > height) {
        height =bounds.size.height - 52;
    }
    
    self.tableView.frame = CGRectMake(0, 0, width, height);
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(UITableView *)tableView{
    if (!_tableView) {
        
        CGRect bounds = [UIScreen mainScreen].bounds;
        float height =bounds.size.height - 64;
        float width = bounds.size.width;
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.top = 0;
        _tableView.backgroundColor = COLOR_HEX(0xf5f5f5);
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
         _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
#pragma mark  cell详情
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PPMProjectDetailCell  *cell = [PPMProjectDetailCell cellWithTableView:tableView];
    PPMProjectDetailModel *model = _dataArray[indexPath.row];
    
    
    cell.model = model;
    cell.accessoryType = UITableViewCellAccessoryNone;
     //选中 显示
    cell.showDetailText = NO;
    if (_selectRow ==  indexPath.row)
        cell.showDetailText = YES;
    
   
    
    
    cell.hiddenDownLine = NO;
    if (indexPath.row == _dataArray.count - 1)
         cell.hiddenDownLine = YES;
    
    return cell;
}
#pragma mark  cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectRow ==  indexPath.row){
        PPMProjectDetailModel *model = _dataArray[indexPath.row];
        return 133 + model.highDetailText;
    }else{
        return 133;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectRow = indexPath.row;
    [self.tableView reloadData];
}
#pragma mark 横竖屏
-(BOOL)shouldAutorotate
{
    return YES;
}
#pragma mark 支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}
@end
