//
//  IWHomeMoreVC.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWHomeMoreVC.h"
#import "IWHomeMoreModel.h"
#import "IWHomeMoreCell.h"
#import "IWDetailsVC.h"

@interface IWHomeMoreVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic,weak)UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
// 空设计
@property (nonatomic,weak)ANodataView *noDataView;
// 刷新当前数据(并非加载更多)
@property (nonatomic,assign)BOOL isRefreshData;
// 加载更多页书
@property (nonatomic,assign)NSInteger pageNum;
// 标记
@property (nonatomic,weak)UIView *redView;
// 排序条件 saleCount，salePrice，updatedTime,
@property (nonatomic,copy)NSString *sortParam;
// 升序asc 降序desc saleCount，salePrice，updatedTime,
@property (nonatomic,copy)NSString *descOrAsc;
@property (nonatomic,assign)NSInteger chooseBtnNum;
// 搜索
@property (nonatomic,weak)IWSearchBar *searchBar;

@end
#define btnW (kViewWidth - kFRate(66)) / 4
@implementation IWHomeMoreVC
{
    UIButton *_oldBtn;
}
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.pageNum = 1;
    self.isRefreshData = YES;
    self.sortParam = @"";
    self.descOrAsc = @"";
    _chooseBtnNum = 0;
    
    // 搜索
    CGRect mainViewBounds = self.navigationController.view.bounds;
    IWSearchBar *searchBar = [[IWSearchBar alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-120)/2), CGRectGetMinY(mainViewBounds)+25, CGRectGetWidth(mainViewBounds)-120, 30)];
    searchBar.delegate = self;
    searchBar.text = self.content?self.content:@"";
    if (_isHome) {
        searchBar.hidden = NO;
        self.navigationItem.title = @"";
    }else{
        self.navigationItem.title = @"商品列表";
        searchBar.hidden = YES;
    }
    [self.navigationController.view addSubview: searchBar];
    self.searchBar = searchBar;
    
    // 左按钮
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.view.backgroundColor = IWColor(244, 248, 249);
    // Do any additional setup after loading the view.
    
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + kFRate(40), kViewWidth, kViewHeight - 64 - kFRate(40)) style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor clearColor];
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
        [weakSelf requsetData];
        // 结束加载更多
        [myTableView.mj_header endRefreshing];
    }];
    // 上拉刷新
    myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.isRefreshData = NO;
        [weakSelf requsetData];
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
    
    // 菜单按钮
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, kFRate(10) + 64, kViewWidth, kFRate(30))];
    menuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:menuView];
    
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(0, kFRate(29.5), kViewWidth, kFRate(0.5))];
    linView.backgroundColor = kLineColor;
    [menuView addSubview:linView];
    // 菜单
    NSArray *menuArr = @[@"默认",@"销量",@"价格",@"最新"];
    // 按钮宽
    for (NSInteger i = 0; i < menuArr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kFRate(33) + btnW * i, 0, btnW, kFRate(28.5));
        [btn setTitle:menuArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = kFont28px;
        [btn setTitleColor:IWColor(93, 93, 93) forState:UIControlStateNormal];
        [btn setTitleColor:IWColor(252, 33, 95) forState:UIControlStateSelected];
        btn.tag = 3000 + i;
        [btn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [menuView addSubview:btn];
    }
    // 选中标记
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(kFRate(33), kFRate(27.5), btnW, kFRate(2))];
    redView.backgroundColor = IWColor(252, 33, 95);
    [menuView addSubview:redView];
    self.redView = redView;
    
    _oldBtn = [self.view viewWithTag:3000];
    _oldBtn.selected = YES;
    [self requsetData];
    
}

#pragma mark - 菜单
- (void)menuBtnClick:(UIButton *)sender
{
    _oldBtn.selected = NO;
    _oldBtn = sender;
    sender.selected = YES;
    [self.searchBar endEditing:YES];
    self.redView.frame = CGRectMake(kFRate(33) + btnW * (sender.tag - 3000), kFRate(28.5), btnW, kFRate(1));
    //  saleCount，salePrice，updatedTime,升序asc 降序desc
    switch (sender.tag - 3000) {
        case 0:
            self.sortParam = @"";
            self.descOrAsc = @"";
            _chooseBtnNum = 0;
            break;
        case 1:
            self.sortParam = @"saleCount";
            self.descOrAsc = @"desc";
            _chooseBtnNum = 1;
            break;
        case 2:
            self.sortParam = @"salePrice";
            self.descOrAsc = @"asc";
            _chooseBtnNum = 2;
            break;
            
        default:
            self.sortParam = @"updatedTime";
            self.descOrAsc = @"desc";
            _chooseBtnNum = 3;
            break;
    }
    self.pageNum = 1;
    self.isRefreshData = YES;
    [self requsetData];
    
}

#pragma mark - 搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar endEditing:YES];
    self.pageNum = 1;
    self.isRefreshData = YES;
    self.content = self.searchBar.text;
    [self requsetData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kFRate(120);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWHomeMoreCell *cell = [IWHomeMoreCell cellWithTableView:tableView];
    cell.moreMode = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWHomeMoreModel *model = self.dataArr[indexPath.row];
    IWDetailsVC *detailVC = [[IWDetailsVC alloc] init];
    detailVC.productId = model.productId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)collectionLeftCilck
{
    self.searchBar.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 数据请求
- (void)requsetData
{
    __weak typeof(self) weakSelf = self;
    if (!_isRefreshData) {
        if (self.pageNum == 1 && self.dataArr.count > 0) {
            self.pageNum = 2;
        }
    }
    // &page=%@&sortParam=%@&descOrAsc=%@
    NSString *url;
    if (self.content) {
        if (_chooseBtnNum == 0) {
            url = [NSString stringWithFormat:@"%@/platform/getProductList?page=%@&productName=%@",kNetUrl,[NSString stringWithFormat:@"%ld",self.pageNum],self.content];
        }else{
            url = [NSString stringWithFormat:@"%@/platform/getProductList?page=%@&sortParam=%@&descOrAsc=%@&productName=%@",kNetUrl,[NSString stringWithFormat:@"%ld",self.pageNum],self.sortParam,self.descOrAsc,self.content];
        }
        
    }else{
        if (_chooseBtnNum == 0) {
           url = [NSString stringWithFormat:@"%@/platform/getProductList?cateId=%@&page=%@",kNetUrl,self.regionId,[NSString stringWithFormat:@"%ld",self.pageNum]];
        }else{
           url = [NSString stringWithFormat:@"%@/platform/getProductList?cateId=%@&page=%@&sortParam=%@&descOrAsc=%@",kNetUrl,self.regionId,[NSString stringWithFormat:@"%ld",self.pageNum],self.sortParam,self.descOrAsc];
        }
    }
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
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
        if (_isRefreshData) {
            if (dataArr.count == 0)
            {
                [weakSelf allFailData];
                return;
            }
            [weakSelf.dataArr removeAllObjects];
        }
        _noDataView.hidden = YES;
        for (NSDictionary *dic in dataArr) {
            IWHomeMoreModel *model = [[IWHomeMoreModel alloc] initWithDic:dic];
            [weakSelf.dataArr addObject:model];
        }
        //添加最后一条
        if (dataArr.count == 0) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"加载完毕,没有更多数据"];
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
