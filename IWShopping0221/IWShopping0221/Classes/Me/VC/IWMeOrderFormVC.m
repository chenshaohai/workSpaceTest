//
//  IWMeOrderFormVC.m
//  IWShopping0221
//
//  Created by s on 17/3/4.
//  Copyright © 2017年 sword. All rights reserved.
//
#import "IWNearSurePayVC.h"
#import "IWTabBarViewController.h"
#import "IWMeOrderFormVC.h"
#import "MJRefresh.h"
#import "IWMeOrderFormModel.h"
#import "IWMeOrderFormCell.h"
#import "IWNearSelectButton.h"
#import "IWMeOrderFormProductModel.h"
#import "IWMeRequestShouHouVC.h"
#import "IWMeOrderButton.h"
#import "IWTabBarViewController.h"
#import "IWToViewWuLiuVC.h"
#import "IWDingDanOneVC.h"
#import "IWNearCommitDiscussVC.h"
#import "IWNavigationController.h"
#import "WXApi.h"
#import "WXApiObject.h"

#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"

@interface IWMeOrderFormVC ()<UITableViewDataSource,UITableViewDelegate>
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

//选中的模型
@property (nonatomic,strong)IWMeOrderFormModel *selectModel;
@end

@implementation IWMeOrderFormVC

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
    
    self.navigationItem.title = @"我的订单";
    self.navigationController.navigationBar.barTintColor = [UIColor HexColorToRedGreenBlue:@"ff3b60"];
    
    [self setupTopView];
    
    self.needNoRefresh = YES;
    //请求数据
    [self getProjectesDownRefresh:NO isFrist:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //检测是否装了微信软件
    if ([WXApi isWXAppInstalled]){ //监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXPay" object:nil];
    }
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(aliPayCallBack:) name:@"aliPayCallBack" object:nil];
    
    
    [ASingleton shareInstance].shoppingVCNeedNoRefresh = NO;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.needNoRefresh == NO) {
        //请求数据
        [self getProjectesDownRefresh:NO isFrist:NO];
    }else{
        self.needNoRefresh = NO;
    }
}
#pragma mark - 顶部
-(void)setupTopView{
    
    CGFloat viewH = 42;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kViewWidth, viewH)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    self.topView = topView;
    
    
    // 全部
    CGFloat  buttonW = kViewWidth/5.0;
    IWNearSelectButton *allBTN = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(0, 0,buttonW, viewH)];
    allBTN.index = 0;
    [allBTN setTitle:@"全部" forState:UIControlStateNormal];
    [allBTN setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
    [allBTN addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:allBTN];
    self.allBTN = allBTN;
    
    
    //
    IWNearSelectButton *payBTN = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(buttonW, 0,buttonW, viewH)];
    payBTN.index = 1;
    [payBTN setTitle:@"待付款" forState:UIControlStateNormal];
    [payBTN setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
    [payBTN addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:payBTN];
    self.payBTN = payBTN;
    
    //评价最高
    IWNearSelectButton *sendBTN = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(2 * buttonW, 0,buttonW, viewH)];
    sendBTN.index = 2;
    [sendBTN setTitle:@"待发货" forState:UIControlStateNormal];
    [sendBTN setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
    [sendBTN addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:sendBTN];
    self.sendBTN = sendBTN;
    //
    IWNearSelectButton *receiveBTN = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(3 * buttonW, 0,buttonW, viewH)];
    receiveBTN.index = 3;
    [receiveBTN setTitle:@"待收货" forState:UIControlStateNormal];
    [receiveBTN setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
    [receiveBTN addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:receiveBTN];
    self.receiveBTN = receiveBTN;
    //评价最高
    IWNearSelectButton *discussBTN = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(4 * buttonW, 0,buttonW, viewH)];
    discussBTN.index = 4;
    [discussBTN setTitle:@"待评价" forState:UIControlStateNormal];
    [discussBTN setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
    [discussBTN addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:discussBTN];
    self.discussBTN = discussBTN;
}
#pragma mark 中间按钮点击
-(void)selectButtonClick:(IWNearSelectButton *)button{
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    // 替换数据原
    switch (button.index) {
        case 0:
            self.dataArray = self.allArray;
            break;
        case 1:
            self.dataArray = self.payArray;
            break;
        case 2:
            self.dataArray = self.sendArray;
            break;
        case 3:
            self.dataArray = self.receiveArray;
            break;
        default:
            self.dataArray = self.discussArray;
            break;
    }
    
    self.index = button.index;
    [self.tableView reloadData];
}
#pragma mark 中间按钮点击
-(void)selectButtonClickIndex:(NSInteger)index{
    if (self.selectButton)
        self.selectButton.selected = NO;
    
    // 替换数据原
    switch (index) {
        case 0:{
            self.allBTN.selected = YES;
            self.selectButton = self.allBTN;
            self.dataArray = self.allArray;
        }break;
        case 1:{
            self.payBTN.selected = YES;
            self.selectButton = self.payBTN;
            self.dataArray = self.payArray;
        }break;
        case 2:{
            self.sendBTN.selected = YES;
            self.selectButton = self.sendBTN;
            self.dataArray = self.sendArray;
        }break;
        case 3:{
            self.receiveBTN.selected = YES;
            self.selectButton = self.receiveBTN;
            self.dataArray = self.receiveArray;
        }break;
        default:{
            self.discussBTN.selected = YES;
            self.selectButton = self.discussBTN;
            self.dataArray = self.discussArray;
        }break;
    }
    [self.tableView reloadData];
}


-(void)setupTableView{
    if (self.tableView)
        return;
    //添加列表
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), kViewWidth, kViewHeight - CGRectGetMaxY(self.topView.frame)) style:UITableViewStylePlain];
    //去掉下划线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 0.01);
    tableView.userInteractionEnabled = YES;
    self.tableView = tableView;
    //    __weak typeof(self) weakSelf = self;
    //    // 下拉刷新
    //    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        [weakSelf getProjectes];
    //        // 结束刷新
    //        [tableView.mj_header endRefreshing];
    //    }];
    //    // 设置自动切换透明度(在导航栏下面自动隐藏)
    //    tableView.mj_header.automaticallyChangeAlpha = YES;
}

#pragma mark //请求数据
-(void)getProjectesDownRefresh:(BOOL )isDownRefresh isFrist:(BOOL)isFrist{
    //下拉就去第一页
    if (!isDownRefresh)
        self.page = 1;
    NSString *userId = [ASingleton shareInstance].loginModel.userId;
    NSString *url = [NSString stringWithFormat:@"%@/%@?userId=%@",kNetUrl,@"user/getShopOrders",userId];
    
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    
    _dataArray = [NSMutableArray array];
    _allArray = [NSMutableArray array];
    _payArray = [NSMutableArray array];
    _sendArray = [NSMutableArray array];
    _receiveArray = [NSMutableArray array];
    _discussArray = [NSMutableArray array];
    
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        weakSelf.mustHiddenNoDataView = NO;
        
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
            ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + kFRate(10), kViewWidth,kViewHeight)];
            noDataView.backgroundColor = [UIColor clearColor];
            noDataView.tishiString = @"我的订单没有数据";
            //默认隐藏
            noDataView.hidden = NO;
            noDataView.refreshButtonClick = ^(ANodataView *noDataView,UIButton *refreshButton){
                
                
            };
            noDataView.showRefreshButton = NO;
            self.noDataView = noDataView;
            
            [self.view addSubview:noDataView];
        }
        
        for (NSDictionary *contentDic in contentArray){
            
            /*
             {
             code = 0;
             data =     (
             {
             addressId = 36;
             addressInfo = "";
             children =             (
             {
             attributeValue = "";
             count = 1;
             orderDetailId = 28;
             productId = 14;
             productName = "\U5e05\U6c14\U4f11\U95f2\U886c\U8863\U7537\U88c5";
             salePrice = 69;
             smarketPrice = 169;
             thumbImg = "/aigou/shop/20170312/53db2923-6413-474d-ac03-0d9f86a87add.jpg";
             }
             );
             createdTime = 1489514010000;
             expressNum = 755300189836;
             expressPrice = 0;
             orderId = 24;
             orderNum = 1489514010670;
             payPrice = 399;
             shopId = 14;
             shopName = "\U6fb3\U54c1\U835f";
             state = 1;
             updatedTime = 1489931125000;
             },
             );
             message = success;
             }
             
             */
            IWMeOrderFormModel *model = [IWMeOrderFormModel modelWithDic:contentDic];
            [self.allArray addObject:model];
            // &state = 0 待付款  1 待发货 2待收货 3待评价   4交易完成   5交易关闭   -1 交易取消
            NSInteger state = [model.state integerValue];
            switch (state) {
                case 0:
                    [self.payArray addObject:model];
                    break;
                case 1:
                    [self.sendArray addObject:model];
                    break;
                case 2:
                    [self.receiveArray addObject:model];
                    break;
                case 3:
                    [self.discussArray addObject:model];
                    break;
                default:
                    break;
            }
        }
        [self setupTableView];
        
        
        [self selectButtonClickIndex:self.index];
        
        
    } failure:^(NSError *error) {
        weakSelf.mustHiddenNoDataView = NO;
        [[ASingleton shareInstance] stopLoadingView];
        [weakSelf failSetup];
        
        //3.无数据时的图标
        ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + kFRate(10), kViewWidth,kViewHeight)];
        noDataView.backgroundColor = [UIColor clearColor];
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
    //    [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kFRate(9 + 35);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    IWMeOrderFormModel *model =  self.dataArray[section];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(9 + 35))];
    headView.backgroundColor = kColorRGB(239, 239, 239);
    
    CGFloat whiteViewH = 35;
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, kFRate(9), kViewWidth, whiteViewH)];
    whiteView.backgroundColor = kColorRGB(250, 250, 250);
    [headView addSubview:whiteView];
    
    
    
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(kFRate(10),(whiteViewH -  kFRate(20))/2.0, kFRate(20), kFRate(20))];
    iconView.image = [UIImage imageNamed:@"IWMeShouHouIcon"];
    [whiteView addSubview:iconView];
    
    
    CGFloat  labelH = kFRate(15);
    CGFloat  stateLabelW = kFRate(60);
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth - stateLabelW - kFRate(10),(whiteViewH -  labelH)/2.0, stateLabelW, labelH)];
    
    // &state = 0 待付款  1 待发货 2待收货 3待评价   4交易完成   5交易关闭   -1 交易取消\
    
    NSString *stateString = @"待付款";
    NSInteger state = [model.state integerValue];
    switch (state) {
        case 0:
            stateString = @"待付款";
            break;
        case 1:
            stateString = @"待发货";
            break;
        case 2:
            stateString = @"待收货";
            break;
        case 3:
            stateString = @"待评价";
            break;
        case 4:
            stateString = @"交易完成";
            break;
        case 5:
            stateString = @"交易关闭";
            break;
        case -1:
            stateString = @"交易取消";
            break;
        default:
            stateString = @"";
            break;
    }
    
    
    
    stateLabel.text = stateString;
    stateLabel.font = kFont28px;
    stateLabel.textColor = IWColorRed;
    stateLabel.textAlignment = NSTextAlignmentRight;
    stateLabel.backgroundColor = [UIColor clearColor];
    [whiteView addSubview:stateLabel];
    
    
    
    UILabel *orderNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame) + kFRate(10),(whiteViewH -  labelH)/2.0, CGRectGetMinX(stateLabel.frame) - CGRectGetMaxX(iconView.frame) - kFRate(20), labelH)];
    orderNameLabel.text = model.shopName;
    orderNameLabel.font = kFont28px;
    orderNameLabel.textColor = kColorSting(@"666666");
    orderNameLabel.backgroundColor = [UIColor clearColor];
    [whiteView addSubview:orderNameLabel];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(headView.frame) - 0.5, kViewWidth, 0.5)];
    line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
    [headView addSubview:line];
    
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kFRate(56);
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    IWMeOrderFormModel *model =  self.dataArray[section];
    
    NSInteger productCount = 0;
    for (IWMeOrderFormProductModel *productModel in model.children) {
        productCount =  productCount + [productModel.count integerValue];
    }
    
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(65))];
    headView.backgroundColor = [UIColor whiteColor];
    
//    UILabel *yuFeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(kFRate(200),0,kFRate(100),kFRate(28))];
//    yuFeiLabel.text = [NSString stringWithFormat:@"已抵扣%@贝壳(含运费￥%@)",model.integral,model.expressPrice];
     UILabel *yuFeiLabel = [[UILabel alloc]initWithFrame:CGRectMake(kFRate(200),0,kFRate(60),kFRate(28))];
     yuFeiLabel.text = [NSString stringWithFormat:@"(含运费￥%@)",model.expressPrice];
    yuFeiLabel.font = kFont26px;
    yuFeiLabel.textColor = kColorSting(@"666666");
    yuFeiLabel.backgroundColor = [UIColor whiteColor];
    [yuFeiLabel sizeToFit];
    CGFloat yuFeiLableW = yuFeiLabel.frame.size.width;
    yuFeiLabel.frame = CGRectMake(kViewWidth - yuFeiLableW - 10,0,yuFeiLableW,kFRate(28));
    [headView addSubview:yuFeiLabel];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kFRate(200),0, kFRate(60), kFRate(28))];
    timeLabel.font = kFont26px;
    timeLabel.textColor = IWColorRed;
    timeLabel.text = [NSString stringWithFormat:@"￥:%@ ",model.payPrice];
    timeLabel.backgroundColor = [UIColor whiteColor];
    [timeLabel sizeToFit];
    timeLabel.frame = CGRectMake(CGRectGetMinX(yuFeiLabel.frame) - timeLabel.frame.size.width,0, timeLabel.frame.size.width, kFRate(28));
    [headView addSubview:timeLabel];
    
    UILabel *orderNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(kFRate(90), 0, kFRate(105), kFRate(28))];
    orderNumLabel.text = [NSString stringWithFormat:@"共%ld件 合计:",productCount];
    orderNumLabel.font = kFont26px;
    orderNumLabel.textColor = kColorSting(@"666666");
    orderNumLabel.backgroundColor = [UIColor whiteColor];
    [orderNumLabel sizeToFit];
    CGFloat orderNumLabelW = orderNumLabel.frame.size.width;
    orderNumLabel.frame = CGRectMake(CGRectGetMinX(timeLabel.frame) - orderNumLabelW,0,orderNumLabelW,kFRate(28));
    [headView addSubview:orderNumLabel];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(timeLabel.frame), kViewWidth, 0.5)];
    line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
    [headView addSubview:line];
    
    
    UIView *footDownView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), kViewWidth, kFRate(28))];
    footDownView.backgroundColor = [UIColor whiteColor];
    
    [headView addSubview:footDownView];
    
    
    CGFloat buttonW = kFRate(53);
    CGFloat buttonH = 17;
    
    
    // 仅仅用待评价的 查看物流
    IWMeOrderButton *daiPingJiaWuLiuButton = [[IWMeOrderButton alloc]initWithFrame:CGRectMake(kViewWidth - kFRate(135) - buttonW - kFRate(9) , (CGRectGetHeight(footDownView.frame) - buttonH )/2.0, buttonW, buttonH)];
    
    daiPingJiaWuLiuButton.titleLabel.font = kFont24px;
    [daiPingJiaWuLiuButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [daiPingJiaWuLiuButton addTarget:self action:@selector(daiPingJiaWuLiuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footDownView addSubview:daiPingJiaWuLiuButton];
    [daiPingJiaWuLiuButton setTitle:@"查看物流" forState:UIControlStateNormal];
    daiPingJiaWuLiuButton.OrderFormModel = model;
    daiPingJiaWuLiuButton.section = section;
    
    
    IWMeOrderButton *payButton = [[IWMeOrderButton alloc]initWithFrame:CGRectMake(kViewWidth - kFRate(135), (CGRectGetHeight(footDownView.frame) - buttonH )/2.0, buttonW, buttonH)];
    
    payButton.titleLabel.font = kFont24px;
    [payButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footDownView addSubview:payButton];
    
    payButton.OrderFormModel = model;
    payButton.section = section;
    
    
    IWMeOrderButton *cancelButton = [[IWMeOrderButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(payButton.frame) + kFRate(9), (CGRectGetHeight(footDownView.frame) - buttonH )/2.0, buttonW, buttonH)];
    
    cancelButton.titleLabel.font = kFont24px;
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footDownView addSubview:cancelButton];
    
    cancelButton.OrderFormModel = model;
    cancelButton.section = section;
    
    //默认 第一个隐藏，第二个显示， 同时不响应点击事件
    payButton.hidden = YES;
    cancelButton.hidden = NO;
    payButton.enabled = NO;
    cancelButton.enabled = NO;
    
    //默认待评价 物流按钮 隐藏
    daiPingJiaWuLiuButton.hidden = YES;
    daiPingJiaWuLiuButton.enabled = NO;
    
    
    
    NSString *stateString = @"待付款";
    
    if ([model.state isEqual:@"0"]) {
        payButton.hidden = NO;
        payButton.enabled = YES;
        cancelButton.enabled = YES;
        
        [payButton setTitle:@"付  款" forState:UIControlStateNormal];
        [payButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        payButton.padColor = [UIColor redColor];
        
        [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
        cancelButton.padColor = [UIColor lightGrayColor];
    }else if([model.state isEqual:@"1"]){
        [cancelButton setTitle:@"待发货" forState:UIControlStateNormal];
        cancelButton.padColor = [UIColor clearColor];
        stateString = @"待发货";
    }else if ([model.state isEqual:@"2"]){
        
        payButton.hidden = NO;
        payButton.enabled = YES;
        cancelButton.enabled = YES;
        
        [payButton setTitle:@"查看物流" forState:UIControlStateNormal];
        [cancelButton setTitle:@"确认收货" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        stateString = @"待收货";
    }else if ([model.state isEqual:@"3"]){
        
        daiPingJiaWuLiuButton.hidden = NO;
        daiPingJiaWuLiuButton.enabled = YES;
        
        
        payButton.hidden = NO;
        payButton.enabled = YES;
        [payButton setTitle:@"评价" forState:UIControlStateNormal];
        [payButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        cancelButton.hidden = NO;
        [cancelButton setTitle:@"售 后" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        cancelButton.enabled = YES;
        
        
        stateString = @"待评价";
    }else if ([model.state isEqual:@"4"]){
        
        payButton.hidden = NO;
        payButton.enabled = YES;
        cancelButton.enabled = YES;
        
        [payButton setTitle:@"查看物流" forState:UIControlStateNormal];
        
        [cancelButton setTitle:@"售 后" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        stateString = @"交易完成";
    }else if ([model.state isEqual:@"5"]){
        [cancelButton setTitle:@"交易关闭" forState:UIControlStateNormal];
        stateString = @"交易关闭";
        cancelButton.padColor = [UIColor clearColor];
    }else if ([model.state isEqual:@"-1"]){
        [cancelButton setTitle:@"交易取消" forState:UIControlStateNormal];
        stateString = @"交易取消";
        cancelButton.padColor = [UIColor clearColor];
    }else{
        
        
    }
    
    //    timeLabel.text = [NSString stringWithFormat:@"   订单状态 ：%@",stateString];
    
    return headView;
}

#pragma mark 查看物流按钮点击事件
-(void)daiPingJiaWuLiuButtonClick:(IWMeOrderButton *)button{
    IWMeOrderFormModel *model =  button.OrderFormModel;
    //查看物流
    [self chaWuLiuWithModel:model];
    
}
#pragma mark 第一个按钮点击事件
-(void)payButtonClick:(IWMeOrderButton *)button{
    IWMeOrderFormModel *model =  button.OrderFormModel;
    if ([model.state isEqual:@"0"]) {
        //去支付
        [self payWithModel:model];
    }else if ([model.state isEqual:@"2"]){
        //查看物流
        [self chaWuLiuWithModel:model];
    }else if ([model.state isEqual:@"3"]){
        //@"评价"
        [self discuessWithModel:model];
    }else if ([model.state isEqual:@"4"]){
        //查看物流
        [self chaWuLiuWithModel:model];
    }
}
#pragma mark 第二个按钮点击事件
-(void)cancelButtonClick:(IWMeOrderButton *)button{
    IWMeOrderFormModel *model =  button.OrderFormModel;
    
    if ([model.state isEqual:@"0"]) {
        //取消订单
        [self cancelPayWithModel:model];
    }else if ([model.state isEqual:@"2"]){
        //确认收货
        [self sureWithModel:model];
    }else if ([model.state isEqual:@"3"]){
        //售后
        [self shouHouWithModel:model];
    }else if ([model.state isEqual:@"4"]){
        //售后
        [self shouHouWithModel:model];
        
    }
}
#pragma mark //售后
-(void)shouHouWithModel:(IWMeOrderFormModel *)model{
    
    IWMeRequestShouHouVC *shouHouVC = [[IWMeRequestShouHouVC alloc]init];
    
    shouHouVC.model = model;
    
    [self.navigationController pushViewController:shouHouVC animated:YES];
}

#pragma mark 去支付
-(void)payWithModel:(IWMeOrderFormModel *)model{
    self.selectModel = model;
    
    __weak typeof(self) weakSelf = self;
    UIAlertController *alerTure = [UIAlertController alertControllerWithTitle:@"" message:@"选择支付方式" preferredStyle:UIAlertControllerStyleActionSheet];
    // 添加按钮
    UIAlertAction *weiXing = [UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 请求
        [weakSelf payFromRow:0];
    }];
    [alerTure addAction:weiXing];
    // 添加按钮
    UIAlertAction *zhiFuBao = [UIAlertAction actionWithTitle:@"支付宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 请求
        [weakSelf payFromRow:1];
    }];
    [alerTure addAction:zhiFuBao];
    // 添加按钮
    UIAlertAction *yinLian = [UIAlertAction actionWithTitle:@"银联" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 请求
        [weakSelf payFromRow:2];
    }];
//    [alerTure addAction:yinLian];
    // 取消按钮
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        IWTabBarViewController *tbVC = (IWTabBarViewController *)self.tabBarController;
        [tbVC from:2 To:3 isRootVC:NO currentVC:self];
        
    }];
    [alerTure addAction:cancel];
    [weiXing setValue:[UIColor greenColor] forKey:@"titleTextColor"];
//    [zhiFuBao setValue:[UIColor greenColor] forKey:@"titleTextColor"];
//    [yinLian setValue:[UIColor greenColor] forKey:@"titleTextColor"];
    [cancel setValue:kRedColor forKey:@"titleTextColor"];
    [self presentViewController:alerTure animated:YES completion:nil];
}
#pragma mark  付款
-(void)payFromRow:(int) index{
    
    
#warning  微信支付
    if(index == 0){
        
        if ([WXApi isWXAppInstalled]){
            [self sendNetWorking_WXPay];
            
        }else{
            [self alert:@"提示" msg:@"未安装微信"];
        }
        //支付宝
    }else if(index == 1){
#warning  需要填写商户app申请的
        NSString *appID = kAliPayAppID;
#warning  私钥
        NSString *rsa2PrivateKey = kRsa2PrivateKey;
        NSString *rsaPrivateKey = @"";
        /*
         *生成订单信息及签名
         */
        //将商品信息赋予AlixPayOrder的成员变量
        Order* order = [Order new];
        
        // NOTE: app_id设置
        order.app_id = appID;
        
        // NOTE: 支付接口名称
        order.method = @"alipay.trade.app.pay";
        
        // NOTE: 参数编码格式
        order.charset = @"utf-8";
        
        // NOTE: 当前时间点
        NSDateFormatter* formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        order.timestamp = [formatter stringFromDate:[NSDate date]];
        
        // NOTE: 支付版本
        order.version = @"1.0";
        
        // NOTE: sign_type 根据商户设置的私钥来决定
        order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
        
        // NOTE: 商品数据
        order.biz_content = [BizContent new];
        order.biz_content.body = @"我是测试数据";
        
        IWMeOrderFormProductModel *selectModel  =  self.selectModel.children.firstObject;
        NSString  *productName = @"商品";
        if([selectModel isKindOfClass:[IWMeOrderFormProductModel class]] || [selectModel.productName isKindOfClass:[NSNull class]] || [selectModel.productName isEqual:@""]){
            productName = selectModel.productName;
        
        }
        order.biz_content.subject = productName;
        
#warning 订单号
        order.biz_content.out_trade_no = self.selectModel.orderId; //订单ID（由商家自行制定）
        order.biz_content.timeout_express = @"30m"; //超时时间设置
        order.biz_content.total_amount = [NSString stringWithFormat:@"%@", self.selectModel.payPrice]; //商品价格
//        order.biz_content.total_amount = [NSString stringWithFormat:@"%@", @"0.01"]; //商品价格
        
        //将商品信息拼接成字符串
        NSString *orderInfo = [order orderInfoEncoded:NO];
        NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
        NSLog(@"orderSpec = %@",orderInfo);
        
        // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
        //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
        NSString *signedString = nil;
        RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
        if ((rsa2PrivateKey.length > 1)) {
            signedString = [signer signString:orderInfo withRSA2:YES];
        } else {
            signedString = [signer signString:orderInfo withRSA2:NO];
        }
        
        // NOTE: 如果加签成功，则继续执行支付
        if (signedString != nil) {
            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
            NSString *appScheme = @"IWShopping";
            
            // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
            NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                     orderInfoEncoded, signedString];
            __weak typeof(self) weaKself = self;
            // NOTE: 调用支付结果开始支付
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                
                
                NSLog(@"reslut = %@",resultDic);
                //                  [weaKself payOrderFinishWIthOrderIds:orderIds];
                
                
                //                    //结果处理,其实就是取字典里面的内容,这个取字符串然后变个模型就好了 或者直接取不便模型,方法很多.
                //                    NSLog(@"开始确认支付状态 %@",resultDic[@"resultStatus"]);
                //                    AlixPayResult* resultModel = [AlixPayResult itemWithDictory:resultDic];
                //                    if (resultModel)
                //                    {
                //                        //状态返回9000为成功
                //                        if (resultModel.statusCode == 9000)
                //                        {
                //                            /*
                //                             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
                //                             */
                //                            NSLog(@"支付宝交易成功");
                //
                //                            /*
                //                             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
                //                             */
                //
                //                            //交易成功
                //                            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
                //                            id<DataVerifier> verifier;
                //                            verifier = CreateRSADataVerifier(key);
                //
                //                            // 验证签名
                //                            if ([verifier verifyString:resultModel.resultString withSign:resultModel.signString])
                //                            {
                //                                //验证签名成功，交易结果无篡改
                //                                NSLog(@"验证成功");
                //                            }
                //                        }
                //                    }
                //                    else if([resultDic[@"resultStatus"]isEqualToString:@"6001"])
                //                    {
                //                        //用户取消
                //                        NSLog(@"用户主动取消支付");
                //                    }else
                //                    {
                //                        
                //                    }
                
                
            }];
        }

        //银联
    }else{
        
        [self  payOrderFinish];
    }
}

#pragma mark    支付宝付款通知
-(void)aliPayCallBack:(NSNotification*) notification{
    NSDictionary  *object =   [notification object];//通过这个获取到传递的对象
    /* result = "{\"alipay_trade_app_pay_response\":{\"code\":\"10000\",\"msg\":\"Success\",\"app_id\":\"2017040506558991\",\"auth_app_id\":\"2017040506558991\",\"charset\":\"utf-8\",\"timestamp\":\"2017-04-09 00:14:15\",\"total_amount\":\"0.01\",\"trade_no\":\"2017040921001004340257093639\",\"seller_id\":\"2088621609397812\",\"out_trade_no\":\"521\"},\"sign\":\"lGo6OGL8/DybIQblJHR4/M6OrR2mY0EhPmSePtWHxQFi5uuOXCx4UGZVgQRcOh28e7drAXCFN8wkeu8zz//ELvTl1FfZTM64W92Vxu6oRNLXWevkvW9FLSpJOf22OgFDQZPFLCz9vbq4C246U+1pw0EAn3MWXhHJAImxPCJeMPn5Y9XK0UIUTnS3o7axRubRQdPIs9FZHvhTyAbzc1kYmCD3RTUxiN/VqvrWWiWX7P7CUaK79k0ErY3dOveuodvam6kCSDtaIN5L8RjDRS9u7h6C4YkkMjP98EXkiDbJNTHQVJ5K2mkDrdPTZ63hVvtujXzItchjUSmQzdjm90M2rQ==\",\"sign_type\":\"RSA2\"}";
     resultStatus = 9000;*/
    //结果处理,其实就是取字典里面的内容,这个取字符串然后变个模型就好了 或者直接取不便模型,方法很多.
    NSLog(@"开始确认支付状态 %@",object[@"resultStatus"]);
    //状态返回9000为成功
    if ([object[@"resultStatus"] isEqual:@"9000"])
    {
        NSLog(@"支付宝交易成功");
        [self payOrderFinish];
    }else if([object[@"resultStatus"] isEqual:@"6001"]){
        //用户取消
        NSLog(@"用户主动取消支付");
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"用户主动取消支付"];
    }else{
        //失败
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"支付失败"];
    }
}

#pragma mark   结束付款 回调
-(void)payOrderFinish{
    //调用接口
    NSString *lastString = [NSString stringWithFormat:@"%@/%@?orderIds=%@",kNetUrl,@"order/payOrderFinish",self.selectModel.orderId];
    
    //转码  必须要这一步，要不就挂了
    NSString *url = [lastString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    __weak typeof(self) weakSelf = self;
//    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
//        [[ASingleton shareInstance] stopLoadingView];
        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"code"]) {
//            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"支付回调失败"];
//            [weakSelf payOrderFinishSuccess];
            return ;
        }
        if (![@"0" isEqual:json[@"code"]]){
//            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"支付回调失败"];
//            [weakSelf payOrderFinishSuccess];
            return ;
        }
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"支付回调成功"];
        [weakSelf payOrderFinishSuccess];
    } failure:^(NSError *error) {
//        [[ASingleton shareInstance] stopLoadingView];
//        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"支付回调失败"];
//        [weakSelf payOrderFinishSuccess];
    }];
}
#pragma mark 结束付款成功 回调  刷新当前页面数据
-(void)payOrderFinishSuccess{
    [self getProjectesDownRefresh:NO isFrist:NO];
}

#pragma mark 查看物流
-(void)chaWuLiuWithModel:(IWMeOrderFormModel *)model{
    IWToViewWuLiuVC *toVC = [[IWToViewWuLiuVC alloc] init];
    toVC.orderId = model.orderId;
    [self.navigationController pushViewController:toVC animated:YES];
}
#pragma mark 取消订单
-(void)cancelPayWithModel:(IWMeOrderFormModel *)model{
    
    //调用接口
    NSString *url = [NSString stringWithFormat:@"%@/%@?shopId=%@&orderId=%@",kNetUrl,@"order/cancelOrder",model.shopId,model.orderId];
    
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"code"]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"取消订单失败"];
            return ;
        }
        if (![@"0" isEqual:json[@"code"]]){
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"取消订单失败"];
            return ;
        }
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"取消订单成功"];
        [weakSelf getProjectesDownRefresh:NO isFrist:NO];
        
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"取消订单失败"];
    }];
}
#pragma mark 确认收货
-(void)sureWithModel:(IWMeOrderFormModel *)model{
    
    //调用接口
    NSString *url = [NSString stringWithFormat:@"%@/%@?shopId=%@&orderId=%@",kNetUrl,@"order/receivingOrder",model.shopId,model.orderId];
    
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"code"]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"确认收货失败"];
            return ;
        }
        if (![@"0" isEqual:json[@"code"]]){
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"确认收货失败"];
            return ;
        }
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"确认收货成功"];
        [weakSelf getProjectesDownRefresh:NO isFrist:NO];
        
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"确认收货失败"];
    }];
    
    
}
#pragma mark 评价"
-(void)discuessWithModel:(IWMeOrderFormModel *)model{
    
    
    IWNearCommitDiscussVC *discussVC = [[IWNearCommitDiscussVC alloc]init];
    discussVC.model = model;
    
    discussVC.orderFormVC = self;
    
    [self.navigationController pushViewController:discussVC animated:YES];
    
}


#pragma mark 高度cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFRate(100);
}

#pragma mark 组数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
#pragma mark 组内部cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    IWMeOrderFormModel *model = self.dataArray[section];
    return model.children.count;
}
#pragma mark 组内部cell实现
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IWMeOrderFormCell *cell = [IWMeOrderFormCell cellWithTableView:tableView];
    
    IWMeOrderFormModel *model = self.dataArray[indexPath.section];
    IWMeOrderFormProductModel *productModel = model.children[indexPath.row];
    cell.model = productModel;
    //    __weak typeof(self) weakSelf = self;
    //    cell.selectBtnClick = ^(IWMeOrderFormCell * cell){
    //        model.haveSelect = !model.haveSelect;
    //        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //
    //    };
    //    cell.subBtnClick = ^(IWMeOrderFormCell * cell){
    //        NSInteger  count =  [model.count integerValue];
    //        if (count != 1) {
    //            model.count = [NSString stringWithFormat:@"%ld", count - 1];
    //            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //        }
    //    };
    //    cell.addBtnClick = ^(IWMeOrderFormCell * cell){
    //        NSInteger  count =  [model.count integerValue];
    //        model.count = [NSString stringWithFormat:@"%ld", count + 1];
    //        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //    };
    //    cell.crashBtnClick = ^(IWMeOrderFormCell * cell){
    //
    //        NSMutableArray *tempArray  = self.dataArray[indexPath.section];
    //        [tempArray removeObjectAtIndex:indexPath.row];
    //        if (!tempArray || tempArray.count == 0) {
    //            [self.dataArray removeObjectAtIndex:indexPath.section];
    //
    //        }
    //
    //        [weakSelf.tableView reloadData];
    //    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    IWMeOrderFormModel *fatherModel =   self.dataArray[indexPath.section];
    IWMeOrderFormProductModel *model = fatherModel.children[indexPath.row];
    NSString *stateStr;
    switch ([fatherModel.state integerValue]) {
        case 0:
            stateStr = @"待付款";
            break;
        case 1:
            stateStr = @"待发货";
            break;
        case 2:
            stateStr = @"待收货";
            break;
        case 3:
            stateStr = @"待评价";
            break;
            
        default:
            break;
    }
    NSDictionary *oneDic = @{
                             @"orderNum":fatherModel.orderNum,
                             @"createTime":fatherModel.createdTime,
                             @"orderState":stateStr?stateStr:@"",
                             @"shopId":fatherModel.shopId,
                             @"orderId":fatherModel.orderId
                             };
    
    
    NSString *consigneeName = @"";
    NSString *phone = @"";
    
    NSString *consigneeAdd = @"";
    if ([fatherModel.addressInfo isKindOfClass:[NSDictionary class]]) {
        consigneeName = fatherModel.addressInfo[@"consignee"]?fatherModel.addressInfo[@"consignee"]:@"";
        phone = fatherModel.addressInfo[@"phone"]?fatherModel.addressInfo[@"phone"]:@"";
        // province city district detailAddress
        consigneeAdd = [NSString stringWithFormat:@"%@ %@ %@ %@",fatherModel.addressInfo[@"province"]?fatherModel.addressInfo[@"province"]:@"",
                        fatherModel.addressInfo[@"city"]?fatherModel.addressInfo[@"city"]:@"",
                        fatherModel.addressInfo[@"district"]?fatherModel.addressInfo[@"district"]:@"",
                        fatherModel.addressInfo[@"detailAddress"]?fatherModel.addressInfo[@"detailAddress"]:@""];
        
    }
    NSDictionary *twoDic = @{
                             
                             @"consigneeName":consigneeName,
                             @"phone":phone,
                             @"consigneeAdd":consigneeAdd
                             
                             };
    // 此数组放两个字典
    NSMutableArray *threeArr = [NSMutableArray array];
    
    for (IWMeOrderFormProductModel *model in fatherModel.children) {
        NSDictionary *dic = @{
                              
                              @"shopName":fatherModel.shopName,
                              @"goodsImg":model.thumbImg,
                              @"goodsName":model.productName,
                              @"goodsSku":model.attributeValue,
                              @"goodsPrice":model.salePrice,
                              // @"distribution":配送方式(如:快递、邮寄等)
                              // @"payWay":支付方式(如:微信、支付宝等)
                              @"shopNum":model.count
                              
                              };
        
        [threeArr addObject:dic];
    }
    
    NSDictionary * fourDic = @{
                               @"orderTotal":fatherModel.payPrice,
                               @"freight":fatherModel.expressPrice,
                               // @"discount":会币抵扣
                               };
    IWDingDanOneVC *oneVC = [[IWDingDanOneVC alloc] init];
    oneVC.oneDic = oneDic;
    oneVC.twoDic = twoDic;
    //    oneVC.threeDic = threeDic;
    oneVC.fourDic = fourDic;
    
    oneVC.threeArr = threeArr;
    [self.navigationController pushViewController:oneVC animated:YES];
}

#pragma mark  set方法
-(void)setNeedPOPToRootIndex:(NSInteger)needPOPToRootIndex{
    _needPOPToRootIndex = needPOPToRootIndex;
    [ASingleton shareInstance].orderFormbackCommit = ^(BOOL removeBlock){
        IWTabBarViewController *tbVC = (IWTabBarViewController *)self.tabBarController;
        [tbVC from:0 To:_needPOPToRootIndex isRootVC:NO currentVC:self];
        [ASingleton shareInstance].orderFormbackCommit = nil;
    };
}

#pragma mark 微信支付
- (void)sendNetWorking_WXPay{
    
        [[ASingleton shareInstance]startLoadingInView:self.view];
        NSString *url = [NSString stringWithFormat:@"%@/%@?payPrice=%@&orderIds=%@",kNetUrl,@"pay/weixin",[NSString stringWithFormat:@"%@", self.selectModel.payPrice],self.selectModel.orderId];
        
        __weak typeof(self) weakSelf = self;
        [IWHttpTool  getWithURL:url params:nil success:^(id json) {
            [[ASingleton shareInstance] stopLoadingView];
            
            if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"data"]) {
                [weakSelf failSetup];
                return ;
            }
            if (![@"0" isEqual:json[@"code"]]){
                [weakSelf failSetup];
                return ;
            }
            NSDictionary *contentDic = json[@"data"];
            if (!contentDic || ![contentDic isKindOfClass:[NSDictionary class]]) {
                [weakSelf failSetup];
                return ;
            }
            
            NSString *appid         = contentDic[@"appid"]?contentDic[@"appid"]:@"";
            NSString *noncestr      = contentDic[@"noncestr"]?contentDic[@"noncestr"]:@"";
            NSString *package       = contentDic[@"package"]?contentDic[@"package"]:@"";
            NSString *partnerid     = contentDic[@"partnerid"]?contentDic[@"partnerid"]:@"";
            NSString *sign          = contentDic[@"sign"]?contentDic[@"sign"]:@"";
            NSString *prepayid      = contentDic[@"prepayid"]?contentDic[@"prepayid"]:@"";
            NSString *timestamp     = contentDic[@"timestamp"]?contentDic[@"timestamp"]:@"";
            
            
            //调起微信支付
            PayReq* wxreq             = [[PayReq alloc] init];
            wxreq.openID              = appid; // 微信的appid
            wxreq.partnerId           = partnerid;
            wxreq.prepayId            = prepayid;
            wxreq.nonceStr            = noncestr;
            wxreq.timeStamp           = [timestamp intValue];
            wxreq.package             = package;
            wxreq.sign                = sign;
            [WXApi sendReq:wxreq];
        } failure:^(NSError *error) {
            [[ASingleton shareInstance] stopLoadingView];
            [weakSelf failSetup];
        }];
 }
#pragma mark - 事件
- (void)getOrderPayResult:(NSNotification *)notification{
    NSLog(@"userInfo: %@",notification.userInfo);
    if ([notification.object isEqualToString:@"success"]){
        //回调
        [self  payOrderFinish];
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        [self alert:@"提示" msg:@"支付失败"];
    }
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}
#pragma mark 移除通知
- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
