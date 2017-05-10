//
//  IWDetailsVC.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/24.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDetailsVC.h"
#import "IWDetailsThreeCell.h"
#import "IWCommentModel.h"
#import "IWDetailsFourCell.h"
#import "IWDetailModel.h"
#import "IWDetailImagesModel.h"
#import "IWDetailSkuModel.h"
#import "IWDetailSkuInfosModel.h"
#import "IWSkuCell.h"
#import "IWAddShoopNumCell.h"
#import "IWItemsModel.h"
#import "IWShopBtn.h"
#import "IWLoginVC.h"
#import "IWShoppingSureVC.h"
#import "IWShoppingModel.h"
#import "IWTabBarViewController.h"
@interface IWDetailsVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
// 列表
@property (nonatomic,weak)UITableView *myTableView;
// 轮播控制器
@property (nonatomic,weak)SDCycleScrollView *cycleScrollView;
// 商品详情按钮选中下标
@property (nonatomic,weak)UIView *linView;
// 评论数据源
@property (nonatomic,strong)NSMutableArray *commentData;
// 是否选中评论按钮
@property (nonatomic,assign)BOOL isComment;
// 无数据
@property (nonatomic,weak)ANodataView *noDataView;
// 模型
@property (nonatomic,strong)IWDetailModel *detailModel;
// webView高度
@property (nonatomic,assign)CGFloat webViewH;
// 价格展示
@property (nonatomic,copy)NSString *showPrice;
// 库存
@property (nonatomic,assign)NSInteger showStock;
// 选择ID数组
@property (nonatomic,strong)NSMutableArray *chooseIdArr;
@property (nonatomic,strong)NSMutableArray *chooseNameArr;
// 销售价
@property (nonatomic,weak)UILabel *salePriceLabel;
// 商品名字
@property (nonatomic,weak)UILabel *productNameLabel;
// 市场价
@property (nonatomic,weak)UILabel *smarketPriceLabel;

// itemid
@property (nonatomic,copy)NSString *itemId;
// 加载更多页书
@property (nonatomic,assign)NSInteger pageNum;
// 刷新当前数据(并非加载更多)
@property (nonatomic,assign)BOOL isRefreshData;
// 购买数量
@property (nonatomic,assign)NSInteger shopNum;
// 收藏按钮
@property (nonatomic,weak)UIButton *shouCangBtn;

@end

@implementation IWDetailsVC
- (NSMutableArray *)commentData
{
    if (_commentData == nil) {
        _commentData = [[NSMutableArray alloc] init];
    }
    return _commentData;
}

- (NSMutableArray *)chooseIdArr
{
    if (_chooseIdArr == nil) {
        _chooseIdArr = [[NSMutableArray alloc] init];
    }
    return _chooseIdArr;
}

- (NSMutableArray *)chooseNameArr
{
    if (_chooseNameArr == nil) {
        _chooseNameArr = [[NSMutableArray alloc] init];
    }
    return _chooseNameArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    _showStock = 0;
    self.pageNum = 1;
    self.isRefreshData = YES;
    _shopNum = 1;
    // 左按钮
    self.navigationItem.title = @"商品详情";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestData];
    //3.无数据时的图标
    ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth,kViewHeight)];
    noDataView.backgroundColor = [UIColor whiteColor];
    noDataView.tishiString = @"没有数据";
    //默认隐藏
    noDataView.hidden = YES;
    [self.view addSubview:noDataView];
    self.noDataView = noDataView;
    // Do any additional setup after loading the view.
    
    // 通知返回webView的高度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webViewH:) name:@"IWWebViewHeight" object:nil];
}

- (void)webViewH:(NSNotification *)no
{
    _webViewH = [no.userInfo[@"webViewH"] floatValue];
    [self.myTableView reloadData];
    IWLog(@"%@",no.userInfo[@"webViewH"]);
}

#pragma mark - 创建列表
- (void)createTableView
{
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64 - kFRate(50)) style:UITableViewStylePlain];
    // 列表
    myTableView.backgroundColor = IWColor(240, 240, 240);
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    [self createHeaderView];
    
    __weak typeof(self) weakSelf = self;
    // 上拉加载更多
    myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_isComment) {
            weakSelf.isRefreshData = NO;
            [weakSelf pointData];
            [myTableView.mj_footer endRefreshing];
        }else{
            [myTableView.mj_footer endRefreshing];
        }
        
    }];
    
    // 底部购买框
    UIView *shopView = [[UIView alloc] initWithFrame:CGRectMake(0, kViewHeight - kFRate(50), kViewHeight, kFRate(50))];
    shopView.backgroundColor = [UIColor whiteColor];
    shopView.layer.borderWidth = kFRate(0.5);
    shopView.layer.borderColor = IWColor(240, 240, 240).CGColor;
    [self.view addSubview:shopView];
    
    // 收藏
    UIButton *shouCangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shouCangBtn.frame = CGRectMake(0, 0, kFRate(50), kFRate(50));
    [shouCangBtn setImage:_IMG(@"IWWeiShouCang") forState:UIControlStateNormal];
    shouCangBtn.layer.borderWidth = kFRate(0.5);
    shouCangBtn.layer.borderColor = IWColor(240, 240, 240).CGColor;
    shouCangBtn.contentMode = UIViewContentModeCenter;
    [shouCangBtn addTarget:self action:@selector(shouCangBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [shopView addSubview:shouCangBtn];
    self.shouCangBtn = shouCangBtn;
    
    // 购物车
    UIButton *shopCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shopCarBtn.frame = CGRectMake(CGRectGetMaxX(shouCangBtn.frame), 0, kFRate(50), kFRate(50));
    [shopCarBtn setImage:_IMG(@"IWGouWuChe") forState:UIControlStateNormal];
    shopCarBtn.layer.borderWidth = kFRate(0.5);
    shopCarBtn.layer.borderColor = IWColor(240, 240, 240).CGColor;
    shopCarBtn.contentMode = UIViewContentModeCenter;
    [shopCarBtn addTarget:self action:@selector(shopCarBtn) forControlEvents:UIControlEventTouchUpInside];
    [shopView addSubview:shopCarBtn];
    
    // 加入购物车
    CGFloat addW = (kViewWidth - kFRate(100)) / 2;
    UIButton *addShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addShopBtn.frame = CGRectMake(CGRectGetMaxX(shopCarBtn.frame), 0, addW, kFRate(50));
    [addShopBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    addShopBtn.backgroundColor = [UIColor orangeColor];
    addShopBtn.titleLabel.font = kFont28px;
    [addShopBtn addTarget:self action:@selector(addShopBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [shopView addSubview:addShopBtn];
    
    // 立即购买
    UIButton *shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shopBtn.frame = CGRectMake(CGRectGetMaxX(addShopBtn.frame), 0, addW, kFRate(50));
    [shopBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    shopBtn.backgroundColor = kRedColor;
    shopBtn.titleLabel.font = kFont28px;
    [shopBtn addTarget:self action:@selector(shopBtn) forControlEvents:UIControlEventTouchUpInside];
    [shopView addSubview:shopBtn];
}

- (void)createHeaderView
{
    CGFloat tableW = self.myTableView.frame.size.width;
    // headerView
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> 轮播图 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, tableW, kRate(320)) delegate:self placeholderImage:nil];
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    //    cycleScrollView.autoScrollTimeInterval = 1.0;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotColor = IWColor(252, 62, 99); // 自定义分页控件小圆标颜色
    cycleScrollView.pageDotColor = [UIColor whiteColor];
    [headerView addSubview:cycleScrollView];
    self.cycleScrollView = cycleScrollView;
    //         --- 模拟加载延迟
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *tempArr = weakSelf.detailModel.imgModelArr;
        NSMutableArray *imgArr = [[NSMutableArray alloc] init];
        if (tempArr && tempArr.count > 0) {
            for (IWDetailImagesModel *model in tempArr) {
                [imgArr addObject:model.thumbImg];
            }
        }
        cycleScrollView.imageURLStringsGroup = imgArr;
    });
    
    // 商品
    UILabel *productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kFRate(10), CGRectGetMaxY(cycleScrollView.frame) + kFRate(15), kViewWidth - kFRate(20), _detailModel.nameH)];
    productNameLabel.text = _detailModel.productName;
    productNameLabel.textColor = IWColor(50, 50, 50);
    productNameLabel.font = kFont32pxBold;
    productNameLabel.numberOfLines = 0;
    [headerView addSubview:productNameLabel];
    self.productNameLabel = productNameLabel;
    
    // 出售价
    UILabel *salePriceLabel = [[UILabel alloc] init];
    CGFloat showPriceF = [_showPrice floatValue];
    CGFloat integralF = [_detailModel.integral floatValue];
    salePriceLabel.text = [NSString stringWithFormat:@"￥%.2f+%.0f贝壳",showPriceF,integralF];
    salePriceLabel.textColor = kRedColor;
    salePriceLabel.font = kFont32px;
    [salePriceLabel sizeToFit];
    salePriceLabel.frame = CGRectMake(kFRate(10), kFRate(15) + CGRectGetMaxY(productNameLabel.frame), salePriceLabel.frame.size.width, salePriceLabel.frame.size.height);
    [headerView addSubview:salePriceLabel];
    self.salePriceLabel = salePriceLabel;
    
    // 市场价
    UILabel *smarketPriceLabel = [[UILabel alloc] init];
    smarketPriceLabel.text = _detailModel.smarketPrice;
    smarketPriceLabel.textColor = IWColor(120, 120, 120);
    smarketPriceLabel.font = kFont28px;
    [smarketPriceLabel sizeToFit];
    smarketPriceLabel.frame = CGRectMake(CGRectGetMaxX(salePriceLabel.frame) + kFRate(10), salePriceLabel.frame.origin.y + kFRate(1), smarketPriceLabel.frame.size.width, smarketPriceLabel.frame.size.height);
    
    NSString *oldPrice = _detailModel.smarketPrice?_detailModel.smarketPrice:@"";
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:IWColor(120, 120, 120) range:NSMakeRange(0, length)];
    [smarketPriceLabel setAttributedText:attri];
//    [headerView addSubview:smarketPriceLabel];
    self.smarketPriceLabel = smarketPriceLabel;
    
    // 原价
    UILabel *stockName = [[UILabel alloc] init];
    stockName.text = @"原价: ";
    stockName.textColor = IWColor(160, 160, 160);
    stockName.font = kFont24px;
    [stockName sizeToFit];
    stockName.frame = CGRectMake(kFRate(10), CGRectGetMaxY(salePriceLabel.frame) + kFRate(15), stockName.frame.size.width, stockName.frame.size.height);
    [headerView addSubview:stockName];
    
    UILabel *stockLabel = [[UILabel alloc] init];
    CGFloat smarketPriceF = [_detailModel.smarketPrice floatValue];
    stockLabel.text = [NSString stringWithFormat:@"%.2f",smarketPriceF];
    stockLabel.textColor = IWColor(98, 98, 98);
    stockLabel.font = kFont24px;
    [stockLabel sizeToFit];
    stockLabel.frame = CGRectMake(CGRectGetMaxX(stockName.frame), stockName.frame.origin.y, stockLabel.frame.size.width, stockLabel.frame.size.height);
    [headerView addSubview:stockLabel];
    
    // 邮费
    UILabel *saleCountName = [[UILabel alloc] init];
    saleCountName.text = @"邮费: ";
    saleCountName.textColor = IWColor(160, 160, 160);
    saleCountName.font = kFont24px;
    [saleCountName sizeToFit];
    saleCountName.frame = CGRectMake((kViewWidth - kFRate(20)) / 2, stockName.frame.origin.y, saleCountName.frame.size.width, saleCountName.frame.size.height);
    [headerView addSubview:saleCountName];
    
    UILabel *saleCountLabel = [[UILabel alloc] init];
    saleCountLabel.text = _detailModel.expressMoney;
    saleCountLabel.textColor = IWColor(98, 98, 98);
    saleCountLabel.font = kFont24px;
    [saleCountLabel sizeToFit];
    saleCountLabel.frame = CGRectMake(CGRectGetMaxX(saleCountName.frame), stockName.frame.origin.y, saleCountLabel.frame.size.width, saleCountLabel.frame.size.height);
    [headerView addSubview:saleCountLabel];
    
    // 销量
    UILabel *expressMoneyName = [[UILabel alloc] init];
    expressMoneyName.text = @"销量: ";
    expressMoneyName.textColor = IWColor(160, 160, 160);
    expressMoneyName.font = kFont24px;
    [expressMoneyName sizeToFit];
    expressMoneyName.frame = CGRectMake(kFRate(10), CGRectGetMaxY(stockName.frame) + kFRate(10), expressMoneyName.frame.size.width, expressMoneyName.frame.size.height);
    [headerView addSubview:expressMoneyName];
    
    UILabel *expressMoneyLabel = [[UILabel alloc] init];
    expressMoneyLabel.text = _detailModel.saleCount;
    expressMoneyLabel.textColor = IWColor(98, 98, 98);
    expressMoneyLabel.font = kFont24px;
    [expressMoneyLabel sizeToFit];
    expressMoneyLabel.frame = CGRectMake(CGRectGetMaxX(expressMoneyName.frame), expressMoneyName.frame.origin.y, expressMoneyLabel.frame.size.width, expressMoneyLabel.frame.size.height);
    [headerView addSubview:expressMoneyLabel];
    
    // 库存
    UILabel *integralName = [[UILabel alloc] init];
    integralName.text = @"库存: ";
    integralName.textColor = IWColor(160, 160, 160);
    integralName.font = kFont24px;
    [integralName sizeToFit];
    integralName.frame = CGRectMake(saleCountName.frame.origin.x, CGRectGetMaxY(stockName.frame) + kFRate(10), integralName.frame.size.width, integralName.frame.size.height);
    [headerView addSubview:integralName];
    
    UILabel *integralLabel = [[UILabel alloc] init];
    integralLabel.text = _detailModel.stock;
    integralLabel.textColor = IWColor(98, 98, 98);
    integralLabel.font = kFont24px;
    [integralLabel sizeToFit];
    integralLabel.frame = CGRectMake(CGRectGetMaxX(integralName.frame), integralName.frame.origin.y, integralLabel.frame.size.width, integralLabel.frame.size.height);
    [headerView addSubview:integralLabel];
    
    headerView.frame = CGRectMake(0, 0, tableW, CGRectGetMaxY(integralLabel.frame) + kFRate(20));
    
    self.myTableView.tableHeaderView = headerView;
}

- (void)collectionLeftCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return _detailModel.skuModelArr.count + 1;
            break;
            
        default:
            if (_isComment) {
                return self.commentData.count;
            }else{
               return 1;
            }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (indexPath.row < _detailModel.skuModelArr.count) {
            IWDetailSkuModel *model = _detailModel.skuModelArr[indexPath.row];
            return model.cellH;
        }
        return kFRate(50.0f);
    }else{
        if (_isComment) {
            IWCommentModel *model = self.commentData[indexPath.row];
            return model.cellH;
        }
        return _webViewH;
    }
}

#pragma mark - Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == _detailModel.skuModelArr.count) {
            IWAddShoopNumCell *cell = [IWAddShoopNumCell cellWithTableView:tableView];
            cell.IWAddShopNum = ^(NSInteger shopNum){
                _shopNum = shopNum;
            };
            return cell;
        }else{
            IWSkuCell *cell = [IWSkuCell cellWithTableView:tableView];
            cell.skuModel = _detailModel.skuModelArr[indexPath.row];
            __weak typeof(self) weakSelf = self;
            cell.IWChooseSku = ^(NSInteger tag){
                IWDetailSkuModel *skuModel = _detailModel.skuModelArr[indexPath.row];
                IWDetailSkuInfosModel *infoModel = skuModel.skuInfosModelArr[tag];
                [weakSelf chooseItemId:infoModel.attributeValueId itemName:infoModel.attributeValueName index:indexPath.row];
            };
            return cell;
        }
    }else{
        if (_isComment) {
            IWDetailsFourCell *cell = [IWDetailsFourCell cellWithTableView:tableView];
            cell.commentModel = self.commentData[indexPath.row];
            return cell;
        }
        IWDetailsThreeCell *cell = [IWDetailsThreeCell cellWithTableView:tableView];
        cell.detailModel = _detailModel;
        if (_webViewH > 0) {
            cell.webView.frame = CGRectMake(0, 0, kViewWidth, _webViewH);
        }
        
        return cell;
    }
}

#pragma mark - HeaderView商品详情/评论

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return kFRate(50.0f);
    }
    return kFRate(10);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(50))];
    headerView.backgroundColor = [UIColor whiteColor];
    if (section == 1) {
        UIView *btnBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(10))];
        btnBack.backgroundColor = IWColor(240, 240, 240);
        [headerView addSubview:btnBack];
        
        NSArray *btnName = @[@"商品详情",@"商品评价"];
        for (NSInteger i = 0; i < 2; i ++) {
            UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (i == 0) {
                headerBtn.frame = CGRectMake(kFRate(20), kFRate(10), kViewWidth / 2 - kFRate(20), kFRate(40));
            }else{
                headerBtn.frame = CGRectMake(i * kViewWidth / 2, kFRate(10), kViewWidth / 2 - kFRate(20), kFRate(40));
            }
            
            [headerBtn setTitle:btnName[i] forState:UIControlStateNormal];
            headerBtn.titleLabel.font = kFont28px;
            [headerBtn setTitleColor:IWColor(50, 50, 50) forState:UIControlStateNormal];
            headerBtn.tag = i + 66666;
            [headerBtn addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:headerBtn];
        }
        // 选中下划线
        UIView *linView = [[UIView alloc] init];
        if (_isComment) {
            linView.frame = CGRectMake(kViewWidth / 2, kFRate(47.5), kViewWidth / 2 - kFRate(20), kFRate(2.5));
        }else{
            linView.frame = CGRectMake(kFRate(20), kFRate(47.5), kViewWidth / 2 - kFRate(20), kFRate(2.5));
        }
        linView.backgroundColor = kRedColor;
        [headerView addSubview:linView];
        self.linView = linView;
        
        UIView *gLinView = [[UIView alloc] initWithFrame:CGRectMake(0, kFRate(49.5), kViewWidth, kFRate(0.5))];
        gLinView.backgroundColor = kLineColor;
        [headerView addSubview:gLinView];
        
        return headerView;
    }else{
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(10))];
        headerView.backgroundColor = [UIColor clearColor];
        return headerView;
    }
    return nil;
}

// 详情切换
- (void)headerBtnClick:(UIButton *)sender
{
    switch (sender.tag - 66666) {
        case 0:
            _isComment = NO;
            break;
            
        default:
            _isComment = YES;
            if (self.commentData.count == 0) {
                [[TKAlertCenter defaultCenter]postAlertWithMessage:@"暂无评价"];
            }
            break;
    }
    [self.myTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 选择规格
- (void)chooseItemId:(NSString *)itemId itemName:(NSString *)itemName index:(NSInteger)index
{
    self.chooseIdArr[index] = itemId;
    self.chooseNameArr[index] = itemName;
    if (self.chooseIdArr && self.chooseIdArr.count > 0) {
        NSString *string = [self.chooseIdArr componentsJoinedByString:@";"];
        if (self.detailModel.itemsModelArr && self.detailModel.itemsModelArr.count > 0) {
            for (NSInteger i = 0; i < self.detailModel.itemsModelArr.count; i ++) {
                IWItemsModel *itemModel = self.detailModel.itemsModelArr[i];
                if ([string isEqual:itemModel.attValArr]) {
//                    if (![itemModel.stock isEqual:@"0"] && itemModel.stock && ![itemModel.stock isKindOfClass:[NSNull class]]) {
                    self.showPrice = itemModel.salePrice;
                    self.showStock = [itemModel.stock integerValue];
                    self.itemId = itemModel.itemId;
                    CGFloat showPriceF = [_showPrice floatValue];
                    CGFloat integralF = [_detailModel.integral floatValue];
                    self.salePriceLabel.text = [NSString stringWithFormat:@"￥%.2f+%.0f贝壳",showPriceF,integralF];
                    [self.salePriceLabel sizeToFit];
                    self.salePriceLabel.frame = CGRectMake(kFRate(10), kFRate(15) + CGRectGetMaxY(self.productNameLabel.frame), self.salePriceLabel.frame.size.width, self.salePriceLabel.frame.size.height);
                    self.smarketPriceLabel.frame = CGRectMake(CGRectGetMaxX(self.salePriceLabel.frame) + kFRate(10), self.salePriceLabel.frame.origin.y + kFRate(1), self.smarketPriceLabel.frame.size.width, self.smarketPriceLabel.frame.size.height);
                        break;
//                    }
                }else{
                    self.showStock = 0;
                }
            }
        }else{
            self.showStock = 0;
        }
    }else{
        self.showStock = 0;
    }
    IWLog(@"%ld",self.showStock);
}

#pragma mark - 加入购物车/收藏
// 收藏
- (void)shouCangBtnClick
{
    if ([ASingleton shareInstance].loginModel == nil) {
        IWLoginVC *loginVC = [[IWLoginVC alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    if (_showStock == 0) {
        [self changeFail:@"暂无库存"];
        return;
    }
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/platform/addProductCollect?shopId=%@&productId=%@&productName=%@&smarketPrice=%@&salePrice=%@&integral=%@&thumbImg=%@&userId=%@",kNetUrl,_detailModel.shopId,_detailModel.productId,_detailModel.productName,_detailModel.smarketPrice,_showPrice,_detailModel.integral,_detailModel.thumbImg,[ASingleton shareInstance].loginModel.userId];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf changeFail:json[@"message"]?:@"收藏失败"];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf changeFail:json[@"message"]?:@"收藏失败"];
            return ;
        }
        [weakSelf.shouCangBtn setImage:_IMG(@"IWYiShouCang") forState:UIControlStateNormal];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf changeFail:@"收藏失败"];
        return ;
    }];
}
// 购物车
- (void)shopCarBtn
{
    //切换回第一个控制器
    if ([ASingleton shareInstance].loginModel == nil) {
        IWLoginVC *loginVC = [[IWLoginVC alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    IWTabBarViewController *tbVC = (IWTabBarViewController *)self.tabBarController;
    [tbVC from:0 To:2 isRootVC:NO currentVC:self];
}
// 加入购物车
- (void)addShopBtnClick{
    if ([ASingleton shareInstance].loginModel == nil) {
        IWLoginVC *loginVC = [[IWLoginVC alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    if (_showStock == 0) {
        [self changeFail:@"暂无库存"];
        return;
    }
    NSString *string = [self.chooseNameArr componentsJoinedByString:@";"];
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/platform/addUserCart?method=%@&userId=%@&productId=%@&productNum=%@&shopId=%@&count=%@&attributeValue=%@&itemId=%@",kNetUrl,@"save",[ASingleton shareInstance].loginModel.userId,_detailModel.productId,_detailModel.productNum,_detailModel.shopId,[NSString stringWithFormat:@"%ld",_shopNum],string,_itemId];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf changeFail:@"加入购物车失败"];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf changeFail:@"加入购物车失败"];
            return ;
        }
        [weakSelf changeFail:@"加入购物车成功"];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf changeFail:@"加入购物车失败"];
        return ;
    }];
}

- (void)shopBtn{
    if ([ASingleton shareInstance].loginModel == nil) {
        IWLoginVC *loginVC = [[IWLoginVC alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    if (_showStock == 0) {
        [self changeFail:@"暂无库存"];
        return;
    }
    IWShoppingModel *shopModel = [[IWShoppingModel alloc]init];
    
    shopModel.shopId = self.detailModel.shopId;
    shopModel.shopName = self.detailModel.productName;
    shopModel.itemId = _itemId;
    shopModel.modelId = self.detailModel.productId;
    shopModel.name = self.detailModel.productName;

    shopModel.count = [NSString stringWithFormat:@"%ld",_shopNum];
    shopModel.content = [self.chooseNameArr componentsJoinedByString:@";"];
    shopModel.logo = self.detailModel.thumbImg;
    shopModel.price = self.showPrice;
    shopModel.smarketPrice = _detailModel.smarketPrice;
    shopModel.totalPrice = [NSString stringWithFormat:@"%.2f",[shopModel.smarketPrice floatValue]  * _shopNum];
    shopModel.payPrice = [NSString stringWithFormat:@"%.2f",[shopModel.price floatValue]  * _shopNum];
    shopModel.integral = _detailModel.integral;
    shopModel.expressMoney = _detailModel.expressMoney;
    /*cart =             (
     {
     attributeValue = "\U89c4\U683c:\U989c\U8272:\U767d\U8272|\U5c3a\U7801:L\U7801";
     cartId = 1;
     count = 3;
     itemId = 1;
     productId = 1;
     productName = "\U8d1d\U8bd7\U60c5\U7ae5\U88c5\U513f\U7ae5\U7eaf\U68c9\U6625\U590f\U5b63\U7537\U5973\U7ae5\U5b9d\U5b9d\U7761\U8863\U5bb6\U5c45\U670d\U77ed\U8896\U5185\U8863\U79cb\U8863\U5957\U88c5   KT\U732b";
     salePrice = 25;
     shopId = 4;
     thumbImg = "c0edc1ca-52f0-43b1-b7f4-8dc42d2aa447";
     userId = 1;
     }
     );
     shopId = 4;
     shopName = "\U97e9\U90fd\U8863\U820d\U5973\U88c5\U5e97";
     },
     */
    
    NSArray *selectArray = @[@[shopModel]];
    
    IWShoppingSureVC *sureVC = [[IWShoppingSureVC alloc]init];
    
    sureVC.dataArray = selectArray;
    
    [self.navigationController pushViewController:sureVC animated:YES];
}


- (void)changeFail:(NSString *)str
{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:str];
}

#pragma mark - 数据请求
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    self.noDataView.hidden = YES;
    NSString *url = [NSString stringWithFormat:@"%@/platform/getProductDetail?productId=%@",kNetUrl,self.productId];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf Faile];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf Faile];
            return ;
        }
        if (json[@"data"] == nil || ![json[@"data"] isKindOfClass:[NSDictionary class]]) {
            [weakSelf Faile];
            return ;
        }
        NSDictionary *data = json[@"data"];
        // 获取轮播图片集合
        weakSelf.detailModel = [[IWDetailModel alloc] initWithDic:data];
        weakSelf.showStock = [weakSelf.detailModel.stock integerValue];
        IWItemsModel *itemModel1 = weakSelf.detailModel.itemsModelArr[0];
        weakSelf.itemId = itemModel1.itemId;
        if (weakSelf.detailModel.skuModelArr && weakSelf.detailModel.skuModelArr.count > 0) {
            for (NSInteger i = 0; i < weakSelf.detailModel.skuModelArr.count; i ++) {
                IWDetailSkuModel *skuModel = weakSelf.detailModel.skuModelArr[i];
                if (skuModel.skuInfosModelArr && skuModel.skuInfosModelArr.count > 0) {
                    IWDetailSkuInfosModel *infoModel = skuModel.skuInfosModelArr[0];
                    [weakSelf.chooseIdArr addObject:infoModel.attributeValueId];
                    [weakSelf.chooseNameArr addObject:infoModel.attributeValueName];
                }
            }
        }
        if (weakSelf.chooseIdArr && weakSelf.chooseIdArr.count > 0) {
            NSString *string = [weakSelf.chooseIdArr componentsJoinedByString:@";"];
            if (weakSelf.detailModel.itemsModelArr && weakSelf.detailModel.itemsModelArr.count > 0) {
                for (NSInteger i = 0; i < weakSelf.detailModel.itemsModelArr.count; i ++) {
                    IWItemsModel *itemModel = weakSelf.detailModel.itemsModelArr[i];
                    if ([string isEqual:itemModel.attValArr]) {
                        if (![itemModel.stock isEqual:@"0"] && itemModel.stock && ![itemModel.stock isKindOfClass:[NSNull class]]) {
                        weakSelf.showPrice = itemModel.salePrice;
                        weakSelf.showStock = [itemModel.stock integerValue];
                        weakSelf.itemId = itemModel.itemId;
                            break;
                        }
                    }
                }
            }
        }
        if (weakSelf.showPrice == nil || [weakSelf.showPrice isEqual:@""]) {
            weakSelf.showPrice = weakSelf.detailModel.salePrice;
        }
        [weakSelf createTableView];
        // 异步请求评论内容
        dispatch_queue_t seriaQueue = dispatch_queue_create("pointData", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(seriaQueue, ^{
            [weakSelf pointData];
        });
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf Faile];
        return ;
    }];
}

- (void)pointData{
    if (!_isRefreshData) {
        if (self.pageNum == 1 && self.commentData.count > 0) {
            self.pageNum = 2;
        }
    }
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/platform/getProductEvaluates?productId=%@&page=%@",kNetUrl,_detailModel.productId,[NSString stringWithFormat:@"%ld",_pageNum]];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf commentFail];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf commentFail];
            return ;
        }
        if (json[@"data"] == nil || ![json[@"data"] isKindOfClass:[NSArray class]]) {
            [weakSelf commentFail];
            return;
        }
        NSArray *dataArr = json[@"data"];
        if (dataArr.count == 0) {
            [weakSelf commentFail];
            return;
        }
        for (NSDictionary *dic in dataArr) {
            IWCommentModel *model = [[IWCommentModel alloc] initWithDic:dic];
            [weakSelf.commentData addObject:model];
        }
        if (!_isRefreshData && dataArr.count > 0) {
            weakSelf.pageNum ++;
        }
        [weakSelf.myTableView reloadData];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        return ;
    }];
}

- (void)Faile{
    self.noDataView.hidden = NO;
}

- (void)commentFail
{
    if (!_isRefreshData) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"加载完毕,没有更多评价"];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
