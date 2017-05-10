//
//  IWRecordVC.m
//  IWShopping0221
//
//  Created by admin on 2017/3/6.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWRecordVC.h"
#import "IWRecordCell.h"
#import "IWRecordModel.h"
#import "IWTabBarViewController.h"

@interface IWRecordVC ()<UITableViewDelegate,UITableViewDataSource>
// 列表
@property (nonatomic,weak)UITableView *myTableView;
// 数据元
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,weak)UIButton *oldBtn;
// 标记
@property (nonatomic,weak)UIView *redView;
// 空设计
@property (nonatomic,weak)ANodataView *noDataView;
// 选中下标
@property (nonatomic,assign)NSInteger index;
// 接口集合
@property (nonatomic,strong)NSArray *urlArr;
@end

@implementation IWRecordVC
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}
- (void)collectionLeftCilck
{
    if (_isMendian) {
        IWTabBarViewController *tbVC = (IWTabBarViewController *)self.tabBarController;
        [tbVC from:0 To:0 isRootVC:NO currentVC:self];
    }else{
       [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    NSString *url1 = [NSString stringWithFormat:@"%@/user/getStoreOrders?userId=%@&userName=%@",kNetUrl,[ASingleton shareInstance].loginModel.userId,[ASingleton shareInstance].loginModel.userName];
    NSString *url2 = [NSString stringWithFormat:@"%@/user/getStoreOrders?userId=%@&userName=%@&state=%@",kNetUrl,[ASingleton shareInstance].loginModel.userId,[ASingleton shareInstance].loginModel.userName,@"0"];
    NSString *url3 = [NSString stringWithFormat:@"%@/user/getStoreOrders?userId=%@&userName=%@&state=%@",kNetUrl,[ASingleton shareInstance].loginModel.userId,[ASingleton shareInstance].loginModel.userName,@"1"];
    _urlArr = @[url1,url2,url3];
    _index = 0;
    
    // 左按钮
    self.navigationItem.title = @"消费记录";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.view.backgroundColor = IWColor(240, 240, 240);
    // Do any additional setup after loading the view.
    
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kFRate(40))];
    menuView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:menuView];
    NSArray *menuText = @[@"全部",@"待支付",@"交易完成"];
    for (NSInteger i = 0; i < menuText.count; i ++) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.frame = CGRectMake((kViewWidth - kFRate(240)) / 2 + kFRate(80) * i, 0, kFRate(80), kFRate(38));
        [menuBtn setTitle:menuText[i] forState:UIControlStateNormal];
        menuBtn.titleLabel.font = kFont28px;
        [menuBtn setTitleColor:IWColor(93, 93, 93) forState:UIControlStateNormal];
        [menuBtn setTitleColor:IWColor(252, 33, 95) forState:UIControlStateSelected];
        menuBtn.tag = 5000 + i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [menuView addSubview:menuBtn];
    }
    // 选中标记
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake((kViewWidth - kFRate(240)) / 2, kFRate(38), kFRate(80), kFRate(2))];
    redView.backgroundColor = IWColor(252, 33, 95);
    [menuView addSubview:redView];
    self.redView = redView;
    
    _oldBtn = [self.view viewWithTag:5000];
    _oldBtn.selected = YES;
    
    // 列表
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64) style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    
    __weak typeof(self) weakSelf = self;
    // 下拉刷新
    myTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData:_urlArr[_index]];
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
    
    [self requestData:_urlArr[_index]];
}

- (void)menuBtnClick:(UIButton *)sender
{
    _index = sender.tag - 5000;
    _oldBtn.selected = NO;
    _oldBtn = sender;
    sender.selected = YES;
    self.redView.frame = CGRectMake((kViewWidth - kFRate(240)) / 2 + kFRate(80) * (sender.tag - 5000), kFRate(38), kFRate(80), kFRate(2));
    [self requestData:_urlArr[_index]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWRecordModel *model = self.dataArr[indexPath.row];
    return model.cellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWRecordCell *cell = [IWRecordCell cellWithTableView:tableView];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark - 数据请求
- (void)requestData:(NSString *)url
{
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf.dataArr removeAllObjects];
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
        weakSelf.noDataView.hidden = YES;

        for (NSDictionary *dic in dataArr) {
            IWRecordModel *model = [[IWRecordModel alloc] initWithDic:dic];
            [weakSelf.dataArr addObject:model];
        }
        [weakSelf.myTableView reloadData];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf allFailData];
        return ;
    }];
}

- (void)allFailData
{
    self.noDataView.hidden = NO;
    [self.dataArr removeAllObjects];
    [self.myTableView reloadData];
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
