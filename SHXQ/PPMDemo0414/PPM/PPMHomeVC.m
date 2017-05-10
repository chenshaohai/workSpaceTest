//
//  EPResearchMobileBaseVC.m
//  E-Platform
//
//  Created by Apple on 2017/02/14.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import "PPMHomeVC.h"
#import "EPResearchMobileTabBar.h"
#import "EPCardTabModel.h"
#import "UIViewController+BackButtonHandler.h"
#import "EPRMNavSelectView.h"
#import "UIViewController+DismissKeyboard.h"

#import "EPPmStatisticsView.h"
#import "EPObStatisticsView.h"
#import "BookObtain.h"

static const NSInteger contentViewTagSux = 2345;

@interface PPMHomeVC ()
<EPCardTabBarDelegate,UIScrollViewDelegate,EPRMNavSelectViewDelegate>

@property (nonatomic, strong) EPResearchMobileTabBar *cardTabBar;
@property (nonatomic, strong) UIScrollView  *scrollView;
//保存上个页面的导航栏颜色
@property (nonatomic, strong) UIColor *navBarColor;
//保存刚进入页面时导航控制器中VC个数
@property (nonatomic, assign) NSInteger currentVCCount;


@property (nonatomic, assign) NSInteger seleteTab;
@property (nonatomic, strong) NSMutableArray *tabDatas;

@end

@implementation PPMHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =
    
    COLOR_HEX(0xf5f5f5);
    
    [self configSubViews];
    [self creatDatas];
    [self setupForDismissKeyboard];
    //去掉顶部空白
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = COLOR_HEX(0x29324c);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //返回上级页面时才重置导航栏颜色
    if (_currentVCCount > self.navigationController.viewControllers.count) {
        self.navigationController.navigationBar.barTintColor = self.navBarColor;
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}


- (void)creatDatas
{
    self.tabDatas = [[NSMutableArray alloc]init];
    self.seleteTab = 0;
    NSArray *tabDatas = @[
                         @{@"tabTitle": @"项目",
                           @"navTitle": @"项目",
                           @"imgUrl": @"EPRMProgect_hui",
                           @"selectImgUrl": @"EPRMProgect",
                           @"contentViewType":@"EPObPartProjectView",
                           },
                         
                         @{@"tabTitle": @"审批",
                           @"navTitle": @"审批",
                           @"imgUrl": @"EPRMStatistics_hui",
                           @"selectImgUrl": @"EPRMStatistics",
                           @"contentViewType":@"EPObStatisticsView",
                           
                           }
                         ];
    
    
    for (NSInteger i = 0; i < tabDatas.count; i++) {
        EPCardTabModel *model = [EPCardTabModel modelWithDic:tabDatas[i] target:nil];
        if (i == 0) {
            model.isSelect = YES;
        }
        [self.tabDatas addObject:model];
        
        [self configContentViewsWithType:model.contentViewType index:i];
    }
    
    [self refreshTabViews];
}

- (void)configSubViews {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navBarColor = self.navigationController.navigationBar.barTintColor;
    self.currentVCCount = self.navigationController.viewControllers.count;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.cardTabBar];

}

- (void)configContentViewsWithType:(EPRMContentViewType)type index:(NSInteger)index
{
    UIView *contentView = [self.view viewWithTag:type + contentViewTagSux];
    if ([self.scrollView.subviews containsObject:contentView]) {
        [self.scrollView bringSubviewToFront:contentView];
        return;
    }
    switch (type) {
        //项目
        case EPRMContentViewType_ObProject:
        {
            EPPmStatisticsView *view = [[EPPmStatisticsView alloc]initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT)];
            view.tag = EPRMContentViewType_PmStatistics + contentViewTagSux;
            view.backgroundColor = COLOR_HEX(0xf5f5f5);
            view.weakVC = self;
            [self.scrollView addSubview:view];
         
        }
            break;
            
       //审批
        case EPRMContentViewType_ObStatistics:
        {
            EPObStatisticsView *view = [[EPObStatisticsView alloc]initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT)];
            view.backgroundColor = COLOR_HEX(0xf5f5f5);
            view.weakVC = self;
            view.tag = EPRMContentViewType_ObStatistics + contentViewTagSux;
            [self.scrollView addSubview:view];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 初始化视图

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        _scrollView.backgroundColor = COLOR_HEX(0xf5f5f5);
        
    }
    return _scrollView;
}

- (EPResearchMobileTabBar *)cardTabBar {
    if (!_cardTabBar) {
        _cardTabBar = [[EPResearchMobileTabBar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TABBAR_HEIGHT - NAVBAR_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT)];
        _cardTabBar.hidden = YES;
        _cardTabBar.delegate = self;
    }
    return _cardTabBar;
}


#pragma mark - 数据处理

- (void)refreshTabViews
{
    //scrollView
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.tabDatas.count, SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT);
    //cardTabbar
    self.cardTabBar.hidden = NO;
    [self.cardTabBar loadDataWithDatas:self.tabDatas];
    [self clickTabItemWithIndex:0];
}

- (void)refreshNavViewsWithTabModel:(EPCardTabModel *)tabModel
{
    self.title = tabModel.navTitle;
    self.navigationItem.rightBarButtonItem = nil;
}


- (BOOL)navigationShouldPopOnBackButton
{
    self.navigationController.navigationBar.barTintColor = self.navBarColor;
    return YES;
}

#pragma mark - scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX/SCREEN_WIDTH;
    self.cardTabBar.selectItem = index;
    [self.cardTabBar chageSelectStatus];
    self.seleteTab = index;
    EPCardTabModel *tabModel = self.tabDatas[index];
    [self refreshNavViewsWithTabModel:tabModel];
}
#pragma mark - cardTabBar代理
- (void)clickTabItemWithIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
    self.seleteTab = index;
    EPCardTabModel *tabModel = self.tabDatas[index];
    [self refreshNavViewsWithTabModel:tabModel];
    
    Book  *aa = [BookObtain bookWithurl:@"fdafdsaf"];
    
    NSLog(@"%@",aa.name);
    
    if (aa) {
     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"fdafdas" message:@"fdafdas" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert show];
        
        
    }
    
}



@end
