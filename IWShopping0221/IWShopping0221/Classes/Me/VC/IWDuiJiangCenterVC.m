//
//  IWDuiJiangCenterVC.m
//  IWShopping0221
//
//  Created by admin on 2017/3/9.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDuiJiangCenterVC.h"
#import "IWDuiJiangCenterCell.h"
#import "IWDuiJiangCenterModel.h"

@interface IWDuiJiangCenterVC ()<UITableViewDelegate,UITableViewDataSource>
// 列表
@property (nonatomic,weak)UITableView *myTableView;
// 数据源
@property (nonatomic,strong)NSMutableArray *dataArr;
// 空设计
@property (nonatomic,weak)ANodataView *noDataView;
// 标记
@property (nonatomic,weak)UIView *redView;
@property (nonatomic,weak)UIButton *oldBtn;
// 刷新当前数据(并非加载更多)
@property (nonatomic,assign)BOOL isRefreshData;
// 加载更多页书
@property (nonatomic,assign)NSInteger pageNum;
@end

@implementation IWDuiJiangCenterVC
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
    self.pageNum = 1;
    self.isRefreshData = YES;
    // 左按钮
    self.navigationItem.title = @"中奖纪录";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = IWColor(240, 240, 240);
    
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kFRate(40))];
    menuView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:menuView];
    NSArray *menuText = @[@"中奖纪录",@"兑奖状态"];
    CGFloat btnW = (kViewWidth - kFRate(40)) / 2;
    for (NSInteger i = 0; i < menuText.count; i ++) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.frame = CGRectMake(kFRate(20) + btnW * i, 0, btnW, kFRate(38));
        [menuBtn setTitle:menuText[i] forState:UIControlStateNormal];
        menuBtn.titleLabel.font = kFont28px;
        [menuBtn setTitleColor:IWColor(93, 93, 93) forState:UIControlStateNormal];
        [menuBtn setTitleColor:IWColor(252, 33, 95) forState:UIControlStateSelected];
        menuBtn.tag = 9000 + i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [menuView addSubview:menuBtn];
    }
    // 选中标记
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(kFRate(20), kFRate(38), btnW, kFRate(2))];
    redView.backgroundColor = IWColor(252, 33, 95);
//    [menuView addSubview:redView];
    self.redView = redView;
    _oldBtn = [self.view viewWithTag:9000];
    _oldBtn.selected = YES;
    // Do any additional setup after loading the view.
    
    // 列表
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64) style:UITableViewStylePlain];
    myTableView.backgroundColor = IWColor(240, 240, 240);
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    
    __weak typeof(self) weakSelf = self;
    // 下拉加载更多
    myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNum = 1;
        weakSelf.isRefreshData = YES;
        [weakSelf requestData];
        // 结束加载更多
        [myTableView.mj_header endRefreshing];
    }];
    // 上拉刷新
    myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.isRefreshData = NO;
        [weakSelf requestData];
        // 结束刷新
        [myTableView.mj_footer endRefreshing];
    }];
    
    //3.无数据时的图标
    ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth,kViewHeight - 64)];
    noDataView.backgroundColor = [UIColor whiteColor];
    noDataView.tishiString = @"没有数据";
    //默认隐藏
    noDataView.hidden = YES;
    [self.myTableView addSubview:noDataView];
    self.noDataView = noDataView;
    
    [self requestData];
}

- (void)menuBtnClick:(UIButton *)sender
{
    _oldBtn.selected = NO;
    _oldBtn = sender;
    sender.selected = YES;
    self.redView.frame = CGRectMake(kFRate(20) + ((kViewWidth - kFRate(40)) / 2) * (sender.tag - 9000), kFRate(38), (kViewWidth - kFRate(40)) / 2, kFRate(2));
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWDuiJiangCenterModel *model = self.dataArr[indexPath.row];
    return model.cellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWDuiJiangCenterCell *cell = [IWDuiJiangCenterCell cellWithTableView:tableView];
    cell.model = self.dataArr[indexPath.row];
//    cell.IWDuiJiangCender = ^(){
//        IWLog(@"编辑%ld",indexPath.row);
//    };
    return cell;
}

#pragma mark - 数据请求
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    if (!_isRefreshData) {
        if (self.pageNum == 1 && self.dataArr.count > 0) {
            self.pageNum = 2;
        }
    }
    NSString *url = [NSString stringWithFormat:@"%@/user/getGiftLog?userId=%@&page=%@",kNetUrl,[ASingleton shareInstance].loginModel.userId,[NSString stringWithFormat:@"%ld",self.pageNum]];
    IWLog(@"%@",url);
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            if (!_isRefreshData) {
                [[TKAlertCenter defaultCenter]postAlertWithMessage:@"加载完毕,没有更多数据"];
            }
            [weakSelf allFailData];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            if (!_isRefreshData) {
                [[TKAlertCenter defaultCenter]postAlertWithMessage:@"加载完毕,没有更多数据"];
            }
            [weakSelf allFailData];
            return ;
        }
        if (json[@"data"] == nil || ![json[@"data"] isKindOfClass:[NSArray class]]) {
            if (!_isRefreshData) {
                [[TKAlertCenter defaultCenter]postAlertWithMessage:@"加载完毕,没有更多数据"];
            }
            [weakSelf allFailData];
            return ;
        }
        NSArray *dataArr = json[@"data"];
        if (dataArr.count == 0) {
            if (!_isRefreshData) {
                [[TKAlertCenter defaultCenter]postAlertWithMessage:@"加载完毕,没有更多数据"];
            }else{
                [weakSelf allFailData];
            }
            return ;
        }
        if (_isRefreshData) {
            [weakSelf.dataArr removeAllObjects];
        }
        weakSelf.noDataView.hidden = YES;
        for (NSDictionary *dic in dataArr) {
            IWDuiJiangCenterModel *model = [[IWDuiJiangCenterModel alloc] initWithDic:dic];
            [self.dataArr addObject:model];
        }
        if (!_isRefreshData && dataArr.count > 0) {
            weakSelf.pageNum ++;
        }
        [weakSelf.myTableView reloadData];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        if (!_isRefreshData) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"加载完毕,没有更多数据"];
        }
        [weakSelf allFailData];
        return ;
    }];
}

- (void)allFailData
{
    self.noDataView.hidden = NO;
    [self.dataArr removeAllObjects];
    self.pageNum = 0;
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
