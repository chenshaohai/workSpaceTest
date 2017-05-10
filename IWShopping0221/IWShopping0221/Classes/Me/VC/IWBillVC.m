//
//  IWBillVC.m
//  IWShopping0221
//
//  Created by admin on 2017/3/7.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWBillVC.h"
#import "IWBillCell.h"
#import "IWBillModel.h"

@interface IWBillVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)UIButton *oldBtn;
// 标记
@property (nonatomic,weak)UIView *redView;
// 列表
@property (nonatomic,weak)UITableView *myTableView;
// 数据源
@property (nonatomic,strong)NSMutableArray *dataArr;
// 展示数据源
@property (nonatomic,strong)NSArray *showArr;
// 空设计
@property (nonatomic,weak)ANodataView *noDataView;
// 判断数据是否加载完
@property (nonatomic,assign)BOOL isFilish;
@end

@implementation IWBillVC
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

    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 左按钮
    self.navigationItem.title = @"收支明细";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.view.backgroundColor = IWColor(240, 240, 240);
    
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kFRate(40))];
    menuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:menuView];
    NSArray *menuText = @[@"全部",@"冻结",@"交易",@"赠送",@"退款"];
    CGFloat btnW = kViewWidth / 5;
    for (NSInteger i = 0; i < menuText.count; i ++) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.frame = CGRectMake(btnW * i, 0, btnW, kFRate(38));
        [menuBtn setTitle:menuText[i] forState:UIControlStateNormal];
        menuBtn.titleLabel.font = kFont28px;
        [menuBtn setTitleColor:IWColor(93, 93, 93) forState:UIControlStateNormal];
        [menuBtn setTitleColor:IWColor(252, 33, 95) forState:UIControlStateSelected];
        menuBtn.tag = 7000 + i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [menuView addSubview:menuBtn];
    }
    // 选中标记
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, kFRate(38), btnW, kFRate(2))];
    redView.backgroundColor = IWColor(252, 33, 95);
    [menuView addSubview:redView];
    self.redView = redView;
    _oldBtn = [self.view viewWithTag:7000];
    _oldBtn.selected = YES;
    
    // 列表
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + kFRate(50) + kFRate(32), kViewWidth, kViewHeight - 64 - kFRate(50) - kFRate(32)) style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    
    // headerView
    CGFloat labelW = kViewWidth / 3;
    NSArray *textArr = @[@"交易时间",@"交易类型",@"收支"];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + kFRate(50), kViewWidth, kFRate(32))];
    headerView.backgroundColor = IWColor(252, 33, 95);
    for (NSInteger i = 0; i < textArr.count; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelW * i, 0, labelW, kFRate(32))];
        label.text = textArr[i];
        label.textColor = [UIColor whiteColor];
        label.font = kFont28px;
        label.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:label];
    }
    [self.view addSubview:headerView];
    
    __weak typeof(self) weakSelf = self;
     //下拉刷新
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
}

#pragma mark - 菜单点击
- (void)menuBtnClick:(UIButton *)sender
{
    _oldBtn.selected = NO;
    _oldBtn = sender;
    sender.selected = YES;
    self.redView.frame = CGRectMake((kViewWidth / 5) * (sender.tag - 7000), kFRate(38), kViewWidth / 5, kFRate(2));
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (IWBillModel *model in self.dataArr) {
        switch (_oldBtn.tag - 7000) {
            case 0:
                [tempArr addObject:model];
                break;
            case 1:
                if ([model.type integerValue] == 4) {
                    [tempArr addObject:model];
                }
                break;
            case 2:
                if ([model.type integerValue] == 1) {
                    [tempArr addObject:model];
                }
                break;
            case 3:
                if ([model.type integerValue] == 2) {
                    [tempArr addObject:model];
                }
                break;
            case 4:
                if ([model.type integerValue] == 3) {
                    [tempArr addObject:model];
                }
                break;
                
            default:
                break;
        }
    }
    self.showArr = tempArr;
    [self.myTableView reloadData];
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isFilish) {
        if (self.showArr.count > 0) {
            self.noDataView.hidden = YES;
        }else{
            self.noDataView.hidden = NO;
        }
    }
    return self.showArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kFRate(40);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWBillCell *cell = [IWBillCell cellWithTableView:tableView];
    cell.model = self.showArr[indexPath.row];
    cell.contentBtn.tag = 8000 + indexPath.row;
    [cell.contentBtn addTarget:self action:@selector(contentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - 查看详情
- (void)contentBtnClick:(UIControl *)sender
{
    IWLog(@"查看详情======%ld",sender.tag - 8000);
}

#pragma mark - 数据请求
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/getUserBalanceLog?userId=%@&userName=%@",kNetUrl,[ASingleton shareInstance].loginModel.userId,[ASingleton shareInstance].loginModel.userName];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
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
            IWBillModel *model = [[IWBillModel alloc] initWithDic:dic];
            [weakSelf.dataArr addObject:model];
        }
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        if (weakSelf.isFilish) {
            for (IWBillModel *model in self.dataArr) {
                switch (_oldBtn.tag - 7000) {
                    case 0:
                        [tempArr addObject:model];
                        break;
                    case 1:
                        if ([model.type integerValue] == 4) {
                            [tempArr addObject:model];
                        }
                        break;
                    case 2:
                        if ([model.type integerValue] == 1) {
                            [tempArr addObject:model];
                        }
                        break;
                    case 3:
                        if ([model.type integerValue] == 2) {
                            [tempArr addObject:model];
                        }
                        break;
                    case 4:
                        if ([model.type integerValue] == 3) {
                            [tempArr addObject:model];
                        }
                        break;
                        
                    default:
                        break;
                }
            }
            weakSelf.showArr = tempArr;
        }else{
            weakSelf.showArr = weakSelf.dataArr;
        }
        weakSelf.isFilish = YES;
        [weakSelf.myTableView reloadData];
    } failure:^(NSError *error) {
        weakSelf.isFilish = YES;
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf allFailData];
        return ;
    }];
}

- (void)allFailData
{
    self.isFilish = YES;
    self.showArr = @[];
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
