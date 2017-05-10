//
//  IWReturnGoodsVC.m
//  IWShopping0221
//
//  Created by admin on 2017/3/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWReturnGoodsVC.h"
#import "IWReturnGoodsModel.h"
#import "IWGoodTwoModel.h"
#import "IWGoodsOneCell.h"
#import "IWGoodsTwoCell.h"
#import "IWGoodsThreeCell.h"
#import "IWGoodsThreeModel.h"
#import "IWDetailsVC.h"
#import "IWToViewWuliuModel.h"
#import "IWTuiHuanWuLiuModel.h"
#import "IWTuiHuanWuLiuCell.h"

@interface IWReturnGoodsVC ()<UITableViewDelegate,UITableViewDataSource>
// 列表
@property (nonatomic,weak)UITableView *myTableView;
// 模型
@property (nonatomic,strong)IWReturnGoodsModel *oneModel;
@property (nonatomic,strong)IWGoodTwoModel *twoModel;
@property (nonatomic,strong)IWGoodsThreeModel *threeModel;
// 订单id
@property (nonatomic,copy)NSString *orderId;
// 物流详情模型
@property (nonatomic,strong)IWTuiHuanWuLiuModel *wuliuModel;
@end

@implementation IWReturnGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = IWColor(240, 240, 240);
    self.navigationItem.title = @"订单详情";
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
    
    [self requestData];
}

#pragma mark - 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return _oneModel.cellH;
            break;
        case 1:
            return 0;
            break;
        case 2:
            return _twoModel.cellH;
            break;
        case 3:
            return _threeModel.cellH;
            break;
            
        default:
            break;
    }
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            IWGoodsOneCell *cell = [IWGoodsOneCell cellWithTableView:tableView];
            cell.model = _oneModel;
            return cell;
        }
            break;
        case 1:
        {
            IWTuiHuanWuLiuCell *cell = [IWTuiHuanWuLiuCell cellWithTableView:tableView];
            //cell.model = _wuliuModel;
            return cell;
        }
            break;
        case 2:
        {
            IWGoodsTwoCell *cell = [IWGoodsTwoCell cellWithTableView:tableView];
            cell.model = _twoModel;
            return cell;
        }
            break;
        case 3:
        {
            IWGoodsThreeCell *cell = [IWGoodsThreeCell cellWithTableView:tableView];
            cell.model = _threeModel;
            return cell;
        }
            break;

        default:
            break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        IWDetailsVC *detaVC = [[IWDetailsVC alloc] init];
        detaVC.productId = _twoModel.productId;
        [self.navigationController pushViewController:detaVC animated:YES];
    }
}

#pragma mark - 数据请求
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/getRefundOrderDetail?refundId=%@",kNetUrl,self.refundId];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf allFailData:@"获取详情失败"];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf allFailData:@"获取详情失败"];
            return ;
        }
        if (json[@"data"] == nil || ![json[@"data"] isKindOfClass:[NSDictionary class]]) {
            [weakSelf allFailData:@"获取详情失败"];
            return ;
        }
        NSDictionary *dic = json[@"data"];
        _oneModel = [[IWReturnGoodsModel alloc] initWithDic:dic];
        _twoModel = [[IWGoodTwoModel alloc] initWithDic:dic];
        _threeModel = [[IWGoodsThreeModel alloc] initWithDic:dic];
        _orderId = dic[@"orderId"]?dic[@"orderId"]:@"";
        [weakSelf requestWuliuData];
        [weakSelf.myTableView reloadData];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf allFailData:@"获取详情失败"];
        return ;
    }];
}

- (void)requestWuliuData
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/order/expressInfo?orderId=%@",kNetUrl,_orderId];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        if (json[@"Success"] == nil || ![json[@"Success"] isEqual:@"0"]) {
            return ;
        }
        NSDictionary *wuliuDic = json;
        weakSelf.wuliuModel = [[IWTuiHuanWuLiuModel alloc] initWithDic:wuliuDic];
        [weakSelf.myTableView reloadData];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        return ;
    }];
}

- (void)allFailData:(NSString *)str
{
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
