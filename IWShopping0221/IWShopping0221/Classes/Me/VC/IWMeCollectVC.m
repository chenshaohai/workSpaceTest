//
//  IWHomeMoreVC.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMeCollectVC.h"
#import "IWMeCollectModel.h"
#import "IWMeCollectCell.h"

@interface IWMeCollectVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,weak)ANodataView *noDataView;
@end

@implementation IWMeCollectVC
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的收藏";
   
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.view.backgroundColor = [UIColor whiteColor];
 
    [self getProjectesDownRefresh:NO isFrist:YES];
}

#pragma mark //请求数据
-(void)getProjectesDownRefresh:(BOOL )isDownRefresh isFrist:(BOOL)isFrist{
    //下拉就去第一页
    if (!isDownRefresh)
        self.page = 1;
    
    NSString *userId = [ASingleton shareInstance].loginModel.userId;
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?userId=%@",kNetUrl,@"user/getProductCollect",userId];
    
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    
    [self.dataArr removeAllObjects];
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        //数据清除
          [self.dataArr removeAllObjects];
        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"data"]) {
            [weakSelf failSetup];
            return ;
        }
        if (![@"0" isEqual:json[@"code"]]){
            [weakSelf failSetup];
            return ;
        }
        
        NSArray *contentArray = json[@"data"];
        if (!contentArray || ![contentArray isKindOfClass:[NSArray class]]) {
            [weakSelf failSetup];
            return ;
        }
        if (contentArray.count == 0) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"没有收藏商品"];
            
            if (self.myTableView) {
                [self.myTableView reloadData];
                self.myTableView.hidden = YES;
            }
            
            //3.无数据时的图标
            ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(-10, -20, kViewWidth,kViewHeight)];
            noDataView.backgroundColor = [UIColor clearColor];
            noDataView.tishiString = @"没有收藏商品";
            //默认隐藏
            noDataView.hidden = NO;
            noDataView.refreshButtonClick = ^(ANodataView *noDataView,UIButton *refreshButton){
            };
            noDataView.showRefreshButton = NO;
            self.noDataView = noDataView;
            [self.view addSubview:noDataView];
        }
        for (NSDictionary *contentDic in contentArray){
                    IWMeCollectModel *model = [[IWMeCollectModel alloc]initWithDic:contentDic];
                    [self.dataArr addObject:model];
        }
        if (isFrist) {
            [self setupTableView];
        }
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [weakSelf failSetup];
    }];
}
-(void)setupTableView{
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64) style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
}
#pragma mark 失败处理
-(void)failSetup{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:@"数据获取失败"];
    if (self.myTableView) {
        [self.myTableView reloadData];
        self.myTableView.hidden = YES;
    }
    
    //3.无数据时的图标
    ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(-10, -20, kViewWidth,kViewHeight)];
    noDataView.backgroundColor = [UIColor clearColor];
    noDataView.tishiString = @"数据获取失败";
    noDataView.hidden = NO;
    self.noDataView = noDataView;
    [self.view addSubview:noDataView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kFRate(125);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWMeCollectCell *cell = [IWMeCollectCell cellWithTableView:tableView];
    cell.model = self.dataArr[indexPath.row];
    cell.crashBtnClick = ^(IWMeCollectModel *model){
    
        [self crashWithModel:model];
    };
    return cell;
}
-(void)crashWithModel:(IWMeCollectModel *)model{
//调用删除接口
    NSString *userId = [ASingleton shareInstance].loginModel.userId;
     NSString *url = [NSString stringWithFormat:@"%@/%@?userId=%@&collectId=%@",kNetUrl,@"user/removeProductCollect",userId,model.collectId];
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"code"]) {
            [weakSelf failSetup];
            return ;
        }
        if (![@"0" isEqual:json[@"code"]]){
            [weakSelf crashFailSetup];
            return ;
        }
        
        [weakSelf getProjectesDownRefresh:NO isFrist:NO];
       
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [weakSelf crashFailSetup];
    }];

}
-(void)crashFailSetup{
  [[TKAlertCenter defaultCenter]postAlertWithMessage:@"删除失败"];
}

- (void)collectionLeftCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
