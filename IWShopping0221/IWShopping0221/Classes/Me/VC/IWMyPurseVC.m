//
//  IWMyPurseVC.m
//  IWShopping0221
//
//  Created by admin on 2017/3/3.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMyPurseVC.h"
#import "IWMyPurseCell.h"
#import "IWMypurseModel.h"
#import "IWBillVC.h"
#import "IWWebViewVC.h"
#import "IWDuiJiangCenterVC.h"

@interface IWMyPurseVC ()<UITableViewDelegate,UITableViewDataSource>
// 钱包列表
@property (nonatomic,weak)UITableView *myTableView;
// 数据源
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation IWMyPurseVC
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
    
    // 左按钮
    self.navigationItem.title = @"我的钱包";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.view.backgroundColor = IWColor(240, 240, 240);
    
    // 列表
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64) style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    
    [self requestData];
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
            return 3;
            break;
            
        default:
            return 2;
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kFRate(60.0f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kFRate(10.0f);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWMyPurseCell *cell = [IWMyPurseCell cellWithTableView:tableView];
    if (self.dataArr.count > 0) {
        switch (indexPath.section) {
            case 0:
                cell.model = self.dataArr[indexPath.row];
                break;
            case 1:
                cell.model = self.dataArr[indexPath.row + 3];
                break;
                
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
        {
            switch (indexPath.row) {
                case 1:
                {
                    // 中奖纪录
                    IWDuiJiangCenterVC *vc = [[IWDuiJiangCenterVC alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                    
                default:
                {
                    // 收支明细
                    IWBillVC *billVC = [[IWBillVC alloc] init];
                    [self.navigationController pushViewController:billVC animated:YES];
                }
                    break;
            }
        }
            break;
            
        default:
            switch (indexPath.row) {
                case 0:
                {
                    // 余额
                    IWWebViewVC *VC = [[IWWebViewVC alloc] init];
                    VC.navTitle = @"账户余额";
                    VC.url = [ASingleton shareInstance].loginModel.balanceUrl;
                    //                    [self.navigationController pushViewController:VC animated:YES];
                }
                    break;
                    
                default:
                {
                    // 余币
                    IWWebViewVC *VC = [[IWWebViewVC alloc] init];
                    VC.navTitle = @"账户余币";
                    VC.url = [ASingleton shareInstance].loginModel.integralUrl;
                    //                    [self.navigationController pushViewController:VC animated:YES];
                }
                    break;
            }
            
            break;
    }
}

#pragma mark - 数据自造
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/freshUserInfo?userId=%@",kNetUrl,[ASingleton shareInstance].loginModel.userId];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf allFailData:@"获取余额信息失败"];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf allFailData:json[@"message"]];
            return ;
        }
        if (json[@"data"] == nil || ![json[@"data"] isKindOfClass:[NSDictionary class]]) {
            [weakSelf allFailData:json[@"message"]];
            return ;
        }
        NSDictionary *dataDic = json[@"data"];
        NSArray *data = @[@{@"topImg":@"IWQianBao",@"name":@"账户余额",@"content":dataDic[@"userBalance"]?:@"0.00",@"rightImg":@"IWNearShoppingDetailNext"},@{@"topImg":@"IWJinBi",@"name":@"贝壳余额",@"content":dataDic[@"userIntegral"]?:@"0.00",@"rightImg":@"IWNearShoppingDetailNext"},@{@"topImg":@"IWQianBao",@"name":@"返佣总额",@"content":dataDic[@"totalCommission"]?:@"0.00",@"rightImg":@"IWNearShoppingDetailNext"},@{@"topImg":@"IWShouZhi",@"name":@"收支明细",@"content":@"现金交易明细",@"rightImg":@"IWNearShoppingDetailNext"},@{@"topImg":@"IWDuiJiang",@"name":@"中奖纪录",@"content":@"查看全部纪录",@"rightImg":@"IWNearShoppingDetailNext"}];
        for (NSDictionary *dic in data) {
            IWMypurseModel *model = [[IWMypurseModel alloc] initWithDic:dic];
            [self.dataArr addObject:model];
        }
        [weakSelf.myTableView reloadData];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf allFailData:@"获取余额信息失败"];
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
