//
//  IWNearShoppingDetailVC.m
//  IWShopping0221
//
//  Created by s on 17/2/25.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWNearShoppingDetailVC.h"
#import "IWNearSelectButton.h"
#import "IWMapVC.h"
#import "IWNearShoppingDetailServeCell.h"
#import "IWNearShoppingDetailDiscussCell.h"
#import "IWNearCommitBillVC.h"
@interface IWNearShoppingDetailVC ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
//
@property (nonatomic,weak)UITableView *tableView;
// 店铺图片
@property (nonatomic,weak)UIImageView *topView;
// 店铺名称
@property (nonatomic,weak)UILabel *shoppingNameLabel;
// 时间
@property (nonatomic,weak)UILabel *timeLabel;
// 电话
@property (nonatomic,weak)UILabel *phoneLabel;
// 地址
@property (nonatomic,weak)UILabel *locationLabel;
// 距离
@property (nonatomic,weak)UILabel *distanceLabel;
// 中间
@property (nonatomic,weak)UIView *middleView;
// 底部
@property (nonatomic,weak)UIView *downView;

@property (nonatomic,weak)UIView *selectView;
@property (nonatomic,weak)IWNearSelectButton *selectButton;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)UIView *headView;
@property (nonatomic,copy)NSString *phone;



@property (nonatomic,copy)NSString *city ;
@property (nonatomic,copy)NSString *country;
@property (nonatomic,copy)NSString *desc;
@property (nonatomic,copy)NSString *discountRatio;
@property (nonatomic,copy)NSString *district;
@property (nonatomic,copy)NSString *province;
@property (nonatomic,copy)NSString *shopAddress;
@property (nonatomic,copy)NSString *shopId;
@property (nonatomic,copy)NSString *shopLevel;
@property (nonatomic,copy)NSString *shopLogo;
@property (nonatomic,copy)NSString *shopName;
@property (nonatomic,copy)NSString *shopNum;
@property (nonatomic,copy)NSString *shopOfiiceTime;
@property (nonatomic,copy)NSString *shopPhone;
@property (nonatomic,copy)NSString *shopQrCode;
@property (nonatomic,copy)NSString *shopSummary;
@property (nonatomic,copy)NSString *shopTel;
@property (nonatomic,copy)NSString *shopType;
@property (nonatomic,copy)NSString *shopUrl;
@property (nonatomic,copy)NSString *shopX;
@property (nonatomic,copy)NSString *shopY;
// 加载更多页书
@property (nonatomic,assign)NSInteger pageNum;
// 刷新当前数据(并非加载更多)
@property (nonatomic,assign)BOOL isRefreshData;
//服务
@property (nonatomic,copy)NSString *shopDescUrl;

//service Cell 高度
@property (nonatomic,assign)CGFloat serviceCellH;

@property (nonatomic,strong)IWNearSelectButton *discountBTN;

@end

@implementation IWNearShoppingDetailVC

#define kNearShoppingDetailHeadViewH  kFRate(200 + 10 + 135+ 10 + 37)
-(instancetype)initWithShopId:(NSString *)shopId{
    self = [super init];
    if (self) {
        _shopId =shopId;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺详情";
    self.view.backgroundColor = [UIColor whiteColor];
    //我要买单
    UIButton *payButton = [[UIButton alloc]initWithFrame:CGRectMake(0, kViewHeight - 40, kViewWidth, 40)];
    [self.view addSubview:payButton];
    payButton.backgroundColor = IWColorRed;
    [payButton addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
    [payButton setTitle:@"我要买单" forState:UIControlStateNormal];
    payButton.titleLabel.font = kFont28px;
    payButton.titleLabel.textColor = [UIColor whiteColor];
    
    self.pageNum = 1;
    self.isRefreshData = YES;
    
    //添加列表
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64 - 40) style:UITableViewStylePlain];
    //去掉下划线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 0.01);
    tableView.userInteractionEnabled = YES;
    self.tableView = tableView;
    
    self.tableView.tableHeaderView = self.headView;
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    
    
    self.dataArray = [NSMutableArray array];
    
    [self downData];
    
    // 通知返回webView的高度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webViewH:) name:@"IWNearShoppingDetailSerceWebViewHeight" object:nil];
}
     
- (void)webViewH:(NSNotification *)no
{
    self.serviceCellH = [no.userInfo[@"webViewH"] floatValue];
    [self.tableView reloadData];
    IWLog(@"%@",no.userInfo[@"webViewH"]);
}
-(void)downData{
    
    NSString *url = [NSString stringWithFormat:@"%@/store/getStoreDetail?shopId=%@",kNetUrl,self.shopId];
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        
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
        
        
        
        self.city =  contentDict[@"city"]?contentDict[@"city"]:@"";
        self.country = contentDict[@"country"]?contentDict[@"country"]:@"";
        self.desc = contentDict[@"desc"]?contentDict[@"desc"]:@"";
        self.discountRatio = contentDict[@"discountRatio"]?contentDict[@"discountRatio"]:@"";
        self.district = contentDict[@"district"]?contentDict[@"district"]:@"";
        self.province = contentDict[@"province"]?contentDict[@"province"]:@"";
        self.shopAddress = contentDict[@"shopAddress"]?contentDict[@"shopAddress"]:@"";
        //        self.shopId = contentDict[@"shopId"]?contentDict[@"shopId"]:@"";
        self.shopLevel = contentDict[@"shopLevel"]?contentDict[@"shopLevel"]:@"";
        self.shopLogo = contentDict[@"shopLogo"]?contentDict[@"shopLogo"]:@"";
        self.shopName = contentDict[@"shopName"]?contentDict[@"shopName"]:@"";
        self.shopNum = contentDict[@"shopNum"]?contentDict[@"shopNum"]:@"";
        self.shopOfiiceTime = contentDict[@"shopOfiiceTime"]?contentDict[@"shopOfiiceTime"]:@"";
        self.shopPhone =contentDict[@"shopPhone"]?contentDict[@"shopPhone"]:@"";
        self.shopQrCode = contentDict[@"shopQrCode"]?contentDict[@"shopQrCode"]:@"";
        self.shopSummary = contentDict[@"shopSummary"]?contentDict[@"shopSummary"]:@"";
        self.shopTel = contentDict[@"shopTel"]?contentDict[@"shopTel"]:@"";
        self.shopType = contentDict[@"shopType"]?contentDict[@"shopType"]:@"";
        //        self.shopUrl = contentDict[@"shopUrl"]?contentDict[@"shopUrl"]:@"";
        self.shopX = contentDict[@"shopX"]?contentDict[@"shopX"]:@"";
        self.shopY = contentDict[@"shopY"]?contentDict[@"shopY"]:@"";
        
        self.shopDescUrl  = contentDict[@"shopDescUrl"]?contentDict[@"shopDescUrl"]:@"";
        /*city = "\U6df1\U5733";
         country = "\U4e2d\U56fd";
         desc = "\U5f88\U68d2\Uff0c\U73af\U5883\U5f88\U597d";
         discountRatio = 90;
         district = "\U9f99\U534e\U65b0\U533a";
         province = "\U5e7f\U4e1c";
         shopAddress = "\U6c11\U6cbb\U8857\U9053\U4eba\U6c11\U8def\U4e0a\U5858\U4e1c\U9f99\U65b0\U6751\U91d1\U7687\U9152\U5e97\U5927\U5385\U53f3\U4fa7\t";
         shopId = 1;
         shopLevel = 5;
         shopLogo = "73178cb6-2c47-41cb-9ee1-ab80e0eec3f9";
         shopName = "\U9f99\U534e\U548c\U695a\U5c45\U9526\U7ee3\U6c5f\U5357";
         shopNum = 1;
         shopOfiiceTime = "9:00-22:00";
         shopPhone = 18565660736;
         shopQrCode = "";
         shopSummary = "\U4e3b\U6253\U6e58\U83dc\U62db\U724c\Uff0c\U5241\U6912\U9c7c\U5934\Uff0c\U519c\U5bb6\U5c0f\U7092\U8089";
         shopTel = "0755-83749303";
         shopType = 2;
         shopUrl = "";
         shopX = "114.031949";
         shopY = "22.643367";*/
        
        [self.topView sd_setImageWithURL:[NSURL URLWithString:kImageTotalUrl(self.shopLogo)] placeholderImage:[UIImage imageNamed:@"IWHomeSign"]];
        // 店铺名称
        self.shoppingNameLabel.text = self.shopName;

        if (self.shopName && self.shopName.length > 16) {
            self.shoppingNameLabel.font = kFont24px;
        }else{
            self.shoppingNameLabel.font = kFont30px;
        }
        
        // 时间
        self.timeLabel.text = self.shopOfiiceTime;
        // 电话
        self.phoneLabel.text = self.shopPhone;
        // 地址
        self.locationLabel.text = self.shopAddress;
        // 距离
        self.distanceLabel.text = @"不知道那个参数";
        
        IWLog(@"线程线程  %@",[NSThread currentThread]);
        [self.tableView reloadData];
        
        [self getDiscussData];
        
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [weakSelf failSetup];
    }];
}

#pragma mark - 评价
-(void)getDiscussData{
    if (!_isRefreshData) {
        if (self.pageNum == 1 && self.dataArray.count > 0) {
            self.pageNum = 2;
        }
    }
    NSString *url = [NSString stringWithFormat:@"%@/store/getStoreEvaluate?shopId=%@",kNetUrl,self.shopId];
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        IWLog(@"json===%@",json);
        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"data"]) {
            [weakSelf failSetup];
            return ;
        }
        if (![@"0" isEqual:json[@"code"]]){
            [weakSelf failSetup];
            return ;
        }
        NSArray *dataArr = json[@"data"];
        if (dataArr.count == 0) {
            [weakSelf failSetup];
            return ;
        }
        
        for (NSDictionary *dict in dataArr) {
            IWNearShoppingDetailDiscussModel *model = [IWNearShoppingDetailDiscussModel modelWithDic:dict];
            [self.dataArray addObject:model];
        }
        if (!_isRefreshData && dataArr.count > 0) {
            weakSelf.pageNum ++;
            
        }
        if (dataArr.count > 0)
        [self.discountBTN setTitle:[NSString stringWithFormat:@"评论(%ld)",dataArr.count] forState:UIControlStateNormal];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [weakSelf failSetup];
        return ;
    }];
}

#pragma mark 失败处理
-(void)failSetup{
    if (!_isRefreshData) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"加载完毕,没有更多数据"];
    }
    [self.tableView reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.001;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.selectButton.index == 0) {
        
        IWNearShoppingDetailServeCell *cell = [IWNearShoppingDetailServeCell cellWithTableView:tableView height:kFRate(400)];
        
        cell.urlString = self.shopDescUrl;
        
        return cell;
        
    }
    
    IWNearShoppingDetailDiscussCell *cell = [IWNearShoppingDetailDiscussCell cellWithTableView:tableView];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.selectButton.index == 0)
        return 1;
    else
        return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectButton.index == 0)
        return self.serviceCellH;
    
    IWNearShoppingDetailDiscussModel *model = self.dataArray[indexPath.row];
    return model.cellH;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
-(UIView *)headView{
    if (!_headView) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kNearShoppingDetailHeadViewH)];
        headView.backgroundColor = kColorSting(@"f2f2f2");
        [self addTopViewToHeadView:headView];
        [self addMiddleViewToHeadView:headView];
        [self addDownViewToHeadView:headView];
        _headView = headView;
    }
    return _headView;
}
#pragma mark
-(void)addTopViewToHeadView:(UIView *)headView{
    UIImageView *topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(200))];
    topView.contentMode = UIViewContentModeScaleAspectFit;
    [topView sd_setImageWithURL:[NSURL URLWithString:@"http://pic33.photophoto.cn/20141204/0005018356673635_b.jpg"] placeholderImage:[UIImage imageNamed:@"http://pic33.photophoto.cn/20141204/0005018356673635_b.jpg"]];
    [headView addSubview:topView];
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0,kFRate(147.5) + kFRate(52.5/2), kViewWidth, kFRate(52.5/2))];
    grayView.backgroundColor = [UIColor blackColor];
    grayView.alpha = 0.8;
    [topView addSubview:grayView];
    self.topView = topView;
    
    UILabel *shoppingNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kFRate(10),kFRate(0), kViewWidth - kFRate(10), kFRate(52.5/2))];
    shoppingNameLabel.backgroundColor = [UIColor clearColor];
    shoppingNameLabel.text = @"";
    [grayView addSubview:shoppingNameLabel];
    shoppingNameLabel.font = kFont30px;
    shoppingNameLabel.textColor = kColorSting(@"ffffff");
    
    self.shoppingNameLabel = shoppingNameLabel;
    
    //    UIImageView *locationView = [[UIImageView alloc]initWithFrame:CGRectMake(kFRate(10), CGRectGetMaxY(shoppingNameLabel.frame) + 2 , kFRate(10), kFRate(13))];
    //    locationView.image = [UIImage imageNamed:@"IWNearShoppingDeatilLocation"];
    //    [grayView addSubview:locationView];
    //
    //
    //    UILabel *distanceLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(locationView.frame) + kFRate(5), CGRectGetMaxY(shoppingNameLabel.frame) - 5 , kViewWidth - CGRectGetMaxX(locationView.frame) + kFRate(5), kFRate(52.5) - CGRectGetHeight(shoppingNameLabel.frame))];
    //    distanceLabel.text = @"附近500m";
    //    distanceLabel.font = kFont24px;
    //    distanceLabel.textColor = kColorSting(@"ffffff");
    //    self.distanceLabel = distanceLabel;
    //    [grayView addSubview:distanceLabel];
    
    
}
#pragma mark
-(void)addMiddleViewToHeadView:(UIView *)headView{
    
    UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + kFRate(10), kViewWidth, kFRate(135))];
    middleView.backgroundColor = [UIColor whiteColor];
    [headView addSubview: middleView];
    self.middleView = middleView;
    
    CGFloat iconX = kFRate(10);
    CGFloat iconY  = kFRate(11.5);
    CGFloat iconHW  = kFRate(22);
    CGFloat labelH = kFRate(45);
    //营业时间
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, labelH)];
    timeView.backgroundColor = [UIColor clearColor];
    
    UIImageView *timeIcon = [[UIImageView alloc]initWithFrame:CGRectMake(iconX, iconY, iconHW, iconHW)];
    timeIcon.image = [UIImage imageNamed:@"IWNearShoppingDeatilTime"];
    [timeView addSubview:timeIcon];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeIcon.frame) + kFRate(15), 0, kViewWidth - CGRectGetMaxX(timeIcon.frame) + kFRate(15), labelH)];
    timeLabel.textColor = kColorSting(@"666666");
//    timeLabel.text =  @"营业时间： 09：00 - 20：00";
    timeLabel.text =  @" ";
    timeLabel.font = kFont30px;
    [timeView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UIView *timeline = [[UIView alloc]initWithFrame:CGRectMake(0, labelH - 0.5, kViewWidth, 0.5)];
    timeline.backgroundColor = [UIColor lightGrayColor];
    [timeView addSubview:timeline];
    
    [middleView addSubview:timeView];
    
    
    //电话号码
    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(timeView.frame), kViewWidth, labelH)];
    phoneView.backgroundColor = [UIColor clearColor];
    
    UIImageView *phoneIcon = [[UIImageView alloc]initWithFrame:CGRectMake(iconX, iconY, iconHW, iconHW)];
    phoneIcon.image = [UIImage imageNamed:@"IWNearShoppingPhone"];
    [phoneView addSubview:phoneIcon];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneIcon.frame) + kFRate(15), 0, kViewWidth - CGRectGetMaxX(phoneIcon.frame) + kFRate(15), labelH)];
    phoneLabel.textColor = kColorSting(@"666666");
//    phoneLabel.text = [NSString stringWithFormat:@"电话号码：%@",self.shopPhone];
    phoneLabel.text = @"";
    phoneLabel.font = kFont30px;
    [phoneView addSubview:phoneLabel];
    self.phoneLabel = phoneLabel;
    
    
    CGFloat nextW = kRate(9);
    CGFloat nextH = kFRate(17.5);
    CGFloat nextX = kViewWidth - kFRate(13) - nextW;
    CGFloat nextY = (CGRectGetHeight(phoneView.frame) - nextH)/2.0;
    
    
    UIImageView *nextView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"IWNearShoppingDetailNext"]];
    nextView.frame = CGRectMake(nextX, nextY,nextW, nextH);
    [phoneView addSubview:nextView];
    
    
    
    UIView *phoneline = [[UIView alloc]initWithFrame:CGRectMake(0, labelH - 0.5, kViewWidth, 0.5)];
    phoneline.backgroundColor = [UIColor lightGrayColor];
    [phoneView addSubview:phoneline];
    
    [middleView addSubview:phoneView];
    
    //绑定点击手势识别 方法PhoneViewTap
    UIGestureRecognizer *tapPhone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PhoneViewTap:)];
    tapPhone.delegate = self;
    // 添加手势识别
    [phoneView addGestureRecognizer:tapPhone];
    
    
    //地址
    UIView *locationView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(phoneView.frame), kViewWidth, labelH)];
    locationView.backgroundColor = [UIColor clearColor];
    locationView.userInteractionEnabled = YES;
    
    UIImageView *locationIcon = [[UIImageView alloc]initWithFrame:CGRectMake(iconX, iconY, kFRate(17), kFRate(23))];
    locationIcon.image = [UIImage imageNamed:@"IWNearShoppingDeatilLocationDetail"];
    [locationView addSubview:locationIcon];
    locationView.userInteractionEnabled = YES;
    
    UILabel *locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(locationIcon.frame) + kFRate(15), 0, kViewWidth - CGRectGetMaxX(locationIcon.frame) - kFRate(15), labelH)];
    locationLabel.textColor = kColorSting(@"666666");
//    locationLabel.text =  @"深圳龙华坂田布吉A-12-67";
     locationLabel.text =  @"";
    locationLabel.font = kFont30px;
    [locationView addSubview:locationLabel];
    self.locationLabel = locationLabel;
    locationLabel.userInteractionEnabled = YES;
    
    UIImageView *nextPhoneView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"IWNearShoppingDetailNext"]];
    nextPhoneView.frame = CGRectMake(nextX, nextY,nextW, nextH);
    [locationView addSubview:nextPhoneView];
    nextPhoneView.userInteractionEnabled = YES;
    
    
    UIView *locationline = [[UIView alloc]initWithFrame:CGRectMake(0, labelH - 0.5, kViewWidth, 0.5)];
    locationline.backgroundColor = [UIColor lightGrayColor];
    [locationView addSubview:locationline];
    locationline.userInteractionEnabled = YES;
    
    [middleView addSubview:locationView];
    
    //绑定点击手势识别 方法tapDetailView
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationViewTap:)];
    tap.delegate = self;
    // 添加手势识别
    [locationView addGestureRecognizer:tap];
    
}
#pragma mark
-(void)addDownViewToHeadView:(UIView *)headView{
    UIView *selectView =  [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.middleView.frame) + 10, kViewWidth, kFRate(37))];
    selectView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:selectView];
    self.selectView = selectView;
    
    
    //服务
    CGFloat  buttonW = kViewWidth/2.0;
    CGFloat   viewH = 37;
    IWNearSelectButton *distanceBTN = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(0, 0,buttonW, viewH)];
    distanceBTN.index = 0;
    [distanceBTN setTitle:@"服务" forState:UIControlStateNormal];
    [distanceBTN setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
    [distanceBTN addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:distanceBTN];
    
    //默认选中
    self.selectButton = distanceBTN;
    distanceBTN.selected = YES;
    
    //评论
    IWNearSelectButton *discountBTN = [[IWNearSelectButton alloc]initWithFrame:CGRectMake(buttonW, 0,buttonW, viewH)];
    discountBTN.index = 1;
    [discountBTN setTitle:@"评论" forState:UIControlStateNormal];
    [discountBTN setImage:[UIImage imageNamed:@"nearSelectDown"] forState:UIControlStateSelected];
    [discountBTN addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.discountBTN = discountBTN;
    [selectView addSubview:discountBTN];
    //
    UIView *line = [[UIView  alloc]init];
    line.frame =CGRectMake(0, viewH - 0.5, kViewWidth, 0.5);
    line.backgroundColor = [UIColor grayColor];
    [selectView addSubview:line];
}
#pragma mark 中间按钮点击
-(void)selectButtonClick:(IWNearSelectButton *)button{
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
  
    if (self.dataArray.count == 0 && self.selectButton.index == 1) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"暂无评价"];
    }
    [self.tableView reloadData];
}
#pragma mark 位置点击
-(void)locationViewTap:(UIGestureRecognizer *)tap{
    IWMapVC  *mapVC = [[IWMapVC alloc]initWithCoordinateX:self.shopY coordinateY:self.shopX locationName:self.shopName];
    [self.navigationController pushViewController:mapVC animated:YES];
}
#pragma mark 电话点击
-(void)PhoneViewTap:(UIGestureRecognizer *)tap{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.shopPhone]]];
}

#pragma mark 我要买单
-(void)payClick:(UIButton *)button{
    
    IWNearCommitBillVC *billVC = [[IWNearCommitBillVC alloc]initWithName:self.shopName andShoppingId:self.shopNum];
    [self.navigationController pushViewController:billVC animated:YES];
    
}

@end
