//
//  IWGategoryVC.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/24.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWGategoryVC.h"
#import "IWGategoryCell.h"
#import "IWGategoryModel.h"
#import "IWGategoryOneModel.h"
#import "IWGategoryTwoModel.h"
#import "IWGategoryThreeModel.h"
#import "IWHomeMoreVC.h"

@interface IWGategoryVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
// 列表
@property (nonatomic,weak)UICollectionView *myCollectionView;
// 模型
@property (nonatomic,strong)IWGategoryModel *collecModel;
// 按钮x值
@property (nonatomic,assign)CGFloat btnX;
// 选中状态
@property (nonatomic,weak)UIButton *oldBtn;
// 分类列表
@property (nonatomic,weak)UIView *backView;
// 是否展示分类列表
@property (nonatomic,assign)BOOL isShowGate;
// 展示按钮
@property (nonatomic,weak)UIButton *showBtn;
@property (nonatomic,weak)UIView *showLabelView;
// 分类数据源
@property (nonatomic,strong)NSMutableArray *oneData;
@property (nonatomic,strong)NSMutableArray *towData;
@property (nonatomic,strong)NSMutableArray *threeData;
// 记录点击一级界面的按钮
@property (nonatomic,assign)NSInteger oneTag;
// 分类按钮frame集合
@property (nonatomic,strong)NSMutableArray *btnFArr;
// 分类滑动界面滑动高度
@property (nonatomic,assign)CGFloat scrollH;
// 分类按钮集合
@property (nonatomic,strong)NSMutableArray *gateBtnArr;
// 空设计
@property (nonatomic,weak)ANodataView *noDataView;

@end

@implementation IWGategoryVC
- (NSMutableArray *)oneData
{
    if (_oneData == nil) {
        _oneData = [[NSMutableArray alloc] init];
    }
    return _oneData;
}
- (NSMutableArray *)towData
{
    if (_towData == nil) {
        _towData = [[NSMutableArray alloc] init];
    }
    return _towData;
}
- (NSMutableArray *)threeData
{
    if (_threeData == nil) {
        _threeData = [[NSMutableArray alloc] init];
    }
    return _threeData;
}

// 分解线 背景颜色
#define kLinColor IWColor(240, 240, 240)
- (void)viewDidLoad {
    
    [super viewDidLoad];
    _gateBtnArr = [[NSMutableArray alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"分类";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestOneData];
    [self requestTwoData];
    // 创建表头按钮
    [self creatScrollBtn];
    
    // 列表
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 上左下右(边缘间距)
    layout.sectionInset = UIEdgeInsetsMake(kFRate(7.5), kFRate(15), kFRate(0), kFRate(15));
    // 行间距(cell上下)
    layout.minimumLineSpacing = kFRate(10);
    // 设置
    UICollectionView *myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + kFRate(40), kViewWidth, kViewHeight - 64 - kFRate(40)) collectionViewLayout:layout];
    myCollectionView.backgroundColor = [UIColor whiteColor];
    
    // 注册
    [myCollectionView registerClass:[IWGategoryCell class] forCellWithReuseIdentifier:@"IWDetailsGategoryCell"];
    [myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"IWDetailsGategoryHeader"];
    [myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"IWDetailsGategoryFoot"];
    
    myCollectionView.delegate = self;
    myCollectionView.dataSource = self;
    [self.view addSubview:myCollectionView];
    self.myCollectionView = myCollectionView;
    [self createGategroyView];
    
    //3.无数据时的图标
    ANodataView *noDataView = [[ANodataView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth,kViewHeight - 64)];
    noDataView.backgroundColor = [UIColor whiteColor];
    noDataView.tishiString = @"没有数据";
    //默认隐藏
    noDataView.hidden = YES;
    [self.myCollectionView addSubview:noDataView];
    self.noDataView = noDataView;
        
}

- (void)collectionLeftCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 头部按钮
- (void)creatScrollBtn
{
    // 顶端分界
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kFRate(10))];
    linView.backgroundColor = kLinColor;
    [self.view addSubview:linView];
    _btnX = 0;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + kFRate(10), kViewWidth - kFRate(40), kFRate(30))];
    for (NSInteger i = 0; i < self.oneData.count; i ++) {
        IWGategoryOneModel *oneModel = self.oneData[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(_btnX, 0, oneModel.btnW + kFRate(40), kFRate(30));
        _btnX = _btnX + oneModel.btnW + kFRate(40);
        [btn setTitle:oneModel.cateName forState:UIControlStateNormal];
        [btn setTitleColor:IWColor(134, 134, 134) forState:UIControlStateNormal];
        [btn setTitleColor:IWColor(252, 93, 125) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:kFRate(14)];
        btn.tag = 1000 + i;
        [scrollView addSubview:btn];
    }
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(_btnX, kFRate(30));
    [self.view addSubview:scrollView];
    
    // 当点击展开时覆盖scroll的label
    UIView *showLableView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, kFRate(30))];
    showLableView.hidden = YES;
    showLableView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:showLableView];
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(kFRate(10), 0, scrollView.frame.size.width - kFRate(10), kFRate(30))];
    showLabel.text = @"为您推荐";
    showLabel.textColor = IWColor(140, 140, 140);
    showLabel.font = [UIFont systemFontOfSize:kFRate(14)];
    [showLableView addSubview:showLabel];
    self.showLabelView = showLableView;
    
    // 右边展开/手起按钮
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    showBtn.frame = CGRectMake(kViewWidth - kFRate(40), scrollView.frame.origin.y, kFRate(40), kFRate(30));
    [showBtn setImage:_IMG(@"IWShow") forState:UIControlStateNormal];
    [showBtn setImage:_IMG(@"IWClose") forState:UIControlStateSelected];
    [showBtn addTarget:self action:@selector(isShowClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
    self.showBtn = showBtn;
    
    _oldBtn = [self.view viewWithTag:1000];
    _oldBtn.selected = YES;
    // 默认选择一级界面的第一个按钮
    _oneTag = 0;
}
#pragma mark - 选择商品类型
- (void)topBtnClick:(UIButton *)sender
{
    _oldBtn.selected = NO;
    _oldBtn = sender;
    sender.selected = YES;
    _oneTag = sender.tag - 1000;
    for (NSInteger i = 0; i < self.gateBtnArr.count; i ++) {
        UIButton *btn = self.gateBtnArr[i];
        if (btn.tag - 2000 == _oneTag) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    [self requestTwoData];
    [self.myCollectionView reloadData];
}
- (void)gateBtnClick:(UIButton *)sender
{
    // rop按钮同时变化
    UIButton *tempButton = [self.view viewWithTag:sender.tag - 1000];
    [self topBtnClick:tempButton];
    [self tap];
}
- (void)isShowClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _isShowGate = sender.selected;
    if (_isShowGate) {
        self.backView.hidden = NO;
        self.showLabelView.hidden = NO;
    }else{
        self.backView.hidden = YES;
        self.showLabelView.hidden = YES;
    }
}
#pragma mark - 展示分类按钮
- (void)createGategroyView
{
    // 蒙版
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, kFRate(40) + 64, kViewWidth, kViewHeight - kFRate(50) - 64)];
    backView.backgroundColor = [UIColor clearColor];
    backView.hidden = YES;
    [self.view addSubview:backView];
    self.backView = backView;
    
    // 点击背景取消手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [backView addGestureRecognizer:tap];
    // 屏宽白色背景
    UIView *whiteColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight / 2)];
    whiteColorView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:whiteColorView];
    
    // 分隔线
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(10))];
    linView.backgroundColor = kLinColor;
    [backView addSubview:linView];
    
    // 为您推荐
    UILabel *recommend = [[UILabel alloc] initWithFrame:CGRectMake(kFRate(10), kFRate(20), kViewWidth - kFRate(20), kFRate(25))];
    recommend.text = @"为您推荐";
    recommend.textColor = IWColor(110, 110, 110);
    recommend.font = kFont28pxBold;
    recommend.backgroundColor = [UIColor whiteColor];
    [whiteColorView addSubview:recommend];
    // 按钮滑动背景图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kFRate(10), CGRectGetMaxY(recommend.frame), kViewWidth - kFRate(20), whiteColorView.frame.size.height - CGRectGetMaxY(recommend.frame))];
    scrollView.backgroundColor = [UIColor whiteColor];
    for (NSInteger i = 0; i < self.oneData.count; i ++) {
        IWGategoryOneModel *oneModel = self.oneData[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = [_btnFArr[i] CGRectValue];
        [btn setTitle:oneModel.cateName forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:kFRate(14)];
        btn.tag = 2000 + i;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setTitleColor:IWColor(140, 140, 140) forState:UIControlStateNormal];
        [btn setTitleColor:IWColor(252, 93, 125) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(gateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btn];
        [self.gateBtnArr addObject:btn];
    }
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(kViewWidth - kFRate(20), _scrollH);
    [whiteColorView addSubview:scrollView];
    
    // 滑动框下部分蒙版
    UIView *menView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scrollView.frame), kViewWidth, backView.frame.size.height - CGRectGetMaxY(scrollView.frame) +kFRate(10))];
    menView.backgroundColor = [UIColor blackColor];
    menView.alpha = 0.4f;
    [backView addSubview:menView];
    
    UIButton *tempBtn = [self.view viewWithTag:2000];
    tempBtn.selected = YES;
}

- (void)tap{
    self.backView.hidden = YES;
    self.showBtn.selected = NO;
    self.showLabelView.hidden = YES;
}

#pragma mark - Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.towData.count == 0) {
        self.noDataView.hidden = NO;
    }else{
        self.noDataView.hidden = YES;
    }
    return self.towData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.threeData[section] count];
}
// cell宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kRate(90), kRate(120));
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IWGategoryCell *cell = [[IWGategoryCell alloc] cellWithTableView:collectionView indexPath:indexPath];
    cell.model = self.threeData[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark - 段头段尾
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kViewWidth, kFRate(43));
}

// 头尾创建
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"IWDetailsGategoryHeader" forIndexPath:indexPath];

        reusableView.backgroundColor = [UIColor clearColor];
        
        headerView = reusableView;
    }
    for (UIView *view in headerView.subviews) {
        [view removeFromSuperview];
    }
    // 灰色分界线
    UIView *disView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(10))];
    disView.backgroundColor = kLinColor;
    [headerView addSubview:disView];
    
    // 白底
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, kFRate(10), kViewWidth, kFRate(33))];
    back.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:back];
    
    // 标记线
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(kFRate(17), kFRate(10), kFRate(2), kFRate(13))];
    linView.backgroundColor = IWColor(252, 62, 99);
    [back addSubview:linView];
    
    // 标题
    UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(linView.frame) + kFRate(7), 0, kViewWidth - (CGRectGetMaxX(linView.frame) + kFRate(7)) * 2, kFRate(33))];
    IWGategoryTwoModel *twoModel = self.towData[indexPath.section];
    itemLabel.text = twoModel.cateName;
    itemLabel.font = [UIFont systemFontOfSize:kFRate(14)];
    itemLabel.textColor = [UIColor HexColorToRedGreenBlue:@"#353535"];
    [back addSubview:itemLabel];
    
    // 尾线
    UIView *lastView = [[UIView alloc] initWithFrame:CGRectMake(kFRate(10), kFRate(42.5), kViewWidth - kFRate(20), kFRate(0.5))];
    lastView.backgroundColor = kLineColor;
    [headerView addSubview:lastView];
    
    return headerView;
}

#pragma mark - cell点击

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IWGategoryThreeModel *model = self.threeData[indexPath.section][indexPath.row];
    IWHomeMoreVC *vc = [[IWHomeMoreVC alloc] init];
    vc.regionId = model.cateId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 请求数据
- (void)requestOneData
{
    for (NSDictionary *dic in [ASingleton shareInstance].productCateList) {
        IWGategoryOneModel *oneModel = [[IWGategoryOneModel alloc] initWithDic:dic];
        [self.oneData addObject:oneModel];
    }
    // 分类展示按钮frame集合
    NSInteger linNum;
    if (self.oneData.count % 3 > 0) {
        linNum = self.oneData.count / 3 + 1;
    }else{
        linNum = self.oneData.count / 3;
    }
    // 按钮宽
    CGFloat btnW = (kViewWidth - kFRate(20)) / 3;
    CGFloat btnH = kFRate(25);
    _btnFArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < linNum; i ++) {
        for (NSInteger j = 0; j < 3; j ++) {
            CGRect btnF = CGRectMake(j * btnW, btnH * i, btnW, btnH);
            [_btnFArr addObject:[NSValue valueWithCGRect:btnF]];
        }
    }
    _scrollH = linNum * btnH;
}

- (void)requestTwoData
{
    [self.towData removeAllObjects];
    [self.threeData removeAllObjects];
    IWGategoryOneModel *oneModel = self.oneData[_oneTag];
    if (oneModel.children) {
        for (NSInteger i = 0; i < oneModel.children.count; i ++) {
            NSMutableArray *tempArr = [[NSMutableArray alloc] init];
            IWGategoryTwoModel *twoModel = oneModel.children[i];
            [self.towData addObject:twoModel];
            if (twoModel.children) {
                for (NSInteger j = 0; j < twoModel.children.count; j ++) {
                    IWGategoryThreeModel *threeModel = twoModel.children[j];
                    [tempArr addObject:threeModel];
                }
                [self.threeData addObject:tempArr];
            }else{
                [self.threeData addObject:@[]];
            }
        }
    }
    [self.myCollectionView reloadData];
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
