//
//  IWToViewWuLiuVC.m
//  IWShopping0221
//
//  Created by admin on 2017/3/13.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWToViewWuLiuVC.h"
#import "IWToViewCell.h"
#import "IWToViewModel.h"
#import "IWToViewWuliuModel.h"

@interface IWToViewWuLiuVC ()<UITableViewDelegate,UITableViewDataSource>
// 列表
@property (nonatomic,weak)UITableView *myTableView;
// 数据源
@property (nonatomic,strong)NSMutableArray *dataArr;
// 空设计
@property (nonatomic,weak)ANodataView *noDataView;
// 模型
@property (nonatomic,strong)IWToViewWuliuModel *wuliuModel;
@end

@implementation IWToViewWuLiuVC

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
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"查看物流";
    self.view.backgroundColor = IWColor(244, 248, 249);
    
//    // 下拉刷新
//    myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 结束加载更多
//        [myTableView.mj_header endRefreshing];
//    }];
    
    //3.无数据时的图标
    ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth,kViewHeight - 64)];
    noDataView.backgroundColor = [UIColor whiteColor];
    noDataView.tishiString = @"没有数据";
    //默认隐藏
    noDataView.hidden = YES;
    [self.view addSubview:noDataView];
    self.noDataView = noDataView;
    
    [self requestData];
}

- (void)createView{
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + kFRate(65) , kViewWidth, kViewHeight - 64 - kFRate(65)) style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    
    // 头
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kFRate(60))];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UIImageView *topImg = [[UIImageView alloc] initWithFrame:CGRectMake(kFRate(10), kFRate(15), kFRate(60), kFRate(60))];
    //    topImg.layer.borderWidth = kFRate(0.5);
    topImg.layer.cornerRadius = kFRate(30);
    topImg.backgroundColor = [UIColor lightGrayColor];
//    [headerView addSubview:topImg];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"订单号:";
    nameLabel.textColor = IWColor(79, 79, 79);
    nameLabel.font = kFont32px;
    [nameLabel sizeToFit];
    nameLabel.frame = CGRectMake(kFRate(10), kFRate(0), nameLabel.frame.size.width, kFRate(60));
    [headerView addSubview:nameLabel];
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + kFRate(10), 0, kViewWidth - CGRectGetMaxX(nameLabel.frame) - kFRate(10), kFRate(60))];
    numLabel.text = _wuliuModel.LogisticCode;
    numLabel.textColor = IWColor(165, 165, 165);
    // 28
    numLabel.font = kFont32px;
    [headerView addSubview:numLabel];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.wuliuModel.tracesModelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWToViewModel *model = self.wuliuModel.tracesModelArr[indexPath.row];
    return model.cellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWToViewCell *cell = [IWToViewCell cellWithTableView:tableView indexPath:indexPath];
    cell.model = self.wuliuModel.tracesModelArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.linSView.hidden = YES;
        cell.linXView.hidden = NO;
        cell.contentLabel.textColor = IWColor(243, 21, 79);
        cell.timeLabel.textColor = IWColor(243, 21, 79);
    }else if (indexPath.row == self.dataArr.count - 1){
        cell.linSView.hidden = NO;
        cell.linXView.hidden = YES;
    }else{
        cell.linSView.hidden = NO;
        cell.linXView.hidden = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kFRate(30);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(30))];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(kFRate(10), 0, kViewWidth - kFRate(20), kFRate(30))];
    name.text = @"物流跟踪";
    name.textColor = IWColor(79, 79, 79);
    name.font = kFont30px;
    [headerView addSubview:name];
    
    return headerView;
}

#pragma mark - 数据请求
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/order/expressInfo?orderId=%@",kNetUrl,_orderId];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf failData:@"查看物流信息失败"];
            return ;
        }
        if (json[@"Success"] == nil || ![json[@"Success"] isEqual:@"1"]) {
            [weakSelf failData:@"查看物流信息失败"];
            return ;
        }
        NSDictionary *wuliuDic = json;
        weakSelf.wuliuModel = [[IWToViewWuliuModel alloc] initWithDic:wuliuDic];
        [weakSelf createView];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf failData:@"查看物流信息失败"];
        return ;
    }];
}

- (void)failData:(NSString *)str
{
    self.noDataView.hidden = NO;
    [[TKAlertCenter defaultCenter]postAlertWithMessage:str];
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
