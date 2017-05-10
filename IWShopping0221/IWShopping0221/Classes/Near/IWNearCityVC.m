//
//  IWNearCityVC.m
//  IWShopping0221
//
//  Created by s on 17/2/26.
//  Copyright © 2017年 sword. All rights reserved.
//

//#import "IWNearCityVC.h"
//
//#import "IWNearSelectButton.h"
//#import "AFTSearchBar.h"
//#import "IWNearShoppingDetailServeCell.h"
//#import "IWNearShoppingDetailDiscussCell.h"
//@interface IWNearCityVC ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
////
//@property (nonatomic,weak)UITableView *tableView;
//
//@property (nonatomic,strong)NSArray *dataArray;
//
//@property (nonatomic,strong)UIView *headView;
//
//// 所有页签
//@property (nonatomic,strong)NSMutableArray *allSection;
//// 搜索
//@property (nonatomic,strong)AFTSearchBar *searchBar;
//// 是否搜索
//@property (nonatomic,assign)BOOL isSearch;
////
//@property (nonatomic,strong)ANodataView *noDataView;
//// 字典
//@property (nonatomic,strong)NSMutableDictionary *dictName;
//// 全数据字典
//@property (nonatomic,strong)NSMutableDictionary *allDic;
//// 页签数组
//@property (nonatomic,strong)NSMutableArray *sectionArr;
//
//@end
//@implementation IWNearCityVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    
//    // 搜索
//    _searchBar = [[AFTSearchBar alloc] initWithFrame:CGRectMake(kFRate(8), 64, kViewWidth - kFRate(16), kFRate(31.5))];
//    [_searchBar changeSearchBarBackGroundImage:@"APMMemberSearch_bg" text:@"请输入城市名查找" bigImage:@"APMSearchBig" hasCenterPlaceholder:NO];
//    _searchBar.delegate = self;
//    [self.view addSubview:_searchBar];
//    
//    
//    //添加列表
//    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64) style:UITableViewStylePlain];
//    //去掉下划线
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:tableView];
//    tableView.backgroundColor = [UIColor clearColor];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 0.01);
//    tableView.userInteractionEnabled = YES;
//    self.tableView = tableView;
//    
//    self.tableView.tableHeaderView = self.headView;
//    
//    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//
//    self.dataArray = @[@"深圳",@"北京",@"广州",@"上海",@"深圳",@"天津",@"深圳",@"深圳",@"深圳",@"深圳",@"深圳",@"深圳",@"深圳"];
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    //    return kNearShoppingDetailHeadViewH;
//    
//    return 0.001;
//    
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    if (self.selectButton.index == 1) {
//        
//        IWNearShoppingDetailServeCell *cell = [IWNearShoppingDetailServeCell cellWithTableView:tableView];
//        
//        cell.dic = @{@"key":@"vaule"};
//        
//        return cell;
//        
//    }
//    
//    IWNearShoppingDetailDiscussCell *cell = [IWNearShoppingDetailDiscussCell cellWithTableView:tableView];
//    
//    cell.dic = @{@"key":@"vaule"};
//    
//    return cell;
//    
//    
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if(self.selectButton.index == 0)
//        return 1;
//    else
//        return self.dataArray.count;
//}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.selectButton.index == 0)
//        return kFRate(54 + 114 + 50 + 114);
//    return 80;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    //    return self.headView;
//    
//    
//    return nil;
//}
//-(UIView *)headView{
//    if (!_headView) {
//        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kNearShoppingDetailHeadViewH)];
//        headView.backgroundColor = kColorSting(@"f2f2f2");
//        [self addTopViewToHeadView:headView];
//        [self addMiddleViewToHeadView:headView];
//        [self addDownViewToHeadView:headView];
//        _headView = headView;
//    }
//    return _headView;
//}
//#pragma mark
//-(void)addTopViewToHeadView:(UIView *)headView{
//    UIImageView *topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(200))];
//    [topView sd_setImageWithURL:[NSURL URLWithString:@"http://pic33.photophoto.cn/20141204/0005018356673635_b.jpg"] placeholderImage:[UIImage imageNamed:@"http://pic33.photophoto.cn/20141204/0005018356673635_b.jpg"]];
//    [headView addSubview:topView];
//    
//    
//    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0,kFRate(147.5), kViewWidth, kFRate(52.5))];
//    grayView.backgroundColor = [UIColor grayColor];
//    [topView addSubview:grayView];
//    self.topView = topView;
//    
//    UILabel *shoppingNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kFRate(10),kFRate(5), kViewWidth - kFRate(10), kFRate(52.5/2))];
//    shoppingNameLabel.backgroundColor = [UIColor clearColor];
//    shoppingNameLabel.text = @"小路旗舰店";
//    [grayView addSubview:shoppingNameLabel];
//    shoppingNameLabel.font = kFont30px;
//    shoppingNameLabel.textColor = kColorSting(@"ffffff");
//    
//    self.shoppingNameLabel = shoppingNameLabel;
//    
//    UIImageView *locationView = [[UIImageView alloc]initWithFrame:CGRectMake(kFRate(10), CGRectGetMaxY(shoppingNameLabel.frame) , kFRate(17.5), kFRate(17.5))];
//    locationView.image = [UIImage imageNamed:@"IWHomeSign"];
//    [grayView addSubview:locationView];
//    
//    
//    UILabel *distanceLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(locationView.frame) + kFRate(5), CGRectGetMaxY(shoppingNameLabel.frame) - 5 , kViewWidth - CGRectGetMaxX(locationView.frame) + kFRate(5), kFRate(52.5) - CGRectGetHeight(shoppingNameLabel.frame))];
//    distanceLabel.text = @"附近500m";
//    distanceLabel.font = kFont24px;
//    distanceLabel.textColor = kColorSting(@"ffffff");
//    self.distanceLabel = distanceLabel;
//    [grayView addSubview:distanceLabel];
//    
//    
//}
//#pragma mark
//-(void)addMiddleViewToHeadView:(UIView *)headView{
//    
//    UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + kFRate(10), kViewWidth, kFRate(135))];
//    middleView.backgroundColor = [UIColor whiteColor];
//    [headView addSubview: middleView];
//    self.middleView = middleView;
//    
//    CGFloat iconX = kFRate(10);
//    CGFloat iconY  = kFRate(11.5);
//    CGFloat iconHW  = kFRate(22);
//    CGFloat labelH = kFRate(45);
//    //营业时间
//    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, labelH)];
//    timeView.backgroundColor = [UIColor clearColor];
//    
//    UIImageView *timeIcon = [[UIImageView alloc]initWithFrame:CGRectMake(iconX, iconY, iconHW, iconHW)];
//    timeIcon.image = [UIImage imageNamed:@"IWHomeSign"];
//    [timeView addSubview:timeIcon];
//    
//    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeIcon.frame) + kFRate(15), 0, kViewWidth - CGRectGetMaxX(timeIcon.frame) + kFRate(15), labelH)];
//    timeLabel.textColor = kColorSting(@"666666");
//    timeLabel.text =  @"营业时间： 09：00 - 20：00";
//    timeLabel.font = kFont30px;
//    [timeView addSubview:timeLabel];
//    
//    UIView *timeline = [[UIView alloc]initWithFrame:CGRectMake(0, labelH - 0.5, kViewWidth, 0.5)];
//    timeline.backgroundColor = [UIColor lightGrayColor];
//    [timeView addSubview:timeline];
//    
//    [middleView addSubview:timeView];
//    
//    
//    //电话号码
//    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(timeView.frame), kViewWidth, labelH)];
//    phoneView.backgroundColor = [UIColor clearColor];
//    
//    UIImageView *phoneIcon = [[UIImageView alloc]initWithFrame:CGRectMake(iconX, iconY, iconHW, iconHW)];
//    phoneIcon.image = [UIImage imageNamed:@"IWHomeSign"];
//    [phoneView addSubview:phoneIcon];
//    
//    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneIcon.frame) + kFRate(15), 0, kViewWidth - CGRectGetMaxX(phoneIcon.frame) + kFRate(15), labelH)];
//    phoneLabel.textColor = kColorSting(@"666666");
//    phoneLabel.text =  @"电话号码：133333333";
//    phoneLabel.font = kFont30px;
//    [phoneView addSubview:phoneLabel];
//    
//    UIView *phoneline = [[UIView alloc]initWithFrame:CGRectMake(0, labelH - 0.5, kViewWidth, 0.5)];
//    phoneline.backgroundColor = [UIColor lightGrayColor];
//    [phoneView addSubview:phoneline];
//    
//    [middleView addSubview:phoneView];
//    
//    //地址
//    UIView *locationView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(phoneView.frame), kViewWidth, labelH)];
//    locationView.backgroundColor = [UIColor clearColor];
//    
//    UIImageView *locationIcon = [[UIImageView alloc]initWithFrame:CGRectMake(iconX, iconY, iconHW, iconHW)];
//    locationIcon.image = [UIImage imageNamed:@"IWHomeSign"];
//    [locationView addSubview:locationIcon];
//    
//    UILabel *locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(locationIcon.frame) + kFRate(15), 0, kViewWidth - CGRectGetMaxX(locationIcon.frame) + kFRate(15), labelH)];
//    locationLabel.textColor = kColorSting(@"666666");
//    locationLabel.text =  @"深圳龙华坂田布吉A-12-67";
//    locationLabel.font = kFont30px;
//    [locationView addSubview:locationLabel];
//    
//    UIView *locationline = [[UIView alloc]initWithFrame:CGRectMake(0, labelH - 0.5, kViewWidth, 0.5)];
//    locationline.backgroundColor = [UIColor lightGrayColor];
//    [locationView addSubview:locationline];
//    
//    [middleView addSubview:locationView];
//    
//    //绑定点击手势识别 方法tapDetailView
//    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationViewTap:)];
//    tap.delegate = self;
//    // 添加手势识别
//    [locationView addGestureRecognizer:tap];
//    
//}
//#pragma mark
//-(void)addDownViewToHeadView:(UIView *)headView{
//    UIView *selectView =  [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.middleView.frame) + 10, kViewWidth, kFRate(37))];
//    selectView.backgroundColor = [UIColor whiteColor];
//    [headView addSubview:selectView];
//    self.selectView = selectView;
//    
//    
//    //距离最近
//    CGFloat  buttonW = kViewWidth/2.0;
//    CGFloat   viewH = 37;
//    IWNearSelectButton *distanceBTN = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(0, 0,buttonW, viewH)];
//    distanceBTN.index = 0;
//    [distanceBTN setTitle:@"服务" forState:UIControlStateNormal];
//    [distanceBTN setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
//    [distanceBTN addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [selectView addSubview:distanceBTN];
//    
//    //默认选中
//    self.selectButton = distanceBTN;
//    distanceBTN.selected = YES;
//    
//    //折扣最低
//    IWNearSelectButton *discountBTN = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(buttonW, 0,buttonW, viewH)];
//    discountBTN.index = 1;
//    [discountBTN setTitle:@"评论" forState:UIControlStateNormal];
//    [discountBTN setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
//    [discountBTN addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [selectView addSubview:discountBTN];
//    //
//    UIView *line = [[UIView  alloc]init];
//    line.frame =CGRectMake(0, viewH - 0.5, kViewWidth, 0.5);
//    line.backgroundColor = [UIColor grayColor];
//    [selectView addSubview:line];
//}
//
//  APMRecommendMemberListVC.m

//
//  Created by xiaohai on 16/11/16.
//  Copyright © 2016年  All rights reserved.
//  推荐成员
#import "IWNearCityVC.h"
//#import "APMRecommendMemberListVC.h"
#import "AFTSearchBar.h"
#import "MJRefresh.h"
#import "IWNearCityCell.h"
@interface IWNearCityVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

// 所有页签
@property (nonatomic,strong)NSMutableArray *allSection;
// 搜索
@property (nonatomic,strong)AFTSearchBar *searchBar;
// 是否搜索
@property (nonatomic,assign)BOOL isSearch;
//
@property (nonatomic,strong)UITableView *myTableView;
//
@property (nonatomic,strong)ANodataView *noDataView;
// 字典
@property (nonatomic,strong)NSMutableDictionary *dictName;
// 全数据字典
@property (nonatomic,strong)NSMutableDictionary *allDic;
// 页签数组
@property (nonatomic,strong)NSMutableArray *sectionArr;
/**
 *  成员数组
 */
@property (nonatomic,strong)NSMutableArray *dataArray;
// 强制隐藏无数据
@property (nonatomic,assign)BOOL mustHiddenNoDataView;


@end
@implementation IWNearCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    self.title = @"当前城市- 深圳";
    
    // 搜索
    _searchBar = [[AFTSearchBar alloc] initWithFrame:CGRectMake(kFRate(8), 64, kViewWidth - kFRate(16), kFRate(31.5))];
    [_searchBar changeSearchBarBackGroundImage: @"APMMemberSearch_bg" text:@"请输入城市名查找"  bigImage:@"APMSearchBig" hasCenterPlaceholder:NO];
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    
    
    //默认没有搜索
    self.isSearch = NO;
    //初始化
    self.dataArray = [NSMutableArray array];
    self.mustHiddenNoDataView = YES;
    [self createView];
    [self updataData];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
}



#pragma 下发数据
-(void)updataData{
    __weak typeof(self) weakSelf = self;
    [self.view endEditing:YES];
    [[ASingleton shareInstance]startLoadingInView:self.view];
//    [AHttpRequest getWithURL:self.url params:nil success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        [self.dataArray removeAllObjects];
        [self.allSection removeAllObjects];
        [self.sectionArr removeAllObjects];
        self.mustHiddenNoDataView = NO;
//        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"result"]) {
//            [weakSelf failSetupWithMessage:kLanguagePM(@"Failed",@"数据获取失败")];
//            return ;
//        }
//        if ([@"failure" isEqualToStringXH:json[@"result"]]){
//            [weakSelf failSetupWithMessage:json[@"message"]];
//            return ;
//        }
//        NSArray *contentArray = json[@"content"];
//        if (!contentArray || ![contentArray isKindOfClass:[NSArray class]]|| contentArray.count == 0) {
//            [weakSelf failSetupWithMessage:kLanguagePM(@"Failed",@"数据获取失败")];
//            return ;
//        }
    
    self.dataArray =[NSMutableArray arrayWithArray:@[@"深圳",@"北京",@"广州",@"上海",@"深圳",@"天津",@"深圳",@"深圳",@"深圳",@"深圳",@"深圳",@"深圳",@"深圳"]];
    
        self.searchBar.hidden = NO;
    
        _dictName = [NSMutableDictionary dictionaryWithDictionary:[weakSelf dictWithJsonArray:self.dataArray isFirst:YES]];
        _allDic = [NSMutableDictionary dictionaryWithDictionary:[weakSelf dictWithJsonArray:self.dataArray isFirst:YES]];
        
        [self.myTableView reloadData];
//    } failure:^(NSError *error) {
//        [[ASingleton shareInstance] stopLoadingView];
//        
//        [self.memberArray removeAllObjects];
//        [self.allSection removeAllObjects];
//        [self.sectionArr removeAllObjects];
//        [self.selectMemberArray removeAllObjects];
//        
//        [weakSelf failSetupWithMessage:kLanguagePM(@"Failed",@"数据获取失败")];
//        
//        [self.myTableView reloadData];
//    }];
}
//-(void)failSetupWithMessage:(NSString *)message{
//    self.dictName = [NSMutableDictionary dictionaryWithDictionary:[self dictWithJsonArray:self.memberArray isFirst:YES]];
//    self.allDic = [NSMutableDictionary dictionaryWithDictionary:[self dictWithJsonArray:self.memberArray isFirst:YES]];
//    self.mustHiddenNoDataView = NO;
//    self.searchBar.hidden = YES;
//    [self.myTableView reloadData];
//    if (!message || message.length == 0 ) {
//        [self.view showToastWithText:kLanguagePM(@"Failed",@"数据获取失败") time:1.0];
//        return;
//    }
//    [self.view showToastWithText:message time:1.0];
//}

#pragma mark 创建列表
- (void)createView
{

    // 列表
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchBar.frame) + 10, kViewWidth, kViewHeight - CGRectGetMaxY(_searchBar.frame) - 10) style:UITableViewStyleGrouped];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.sectionFooterHeight = 0;
    myTableView.sectionHeaderHeight = 0;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    
    // 全表空设计图片和文字
    self.noDataView = [[ANodataView alloc] initWithFrame:self.myTableView.bounds];
    self.noDataView.backgroundColor = [UIColor clearColor];
    self.noDataView.showRefreshButton = NO;
    self.noDataView.tishiString = @"没有数据";
    //默认隐藏
    self.noDataView.hidden = YES;
    [self.myTableView addSubview:self.noDataView];
    
}
#pragma mark 搜索按钮点击处理
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSMutableArray *searchData = [[NSMutableArray alloc] init];
    //名字
    NSMutableArray *nameArr = [[NSMutableArray alloc] init];
    //拼音
    NSMutableArray *pinYingArr = [[NSMutableArray alloc] init];
    for (NSString *city in self.dataArray) {
        [nameArr addObject:city];
        
        //转成可变字符串
        NSMutableString *mutableNationName = [NSMutableString stringWithString:city];
        //先转换为带声调的拼音
        CFStringTransform((CFMutableStringRef)mutableNationName,NULL, kCFStringTransformMandarinLatin,NO);
        //再转换为不带声调的拼音
        CFStringTransform((CFMutableStringRef)mutableNationName,NULL, kCFStringTransformStripDiacritics,NO);
        //去掉空格
     NSString *namePinYin = [mutableNationName stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        

        [pinYingArr addObject:namePinYin];
    }
    //1.过滤名字
    NSPredicate *preicate = [NSPredicate predicateWithFormat : @"SELF CONTAINS[cd] %@" ,searchBar.text];
    
    NSArray *seachTempArr = [nameArr filteredArrayUsingPredicate:preicate];
    
    for (NSString *city in self.dataArray) {
        for (NSInteger i = 0; i < seachTempArr.count; i++) {
            if ([city isEqualToString:seachTempArr[i]]) {
                [searchData addObject:city];
            }
        }
    }
    //2.过滤拼音
    NSPredicate *pinYingpreicate = [NSPredicate predicateWithFormat : @"SELF CONTAINS[cd] %@" ,searchBar.text];
    NSArray *seachPingYingTempArr = [pinYingArr filteredArrayUsingPredicate:pinYingpreicate];
    //遍历所有数据
    for (NSString *city in self.dataArray) {
        //遍历搜索过滤 符合条件的数据
        for (NSInteger i = 0; i < seachPingYingTempArr.count; i++) {
            //找到具体数据
            if ([city isEqualToString:seachPingYingTempArr[i]]) {
                BOOL isIn = NO;
                //前面已经添加的排除，没有添加的加入
                for (NSString *cityLast in searchData) {
                    if ([cityLast isEqual:city] ) {
                        isIn = YES;
                        break;
                    }
                }
                if (isIn == NO) {
                    [searchData addObject:city];
                }
                
            }
        }
    }
    self.dictName = [self dictWithJsonArray:searchData isFirst:NO];
    //刷新表格
    [self.myTableView reloadData];
}
#pragma mark 搜索文字更改处理
- (void)searchBar:(AFTSearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (self.searchBar.text.length == 0) {
        self.dictName = self.allDic;
        self.sectionArr = self.allSection;
        self.isSearch = NO;
        [self.myTableView reloadData];
    }else{
        //主动调用
        [self searchBarSearchButtonClicked:searchBar];
        self.isSearch = YES;
    }
}
#pragma mark Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [[self.dictName objectForKey:self.sectionArr[section]] count];
    return count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kFRate(62);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWNearCityCell *cell = [IWNearCityCell cellWithTableView:tableView];
    
    NSString *city = [self.dictName objectForKey:self.sectionArr[indexPath.section]][indexPath.row];
    cell.city = city;
    return cell;
}
#pragma mark Cell 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kFRate(21);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark  组个数 ，内部实现空数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger count = self.sectionArr.count;
    if (count == 0){
        if (self.mustHiddenNoDataView) {
            self.noDataView.hidden = YES;
            return count;
        }
        self.noDataView.hidden = NO;
        return count;
    }
    self.noDataView.hidden = YES;
    return count;
}

//添加索引列
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView == self.searchDisplayController.searchResultsTableView){
        return nil;
    }
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.sectionArr];
   
    return tempArray;
}

//索引列点击事件
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    //点击索引，列表跳转到对应索引的行
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    //弹出首字母提示
    //    [self showLetter:title ];
    return index;
}
// 组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return nil;
    }
    //标题背景
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(21))];
    headView.backgroundColor = [UIColor clearColor];
    
    //标题文字
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(kFRate(12), kFRate(3), kViewWidth, kFRate(18))];
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.numberOfLines = 1;
    titleLable.font = kFont30px;
    titleLable.textColor = [UIColor grayColor];
    NSString *tempTitleText = [self.sectionArr objectAtIndex:section];
    
    
        titleLable.text = tempTitleText;
    
    [headView addSubview:titleLable];
    return headView;
}
#pragma mark -- 给对应的json数据排序
- (NSMutableDictionary *)dictWithJsonArray:(NSArray *)array isFirst:(BOOL)first{
    // 01 创建可变字典，存储每一个key对应的数据列表
    NSMutableDictionary *nationWithCodeDicList = [NSMutableDictionary dictionary];
    // 02 遍历数组
    for (NSString *city in array) {
        // 03 得到Name
        NSString *nationName = city;
        // 04 转成可变字符串
        NSMutableString *mutableNationName = [NSMutableString stringWithString:nationName];
        // 05 先转换为带声调的拼音
        CFStringTransform((CFMutableStringRef)mutableNationName,NULL, kCFStringTransformMandarinLatin,NO);
        // 06 再转换为不带声调的拼音
        CFStringTransform((CFMutableStringRef)mutableNationName,NULL, kCFStringTransformStripDiacritics,NO);
        // 07 得到首字母之大写形式并设置为字典的一个key
        NSString *key = [mutableNationName substringToIndex:1].uppercaseString;
        // 08 获取nationWithCodeDicList中key对应的value
        NSMutableArray *nationWithCodeListKey = [nationWithCodeDicList objectForKey:key];
        // 09 若此数组为空，则创建并保存到字典对应的key
        if (nationWithCodeListKey == nil) {
            nationWithCodeListKey = [NSMutableArray array];
            [nationWithCodeDicList setObject:nationWithCodeListKey forKey:key];
        }
        // 10 若有此数组，就把本次遍历得到的数据加入其中
        [nationWithCodeListKey addObject:city];
    }
    // 11 列表中所有的组标题 使用compare得到有顺序的字母数组
    self.sectionArr =[NSMutableArray arrayWithArray:[[nationWithCodeDicList allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    if (first) {
        self.allSection = [NSMutableArray arrayWithArray:[[nationWithCodeDicList allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    }
    return nationWithCodeDicList;
}
@end



