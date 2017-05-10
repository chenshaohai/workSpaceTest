//
//  IWAddressVC.m
//  IWShopping0221
//
//  Created by admin on 2017/3/8.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWAddressVC.h"
#import "IWAddressCell.h"
#import "IWAddressModel.h"
#import "IWAddNewAddressVC.h"

@interface IWAddressVC ()<UITableViewDelegate,UITableViewDataSource>
// 列表
@property (nonatomic,weak)UITableView *myTableView;
// 数据源
@property (nonatomic,strong)NSMutableArray *dataArr;
// 空设计
@property (nonatomic,weak)ANodataView *noDataView;
@end

@implementation IWAddressVC
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}
- (void)collectionLeftCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 左按钮
    self.navigationItem.title = @"收货地址管理";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    
    // 临时数据
    for (NSInteger i = 0; i < 3; i ++) {
        IWAddressModel *model = [[IWAddressModel alloc] initWithDic:nil];
        [self.dataArr addObject:model];
    }
    
    // 注册
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, kViewHeight - kFRate(45), kViewWidth, kFRate(45));
    addBtn.backgroundColor = IWColor(252, 56, 100);
    [addBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.titleLabel.font = kFont34px;
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    // 列表
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 , kViewWidth, kViewHeight - 64 - kFRate(45)) style:UITableViewStylePlain];
    myTableView.backgroundColor = IWColor(240, 240, 240);
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    
    __weak typeof(self) weakSelf = self;
    // 下拉刷新
    myTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
        // 结束刷新
        [myTableView.mj_header endRefreshing];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    myTableView.mj_header.automaticallyChangeAlpha = YES;
    
    //3.无数据时的图标
    ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth,kViewHeight - 64)];
    noDataView.backgroundColor = [UIColor whiteColor];
    noDataView.tishiString = @"没有数据";
    //默认隐藏
    noDataView.hidden = YES;
    [self.myTableView addSubview:noDataView];
    self.noDataView = noDataView;
    
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addOrEdit) name:@"addOrEdinAddress" object:nil];
}

- (void)addOrEdit
{
    [self requestData];
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWAddressModel *model = self.dataArr[indexPath.row];
    return model.cellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWAddressCell *cell = [IWAddressCell cellWithTableView:tableView];
    cell.model = self.dataArr[indexPath.row];
    cell.IWAddressCellEdit = ^(){
        // 编辑
        IWAddNewAddressVC *vc = [[IWAddNewAddressVC alloc] init];
        vc.model = self.dataArr[indexPath.row];
        vc.isAdd = NO;
        [self.navigationController pushViewController:vc animated:YES];
    };
    cell.IWAddressCellDelete = ^(){
        [self deleteAddress:indexPath.row];
    };
    cell.IWAddressCellChange = ^(){
        [self changeAddress:indexPath.row];
    };
    return cell;
}

#pragma mark - 数据请求
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/getUserAddress?userId=%@&userName=%@",kNetUrl,[ASingleton shareInstance].loginModel.userId,[ASingleton shareInstance].loginModel.userName];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf allFailData];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf allFailData];
            return ;
        }
        if (json[@"data"] == nil || ![json[@"data"] isKindOfClass:[NSArray class]]) {
            [weakSelf allFailData];
            return ;
        }
        NSArray *dataArr = json[@"data"];
        if (dataArr.count == 0) {
            [weakSelf allFailData];
            return ;
        }
        [weakSelf.dataArr removeAllObjects];
        weakSelf.noDataView.hidden = YES;
        for (NSDictionary *dic in dataArr) {
            IWAddressModel *model = [[IWAddressModel alloc] initWithDic:dic];
            [self.dataArr addObject:model];
        }
        [weakSelf.myTableView reloadData];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf allFailData];
        return ;
    }];
}

#pragma mark - 选择默认地址
- (void)changeAddress:(NSInteger)index
{
    IWAddressModel *model = self.dataArr[index];
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/setUserAddress?method=edit&userId=%@&addressId=%@&state=1",kNetUrl,[ASingleton shareInstance].loginModel.userId,model.addressId];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf changeFail:@"选择默认地址失败"];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf changeFail:@"选择默认地址失败"];
            return ;
        }
        
        if (weakSelf.refreshBlock) {
            weakSelf.refreshBlock(weakSelf);
        }
        
        [self requestData];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf changeFail:@"选择默认地址失败"];
        return ;
    }];
}

#pragma mark - 删除地址
- (void)deleteAddress:(NSInteger)index
{
    IWAddressModel *model = self.dataArr[index];
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/removeUserAddress?addressId=%@",kNetUrl,model.addressId];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf changeFail:@"删除地址失败"];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf changeFail:@"删除地址失败"];
            return ;
        }
        [self requestData];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf changeFail:@"删除地址失败"];
        return ;
    }];
}

- (void)allFailData
{
    self.noDataView.hidden = NO;
    [self.dataArr removeAllObjects];
    [self.myTableView reloadData];
}

- (void)changeFail:(NSString *)str
{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:str];
}

#pragma mark - 添加新地址
- (void)addBtnClick
{
    IWAddNewAddressVC *newAddress = [[IWAddNewAddressVC alloc] init];
    newAddress.isAdd = YES;
    [self.navigationController pushViewController:newAddress animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
