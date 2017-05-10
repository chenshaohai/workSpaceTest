//
//  IWDingDanOneVC.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/19.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDingDanOneVC.h"
#import "IWDingDanOneModel.h"
#import "IWDingDanOneCell.h"
#import "IWDingDanTwoModel.h"
#import "IWDingDanTwoCell.h"
#import "IWDingDanThreeModel.h"
#import "IWDingDanThreeCell.h"
#import "IWDingDanFourModel.h"
#import "IWDingDanFourCell.h"

@interface IWDingDanOneVC ()<UITableViewDelegate,UITableViewDataSource>
// 列表
@property (nonatomic,weak)UITableView *myTableView;
// 数据源
@property (nonatomic,strong)NSMutableArray *dataArr;
// 空设计
@property (nonatomic,weak)ANodataView *noDataView;
// 模型
@property (nonatomic,strong)IWDingDanOneModel *oneModel;
@property (nonatomic,strong)IWDingDanTwoModel *twoModel;
@property (nonatomic,strong)IWDingDanFourModel *fourModel;
@end

@implementation IWDingDanOneVC
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
    // 数据
    _oneModel = [[IWDingDanOneModel alloc] initWithDic:_oneDic];
    _twoModel = [[IWDingDanTwoModel alloc] initWithDic:_twoDic];
    if (self.threeArr && self.threeArr.count > 0) {
        for (NSDictionary *dic in self.threeArr) {
            IWDingDanThreeModel *threeModel = [[IWDingDanThreeModel alloc] initWithDic:dic];
            [self.dataArr addObject:threeModel];
        }
    }
    _fourModel = [[IWDingDanFourModel alloc] initWithDic:_fourDic];
    
    self.navigationItem.title = @"订单详情";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 列表
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64) style:UITableViewStyleGrouped];
    myTableView.backgroundColor = IWColor(240, 240, 240);
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.sectionFooterHeight = 0;
    myTableView.sectionHeaderHeight = 0;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    
    // 提交订单背景
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, kViewHeight - kFRate(40), kViewWidth, kFRate(40))];
    btnView.backgroundColor = IWColor(240, 240, 240);
//    [self.view addSubview:btnView];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(kViewWidth - kFRate(140), kFRate(10), kFRate(60), kFRate(20));
    [btn1 setTitle:@"取消订单" forState:UIControlStateNormal];
    [btn1 setTitleColor:IWColor(50, 50, 50) forState:UIControlStateNormal];
    btn1.titleLabel.font = kFont24px;
    btn1.layer.cornerRadius = kFRate(3.0);
    btn1.layer.borderColor = IWColor(50, 50, 50).CGColor;
    btn1.layer.borderWidth = 1.0f;
    [btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(kViewWidth - kFRate(70), kFRate(10), kFRate(60), kFRate(20));
    [btn2 setTitle:@"我要付款" forState:UIControlStateNormal];
    [btn2 setTitleColor:kRedColor forState:UIControlStateNormal];
    btn2.titleLabel.font = kFont24px;
    btn2.layer.cornerRadius = kFRate(3.0);
    btn2.layer.borderColor = kRedColor.CGColor;
    btn2.layer.borderWidth = 1.0f;
    [btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:btn2];
    
}

#pragma mark - 提交订单
- (void)btn1Click:(UIButton *)sender
{
    IWLog(@"取消订单");
}

- (void)btn2Click:(UIButton *)sender
{
    IWLog(@"我要付款");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return self.dataArr.count;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            // 一二Cell
            switch (indexPath.row) {
                case 0:
                    return _oneModel.cellH;
                    break;
                case 1:
                    return _twoModel.cellH;
                    break;
                    
                default:
                    break;
            }
            break;
        case 1:
            // 店铺
        {
            IWDingDanThreeModel *model = self.dataArr[indexPath.row];
            return model.cellH;
        }
            break;
        case 2:
            return _fourModel.cellH;
            break;
            
        default:
            break;
    }
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    IWDingDanOneCell *cell = [IWDingDanOneCell cellWithTableView:tableView];
                    cell.model = _oneModel;
                    return cell;
                }
                    break;
                case 1:
                {
                    IWDingDanTwoCell *cell = [IWDingDanTwoCell cellWithTableView:tableView];
                    cell.model = _twoModel;
                    return cell;
                }
                    break;
                default:
                    break;
            }
            break;
        case 1:
        {
            IWDingDanThreeCell *cell = [IWDingDanThreeCell cellWithTableView:tableView];
            cell.model = self.dataArr[indexPath.row];
            return cell;
        }
            break;
        case 2:
        {
            IWDingDanFourCell *cell = [IWDingDanFourCell cellWithTableView:tableView];
            cell.model = _fourModel;
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return kFRate(30);
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *tempDic = self.threeArr[0];
    UIView *headerView = [[UIView alloc] init];
    if (section == 1) {
        
        headerView.backgroundColor = IWColor(250, 250, 250);
        
        // IWDianpu
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(kFRate(10), kFRate(5), kFRate(20), kFRate(20))];
        img.image = _IMG(@"IWDianpu");
        [headerView addSubview:img];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(kFRate(40), 0, kViewWidth - kFRate(50), kFRate(30))];
        name.text = tempDic[@"shopName"];
        name.font = kFont28px;
        [headerView addSubview:name];
        
        UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(kFRate(10), kFRate(29.5), kViewWidth - kFRate(20), kFRate(0.5))];
        linView.backgroundColor = kLineColor;
        [headerView addSubview:linView];
        
        return headerView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return kFRate(40.5f);
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSDictionary *tempDic = self.threeArr[0];;
    
    UIView *footView = [[UIView alloc] init];
    if (section == 1) {
        footView.backgroundColor = [UIColor whiteColor];
        /*
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(kFRate(10), 0, kFRate(100), kFRate(30))];
        label1.text = @"配送方式";
        label1.font = kFont24px;
        label1.textColor = IWColor(50, 50, 50);
        [footView addSubview:label1];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kViewWidth - kFRate(110), 0, kFRate(100), kFRate(30))];
        label.text = model.distribution;
        label.font = kFont24px;
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = IWColor(160, 160, 160);
        [footView addSubview:label];
        
        // 分割线
        UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(kFRate(10), kFRate(30), kViewWidth - kFRate(20), kFRate(0.5))];
        linView.backgroundColor = kLineColor;
        [footView addSubview:linView];
         */
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(kFRate(10), kFRate(0), kFRate(100), kFRate(30))];
        label2.text = @"支付方式";
        label2.font = kFont24px;
        label2.textColor = IWColor(50, 50, 50);
        [footView addSubview:label2];
        
        UILabel *label0 = [[UILabel alloc] initWithFrame:CGRectMake(kViewWidth - kFRate(110), kFRate(0), kFRate(100), kFRate(30))];
        label0.text = tempDic[@"payWay"]?tempDic[@"payWay"]:@"";
        label0.font = kFont24px;
        label0.textAlignment = NSTextAlignmentRight;
        label0.textColor = IWColor(160, 160, 160);
        [footView addSubview:label0];
        
        UIView *fenge = [[UIView alloc] initWithFrame:CGRectMake(0, kFRate(30.5), kViewWidth, kFRate(10))];
        fenge.backgroundColor = IWColor(240, 240, 240);
        [footView addSubview:fenge];
        
        return footView;
    }
    return nil;
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
