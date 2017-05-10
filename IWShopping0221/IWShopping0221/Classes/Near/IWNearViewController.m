//
//  IWNearViewController.m
//  shopping201702
//
//  Created by MacBook on 2017/2/21.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWNearViewController.h"
#import "IWMapVC.h"
#import "MJRefresh.h"
#import "IWNearTopModel.h"
#import "IWNearShoppingModel.h"
#import "IWNearTopCell.h"
#import "IWNearShoppingCell.h"
#import "IWNearSelectButton.h"
#import "IWNearSearchResultVC.h"
#import "IWNearShoppingDetailVC.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "IWNearCityVC.h"

#import "CityPickerViewController.h"
#import "CityModel.h"
//#import "BMKGeoCodeSearch.h"

@interface IWNearViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,BMKLocationServiceDelegate,CityPickerViewControllerDelegate,UIAlertViewDelegate,BMKGeoCodeSearchDelegate>{
    
    BMKLocationService* _locService;
    
}
//选中的城市模型
@property (nonatomic,strong)CityModel *selectedCityModel;
// 强制隐藏无数据
@property (nonatomic,assign)BOOL mustHiddenNoDataView;
// 无数据
@property (nonatomic,weak)ANodataView *noDataView;
// 表格，
@property (nonatomic,weak)UITableView *tableView;
//顶部数组
@property (nonatomic,strong)NSArray *topDataArray;
//下部数组
@property (nonatomic,strong)NSMutableArray *downDataArray;
//距离数组
@property (nonatomic,strong)NSMutableArray *distanceDataArray;
//折扣数组
@property (nonatomic,strong)NSMutableArray *discountDataArray;
//评论数组
@property (nonatomic,strong)NSMutableArray *discussDataArray;
//选中的按钮
@property (nonatomic,strong)IWNearSelectButton *selectButton;
//第一个底部
@property (nonatomic,strong)UIView *firstFootView;
//
@property (nonatomic,strong)IWSearchBar *searchBar;
// 经度
@property (nonatomic,assign)CGFloat latitude;
//纬度
@property (nonatomic,assign)CGFloat longitude;
//纬度
@property (nonatomic,copy)NSString *city;
//城市按钮
@property (nonatomic,strong)UIButton *cityButton;

//导航条覆盖
@property (nonatomic,strong)UIView *navigationView;

//页面
@property (nonatomic,assign)NSInteger page;


//
@property (nonatomic,strong)BMKGeoCodeSearch *codeSearch;

@end
// 随机色
//#define kArc4randomColor [UIColor colorWithHexRGBString:[NSString stringWithFormat:@"#%d0%d0%d0",arc4random_uniform(9),arc4random_uniform(9),arc4random_uniform(9)]]
#define kArc4randomColor [UIColor clearColor]
@implementation IWNearViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationView.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationView.hidden = YES;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _topDataArray = [NSMutableArray array];
    _distanceDataArray = [NSMutableArray array];
    _discountDataArray = [NSMutableArray array];
    _discussDataArray = [NSMutableArray array];
    _downDataArray = [NSMutableArray array];
    
    self.page = 1;
    
    [self setNavView];
    self.mustHiddenNoDataView = YES;
    
    self.longitude =  [ASingleton shareInstance].longitude;
    self.latitude = [ASingleton shareInstance].latitude;
    self.city = [ASingleton shareInstance].city;
    
    if (!self.city || ![self.city isKindOfClass:[NSString class]] || self.city.length < 1) {
        //定位
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
        
        [_locService startUserLocationService];
        
    }else{
       [self.cityButton setTitle:self.city forState:UIControlStateNormal]; 
        //请求数据
        [self getProjectesDownRefresh:NO isFrist:YES];
    }
    
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *tempAray =  [ASingleton shareInstance].storeCateList;
    if (tempAray && [tempAray isKindOfClass:[NSArray class]] && tempAray.count > 0) {
        for (NSDictionary *dict in tempAray) {
            IWNearTopModel *model = [IWNearTopModel nearTopModelWithDic:dict];
            [modelArray addObject:model];
        }
        
        self.topDataArray =[NSMutableArray arrayWithArray:modelArray];
    }
    
    [self setupTableView];
    
    [self.tableView reloadData];
}

#pragma mark - 设置导航栏
- (void)setNavView
{
    self.navigationItem.title = @"";
    self.navigationController.navigationBar.barTintColor = [UIColor HexColorToRedGreenBlue:@"ff3b60"];
    
    UIView *navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kViewWidth, 44)];
    navigationView.backgroundColor = [UIColor clearColor];
    [self.navigationController.view addSubview: navigationView];
    
    self.navigationView = navigationView;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"未定位" forState:UIControlStateNormal];
    leftBtn.titleLabel.font =  [UIFont systemFontOfSize:15];
    leftBtn.titleLabel.textColor = kColorSting(@"ffffff");
    leftBtn.backgroundColor = [UIColor clearColor];
    leftBtn.frame = CGRectMake(10, 5,kFRate(45), 30);
    [leftBtn addTarget:self action:@selector(cityClick:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:leftBtn];
    self.cityButton = leftBtn;
    
    
    UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [downBtn setImage:[UIImage imageNamed:@"IWNearDown"] forState:UIControlStateNormal];
    
    downBtn.backgroundColor = [UIColor clearColor];
    downBtn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame), 5,kFRate(10), 30);
    [downBtn addTarget:self action:@selector(cityClick:) forControlEvents:UIControlEventTouchUpInside];
    
#warning 注释掉
//    [navigationView addSubview:downBtn];
    _searchBar = [[IWSearchBar alloc] initWithFrame:CGRectMake(CGRectGetMaxX(downBtn.frame) + kFRate(10),5,kViewWidth - CGRectGetMaxX(downBtn.frame) + kFRate(10) - 50 , 30)];
    _searchBar.delegate = self;
    
    [navigationView addSubview:_searchBar];
}

-(void)setupTableView{
    //添加列表
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64 - 49) style:UITableViewStylePlain];
    //去掉下划线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 0.01);
    tableView.userInteractionEnabled = YES;
    self.tableView = tableView;
    __weak typeof(self) weakSelf = self;
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getProjectesDownRefresh:NO isFrist:NO];
        // 结束刷新
        [tableView.mj_header endRefreshing];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    
    
    //
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //加载数据
        [weakSelf getProjectesDownRefresh:YES isFrist:NO];
        // 结束刷新
        [tableView.mj_footer endRefreshing];
    }];
    
    tableView.mj_footer.hidden = NO;
    
    
    
    //3.无数据时的图标
    ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(-10, -20, kViewWidth,kViewHeight)];
    noDataView.backgroundColor = [UIColor clearColor];
    noDataView.tishiString = @"没有数据";
    //默认隐藏
    noDataView.hidden = YES;
    [self.tableView addSubview:noDataView];
    self.noDataView = noDataView;
    
}

//停止定位
-(void)stopLocation:(id)sender{
    [_locService stopUserLocationService];
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    BMKCoordinateRegion region;
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0;
    region.span.longitudeDelta = 0;
    self.latitude = userLocation.location.coordinate.latitude;
    self.longitude = userLocation.location.coordinate.longitude;
    
    [ASingleton shareInstance].latitude = self.latitude;
    [ASingleton shareInstance].longitude = self.longitude;
    NSLog(@"当前的坐标是:%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    //请求数据
    [self getProjectesDownRefresh:NO isFrist:YES];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    __weak typeof(self) weakSelf = self;
    
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
#warning 测试
        //    CLLocation *aa = [[CLLocation alloc]initWithLatitude:22 longitude:113];
        //         [geocoder reverseGeocodeLocation:aa completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            if (placemark != nil) {
                NSString *city = placemark.locality;
                NSString *LastCity = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
                NSLog(@"当前城市名称------%@",LastCity);
                
                weakSelf.city = LastCity;
                [ASingleton shareInstance].city = LastCity;
                NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                [weakSelf.cityButton setTitle:LastCity forState:UIControlStateNormal];
                NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                dispatch_queue_t seriaQueue = dispatch_queue_create("toGether", DISPATCH_QUEUE_CONCURRENT);
                dispatch_async(seriaQueue, ^{
                    BMKOfflineMap * _offlineMap = [[BMKOfflineMap alloc] init];
                    //                _offlineMap.delegate = self;//可以不要
                    NSArray* records = [_offlineMap searchCity:city];
                    BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
                    //城市编码如:北京为131
                    NSInteger cityId = oneRecord.cityID;
                    
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    NSLog(@"当前城市编号-------->%zd",cityId);
                });
                //找到了当前位置城市后就关闭服务
                [_locService stopUserLocationService];
            }
        }
    }];
    
    //找到了当前位置城市后就关闭服务
    [_locService stopUserLocationService];
}
/**
 *定位失败后，会调用此函数
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    [self stopLocation:nil];
    //失败以后读取数据
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    //读取数据
    NSString *latitude = [defaults objectForKey:@"IWNearLatitude"];//根据键值取出name
    NSString *longitude = [defaults objectForKey:@"IWNearLongitude"];
    NSString *city = [defaults objectForKey:@"IWNearCity"];
    
    self.city = city;
    self.latitude = [latitude floatValue];
    self.longitude = [longitude floatValue];
    
    if (!self.city || ![self.city isKindOfClass:[NSString class]] || self.city.length < 1) {
        self.city = @"深圳";
        [self.cityButton setTitle:self.city forState:UIControlStateNormal];
        self.latitude = 22.642491;
        self.longitude = 114.032412;
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"未获取到定位数据,默认定位深圳"];
    }else{
        [self.cityButton setTitle:self.city forState:UIControlStateNormal];
    }
    //请求数据
    [self getProjectesDownRefresh:NO isFrist:YES];
}

#pragma mark -  城市点击
-(void)cityClick:(UIButton *)button{
    
    #warning 注释掉  
//    CityPickerViewController *cityPickerVC = [[CityPickerViewController alloc] init];
//    // 设置当前城市
//    cityPickerVC.currentCity = self.city;
//    
//    // 设置热门城市
//    cityPickerVC.hotCities = @[@"成都", @"深圳", @"上海", @"长沙", @"杭州", @"南京", @"徐州", @"北京"];
//    
//    cityPickerVC.cityModels = [self cityModelsPrepare];
//    cityPickerVC.delegate = self;
//    cityPickerVC.title = @"城市选择";
//    [self.navigationController pushViewController:cityPickerVC animated:YES];
}

#pragma mark - CityPickerViewControllerDelegate
- (void)cityPickerViewController:(CityPickerViewController *)cityPickerViewController selectedCityModel:(CityModel *)selectedCityModel {
    NSLog(@"统一输出 cityModel id pid spell name :%ld %ld %@ %@", (long)selectedCityModel.cityId, (long)selectedCityModel.pid, selectedCityModel.spell, selectedCityModel.name);
    self.selectedCityModel = selectedCityModel;
    
    UIAlertView  *alerView = [[UIAlertView alloc]initWithTitle:@"注意" message: [NSString stringWithFormat:@"切换城市为 - %@",selectedCityModel.name] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alerView show];
}
#pragma mark - 弹框
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        return;
    }
    
    self.city = self.selectedCityModel.name;
    
    [self.cityButton setTitle:self.city forState:UIControlStateNormal];
    //通过城市名称获取城市的经纬度
    self.codeSearch =[[BMKGeoCodeSearch alloc]init];
    self.codeSearch.delegate = self;
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city= self.city;
    geoCodeSearchOption.address = self.city;
    BOOL flag = [self.codeSearch geoCode:geoCodeSearchOption];
    if(!flag)
      [[TKAlertCenter  defaultCenter]postAlertWithMessage:@"城市数据获取失败，稍后重试"];
}

#pragma mark -接收正向编码结果
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        self.longitude = result.location.longitude;
        self.latitude = result.location.latitude;
        //重新获取数据
        [self getProjectesDownRefresh:NO isFrist:NO];
    }
    else {
        [[TKAlertCenter  defaultCenter]postAlertWithMessage:@"城市数据获取失败，稍后重试"];
    }
}


#pragma mark - private methods
- (NSMutableArray *)cityModelsPrepare {
    NSURL *plistUrl = [[NSBundle mainBundle] URLForResource:@"City" withExtension:@"plist"];
    NSArray *cityArray = [[NSArray alloc] initWithContentsOfURL:plistUrl];
    
    NSMutableArray *cityModels = [NSMutableArray array];
    for (NSDictionary *dict in cityArray) {
        CityModel *cityModel = [self parseWithDict:dict];
        
        [cityModels addObject:cityModel];
    }
    return cityModels;
}

- (CityModel *)parseWithDict:(NSDictionary *)dict {
    NSInteger cityId = [dict[@"id"] integerValue];
    NSInteger pid = [dict[@"id"] integerValue];
    NSString *name = dict[@"name"];
    NSString *spell = dict[@"spell"];
    
    CityModel *cityModel = [[CityModel alloc] initWithCityId:cityId pid:pid name:name spell:spell];
    NSArray *children = dict[@"children"];
    
    if (children.count != 0) {
        NSMutableArray *childrenArray = [[NSMutableArray alloc] init];
        for (NSDictionary *childDict in children) {
            CityModel *childCityModel = [self parseWithDict:childDict];
            
            [childrenArray addObject:childCityModel];
        }
        
        cityModel.children = childrenArray;
    }
    
    return cityModel;
}

#pragma mark 搜索按钮点击
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.view endEditing:YES];
    
    IWNearSearchResultVC *search = [[IWNearSearchResultVC alloc]initWithCateId:nil shopName:nil latitude:self.latitude longitude:self.longitude class:@"更多"];
    [self.navigationController pushViewController:search animated:YES];
    
    return NO;
}

#pragma mark //请求数据
-(void)getProjectesDownRefresh:(BOOL )isDownRefresh isFrist:(BOOL)isFrist{
    //下拉就去第一页
    if (!isDownRefresh)
        self.page = 1;
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?y=%f&x=%f&page=%d",kNetUrl,@"store/getStoreList",self.latitude,self.longitude,self.page];
    
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
            [weakSelf.downDataArray removeAllObjects];
            [weakSelf.distanceDataArray removeAllObjects];
            [weakSelf.discountDataArray removeAllObjects];
            [weakSelf.discussDataArray removeAllObjects];
        }
        
        
        BOOL  haveData = NO;
        
        NSArray *distanceList = contentDict[@"distanceList"];
        if (!distanceList || ![distanceList isKindOfClass:[NSArray class]]|| distanceList.count == 0) {
        }else{
            for (NSDictionary *contentDic in distanceList) {
                IWNearShoppingModel *model = [IWNearShoppingModel modelWithDic:contentDic];
                [self.distanceDataArray addObject:model];
                haveData = YES;
            }
        }
        //默认选中第一个
        if (isFrist)
            
            self.downDataArray = self.distanceDataArray;
        
        
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
        if (haveData == NO) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"数据加载完成"];
        }else{
            self.page++;
        }
        
        //默认选中第一个
        if (isFrist)
            self.downDataArray = self.distanceDataArray;
        else
            [self selectButtonClick:self.selectButton];
        
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        weakSelf.mustHiddenNoDataView = NO;
                [[ASingleton shareInstance] stopLoadingView];
        [weakSelf failSetup];
    }];
}
#pragma mark 失败处理
-(void)failSetup{
    
    [self.tableView reloadData];
}

#pragma mark 头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
#pragma mark 高度cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //上部
    if (indexPath.section == 0 ) {
        NSInteger count = self.topDataArray.count;
        if(count == 0){
            return 0;
        }else{
            
            CGFloat cellH =  ((self.topDataArray.count + 3) / 4) * kFRate(15 +55) + 15;
            return cellH;
        }
        
    }
    return kFRate(120);
}
#pragma mark 底部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return kFRate(40);
    }
    return kFRate(0);
}
#pragma mark 头部Header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
#pragma mark 底部Footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0)
        return self.firstFootView;
    else
        return nil;
    //    UIView *custview = [[UIView  alloc]init];
    //    custview.frame =CGRectMake(-1.3, 0, tableView.frame.size.width + 2.6, kFRate(13));
    //    custview.backgroundColor = [UIColor clearColor];
    //    UIImageView *image = [[UIImageView alloc]initWithFrame:custview.frame];
    //    //    image.image = [UIImage getSanJiaoImage:_IMG(@"CTDAvenueAIXLNewbolilast")];
    //    [custview addSubview:image];
    //    return custview;
}

-(UIView *)firstFootView{
    
    if (!_firstFootView) {
        
        UIView *custview = [[UIView  alloc]init];
        custview.frame =CGRectMake(0, 0, self.tableView.frame.size.width, kFRate(40));
        custview.backgroundColor = kArc4randomColor;
        custview.userInteractionEnabled = YES;
        
        //灰色间隔
        UIView *grayCustview = [[UIView  alloc]init];
        grayCustview.frame =CGRectMake(0, 0, self.tableView.frame.size.width, kFRate(10));
        grayCustview.backgroundColor = kColorRGB(240, 240, 240);
        [custview addSubview:grayCustview];
        
        //白色底
        UIView *whiteCustview = [[UIView  alloc]init];
        whiteCustview.frame =CGRectMake(0, 10, self.tableView.frame.size.width, kFRate(30));
        whiteCustview.backgroundColor = [UIColor whiteColor];
        [custview addSubview:whiteCustview];
        whiteCustview.userInteractionEnabled = YES;
        
        //距离最近
        CGFloat  buttonW = kViewWidth/3.0;
        IWNearSelectButton *distanceBTN = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(0, 0,buttonW, 30)];
        distanceBTN.index = 0;
        [distanceBTN setTitle:@"距离最近" forState:UIControlStateNormal];
        [distanceBTN setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
        [distanceBTN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [distanceBTN setTitleColor:IWColorRed forState:UIControlStateSelected];
        [distanceBTN addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [whiteCustview addSubview:distanceBTN];
        
        //默认选中
        self.selectButton = distanceBTN;
        distanceBTN.selected = YES;
        
        
        //折扣最低
        IWNearSelectButton *discountBTN = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(buttonW, 0,buttonW, 30)];
        discountBTN.index = 1;
        [discountBTN setTitle:@"折扣最低" forState:UIControlStateNormal];
        [discountBTN setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
        [discountBTN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [discountBTN setTitleColor:IWColorRed forState:UIControlStateSelected];
        [discountBTN addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [whiteCustview addSubview:discountBTN];
        
        //评价最高
        IWNearSelectButton *discussBTN = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(2 * buttonW, 0,buttonW, 30)];
        discussBTN.index = 2;
        [discussBTN setTitle:@"评价最高" forState:UIControlStateNormal];
        [discussBTN setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
        [discussBTN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [discussBTN setTitleColor:IWColorRed forState:UIControlStateSelected];
        [discussBTN addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [whiteCustview addSubview:discussBTN];
        
        //
        UIView *line = [[UIView  alloc]init];
        line.frame =CGRectMake(0, 29.5, self.tableView.frame.size.width, 0.5);
        line.backgroundColor = [UIColor grayColor];
        [whiteCustview addSubview:line];
        
        _firstFootView = custview;
    }
    return _firstFootView;
}

#pragma mark 中间按钮点击
-(void)selectButtonClick:(IWNearSelectButton *)button{
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    // 替换数据原
    switch (button.index) {
        case 0:
            self.downDataArray = self.distanceDataArray;
            break;
        case 1:
            self.downDataArray = self.discountDataArray;
            break;
        default:
            self.downDataArray = self.discussDataArray;
            break;
    }
    [self.tableView reloadData];
}

#pragma mark 组数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    //没有数据
    //    if (!self.dataArray || self.dataArray.count == 0) {
    //        if (self.mustHiddenNoDataView) {//必须隐藏，用于第一次加载
    //            self.noDataView.hidden = YES;
    //        }else{
    //            self.noDataView.hidden = NO;
    //        }
    //        //有数据
    //    }else{
    //        self.noDataView.hidden = YES;
    //    }
    //    if (self.mustHiddenNoDataView || self.noDataView.hidden == NO) {
    //        return 0;
    //    }
    
    return 2;
}
#pragma mark 组内部cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return 1;
    return self.downDataArray.count;
}
#pragma mark 组内部cell实现
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        IWNearTopCell *cell = [IWNearTopCell cellWithTableView:tableView];
        __weak typeof(self) weakSelf = self;
        cell.cellClick = ^(IWNearTopModel *model,NSInteger cellIndex){
            if ([model.nameTitle isEqual:@"更多"]) {
                IWNearSearchResultVC *search = [[IWNearSearchResultVC alloc]initWithCateId:nil shopName:nil latitude:self.latitude longitude:self.longitude class:model.nameTitle];
                [weakSelf.navigationController pushViewController:search animated:YES];
            }else{
                IWNearSearchResultVC *search = [[IWNearSearchResultVC alloc]initWithCateId:model.modelId shopName:nil latitude:self.latitude longitude:self.longitude class:model.nameTitle];
                [weakSelf.navigationController pushViewController:search animated:YES];
            }
        };
        cell.modelArray = weakSelf.topDataArray;
        return cell;
    }else{
        IWNearShoppingCell *cell = [IWNearShoppingCell cellWithTableView:tableView];
        IWNearShoppingModel *model =  self.downDataArray[indexPath.row];
        cell.model = model;;
        return cell;
    }
}
#pragma mark Cell 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0) {
        return;
    }else{
        IWNearShoppingModel *model =  self.downDataArray[indexPath.row];
        //点击事件处理
        IWNearShoppingDetailVC  *detailVC = [[IWNearShoppingDetailVC alloc]initWithShopId:model.modelId];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}
-(void)dealloc{
    _locService.delegate = nil;
}
@end
