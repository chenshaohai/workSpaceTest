//
//  IWHomeMoreVC.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWGoodsTableVC.h"
#import "IWHomeMoreModel.h"
#import "IWHomeMoreCell.h"
#import "IWDetailsVC.h"
#import "IWHomeRegionProductModel.h"

@interface IWGoodsTableVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
// 空设计
@property (nonatomic,weak)ANodataView *noDataView;
// 刷新当前数据(并非加载更多)
@property (nonatomic,assign)BOOL isRefreshData;
// 加载更多页书
@property (nonatomic,assign)NSInteger pageNum;
@end

@implementation IWGoodsTableVC
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
    // 左按钮
    self.navigationItem.title = self.regionName;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.view.backgroundColor = IWColor(244, 248, 249);
    // Do any additional setup after loading the view.
    
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 , kViewWidth, kViewHeight - 64) style:UITableViewStylePlain];
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
    cell.model = self.dataArr[indexPath.row];
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
    NSString *url = [NSString stringWithFormat:@"%@/platform/getRecommendProductByPage?regionId=%@&page=%@",kNetUrl,self.regionId,[NSString stringWithFormat:@"%ld",self.pageNum]];
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
        if (dataArr.count == 0) {
            if (!_isRefreshData) {
                [[TKAlertCenter defaultCenter]postAlertWithMessage:@"加载完毕,没有更多数据"];
            }
            [weakSelf allFailData];
            return ;
        }
        NSDictionary *dic = dataArr[0];
        NSArray *regionProductArr = dic[@"regionProduct"];
        
        if (_isRefreshData) {
            if (regionProductArr == nil || regionProductArr.count == 0)
            {
                [weakSelf allFailData];
                return;
            }
            [weakSelf.dataArr removeAllObjects];
        }
        _noDataView.hidden = YES;
        for (NSDictionary *dic in regionProductArr) {
            IWHomeRegionProductModel *regionModel = [[IWHomeRegionProductModel alloc] initWithDic:dic];
            [weakSelf.dataArr addObject:regionModel];
        }
        
        //添加最后一条
        if (regionProductArr.count == 0) {
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
