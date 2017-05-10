//
//  IWHomeViewController.m
//  shopping201702
//
//  Created by MacBook on 2017/2/21.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWHomeViewController.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "PrefixHeader.pch"
#import "IWGategroyBtn.h"
#import "IWGategoryCell.h"
#import "SGGenerateQRCodeVC.h"
#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SGAlertView.h"
#import "IWDetailsVC.h"
#import "IWSignINVC.h"
#import "IWGategoryVC.h"
#import "IWGoodsTableVC.h"
#import "IWLoginVC.h"
#import "IWHomeBanderModel.h"
#import "IWHomeRegionModel.h"
#import "IWHomeRegionProductModel.h"
#import "IWLuckyVC.h"
#import "IWShareVC.h"
#import "IWHomeNoticeModel.h"
#import "IWToViewWuLiuVC.h"
#import "IWHomeMoreVC.h"
#import "IWHomeCell.h"
#import "IWWebViewVC.h"
#define kLinColor IWColor(240, 240, 240)
@interface IWHomeViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,BMKLocationServiceDelegate>{
    
    BMKLocationService* _locService;
    
}
// 首页列表
@property (nonatomic,weak) UICollectionView *myCollectionView;
// 轮播控制器
@property (nonatomic,weak)SDCycleScrollView *cycleScrollView;
// 搜索
@property (nonatomic,weak)IWSearchBar *searchBar;
// 首页轮播图数据源
@property (nonatomic,strong)NSMutableArray *banderArr;
// bannerView
@property (nonatomic,weak)UIView *headerView;
// 无数据
@property (nonatomic,weak)ANodataView *noDataView;
// 推荐商品数据
@property (nonatomic,strong)NSMutableArray *regionArr;
// 公告
@property (nonatomic,strong)NSMutableArray *noticeArr;
// 消息入口
@property (nonatomic,copy)NSString *messageUrl;
@end

@implementation IWHomeViewController
// banner数据源
- (NSMutableArray *)banderArr
{
    if (_banderArr == nil) {
        _banderArr = [[NSMutableArray alloc] init];
    }
    return _banderArr;
}
// 推荐商品数据源
- (NSMutableArray *)regionArr
{
    if (_regionArr == nil) {
        _regionArr = [[NSMutableArray alloc] init];
    }
    return _regionArr;
}
// 公告数据源
- (NSMutableArray *)noticeArr
{
    if (_noticeArr == nil) {
        _noticeArr = [[NSMutableArray alloc] init];
    }
    return _noticeArr;
}
#pragma mark - 登录请求
- (void)requestLogin
{
    // 获取登录信息
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *userAcuont = [defaults objectForKey:@"userAccount"]?[defaults objectForKey:@"userAccount"]:@"";//根据键值取出账号密码;
    NSString *pwd = [defaults objectForKey:@"password"]?[defaults objectForKey:@"password"]:@"";
    
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/login?userAccount=%@&password=%@",kNetUrl,userAcuont,pwd];
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        
        if (!json || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf failData:@"账号或密码错误"];
            return ;
        }
        if (!json[@"code"] || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf failData:json[@"message"]];
            return ;
        }
        if (!json[@"data"] || ![json[@"data"] isKindOfClass:[NSDictionary class]]) {
            [weakSelf failData:json[@"message"]];
            return ;
        }
        NSDictionary *dataDic = json[@"data"];
        [ASingleton shareInstance].loginModel = [[IWLoginModel alloc] initWithDic:dataDic];
        [ASingleton shareInstance].homeVCNeedRefresh = YES;
        [ASingleton shareInstance].nearVCNeedRefresh = YES;
        [ASingleton shareInstance].shoppingVCNeedRefresh = YES;
        [ASingleton shareInstance].meVCNeedRefresh = YES;
        
        // 登录成功存储userId
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:dataDic forKey:@"modelDic"];
        // 登录成功单利赋值
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf failData:@"账号或密码错误"];
        return ;
    }];
}

- (void)failData:(NSString *)str
{
    [ASingleton shareInstance].loginModel = nil;
    [ASingleton shareInstance].homeVCNeedRefresh = NO;
    [ASingleton shareInstance].nearVCNeedRefresh = NO;
    [ASingleton shareInstance].shoppingVCNeedRefresh = NO;
    [ASingleton shareInstance].meVCNeedRefresh = NO;
    // 登录成功存储userId
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:@"userAccount"];
    [defaults setObject:@"" forKey:@"password"];
    [defaults setObject:nil forKey:@"modelDic"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
        self.view.backgroundColor = IWColor(240, 240, 240);
    [self requestLogin];
    [self createTableView];
    [self setNavView];
    [self refresh];
    //定位
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    
    [_locService startUserLocationService];
}

#pragma mark - WillAppear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.searchBar.hidden = NO;
}

//停止定位
-(void)stopLocation:(id)sender
{
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
    
    [ASingleton shareInstance].latitude = userLocation.location.coordinate.latitude;
    [ASingleton shareInstance].longitude = userLocation.location.coordinate.longitude;
    NSLog(@"当前的坐标是:%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
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
                [ASingleton shareInstance].city = LastCity;
                
//                dispatch_queue_t seriaQueue = dispatch_queue_create("toGether", DISPATCH_QUEUE_CONCURRENT);
//                dispatch_async(seriaQueue, ^{
//                    BMKOfflineMap * _offlineMap = [[BMKOfflineMap alloc] init];
//                    //                _offlineMap.delegate = self;//可以不要
//                    NSArray* records = [_offlineMap searchCity:city];
//                    BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
//                    //城市编码如:北京为131
//                    NSInteger cityId = oneRecord.cityID;
//                    
//                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
//                    NSLog(@"当前城市编号-------->%zd",cityId);
//                });
                
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
    NSLog(@"location error");
}


#pragma mark - 设置导航栏
- (void)setNavView
{
    self.navigationItem.title = @"";
//    self.navigationController.navigationBar.barTintColor = [UIColor HexColorToRedGreenBlue:@"#ff3b60"];
    CGRect mainViewBounds = self.navigationController.view.bounds;
    IWSearchBar *searchBar = [[IWSearchBar alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-120)/2), CGRectGetMinY(mainViewBounds)+25, CGRectGetWidth(mainViewBounds)-120, 30)];
    searchBar.delegate = self;
    [self.navigationController.view addSubview: searchBar];
    self.searchBar = searchBar;
    
    // 自定义导航左右按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"IWNews"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn addTarget:self action:@selector(collectionRightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    // 左按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"IWCode"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

#pragma mark - 导航右按钮
- (void)collectionRightClick
{
    IWWebViewVC *vc = [[IWWebViewVC alloc] init];
    vc.url = _messageUrl;
    vc.navTitle = @"消息";
    self.searchBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)collectionLeftCilck
{
    // 1、 获取摄像设备
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([ASingleton shareInstance].loginModel) {
                            SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
                            scanningQRCodeVC.inToType = @"0";
                            [self.navigationController pushViewController:scanningQRCodeVC animated:YES];
                        }else{
                            IWLoginVC *login = [[IWLoginVC alloc] init];
                            [self.navigationController pushViewController:login animated:YES];
                        }
                        
                        NSLog(@"主线程 - - %@", [NSThread currentThread]);
                    });
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            self.searchBar.hidden = YES;
            if ([ASingleton shareInstance].loginModel) {
                SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
                scanningQRCodeVC.inToType = @"0";
                [self.navigationController pushViewController:scanningQRCodeVC animated:YES];
            }else{
                IWLoginVC *login = [[IWLoginVC alloc] init];
                [self.navigationController pushViewController:login animated:YES];
            }
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
            [alertView show];
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"未检测到您的摄像头" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
        [alertView show];
    }
}

#pragma mark 搜索商品
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar endEditing:YES];
    IWHomeMoreVC *moreVC = [[IWHomeMoreVC alloc] init];
    moreVC.isHome = YES;
    moreVC.content = self.searchBar.text;
    [self.navigationController pushViewController:moreVC animated:YES];
    self.searchBar.hidden = YES;
    self.searchBar.text = @"";
}

// 搜索内容变化
- (void)searchBar:(IWSearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

#pragma mark - 首页列表
- (void)createTableView
{
    // 列表
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 上左下右(边缘间距)
    layout.sectionInset = UIEdgeInsetsMake(kFRate(10), kFRate(10), kFRate(0), kFRate(10));
    // 行间距(cell上下)
    layout.minimumLineSpacing = kFRate(10);
    // 设置
    UICollectionView *myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64 - kFRate(49)) collectionViewLayout:layout];
    myCollectionView.backgroundColor = [UIColor whiteColor];
    
    // 注册
    [myCollectionView registerClass:[IWHomeCell class] forCellWithReuseIdentifier:@"IWHomeCell"];
    [myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"IWHomeHeader"];
    [myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"IWHomeFoot"];
    
    myCollectionView.delegate = self;
    myCollectionView.dataSource = self;
    [self.view addSubview:myCollectionView];
    self.myCollectionView = myCollectionView;
    
    __weak typeof(self) weakSelf = self;
    // 下拉刷新
    myCollectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refresh];
        // 结束刷新
        [myCollectionView.mj_header endRefreshing];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    myCollectionView.mj_header.automaticallyChangeAlpha = YES;
    
    //3.无数据时的图标
    ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth,kViewHeight - 64 - 49)];
    noDataView.backgroundColor = [UIColor whiteColor];
    noDataView.tishiString = @"没有数据";
    //默认隐藏
    noDataView.hidden = YES;
    [self.myCollectionView addSubview:noDataView];
    //self.noDataView = noDataView;
}

#pragma mark - 签到/分类
- (void)gategoryBtnClick:(UIControl *)sender
{
    self.searchBar.hidden = YES;
    switch (sender.tag - 10000) {
        case 0:
        {
            // 签到
            if ([ASingleton shareInstance].loginModel.userId) {
                IWSignINVC *signVC = [[IWSignINVC alloc] init];
                [self.navigationController pushViewController:signVC animated:YES];
            }else{
                IWLoginVC *login = [[IWLoginVC alloc] init];
                [self.navigationController pushViewController:login animated:YES];
            }
            
        }
            break;
        case 1:
        {
            // 抽奖
            if ([ASingleton shareInstance].loginModel) {
                IWLuckyVC *luckyVC = [[IWLuckyVC alloc] init];
                [self.navigationController pushViewController:luckyVC animated:YES];
            }else{
                IWLoginVC *login = [[IWLoginVC alloc] init];
                [self.navigationController pushViewController:login animated:YES];
            }
        }
            break;
        case 2:
            // 分享
        {
//            if ([ASingleton shareInstance].loginModel) {
                IWShareVC *shareVC = [[IWShareVC alloc] init];
                [self.navigationController pushViewController:shareVC animated:YES];
//            }else{
//                IWLoginVC *login = [[IWLoginVC alloc] init];
//                [self.navigationController pushViewController:login animated:YES];
//            }.
        }
            break;
        case 3:
            // 分类
        {
            if ([ASingleton shareInstance].productCateList.count > 0) {
                IWGategoryVC *gategoryVC = [[IWGategoryVC alloc] init];
                [self.navigationController pushViewController:gategoryVC animated:YES];
            }else{
                [[TKAlertCenter defaultCenter]postAlertWithMessage:@"暂无分类商品"];
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.regionArr.count == 0) {
        self.noDataView.hidden = NO;
    }else{
        self.noDataView.hidden = YES;
    }
    return self.regionArr.count + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        IWHomeRegionModel *regionModel = self.regionArr[section - 1];
        return regionModel.productArr.count;
    }
}
// cell宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kRate(93), kRate(93) + kRate(30) + kFRate(40) + kRate(10));
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IWHomeCell *cell = [[IWHomeCell alloc] cellWithTableView:collectionView indexPath:indexPath];
    IWHomeRegionModel *regionModel = self.regionArr[indexPath.section - 1];
    cell.productModel = regionModel.productArr[indexPath.row];
    return cell;
}

#pragma mark - 段头段尾
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(kViewWidth, kFRate(110) + kRate(150));
    }
    return CGSizeMake(kViewWidth, kFRate(43));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"IWHomeHeader" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor orangeColor];
        if (headerView == nil) {
            headerView = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(43))];
        }
        headerView.backgroundColor = [UIColor clearColor];
        
        for (UIView *view in headerView.subviews) {
            [view removeFromSuperview];
        }
        
        if (indexPath.section == 0) {
            headerView.frame = CGRectMake(0, 0, kViewWidth, kFRate(110) + kRate(150));
            // banner文字和图片
            NSMutableArray *textArr = [[NSMutableArray alloc] init];
            NSMutableArray *bannerImgArr = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < self.banderArr.count; i ++) {
                IWHomeBanderModel *model = self.banderArr[i];
                [textArr addObject:model.bannerName];
                [bannerImgArr addObject:model.bannerImg];
            }
            //         --- 轮播时间间隔，默认1.0秒，可自定义
            //cycleScrollView.autoScrollTimeInterval = 4.0;
            // >>>>>>>>>>>>>>>>>>>>>>>>> 轮播图 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            
            SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kViewWidth, kRate(150)) delegate:self placeholderImage:nil];
            cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
            cycleScrollView.currentPageDotColor = IWColor(252, 62, 99); // 自定义分页控件小圆标颜色
            cycleScrollView.pageDotColor = [UIColor whiteColor];
            cycleScrollView.titlesGroup = [textArr copy];
            [headerView addSubview:cycleScrollView];
            self.cycleScrollView = cycleScrollView;
            //         --- 模拟加载延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                cycleScrollView.imageURLStringsGroup = bannerImgArr;
            });
            /*
             block监听点击方式
             cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
             NSLog(@">>>>>  %ld", (long)index);
             };
             
             */
            
            UIView *gategoryViewBack = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cycleScrollView.frame), kViewWidth, kFRate(90))];
            gategoryViewBack.backgroundColor = [UIColor whiteColor];
            [headerView addSubview:gategoryViewBack];
            
            // 间距
            CGFloat disW = (kViewWidth - kFRate(60) - kFRate(40) * 4) / 3;
            // 图片集合与文字
            NSArray *btnImgs = @[@"IWHomeSign",@"IWHomeLuck",@"IWHomeShare",@"IWHomeGategory"];
            NSArray *titles = @[@"签到",@"抽奖",@"分享",@"分类"];
            for (NSInteger i = 0; i < 4; i ++) {
                IWGategroyBtn *gategroyBtn = [[IWGategroyBtn alloc] initWithFrame:CGRectMake(kFRate(30) + (kFRate(40) + disW) * i , kFRate(15), kFRate(40), kFRate(58))];
                gategroyBtn.btnImg.image = _IMG(btnImgs[i]);
                gategroyBtn.title.text = titles[i];
                gategroyBtn.tag = 10000 + i;
                [gategroyBtn addTarget:self action:@selector(gategoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [gategoryViewBack addSubview:gategroyBtn];
            }
            
            // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图文字 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            // 由于模拟器的渲染问题，如果发现轮播时有一条线不必处理，模拟器放大到100%或者真机调试是不会出现那条线的
            // 公告
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(gategoryViewBack.frame), kViewWidth, kFRate(30))];
            backView.backgroundColor = IWColor(250, 241, 219);
            [headerView addSubview:backView];
            
            UILabel *gonggaoLabel = [[UILabel alloc] init];
            gonggaoLabel.text = @"公告:";
            gonggaoLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#353535"];
            gonggaoLabel.font = kFont26pxBold;
            gonggaoLabel.backgroundColor = IWColor(250, 241, 219);
            [gonggaoLabel sizeToFit];
            gonggaoLabel.frame = CGRectMake(kFRate(10), 0, gonggaoLabel.frame.size.width, kFRate(30));
            [backView addSubview:gonggaoLabel];
            
            SDCycleScrollView *cycleScrollViewText = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(CGRectGetMaxX(gonggaoLabel.frame), 0, kViewWidth - CGRectGetMaxX(gonggaoLabel.frame), kFRate(30)) delegate:self placeholderImage:nil];
            cycleScrollViewText.backgroundColor = [UIColor orangeColor];
            cycleScrollViewText.scrollDirection = UICollectionViewScrollDirectionVertical;
            cycleScrollViewText.onlyDisplayText = YES;
            cycleScrollViewText.titleLabelBackgroundColor = IWColor(250, 241, 219);
            cycleScrollViewText.titleLabelTextColor = [UIColor HexColorToRedGreenBlue:@"#353535"];
            cycleScrollViewText.titleLabelTextFont = kFont24px;
            NSMutableArray *titlesArray = [NSMutableArray new];
            for (NSInteger i = 0; i < self.noticeArr.count; i ++) {
                IWHomeNoticeModel *notModel = self.noticeArr[i];
                [titlesArray addObject:notModel.noticeDesc];
            }
            cycleScrollViewText.titlesGroup = [titlesArray copy];
            [backView addSubview:cycleScrollViewText];
        }else{
            // 灰色分界线
            UIView *disView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(10))];
            disView.backgroundColor = kLinColor;
            [headerView addSubview:disView];
            
            // 白底
            UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, kFRate(10), kViewWidth, kFRate(33))];
            back.backgroundColor = [UIColor whiteColor];
            [headerView addSubview:back];
            
            // 标记线
            UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(kFRate(10), kFRate(10), kFRate(2), kFRate(13))];
            linView.backgroundColor = IWColor(252, 62, 99);
            [back addSubview:linView];
            
            // 标题
            UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(linView.frame) + kFRate(7), 0, kViewWidth - CGRectGetMaxX(linView.frame) - kFRate(50), kFRate(33))];
            IWHomeRegionModel *model = self.regionArr[indexPath.section - 1];
            itemLabel.text = model.regionName;
            itemLabel.font = [UIFont systemFontOfSize:kFRate(14)];
            itemLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#353535"];
            [back addSubview:itemLabel];
            
            // 更多
            UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            moreBtn.tag = 30000 + indexPath.section;
            moreBtn.frame = CGRectMake(kViewWidth - kFRate(45), 0, kFRate(40), kFRate(33));
            moreBtn.titleLabel.font = kFont28px;
            [moreBtn setTitleColor:[UIColor HexColorToRedGreenBlue:@"#ff3b60"] forState:UIControlStateNormal];
            [moreBtn setTitle:@"更多>" forState:UIControlStateNormal];
            [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [back addSubview:moreBtn];
            
            // 尾线
            UIView *lastView = [[UIView alloc] initWithFrame:CGRectMake(kFRate(10), kFRate(42.5), kViewWidth - kFRate(20), kFRate(0.5))];
            lastView.backgroundColor = kLineColor;
            [headerView addSubview:lastView];
        }
        
        return headerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IWHomeRegionModel *homeCellModel = self.regionArr[indexPath.section - 1];
    IWHomeRegionProductModel *productModel = homeCellModel.productArr[indexPath.row];
    IWDetailsVC *detailsVC = [[IWDetailsVC alloc] init];
    detailsVC.productId = productModel.productId;
    [self.navigationController pushViewController:detailsVC animated:YES];
    self.searchBar.hidden = YES;
}

#pragma mark - 更多
- (void)moreBtnClick:(UIButton *)sender
{
    self.searchBar.hidden = YES;
    IWGoodsTableVC *moreVC = [[IWGoodsTableVC alloc] init];
    IWHomeRegionModel *model = self.regionArr[sender.tag - 30001];
    moreVC.regionId = model.regionId;
    moreVC.regionName = model.regionName;
    [self.navigationController pushViewController:moreVC animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (cycleScrollView == self.cycleScrollView) {
        IWHomeBanderModel *model = self.banderArr[index];
        if (![model.targetUrl isEqual:@"#"] && ![model.targetUrl isEqual:@""]) {
            IWWebViewVC *webView = [[IWWebViewVC alloc] init];
            webView.navTitle = model.bannerName;
            webView.url = model.targetUrl;
            self.searchBar.hidden = YES;
            [self.navigationController pushViewController:webView animated:YES];
        }
    }else{
        
    }
}

//// 滚动到第几张图回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    //    NSLog(@">>>>>> 滚动到第%ld张图", (long)index);
}

#pragma mark - 请求数据
-(void)refresh{
    
    __weak typeof(self) weakSelf = self;
    self.noDataView.hidden = YES;
    NSString *url = [NSString stringWithFormat:@"%@/platform/baseInfo",kNetUrl];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf.banderArr removeAllObjects];
        [weakSelf.noticeArr removeAllObjects];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf allFailData:@"获取商品失败"];
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
        if (dataDic[@"banner"] == nil || ![dataDic[@"banner"] isKindOfClass:[NSArray class]]) {
            [weakSelf allFailData:json[@"message"]];
            return ;
        }
        if (dataDic[@"storeCateList"] && [dataDic[@"storeCateList"] isKindOfClass:[NSArray class]]) {
            [ASingleton shareInstance].storeCateList = dataDic[@"storeCateList"];
        }
        // 分类
        if (dataDic[@"productCateList"] && [dataDic[@"productCateList"] isKindOfClass:[NSArray class]]) {
            [ASingleton shareInstance].productCateList = dataDic[@"productCateList"];
        }
        [ASingleton shareInstance].aboutUsUrl = dataDic[@"aboutUsUrl"]?dataDic[@"aboutUsUrl"]:@"";
        [ASingleton shareInstance].businessUrl = dataDic[@"businessUrl"]?dataDic[@"businessUrl"]:@"";
        
        weakSelf.messageUrl = dataDic[@"messageUrl"]?:@"";
        // 启动图
        NSDictionary *configDic = dataDic[@"config"]?:nil;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:configDic forKey:@"configDic"];
        // 公告
        if (dataDic[@"notice"] || [dataDic[@"notice"] isKindOfClass:[NSArray class]]) {
            NSArray *notArr = dataDic[@"notice"];
            for (NSDictionary *notDic in notArr) {
                IWHomeNoticeModel *notModel = [[IWHomeNoticeModel alloc] initWithDic:notDic];
                [weakSelf.noticeArr addObject:notModel];
            }
        }
        NSArray *bannerArr = dataDic[@"banner"];
        if (bannerArr.count == 0) {
            [weakSelf allFailData:json[@"message"]];
            return ;
        }
        for (NSDictionary *dic in bannerArr) {
            IWHomeBanderModel *model = [[IWHomeBanderModel alloc] initWithDic:dic];
            [weakSelf.banderArr addObject:model];
        }
        [weakSelf regionData];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf allFailData:@"获取商品失败"];
        return ;
    }];
    
}

#pragma mark - 推荐商品
- (void)regionData
{
    __weak typeof(self) weakSelf = self;
    self.noDataView.hidden = YES;
    NSString *url = [NSString stringWithFormat:@"%@/platform/getRecommendProductByPage",kNetUrl];
    [[ASingleton shareInstance]startLoadingInView:self.view];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf.regionArr removeAllObjects];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf allFailData:@"获取商品失败"];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf allFailData:json[@"message"]];
            return ;
        }
        if (json[@"data"] == nil || ![json[@"data"] isKindOfClass:[NSArray class]]) {
            [weakSelf allFailData:json[@"message"]];
            return ;
        }
        NSArray *dataArr = json[@"data"];
        if (dataArr.count == 0) {
            [weakSelf allFailData:json[@"message"]];
            return ;
        }
        for (NSDictionary *dic in dataArr) {
            IWHomeRegionModel *regionModel = [[IWHomeRegionModel alloc] initWithDic:dic];
            [weakSelf.regionArr addObject:regionModel];
        }
        [weakSelf.myCollectionView reloadData];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf allFailData:@"获取商品失败"];
        return ;
    }];
}

- (void)allFailData:(NSString *)str
{
    self.noDataView.hidden = NO;
    [[TKAlertCenter defaultCenter]postAlertWithMessage:str];
    [self.noticeArr removeAllObjects];
    [self.banderArr removeAllObjects];
    [self.regionArr removeAllObjects];
    [self.myCollectionView reloadData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
     _locService.delegate = nil;
}
@end
