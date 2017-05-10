//
//  IWShoppingVC.m
//  shopping201702
//
//  Created by s on 17/2/21.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWShoppingVC.h"
#import "MJRefresh.h"
#import "IWShoppingCell.h"
#import "IWShoppingModel.h"
#import "IWBatesButton.h"
#import "IWLoginVC.h"
#import "IWGategoryVC.h"
#import "IWShopingHeadSelectButton.h"
#import "IWTabBarViewController.h"
#import "IWShoppingSureVC.h"
@interface IWShoppingVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
// 无数据
@property (nonatomic,strong)ANodataView *noDataView;
// 表格，
@property (nonatomic,weak)UITableView *tableView;
// 展示数组
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,weak)UIView *topView;
//选择
@property (nonatomic,weak)UIView *selectView;

// 导航右
@property (nonatomic,weak)UIButton *modifOrOverBtn;
//金额
@property (nonatomic,weak)UILabel *priceLabel;

//
@property (nonatomic,assign)BOOL isEdit;
//页面
@property (nonatomic,assign)NSInteger page;

//结算按钮
@property (nonatomic,weak)UIButton *payButton;
// 全选按钮
@property (nonatomic,weak)IWBatesButton *allSecectBtn;

//底部
@property (nonatomic,weak)UIView *payView;

@end
@implementation IWShoppingVC
-(ANodataView *)noDataView{
    if (!_noDataView) {
        //3.无数据时的图标
        ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth,kViewHeight)];
        noDataView.backgroundColor = [UIColor clearColor];
        noDataView.tishiString = @"购物车空空";
        //默认隐藏
        noDataView.hidden = YES;
        noDataView.refreshButtonClick = ^(ANodataView *noDataView,UIButton *refreshButton){
            
        };
        noDataView.showRefreshButton = YES;
        
        _noDataView = noDataView;
        [self.view addSubview:noDataView];
    }
    return _noDataView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor HexColorToRedGreenBlue:@"f2f2f2"];
    _dataArray = [NSMutableArray array];
    
    
    self.isEdit = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor HexColorToRedGreenBlue:@"ff3b60"];
    // 自定义导航右
    UIButton *modifOrOverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [modifOrOverBtn setTitle:@"编辑" forState:UIControlStateNormal];
    modifOrOverBtn.titleLabel.textColor = [UIColor whiteColor];
    modifOrOverBtn.frame = CGRectMake(0, 0, 50, 30);
    [modifOrOverBtn addTarget:self action:@selector(modifOrOver:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:modifOrOverBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    modifOrOverBtn.hidden = YES;
    self.modifOrOverBtn = modifOrOverBtn;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //第一次 进入这里，viewWillAppear:没有必要刷新数据了
    [ASingleton shareInstance].shoppingVCNeedNoRefresh = YES;
    
    //请求数据
    [self login];
    
}

-(void)login{
    if ([ASingleton shareInstance].loginModel) {
        //请求数据
        [self getProjectesDownRefresh:NO];
    }else{
        IWLoginVC  *login = [[IWLoginVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //只有进入 订单确认 回退才不刷新
    if ([ASingleton shareInstance].shoppingVCNeedNoRefresh) {
        //后续跳过
        [ASingleton shareInstance].shoppingVCNeedNoRefresh = NO;
        return;
    }
    
    //需要刷新
    //更改 界面的数据
    //请求数据
    [self getProjectesDownRefresh:NO];
    //后续不再刷新
    [ASingleton shareInstance].shoppingVCNeedRefresh = NO;
    //后续不再刷新
    [ASingleton shareInstance].shoppingVCNeedNoRefresh = NO;
    
    
}

#pragma mark //请求数据
-(void)getProjectesDownRefresh:(BOOL )isDownRefresh{
    NSString *userId = [ASingleton shareInstance].loginModel.userId;
    if (!userId) {
        [self failSetup];
        return;
    }
    
    
    
    [[ASingleton shareInstance]startLoadingInView:self.view];
    //下拉就去第一页
    if (!isDownRefresh){
        self.page = 1;
        
        [self.dataArray removeAllObjects];
        //清空数据  0419
        self.allSecectBtn.selected = NO;
        self.priceLabel.text = @"0.00";
    }
    NSString *url = [NSString stringWithFormat:@"%@/%@?userId=%@",kNetUrl,@"user/getUserCart",userId];
    
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
        
        NSArray *contentArray = json[@"data"];
        
        if ([contentArray isEqual:@""] ||([contentArray isKindOfClass:[NSArray class]] && contentArray.count == 0)) {

            //3.无数据时的图标
            weakSelf.noDataView.tishiString = @"购物车为空";
            //默认隐藏
            weakSelf.noDataView.hidden = NO;
            weakSelf.noDataView.refreshButtonClick = ^(ANodataView *noDataView,UIButton *refreshButton){
                //切换回第一个控制器
                IWTabBarViewController *tbVC = (IWTabBarViewController *)weakSelf.tabBarController;
               [tbVC from:1 To:0 isRootVC:YES currentVC:self];
            };
            [weakSelf.noDataView.refreshButton setTitle:@"去购物" forState:UIControlStateNormal];
            weakSelf.noDataView.showRefreshButton = YES;
            weakSelf.noDataView.noDataImage = [UIImage imageNamed:@"noshoppingdata"];
            
            [weakSelf.tableView reloadData];
            weakSelf.tableView.hidden = YES;
            weakSelf.payView.hidden = YES;
            
            
            
            return;
        }
        
        weakSelf.noDataView.hidden = YES;
        weakSelf.tableView.hidden = NO;
        weakSelf.payView.hidden = NO;
        
        for (NSDictionary *contentDic in contentArray){
            
            NSArray *catrArray = contentDic[@"cart"]?contentDic[@"cart"]:nil;
            NSString *shopId = contentDic[@"shopId"]?contentDic[@"shopId"]:@"";
            NSString *shopName = contentDic[@"shopName"]?contentDic[@"shopName"]:@"";
            if (catrArray && [catrArray isKindOfClass:[NSArray class]] && catrArray.count >0) {
                NSMutableArray *catrModelArray = [NSMutableArray array];
                for (NSDictionary *dic in catrArray) {
                    
                    IWShoppingModel *model = [IWShoppingModel modelWithDic:dic shopId:shopId shopName:shopName];
                    [catrModelArray addObject:model];
                }
                [self.dataArray addObject:catrModelArray];
            }
            
        }
        //没创建就添加，后续不再添加
        if (!self.tableView)
            [self setupTableView];
        
        self.modifOrOverBtn.hidden = NO;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [weakSelf failSetup];
    }];
}
#pragma mark 失败处理
-(void)failSetup{
    //    [[TKAlertCenter defaultCenter]postAlertWithMessage:@"数据获取失败"];
    [self.tableView reloadData];
    self.tableView.hidden = YES;
    self.payView.hidden = YES;
    
    //3.无数据时的图标
    self.noDataView.tishiString = @"数据获取失败";
    self.noDataView.hidden = NO;
    __weak typeof(self) weakSelf = self;
    self.noDataView.refreshButtonClick = ^(ANodataView *noDataView,UIButton *refreshButton){
        [weakSelf login];
    };
    [self.noDataView.refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
    
    self.noDataView.showRefreshButton = YES;
}

#pragma mark - 顶部 编辑或完成按钮
-(void)modifOrOver:(UIButton *)button{
    
    self.isEdit = !self.isEdit;
    if (self.isEdit) {
        [button setTitle:@"完成" forState:UIControlStateNormal];
        self.payButton.hidden = YES;
        self.payView.hidden = YES;
    }else{
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        // 发请求  刷新数据
        [self modifyCommit];
        self.payButton.hidden = NO;
        self.payView.hidden = NO;
    }
    [self.tableView reloadData];
}

#pragma mark - 完成按钮点击
-(void)modifyCommit{
    NSMutableString *commitString = [NSMutableString string];
    for (NSArray *cartArray in self.dataArray) {
        
        for (IWShoppingModel *model in cartArray) {
            [commitString appendString:model.cartId];
            [commitString appendString:@"%5E"];
            [commitString appendString:model.count];
            [commitString appendString:@"."];
        }
    }
    if (commitString.length >1) //有值
        [commitString deleteCharactersInRange:NSMakeRange(commitString.length - 1, 1)];
    else //无值
        return;
    NSString *url = [NSString stringWithFormat:@"%@/%@&cart=%@",kNetUrl,@"user/setUserCart?method=edit",commitString];
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        
        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"code"]) {
            [weakSelf modifyCommitFailSetup];
            return ;
        }
        if (![@"0" isEqual:json[@"code"]]){
            [weakSelf modifyCommitFailSetup];
            return ;
        }
        
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"数据修改成功"];
        [weakSelf getProjectesDownRefresh:NO];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"数据修改失败请稍后重试"];
    }];
}
-(void)modifyCommitFailSetup{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:@"数据修改失败请稍后重试"];
}

-(void)setupTableView{
    
    //底部
    UIView *payView = [[UIView alloc]initWithFrame:CGRectMake(0, kViewHeight - 49 - 40, kViewWidth, 40)];
    payView.backgroundColor = [UIColor whiteColor];
    self.payView = payView;
    [self.view addSubview:payView];
    IWBatesButton *button = [[IWBatesButton alloc]initFrame:CGRectMake(0, 0, 65, 40) Icon:@"IWNoSelect" selectIcon:@"IWSelect" iconFrame:CGRectMake(5, 10, 20, 20) title:@"全选" titleFrame:CGRectMake(27, 12, 30, 16) titleFont:kFont24px titleColor:kColorSting(@"666666") titleSelectColor:nil seleTitle:nil];
    self.allSecectBtn = button;
    [button addTarget:self action:@selector(allSecectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [payView addSubview:button];
    
    
    CGFloat buttonW = 85;
    
    UIButton *payButton = [[UIButton alloc]initWithFrame:CGRectMake(kViewWidth - buttonW, 0, buttonW, CGRectGetHeight(payView.frame))];
    payButton.backgroundColor = kColorRGB(221, 22, 78);
    [payButton setTitle:@"结算" forState:UIControlStateNormal];
    payButton.titleLabel.font = kFont24px;
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [payView addSubview:payButton];
    self.payButton = payButton;
    
    CGFloat totalLabelW = kFRate(50);
    
    CGFloat priceLabelW =  kFRate(55);
    
    UILabel *totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth - buttonW - totalLabelW - priceLabelW, 0, totalLabelW, CGRectGetHeight(payView.frame))];
    totalLabel.text = @"合计: ￥";
    totalLabel.font = kFont24px;
    totalLabel.textColor = kColorSting(@"353535");
    [payView addSubview:totalLabel];
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth - buttonW  - priceLabelW, 0, priceLabelW, CGRectGetHeight(payView.frame))];
    priceLabel.text = @"0.00";
    priceLabel.font = kFont24px;
    priceLabel.textColor = kColorRGB(221, 22, 78);
    [payView addSubview:priceLabel];
    self.priceLabel= priceLabel;
    
    //添加列表
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kViewWidth, CGRectGetMinY(payView.frame) - 64) style:UITableViewStylePlain];
    //去掉下划线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 0.01);
    tableView.userInteractionEnabled = YES;
    self.tableView = tableView;
}

#pragma mark 全选点击
-(void)allSecectBtnClick:(IWBatesButton *)button{
    //选中取反
    button.selected = !button.selected;
    for (NSArray *jiSuanArray in self.dataArray) {
        for (IWShoppingModel *jiSuanModel in jiSuanArray) {
            //模型选中取反
            jiSuanModel.haveSelect = button.selected;
            jiSuanModel.haveSectionSelect = button.selected;
        }
    }
    [self.tableView reloadData];
    [self jiSuanTotal];
}
#pragma mark 计算合计金额
-(void)jiSuanTotal{
    CGFloat  totalMoney = 0;
    for (NSArray *jiSuanArray in self.dataArray) {
        for (IWShoppingModel *jiSuanModel in jiSuanArray) {
            if (jiSuanModel.haveSelect) {
                totalMoney += [jiSuanModel.count intValue] * [jiSuanModel.price floatValue];
                totalMoney += [jiSuanModel.count intValue] * [jiSuanModel.integral floatValue];
            }
        }
        self.priceLabel.text  = [NSString stringWithFormat:@"%.2f",totalMoney];
    }
}
#pragma mark 提交
-(void)pay:(UIButton *)button{
    //选中二维数组
    NSMutableArray *selectArray = [NSMutableArray array];
    for (NSArray *modelArray in self.dataArray) {
        //选中的模型数组
        NSMutableArray *selectModelArray = [NSMutableArray array];
        for (IWShoppingModel *model in modelArray) {
            if (model.haveSelect) {
                [selectModelArray addObject:model];
            }
        }
        //如果第二层有值就添加 二维数组中
        if(selectModelArray.count > 0)
            [selectArray addObject:selectModelArray];
    }
    
    if(selectArray.count == 0){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请选择需要结算的商品"];
        return;
    }
    
    
    IWShoppingSureVC *sureVC = [[IWShoppingSureVC alloc]init];
    sureVC.fromShoppingVC = YES;
    
    sureVC.dataArray = selectArray;
    
    [self.navigationController pushViewController:sureVC animated:YES];
    
}
#pragma mark 头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kFRate(28 +10);
}
#pragma mark 头部视图生成
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //没有建立组模型，是否选中和商店名称都放到 具体模型里面去了
    NSArray *sectionArray =  self.dataArray[section];
    IWShoppingModel *model = [sectionArray firstObject];
    
    CGFloat buttonW = kFRate(28);
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth,buttonW + kFRate(10))];
    headView.backgroundColor = kColorRGB(239, 239, 239);
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, kFRate(10), kViewWidth, buttonW)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:whiteView];
    
    
    UIImage *selectImage = [UIImage imageNamed:@"IWNoSelect"];
    
    IWShopingHeadSelectButton *selectBtn = [[IWShopingHeadSelectButton alloc]initWithFrame:CGRectMake(5,0, buttonW, buttonW)];
    [selectBtn setImage:selectImage  forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"IWSelect" ] forState:UIControlStateSelected];
    selectBtn.titleLabel.font = kFont24px;
    [selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.selected = model.haveSectionSelect;
    
    selectBtn.selectBtnClick = ^(IWShopingHeadSelectButton *button){
        if (button.selected == YES) {
            for (IWShoppingModel *modelSelect in sectionArray) {
                modelSelect.haveSelect = NO;
                model.haveSectionSelect = NO;
            }
        }else{
            for (IWShoppingModel *modelSelect in sectionArray) {
                modelSelect.haveSelect = YES;
                model.haveSectionSelect = YES;
            }
        }
        [self jiSuanTotal];
        
        [self.tableView reloadData];
    };
    [whiteView addSubview:selectBtn];
    
    
    
    UILabel *shoppingNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(selectBtn.frame) + kFRate(5),0, kViewWidth, buttonW)];
    shoppingNameLabel.text = [NSString stringWithFormat:@"      %@",model.shopName];
    shoppingNameLabel.font = kFont24px;
    shoppingNameLabel.textColor = kColorSting(@"666666");
    shoppingNameLabel.backgroundColor = [UIColor whiteColor];
    [whiteView addSubview:shoppingNameLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(headView.frame) - 0.5, kViewWidth, 0.5)];
    line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
    [headView addSubview:line];
    
    return headView;
}
#pragma mark 头部视图点击处理
-(void)selectClick:(IWShopingHeadSelectButton *)selectBtn{
    if (selectBtn.selectBtnClick) {
        selectBtn.selectBtnClick(selectBtn);
    }
}
#pragma mark 高度cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFRate(95);
}

#pragma mark 组数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
#pragma mark 组内部cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *tempArray = self.dataArray[section];
    return tempArray.count;
}
#pragma mark 组内部cell实现
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IWShoppingCell *cell = [IWShoppingCell cellWithTableView:tableView];
    
    NSArray *tempArray = self.dataArray[indexPath.section];
    IWShoppingModel *model =  tempArray[indexPath.row];
    cell.model = model;
    cell.isCellEdit = self.isEdit;
    __weak typeof(self) weakSelf = self;
    cell.selectBtnClick = ^(IWShoppingCell * cell){
        model.haveSelect = !model.haveSelect;
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self jiSuanTotal];
    };
    cell.subBtnClick = ^(IWShoppingCell * cell){
        NSInteger  count =  [model.count integerValue];
        if (count != 1) {
            model.count = [NSString stringWithFormat:@"%ld", count - 1];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    };
    cell.addBtnClick = ^(IWShoppingCell * cell){
        NSInteger  count =  [model.count integerValue];
        model.count = [NSString stringWithFormat:@"%ld", count + 1];
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    cell.crashBtnClick = ^(IWShoppingCell * cell){
        
        NSMutableArray *tempArray  = self.dataArray[indexPath.section];
        
        IWShoppingModel *model = tempArray[indexPath.row];
        [weakSelf deleteWithCartId:model.cartId andIndexPath:indexPath];
        
        //        [tempArray removeObjectAtIndex:indexPath.row];
        //        if (!tempArray || tempArray.count == 0) {
        //            [self.dataArray removeObjectAtIndex:indexPath.section];
        //        }
        //
        //        [weakSelf.tableView reloadData];
        
    };
    return cell;
}
#pragma mark - 删除请求
-(void)deleteWithCartId:(NSString *)cartId andIndexPath:(NSIndexPath *)indexPath{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@userId=%@&cartId=%@",kNetUrl,@"user/removeUserCart?",[ASingleton shareInstance].loginModel.userId,cartId];
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        
        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"code"]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"数据删除失败请稍后重试"];
            return ;
        }
        if (![@"0" isEqual:json[@"code"]]){
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"数据删除失败请稍后重试"];
            return ;
        }
        //删除成功操作本地数据
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"数据删除成功"];
        NSMutableArray *tempArray  = self.dataArray[indexPath.section];
        [tempArray removeObjectAtIndex:indexPath.row];
        if (!tempArray || tempArray.count == 0) {
            [self.dataArray removeObjectAtIndex:indexPath.section];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"数据删除失败请稍后重试"];
    }];
}

@end

