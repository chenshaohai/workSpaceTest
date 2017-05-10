//
//  IWMeBackVC.m
//  IWShopping0221
//
//  Created by FRadmin on 17/3/6.
//  Copyright © 2017年 sword. All rights reserved.
//   售后订单

#import "IWMeBackVC.h"
#import "MJRefresh.h"
#import "IWMeShouHouModel.h"
//#import "IWMeOrderFormCell.h"
#import "IWNearSelectButton.h"
//#import "IWMeOrderFormProductModel.h"
#import "IWMeShouHouCell.h"
#import "IWMeOrderButton.h"
#import "IWReturnGoodsVC.h"

@interface IWMeBackVC ()<UITableViewDataSource,UITableViewDelegate>
// 强制隐藏无数据
@property (nonatomic,assign)BOOL mustHiddenNoDataView;
// 无数据
@property (nonatomic,weak)ANodataView *noDataView;
// 表格，
@property (nonatomic,weak)UITableView *tableView;
// 展示数组
@property (nonatomic,strong)NSMutableArray *dataArray;
//全部数组
@property (nonatomic,strong)NSMutableArray *allArray;
//待付款数组
@property (nonatomic,strong)NSMutableArray *payArray;
//代发货数组
@property (nonatomic,strong)NSMutableArray *sendArray;
//待收货数组
@property (nonatomic,strong)NSMutableArray *receiveArray;
//待评价数组
@property (nonatomic,strong)NSMutableArray *discussArray;

@property (nonatomic,weak)UIView *topView;

//选中的按钮
@property (nonatomic,strong)IWNearSelectButton *selectButton;

//选择
@property (nonatomic,weak)UIView *selectView;
//全部
@property (nonatomic,weak)IWNearSelectButton *allBTN;
//待付款
@property (nonatomic,weak)IWNearSelectButton *payBTN;
//代发货
@property (nonatomic,weak)IWNearSelectButton *sendBTN;
//待收货
@property (nonatomic,weak)IWNearSelectButton *receiveBTN;
//待评价
@property (nonatomic,weak)IWNearSelectButton *discussBTN;
//页面
@property (nonatomic,assign)NSInteger page;

//  默认选择第几个
@property (nonatomic,assign)NSInteger index;
@end

@implementation IWMeBackVC

-(instancetype)initWithSelectIndex:(NSInteger )index{
    self = [super init];
    if (self) {
        _index =index;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor HexColorToRedGreenBlue:@"f2f2f2"];
    
    self.mustHiddenNoDataView = YES;
    
    
    _dataArray = [NSMutableArray array];
    _allArray = [NSMutableArray array];
    _payArray = [NSMutableArray array];
    _sendArray = [NSMutableArray array];
    _receiveArray = [NSMutableArray array];
    _discussArray = [NSMutableArray array];
    
    self.navigationItem.title = @"售后订单";
    self.navigationController.navigationBar.barTintColor = [UIColor HexColorToRedGreenBlue:@"ff3b60"];
    
    
    //请求数据
    [self getProjectesDownRefresh:NO isFrist:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}



-(void)setupTableView{
    
    if (self.tableView)
        return;
    //添加列表
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 , kViewWidth, kViewHeight - 64) style:UITableViewStylePlain];
    //去掉下划线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 0.01);
    tableView.userInteractionEnabled = YES;
    self.tableView = tableView;
}

#pragma mark //请求数据
-(void)getProjectesDownRefresh:(BOOL )isDownRefresh isFrist:(BOOL)isFrist{
    //下拉就去第一页
    if (!isDownRefresh)
        self.page = 1;
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?userId=%@",kNetUrl,@"user/getRefundOrders",[ASingleton shareInstance].loginModel.userId];
    
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    
    [self.dataArray  removeAllObjects];
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        weakSelf.mustHiddenNoDataView = NO;
        
       
        IWLog(@"%@",json);
        
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
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"我的订单没有数据"];
            
            //3.无数据时的图标
            ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.topView.frame) + kFRate(10), kViewWidth,kViewHeight)];
            noDataView.backgroundColor = [UIColor clearColor];
            noDataView.tishiString = @"售后订单没有数据";
            //默认隐藏
            noDataView.hidden = NO;
            noDataView.refreshButtonClick = ^(ANodataView *noDataView,UIButton *refreshButton){
                
                
            };
            noDataView.showRefreshButton = NO;
            self.noDataView = noDataView;
            
            [self.view addSubview:noDataView];
        }
        
        for (NSDictionary *contentDic in contentArray){
            
            /*{
             attributeValue = "";
             productName = "2017\U65b0\U6b3e\U76ae\U5939\U514b\U7537\U88c5\U6625\U5b63";
             refundCount = 1;
             refundId = 110;
             refundMoney = 0;
             refundReason = Thug;
             refundType = 2;
             salePrice = 159;
             shopId = 16;
             shopName = "\U6021\U666f\U9ea6\U5f53\U52b3\U5206\U5e97";
             smarketPrice = 499;
             state = "-1";
             thumbImg = "/aigou/shop/20170312/e0bafff0-e8f3-4000-8290-05f91b29d503.jpg";
             }*/
            
            IWMeShouHouModel *model = [IWMeShouHouModel modelWithDic:contentDic];
            [self.dataArray addObject:model];
        }
        
        [self setupTableView];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        weakSelf.mustHiddenNoDataView = NO;
        [[ASingleton shareInstance] stopLoadingView];
        [weakSelf failSetup];
        
        //3.无数据时的图标
        ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.topView.frame) + kFRate(10), kViewWidth,kViewHeight)];
        noDataView.backgroundColor = [UIColor greenColor];
        noDataView.tishiString = @"没有数据";
        //默认隐藏
        noDataView.hidden = NO;
        self.noDataView = noDataView;
        
        [self.view addSubview:noDataView];
    }];
}
#pragma mark 失败处理
-(void)failSetup{
 [[TKAlertCenter defaultCenter]postAlertWithMessage:@"数据获取失败"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kFRate(50);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    IWMeShouHouModel *model =  self.dataArray[section];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(50))];
    headView.backgroundColor = kColorRGB(250, 250, 250);
    
    CGFloat whiteViewH = 40;
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, kFRate(10), kViewWidth, whiteViewH)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:whiteView];
    
    

    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(kFRate(10),(whiteViewH -  kFRate(20))/2.0, kFRate(20), kFRate(20))];
    iconView.image = [UIImage imageNamed:@"IWMeShouHouIcon"];
    [whiteView addSubview:iconView];
    
    
    
    
    
    CGFloat  labelH = kFRate(15);
    
    
    CGFloat  stateLabelW = kFRate(80);
    
     UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth - stateLabelW - kFRate(10),(whiteViewH -  labelH)/2.0, stateLabelW, labelH)];
    
    //state退换状态，0表示待审核，1表示退换中，2表示退换完成，-1表示退换取消
    
    
    NSString  *stateString = @"待审核";
    if ([model.state isEqual:@"1"]) {
        stateString = @"退换中";
    }else if ([model.state isEqual:@"2"]) {
        stateString = @"退换完成";
    }else if ([model.state isEqual:@"-1"]) {
        stateString = @"退换取消";
    }
    stateLabel.text = stateString;
    
    stateLabel.font = kFont28px;
    stateLabel.textColor = IWColorRed;
    stateLabel.textAlignment = NSTextAlignmentRight;
    stateLabel.backgroundColor = [UIColor whiteColor];
    [whiteView addSubview:stateLabel];

    
    
    UILabel *orderNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame) + kFRate(10),(whiteViewH -  labelH)/2.0, CGRectGetMinX(stateLabel.frame) - CGRectGetMaxX(iconView.frame) - kFRate(20), labelH)];
    orderNameLabel.text = model.shopName;
    orderNameLabel.font = kFont28px;
    orderNameLabel.textColor = kColorSting(@"666666");
    orderNameLabel.backgroundColor = [UIColor whiteColor];
    [whiteView addSubview:orderNameLabel];
    
       
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(headView.frame) - 0.5, kViewWidth, 0.5)];
    line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
    [headView addSubview:line];
    
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kFRate(40);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    IWMeShouHouModel *model =  self.dataArray[section];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(40))];
    footView.backgroundColor = [UIColor whiteColor];
    
    CGFloat buttonW = 60;
    CGFloat buttonH = 25;
    
    
    
    IWMeOrderButton *cancelButton = [[IWMeOrderButton alloc]initWithFrame:CGRectMake(kViewWidth - kFRate(10) - buttonW, (kFRate(40) - buttonH )/2.0,buttonW, buttonH)];
    [cancelButton setTitle:@"取消退换" forState:UIControlStateNormal];
    cancelButton.model = model;
    cancelButton.titleLabel.font = kFont24px;
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:cancelButton];
    cancelButton.padColor = [UIColor lightGrayColor];
    
    
    
    if ([model.state isEqual:@"-1"]) {
        cancelButton.hidden = YES;
    }else {
        cancelButton.hidden = NO;
    }
    
    return footView;
}
#pragma mark 按钮点击
-(void)cancelButtonClick:(IWMeOrderButton *)button{
    
    IWMeShouHouModel *model = button.model;
    //调用接口
    NSString *url = [NSString stringWithFormat:@"%@/%@?refundId=%@",kNetUrl,@"order/cancelServiceOrder",model.refundId];
    
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"code"]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"取消退换失败"];
            return ;
        }
        if (![@"0" isEqual:json[@"code"]]){
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"取消退换失败"];
            return ;
        }
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"取消退换成功"];
        [weakSelf getProjectesDownRefresh:NO isFrist:NO];
        
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"取消退换失败"];
    }];

    
}

#pragma mark 高度cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFRate(118);
}

#pragma mark 组数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
#pragma mark 组内部cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
#pragma mark 组内部cell实现
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IWMeShouHouCell *cell = [IWMeShouHouCell cellWithTableView:tableView];
    IWMeShouHouModel *model = self.dataArray[indexPath.section];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWMeShouHouModel *model = self.dataArray[indexPath.section];
    IWReturnGoodsVC *vc = [[IWReturnGoodsVC alloc] init];
    vc.refundId = model.refundId;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

