//
//  IWNearSearchResultVC.m
//  IWShopping0221
//
//  Created by s on 17/2/24.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWNearSearchResultVC.h"
#import "MJRefresh.h"
#import "IWNearShoppingModel.h"
#import "IWNearShoppingSearchResultCell.h"
#import "IWNearSelectButton.h"
#import "IWNearTopModel.h"
#import "IWNearClassVC.h"
#import "IWNearShoppingDetailVC.h"
@interface IWNearSearchResultVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
// 强制隐藏无数据
@property (nonatomic,assign)BOOL mustHiddenNoDataView;
// 无数据
@property (nonatomic,weak)ANodataView *noDataView;
// 表格，
@property (nonatomic,weak)UITableView *tableView;
// 展示数组
@property (nonatomic,strong)NSMutableArray *dataArray;
//折扣数组
@property (nonatomic,strong)NSMutableArray *discountDataArray;
//评论数组
@property (nonatomic,strong)NSMutableArray *discussDataArray;
//选中的按钮
@property (nonatomic,strong)IWNearSelectButton *selectButton;

//
@property (nonatomic,strong)IWSearchBar *searchBar;
//搜索提示结果
@property (nonatomic,weak)UILabel *topLabel;
@property (nonatomic,weak)UIView *topView;
//选择
@property (nonatomic,weak)UIView *selectView;
//类别按钮
@property (nonatomic,weak)IWNearSelectButton *classButton;
//折扣最低
@property (nonatomic,weak)IWNearSelectButton *discountBTN;
//评价最高
@property (nonatomic,weak)IWNearSelectButton *discussBTN;
//类别
@property (nonatomic,copy)NSString *cateId;
//商店名称
@property (nonatomic,copy)NSString *shopName;

//页面
@property (nonatomic,assign)NSInteger page;
// 经度
@property (nonatomic,assign)CGFloat latitude;
//纬度
@property (nonatomic,assign)CGFloat longitude;
//商品名称
@property (nonatomic,copy)NSString *className;
//分类
@property (nonatomic,strong)NSArray *cateClass;


//分类
@property (nonatomic,weak)IWNearClassVC *classVC;
//分类
@property (nonatomic,weak)UIView *classVCView;
//顶部透明蒙版视图
@property (nonatomic,weak)UIButton *topBackGroudView;
@end
// 随机色
//#define kArc4randomColor [UIColor colorWithHexRGBString:[NSString stringWithFormat:@"#%d0%d0%d0",arc4random_uniform(9),arc4random_uniform(9),arc4random_uniform(9)]]
#define kArc4randomColor [UIColor clearColor]
@implementation IWNearSearchResultVC

-(instancetype)initWithCateId:(NSString *)cateId  shopName:(NSString *)shopName latitude:(CGFloat)latitude longitude:(CGFloat)longitude class:(NSString *)className{
    self = [super init];
    if (self) {
        _cateId =cateId;
        _shopName = shopName;
        _latitude = latitude;
        _longitude = longitude;
        _className = className;
    }
    return  self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor HexColorToRedGreenBlue:@"f2f2f2"];
    
    self.page = 1;
    
    _dataArray = [NSMutableArray array];
//    _distanceDataArray = [NSMutableArray array];
    _discountDataArray = [NSMutableArray array];
    _discussDataArray = [NSMutableArray array];
    
    self.mustHiddenNoDataView = YES;
    
    [self setNavView];
    [self setupTopView];
    [self setupTableView];
    
    //请求数据
    [self getProjectesDownRefresh:NO isFrist:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //获取分类数据
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *tempAray =  [ASingleton shareInstance].storeCateList;
    if (tempAray && [tempAray isKindOfClass:[NSArray class]] && tempAray.count > 0) {
        for (NSDictionary *dict in tempAray) {
            IWNearTopModel *model = [IWNearTopModel nearTopModelWithDic:dict];
            [modelArray addObject:model];
        }
        self.cateClass =[NSArray arrayWithArray:modelArray];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _searchBar.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _searchBar.hidden = YES;
}
#pragma mark - 顶部
-(void)setupTopView{
    
    CGFloat viewH = 28;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 74, kViewWidth, 66 - 38)];
    topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topView];
    self.topView = topView;
    
//    UIView *resultView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, viewH)];
//    resultView.backgroundColor = [UIColor whiteColor];
//    [topView addSubview:resultView];
//    
//    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(17, 0, kViewWidth - 17, viewH)];
//    topLabel.textAlignment = NSTextAlignmentLeft;
//    topLabel.text = @"搜索结果";
//    topLabel.font = kFont24pxBold;
//#warning 标注不对
//    topLabel.textColor = kColorSting(@"353535");
//    [resultView addSubview:topLabel];
//    self.topLabel = topLabel;
    
    
    UIView *selectView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, viewH)];
    selectView.backgroundColor = [UIColor whiteColor];
    [topView addSubview:selectView];
    self.selectView = selectView;
    
    
    //距离最近
    CGFloat  buttonW = kViewWidth/3.0;
    IWNearSelectButton *classButton = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(0, 0,buttonW, viewH)];
    classButton.index = 0;
    [classButton setTitle:self.className forState:UIControlStateNormal];
    [classButton setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
    [classButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:classButton];
    self.classButton = classButton;
    
    //默认选中
//    self.selectButton = distanceBTN;
//    distanceBTN.selected = YES;
    
    //折扣最低
    IWNearSelectButton *discountBTN = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(buttonW, 0,buttonW, viewH)];
    discountBTN.index = 1;
    [discountBTN setTitle:@"折扣最低" forState:UIControlStateNormal];
    [discountBTN setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
    [discountBTN addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:discountBTN];
    
    //默认选中
    self.selectButton = discountBTN;
    discountBTN.selected = YES;

    
    //评价最高
    IWNearSelectButton *discussBTN = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(2 * buttonW, 0,buttonW, viewH)];
    discussBTN.index = 2;
    [discussBTN setTitle:@"评价最高" forState:UIControlStateNormal];
    [discussBTN setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
    [discussBTN addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:discussBTN];
    
    //
    UIView *line = [[UIView  alloc]init];
    line.frame =CGRectMake(0, viewH - 0.5, self.tableView.frame.size.width, 0.5);
    line.backgroundColor = [UIColor grayColor];
    [selectView addSubview:line];
}
#pragma mark - 设置导航栏
- (void)setNavView
{
    self.navigationItem.title = @"";
    self.navigationController.navigationBar.barTintColor = [UIColor HexColorToRedGreenBlue:@"ff3b60"];
    CGRect mainViewBounds = self.navigationController.view.bounds;
    _searchBar = [[IWSearchBar alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-120)/2), CGRectGetMinY(mainViewBounds)+25, CGRectGetWidth(mainViewBounds)-120, 30)];
    _searchBar.delegate = self;
    [self.navigationController.view addSubview: _searchBar];
    
}
#pragma mark 搜索商品
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
    [self.searchBar resignFirstResponder];
    self.shopName = searchBar.text;
    [self getProjectesDownRefresh:NO isFrist:YES];
  
}

- (void)searchBar:(IWSearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.shopName = searchText;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}
#pragma mark //请求数据
-(void)getProjectesDownRefresh:(BOOL )isDownRefresh isFrist:(BOOL)isFrist{
        //下拉就去第一页
        if (!isDownRefresh)
            self.page = 1;
    NSString *url = nil;
    
    NSString *shopName = nil;
    //中文处理
    if(self.shopName){
        shopName = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)self.shopName, NULL, NULL,  kCFStringEncodingUTF8 ));
    }
    //有ID  有 搜索文字
    if (self.cateId && self.shopName) {
        url = [NSString stringWithFormat:@"%@/%@?y=%f&x=%f&page=%d&cateId=%@&shopName=%@",kNetUrl,@"store/getStoreList",self.latitude,self.longitude,self.page,self.cateId,shopName];
    //只有类别，没有搜索文字   上级界面(除更多和搜索框)进入，本地点击二级页面刷新
    }else if (self.cateId && !self.shopName){
        url = [NSString stringWithFormat:@"%@/%@?y=%f&x=%f&page=%d&cateId=%@",kNetUrl,@"store/getStoreList",self.latitude,self.longitude,self.page,self.cateId];
    //只有名字没有类别    更多搜索
    }else if(!self.cateId && self.shopName){
    url = [NSString stringWithFormat:@"%@/%@?y=%f&x=%f&page=%d&shopName=%@",kNetUrl,@"store/getStoreList",self.latitude,self.longitude,self.page,shopName];
    //都没有    上级界面更多和搜索框进入
    }else{
    url = [NSString stringWithFormat:@"%@/%@?y=%f&x=%f&page=%d",kNetUrl,@"store/getStoreList",self.latitude,self.longitude,self.page];
    }
    
        __weak typeof(self) weakSelf = self;
        [[ASingleton shareInstance]startLoadingInView:self.view];
        [IWHttpTool  getWithURL:url params:nil success:^(id json) {
            [[ASingleton shareInstance] stopLoadingView];
            weakSelf.mustHiddenNoDataView = NO;
            
            if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"data"]) {
                [weakSelf failSetup];
                return ;
            }
            if (![@"0" isEqual:json[@"code"]]){
                [weakSelf failSetup];
                return ;
            }
            
            NSDictionary *contentDict = json[@"data"];
            if (!contentDict || ![contentDict isKindOfClass:[NSDictionary class]]|| [contentDict allKeys].count == 0) {
                [weakSelf failSetup];
                return ;
            }
            
            //清空数据
            //下拉刷新清空数据
            if (!isDownRefresh) {
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.discountDataArray removeAllObjects];
                [weakSelf.discussDataArray removeAllObjects];
            }
            
            BOOL  haveData = NO;
            
            NSArray *discountList = contentDict[@"discountList"];
            if (!discountList || ![discountList isKindOfClass:[NSArray class]]|| discountList.count == 0) {
            }else{
                for (NSDictionary *contentDic in discountList) {
                    IWNearShoppingModel *model = [IWNearShoppingModel modelWithDic:contentDic];
                    [self.discountDataArray addObject:model];
                    haveData = YES;
                }
            }
            
            NSArray *evaluateList = contentDict[@"evaluateList"];
            if (!evaluateList || ![evaluateList isKindOfClass:[NSArray class]]|| evaluateList.count == 0) {
            }else{
                for (NSDictionary *contentDic in evaluateList) {
                    IWNearShoppingModel *model = [IWNearShoppingModel modelWithDic:contentDic];
                    [self.discussDataArray addObject:model];
                    haveData = YES;
                }
                
            }
            
            //显示提示
            if (haveData == NO && isDownRefresh) {
                [[TKAlertCenter defaultCenter]postAlertWithMessage:@"数据加载完成,没有更多数据"];
            }else{
                self.page++;
            }
            
            //默认选中第一个
            if (isFrist)
                self.dataArray = self.discountDataArray;
            else
                [self selectButtonClick:self.selectButton];
            
            
//            NSString *shopName = @"";
//            if (self.shopName)
//                shopName = self.shopName;
//            self.topLabel.text = [NSString stringWithFormat:@"在 %@ 类别搜索 %@ 结果为 %d 条",self.className,shopName,self.dataArray.count];

            
            [weakSelf.tableView reloadData];
            
        } failure:^(NSError *error) {
            weakSelf.mustHiddenNoDataView = NO;
            [[ASingleton shareInstance] stopLoadingView];
            
            //清空数据
            //下拉刷新清空数据
            if (!isDownRefresh) {
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.discountDataArray removeAllObjects];
                [weakSelf.discussDataArray removeAllObjects];
            }
            [weakSelf failSetup];
        }];
}

#pragma mark 失败处理
-(void)failSetup{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:@"数据获取失败，请稍后重试"];
    [self.tableView reloadData];
    
//    NSString *shopName = @"";
//    if (self.shopName) {
//        shopName = self.shopName;
//    }
//    
//     self.topLabel.text = [NSString stringWithFormat:@"在 %@ 类别搜索 %@ 结果为 %d 条",self.className,shopName,self.dataArray.count];
}
-(void)setupTableView{
    //添加列表
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), kViewWidth, kViewHeight - CGRectGetMaxY(self.topView.frame)) style:UITableViewStylePlain];
    //去掉下划线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 0.01);
    tableView.userInteractionEnabled = YES;
    self.tableView = tableView;
    //    __weak typeof(self) weakSelf = self;
    //    // 下拉刷新
    //    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //        [weakSelf getProjectes];
    //        // 结束刷新
    //        [tableView.mj_header endRefreshing];
    //    }];
    //    // 设置自动切换透明度(在导航栏下面自动隐藏)
    //    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    
    //3.无数据时的图标
    ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(-10, -20, kViewWidth,kViewHeight)];
    noDataView.backgroundColor = [UIColor clearColor];
    noDataView.tishiString = @"没有数据";
    //默认隐藏
    noDataView.hidden = YES;
    [self.tableView addSubview:noDataView];
    self.noDataView = noDataView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
#pragma mark 高度cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFRate(120);
}

-(void)topBackGroudViewTap{
    [self.topBackGroudView removeFromSuperview];
    [self.classVCView removeFromSuperview];
    [self.classVC removeFromParentViewController];
}
#pragma mark 中间按钮点击
-(void)selectButtonClick:(IWNearSelectButton *)button{
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    // 替换数据原
    switch (button.index) {
        case 0:{
            CGFloat  viewY = CGRectGetMaxY(self.topView.frame);
            //顶部透明蒙版视图
            UIButton *topBackGroudView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, viewY)];
            topBackGroudView.backgroundColor = [UIColor clearColor];
            UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
            [window addSubview:topBackGroudView];
            [topBackGroudView addTarget:self action:@selector(topBackGroudViewTap) forControlEvents:UIControlEventTouchUpInside];
            self.topBackGroudView = topBackGroudView;
            
            
            
            IWNearClassVC *classVC = [[IWNearClassVC alloc]initWithCateArray:self.cateClass];
            
            classVC.view.frame = CGRectMake(0,viewY, kViewWidth, kViewHeight -viewY);
            
            //添加子视图控制器
            [self addChildViewController:classVC];
            [self.view addSubview:classVC.view];
            
            
            self.classVCView = classVC.view;
            self.classVC = classVC;
            
            
            classVC.cellClick= ^(IWNearClassVC *classVC,IWNearTopModel *model){
                
                [self.topBackGroudView removeFromSuperview];
                [classVC.view removeFromSuperview];
                [classVC removeFromParentViewController];
                
                self.classButton.selected = NO;
                self.className = model.nameTitle;
                [self.classButton setTitle:model.nameTitle forState:UIControlStateNormal];
                
                if ([model.nameTitle isEqual:@"更多"]) {
                    self.cateId = nil;
                }else{
                self.cateId =  model.modelId;
                }
                //传入第一次的原因： 选中第二个按钮
                [self getProjectesDownRefresh:NO isFrist:YES];
            };
            
            
            
        }break;
        case 1:
            self.dataArray = self.discountDataArray;
            break;
        default:
            self.dataArray = self.discussDataArray;
            break;
    }
    [self.tableView reloadData];
}

#pragma mark 组数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //没有数据
    //        if (!self.dataArray || self.dataArray.count == 0) {
    //           if (self.mustHiddenNoDataView) {//必须隐藏，用于第一次加载
    //                self.noDataView.hidden = YES;
    //           }else{
    //                self.noDataView.hidden = NO;
    //            }
    //            //有数据
    //        }else{
    //            self.noDataView.hidden = YES;
    //        }
    //        if (self.mustHiddenNoDataView || self.noDataView.hidden == NO) {
    //            return 0;
    //        }
    return 1;
}
#pragma mark 组内部cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
#pragma mark 组内部cell实现
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IWNearShoppingSearchResultCell *cell = [IWNearShoppingSearchResultCell cellWithTableView:tableView];
    IWNearShoppingModel *model =  self.dataArray[indexPath.row];
    cell.model = model;;
    return cell;
}
#pragma mark Cell 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IWNearShoppingModel *model =  self.dataArray[indexPath.row];
    IWNearShoppingDetailVC *tabVC = [[IWNearShoppingDetailVC alloc]initWithShopId:model.modelId];
    //点击事件处理
    [self.navigationController pushViewController:tabVC animated:YES];
}
-(void)goBack:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
