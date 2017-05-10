//
//  IWMeVC.m
//  shopping201702
//
//  Created by s on 17/2/21.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMeVC.h"
#import "IWBatesButton.h"
#import "IWMeCollectVC.h"
#import "IWMeOrderFormVC.h"
#import "IWMeBackVC.h"
#import "IWOpinionVC.h"
#import "IWMyPurseVC.h"
#import "IWRecordVC.h"
#import "IWAddressVC.h"
#import "IWLoginVC.h"
#import "IWMePersonCentreVC.h"
#import "IWWebViewVC.h"
@interface IWMeVC ()


/**
 * 大的头像
 */
@property (nonatomic,weak)UIImageView *topView;
/**
 * 小的头像
 */
@property (nonatomic,weak)UIImageView *userIcon;
//昵称
@property (nonatomic,weak)UILabel *userName;


/**
 *
 */
@property (nonatomic,weak)UIView *middleView;
/**
 *
 */
@property (nonatomic,weak)UIView *downView;

/**
 *
 */
@property (nonatomic,weak)UIScrollView *myScrollView;

@end

@implementation IWMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kViewWidth,kViewHeight  - 49 - 20)];
    
    myScrollView.backgroundColor = kColorRGB(239, 239, 239);
    myScrollView.bounces = NO;
    myScrollView.showsHorizontalScrollIndicator = YES;
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(kViewWidth, kFRate(580 + 55));
    [self.view addSubview: myScrollView];
    self.myScrollView = myScrollView;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addTopView];
    [self addMiddleView];
    [self addDownView];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
#warning 0419
    //不需要刷新
//    if (![ASingleton shareInstance].meVCNeedRefresh) {
//        return;
//    }
    
    //需要刷新
    //更改 界面的数据
    //    图片
    NSString *imageName =  [ASingleton shareInstance].loginModel.userImg;
    if (imageName && ![imageName isEqualToString:@""]) {
        [self.userIcon sd_setImageWithURL:[NSURL URLWithString:kImageTotalUrl([ASingleton shareInstance].loginModel.userImg]) placeholderImage:[UIImage imageNamed:@"IWTouXiang"]];
         }else{
             self.userIcon.image =[UIImage imageNamed:@"IWTouXiang"];
         }
    
    //昵称
    self.userName.text = [ASingleton shareInstance].loginModel.nickName;
    
    //不再刷新
    [ASingleton shareInstance].meVCNeedRefresh = NO;
    
    
}

#pragma mark - 顶部视图
-(void)addTopView{
    
    //模糊底图
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(190))];
    
//       [topView sd_setImageWithURL:[NSURL URLWithString:kImageTotalUrl([ASingleton shareInstance].loginModel.userImg)] placeholderImage:[UIImage imageNamed:@"IWuctbg"]];
    topView.image = [UIImage imageNamed:@"IWuctbg"];
       
    topView.contentMode = UIViewContentModeScaleAspectFill;
    topView.userInteractionEnabled = YES;
    [self.myScrollView addSubview:topView];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = topView.bounds;
    [topView addSubview:effectView];
    
    [self.myScrollView addSubview:topView];
    self.topView = topView;
    
    //头像
    CGFloat userIconWH = kFRate(76);
    UIImageView *userIcon = [[UIImageView alloc]initWithFrame:CGRectMake((kViewWidth - userIconWH)/2, kFRate(15), userIconWH, userIconWH)];
    NSString *imageName =  [ASingleton shareInstance].loginModel.userImg;
    if (imageName && ![imageName isEqualToString:@""]) {
        [userIcon sd_setImageWithURL:[NSURL URLWithString:kImageTotalUrl([ASingleton shareInstance].loginModel.userImg]) placeholderImage:[UIImage imageNamed:@"IWTouXiang"]];
         }else{
             userIcon.image =[UIImage imageNamed:@"IWTouXiang"];
         }
    userIcon.layer.cornerRadius = userIconWH/2;
    userIcon.clipsToBounds = YES;
    [topView addSubview:userIcon];
    self.userIcon = userIcon;
    
    
    userIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconTap:)];
    [userIcon addGestureRecognizer:tap];
    
    
    
    //昵称
    UILabel *userName = [[UILabel alloc]init];
    userName.text = @"";
    userName.font = kFont28px;
    userName.textColor = kColorSting(@"ffffff");
    userName.textAlignment = NSTextAlignmentCenter;
    [userName sizeToFit];
    
    userName.frame =CGRectMake(0, CGRectGetMaxY(userIcon.frame) + kFRate(9),kViewWidth, kFRate(16));
    [topView addSubview:userName];
    self.userName = userName;
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(userName.frame) + kFRate(12), kViewWidth, 1)];
    
    
    line.backgroundColor = kColorRGBA(255, 255, 255, 0.5);
    [topView addSubview:line];
    
    CGFloat buttonW = kFRate(30);
    CGFloat buttonH = kFRate(50);
    CGFloat padding = (kViewWidth - 3 * buttonW)/4;
    CGFloat buttonY = CGRectGetMaxY(line.frame) + kFRate(9);
    
    CGFloat iconW = kFRate(21);
    CGFloat iconH = kFRate(25);
    CGFloat iconX = kFRate(2.5);
    CGFloat iconY = 0;
    
    CGFloat textW = buttonW;
    CGFloat textnH = kFRate(14);
    CGFloat textX = 0;
    CGFloat textY = buttonH -textnH;
    
    IWBatesButton *buttonCollect = [[IWBatesButton alloc]initFrame:CGRectMake(padding, buttonY, buttonW, buttonH) Icon:@"IWMe16" selectIcon:nil iconFrame:CGRectMake(iconX, iconY, iconW, iconH) title:@"收藏" titleFrame:CGRectMake(textX, textY,textW, textnH) titleFont:kFont28px titleColor:kColorSting(@"ffffff") titleSelectColor:nil seleTitle:nil];
    buttonCollect.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [buttonCollect addTarget:self action:@selector(buttonCollectClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:buttonCollect];
    
    
    IWBatesButton *buttonMoney = [[IWBatesButton alloc]initFrame:CGRectMake(padding + (padding + buttonW), buttonY, buttonW, buttonH) Icon:@"IWMe15" selectIcon:nil iconFrame:CGRectMake(iconX, iconY, iconW, iconH) title:@"钱包" titleFrame:CGRectMake(textX, textY,textW, textnH) titleFont:kFont28px titleColor:kColorSting(@"ffffff") titleSelectColor:nil seleTitle:nil];
    buttonMoney.titleLabel.textAlignment = NSTextAlignmentCenter;
    [buttonMoney addTarget:self action:@selector(buttonMoneyClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:buttonMoney];
    
    
    IWBatesButton *buttonMember = [[IWBatesButton alloc]initFrame:CGRectMake(padding + 2 * (padding + buttonW), buttonY, buttonW, buttonH) Icon:@"IWMe14" selectIcon:nil iconFrame:CGRectMake(iconX, iconY, iconW, iconH) title:@"账单" titleFrame:CGRectMake(textX, textY,textW, textnH) titleFont:kFont28px titleColor:kColorSting(@"ffffff") titleSelectColor:nil seleTitle:nil];
    [buttonMember addTarget:self action:@selector(buttonMemberClick:) forControlEvents:UIControlEventTouchUpInside];
    buttonMember.titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:buttonMember];
    
}

#pragma mark - 头像点击
-(void)userIconTap:(UIGestureRecognizer *)tap{
    if (![ASingleton shareInstance].loginModel) {
        IWLoginVC  *login = [[IWLoginVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    
    IWMePersonCentreVC  *login = [[IWMePersonCentreVC alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}
#pragma mark - 收藏
-(void)buttonCollectClick:(IWBatesButton *)button{
    
    if (![ASingleton shareInstance].loginModel) {
        IWLoginVC  *login = [[IWLoginVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    
    IWMeCollectVC  *myCollectVC = [[IWMeCollectVC alloc]init];
    
    [self.navigationController pushViewController:myCollectVC animated:YES];
    
}
#pragma mark -钱包
-(void)buttonMoneyClick:(IWBatesButton *)button{
    
    if (![ASingleton shareInstance].loginModel) {
        IWLoginVC  *login = [[IWLoginVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    IWMyPurseVC *purseVC = [[IWMyPurseVC alloc] init];
    [self.navigationController pushViewController:purseVC animated:YES];
}
#pragma mark - 会员
-(void)buttonMemberClick:(IWBatesButton *)button{
    if (![ASingleton shareInstance].loginModel) {
        IWLoginVC  *login = [[IWLoginVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    
    IWRecordVC *recordVC = [[IWRecordVC alloc] init];
    [self.navigationController pushViewController:recordVC animated:YES];
    
}
#pragma mark - 中间视图
-(void)addMiddleView{
    
    UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + kFRate(10), kViewWidth, kFRate(29 + 92 + 10))];
    middleView.backgroundColor = [UIColor whiteColor];
    [self.myScrollView addSubview:middleView];
    self.middleView = middleView;
    
    
    UIImageView * myDingDan= [[UIImageView alloc]initWithFrame:CGRectMake(kFRate(10), kFRate(8),kFRate(19), kFRate(23))];
    myDingDan.image = [UIImage imageNamed:@"订单icon"];
    [middleView addSubview:myDingDan];
    
    
    UILabel *myDingDanLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(myDingDan.frame)+ kFRate(5),kFRate(12.5), kFRate(100), kFRate(14))];
    myDingDanLabel.text = @"我的订单";
    myDingDanLabel.textColor = kColorSting(@"353535");
    myDingDanLabel.font = kFont28px;
    [middleView addSubview:myDingDanLabel];
    
    
    
    UIImageView * next= [[UIImageView alloc]initWithFrame:CGRectMake(kViewWidth -  kFRate(22), kFRate(11),kFRate(9), kFRate(17))];
    next.image = [UIImage imageNamed:@"NextEmail副本2拷贝"];
    [middleView addSubview:next];
    next.userInteractionEnabled = YES;
    
    UILabel *MoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(next.frame) - kFRate(100),kFRate(12.5), kFRate(100), kFRate(14))];
    MoreLabel.text = @"查看全部订单";
    MoreLabel.textColor = kColorSting(@"353535");
    MoreLabel.font = kFont28px;
    MoreLabel.textAlignment = NSTextAlignmentRight;
    [middleView addSubview:MoreLabel];
    MoreLabel.userInteractionEnabled = YES;
    
    
    // 查看全部订单 手势  不参与尺寸计算
    UIView *tapView = [[UIView alloc]initWithFrame:CGRectMake(kViewWidth - 150, 0, 150,kFRate(28))];
    [middleView addSubview:tapView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChaKanMore:)];
    [tapView addGestureRecognizer:tap];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kFRate(39)- 0.5 , kViewWidth, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [middleView addSubview:line];
    
    
    CGFloat firstX = kFRate(20);
    CGFloat buttonW = kFRate(45);
    CGFloat buttonH = kFRate(50);
    CGFloat padding = (kViewWidth - 5 * buttonW - 2 * firstX )/4;
    CGFloat buttonY = CGRectGetMaxY(line.frame) + kFRate(23);
    
    
    CGFloat iconW = kFRate(30);
    CGFloat iconH = kFRate(30);
    CGFloat iconX = kFRate(5);
    CGFloat iconY = 0;
    
    CGFloat textW = buttonW;
    CGFloat textnH = kFRate(14);
    CGFloat textX = 0;
    CGFloat textY = buttonH -textnH;
    
    IWBatesButton *buttonCollect = [[IWBatesButton alloc]initFrame:CGRectMake(firstX, buttonY, buttonW, buttonH) Icon:@"待付款" selectIcon:nil iconFrame:CGRectMake(iconX, iconY, iconW, iconH) title:@"待付款" titleFrame:CGRectMake(textX, textY,textW, textnH) titleFont:kFont28px titleColor:kColorSting(@"353535") titleSelectColor:nil seleTitle:nil];
    buttonCollect.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [buttonCollect addTarget:self action:@selector(waitPayClick:) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:buttonCollect];
    
    
    IWBatesButton *buttonMoney = [[IWBatesButton alloc]initFrame:CGRectMake(firstX + (padding + buttonW), buttonY, buttonW, buttonH) Icon:@"待发货-3" selectIcon:nil iconFrame:CGRectMake(iconX, iconY, iconW, iconH) title:@"待发货" titleFrame:CGRectMake(textX, textY,textW, textnH) titleFont:kFont24px titleColor:kColorSting(@"353535") titleSelectColor:nil seleTitle:nil];
    buttonMoney.titleLabel.textAlignment = NSTextAlignmentCenter;
    [buttonMoney addTarget:self action:@selector(waitFaHuoClick:) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:buttonMoney];
    
    //待收货-2
    IWBatesButton *buttonMember = [[IWBatesButton alloc]initFrame:CGRectMake(firstX + 2 * (padding + buttonW), buttonY, buttonW, buttonH) Icon:@"待发货-2" selectIcon:nil iconFrame:CGRectMake(iconX, iconY + kFRate(2), kFRate(30), kFRate(20)) title:@"待收货" titleFrame:CGRectMake(textX, textY,textW, textnH) titleFont:kFont28px titleColor:kColorSting(@"353535") titleSelectColor:nil seleTitle:nil];
    [buttonMember addTarget:self action:@selector(waitShouhuoClick:) forControlEvents:UIControlEventTouchUpInside];
    buttonMember.titleLabel.textAlignment = NSTextAlignmentCenter;
    [middleView addSubview:buttonMember];
    
    //待评价
    IWBatesButton *buttonMoney1 = [[IWBatesButton alloc]initFrame:CGRectMake(firstX + 3 * (padding + buttonW), buttonY, buttonW, buttonH) Icon:@"待评价" selectIcon:nil iconFrame:CGRectMake(iconX, iconY, iconW, iconH) title:@"待评价" titleFrame:CGRectMake(textX, textY,textW, textnH) titleFont:kFont28px titleColor:kColorSting(@"353535") titleSelectColor:nil seleTitle:nil];
    buttonMoney1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [buttonMoney1 addTarget:self action:@selector(waitPingJiaClick:) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:buttonMoney1];
    
    //退换货
    IWBatesButton *buttonMember2 = [[IWBatesButton alloc]initFrame:CGRectMake(firstX + 4  * (padding + buttonW), buttonY, buttonW, buttonH) Icon:@"退换货" selectIcon:nil iconFrame:CGRectMake(iconX, iconY, iconW, iconH) title:@"退换货" titleFrame:CGRectMake(textX, textY,textW, textnH) titleFont:kFont28px titleColor:kColorSting(@"353535") titleSelectColor:nil seleTitle:nil];
    [buttonMember2 addTarget:self action:@selector(tuiHuangHuoClick:) forControlEvents:UIControlEventTouchUpInside];
    buttonMember2.titleLabel.textAlignment = NSTextAlignmentCenter;
    [middleView addSubview:buttonMember2];
    
}
#pragma mark - 查看全部订单
-(void)tapChaKanMore:(UIGestureRecognizer *)tap{
    if (![ASingleton shareInstance].loginModel) {
        IWLoginVC  *login = [[IWLoginVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    
    IWMeOrderFormVC *orderFormVC = [[IWMeOrderFormVC alloc]initWithSelectIndex:0];
    orderFormVC.meVC = self;
    
    [self.navigationController pushViewController:orderFormVC animated:YES];
    
}
#pragma mark - 付款
-(void)waitPayClick:(IWBatesButton *)button{
    if (![ASingleton shareInstance].loginModel) {
        IWLoginVC  *login = [[IWLoginVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    
    IWMeOrderFormVC *orderFormVC = [[IWMeOrderFormVC alloc]initWithSelectIndex:1];
    orderFormVC.meVC = self;
    [self.navigationController pushViewController:orderFormVC animated:YES];
    
}
#pragma mark - 发货
-(void)waitFaHuoClick:(IWBatesButton *)button{
    if (![ASingleton shareInstance].loginModel) {
        IWLoginVC  *login = [[IWLoginVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    
    IWMeOrderFormVC *orderFormVC = [[IWMeOrderFormVC alloc]initWithSelectIndex:2];
    orderFormVC.meVC = self;
    [self.navigationController pushViewController:orderFormVC animated:YES];
}
#pragma mark - 收货
-(void)waitShouhuoClick:(IWBatesButton *)button{
    if (![ASingleton shareInstance].loginModel) {
        IWLoginVC  *login = [[IWLoginVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    
    IWMeOrderFormVC *orderFormVC = [[IWMeOrderFormVC alloc]initWithSelectIndex:3];
    orderFormVC.meVC = self;
    [self.navigationController pushViewController:orderFormVC animated:YES];
    
}
#pragma mark - 评价
-(void)waitPingJiaClick:(IWBatesButton *)button{
    if (![ASingleton shareInstance].loginModel) {
        IWLoginVC  *login = [[IWLoginVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    
    IWMeOrderFormVC *orderFormVC = [[IWMeOrderFormVC alloc]initWithSelectIndex:4];
    orderFormVC.meVC = self;
    [self.navigationController pushViewController:orderFormVC animated:YES];
    
}
#pragma mark - 退货货物
-(void)tuiHuangHuoClick:(IWBatesButton *)button{
    if (![ASingleton shareInstance].loginModel) {
        IWLoginVC  *login = [[IWLoginVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    
    IWMeBackVC *orderFormVC = [[IWMeBackVC alloc]init];
    
    [self.navigationController pushViewController:orderFormVC animated:YES];
    
}

#pragma mark - 底部视图添加
-(void)addDownView{
    CGFloat cellH = kFRate(45);
    
    CGFloat buttonW = kFRate(22);
    CGFloat buttonH = kFRate(22);
    CGFloat buttonY = kFRate(11);
    CGFloat buttonX = kFRate(11);
    
    CGFloat textW = kFRate(120);
    CGFloat textH = kFRate(16);
    CGFloat textX = buttonX + buttonW + kFRate(5);
    CGFloat textY = ( cellH - textH )/2;
    
    
    CGFloat nextW = kFRate(9);
    CGFloat nextH = kFRate(17);
    CGFloat nextX = kViewWidth - nextW - kFRate(10);
    CGFloat nextY = ( cellH - nextH )/2;
    
    //收货地址
    UIView *xian = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.middleView.frame) + kFRate(10), kViewWidth, cellH)];
    xian.backgroundColor = [UIColor whiteColor];
    [self.myScrollView addSubview:xian];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDiZhi:)];
    [xian addGestureRecognizer:tap];
    
    
    UIImageView * myDingDan= [[UIImageView alloc]initWithFrame:CGRectMake(buttonX, buttonY,buttonW, buttonH)];
    myDingDan.image = [UIImage imageNamed:@"矢量智能对象-1"];
    [xian addSubview:myDingDan];
    
    UILabel *myDingDanLabel = [[UILabel alloc]initWithFrame:CGRectMake(textX,textY, textW, textH)];
    myDingDanLabel.text = @"收货地址";
    myDingDanLabel.textColor = kColorSting(@"353535");
    myDingDanLabel.font = kFont30px;
    [xian addSubview:myDingDanLabel];
    
    UIImageView * next= [[UIImageView alloc]initWithFrame:CGRectMake(nextX, nextY,nextW, nextH)];
    next.image = [UIImage imageNamed:@"NextEmail副本2拷贝"];
    [xian addSubview:next];
    
    
    // 帮组中心
    UIView *xian1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(xian.frame) + kFRate(5), kViewWidth, cellH * 2 + 0.5)];
    xian1.backgroundColor = [UIColor whiteColor];
    [self.myScrollView addSubview:xian1];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBanZhu:)];
    [xian1 addGestureRecognizer:tap1];
    
    UIImageView * myDingDan1= [[UIImageView alloc]initWithFrame:CGRectMake(buttonX, buttonY,buttonW, buttonH)];
    myDingDan1.image = [UIImage imageNamed:@"IWNearShoppingPhone"];
    [xian1 addSubview:myDingDan1];
    
    UILabel *myDingDanLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(textX,textY, textW, textH)];
    myDingDanLabel1.text = @"加盟合作";
    myDingDanLabel1.textColor = kColorSting(@"353535");
    myDingDanLabel1.font = kFont30px;
    [xian1 addSubview:myDingDanLabel1];
    
    
    UIImageView * next1= [[UIImageView alloc]initWithFrame:CGRectMake(nextX, nextY,nextW, nextH)];
    next1.image = [UIImage imageNamed:@"NextEmail副本2拷贝"];
    [xian1 addSubview:next1];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, cellH - 0.5 , kViewWidth, 0.5)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [xian1 addSubview:line1];
    
    
    // 关于我们 仅仅添加点击事件用，其它没有参与到尺寸计算
    UIView * jiaMengView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(line1.frame),kViewWidth, cellH)];
    jiaMengView.backgroundColor = [UIColor clearColor];
    [xian1 addSubview:jiaMengView];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapJiaMeng:)];
    [jiaMengView addGestureRecognizer:tap3];
    
    
    //  关于我们
    UIImageView * myDingDan2= [[UIImageView alloc]initWithFrame:CGRectMake(buttonX,CGRectGetMaxY(line1.frame) + buttonY,buttonW, buttonH)];
    myDingDan2.image = [UIImage imageNamed:@"关于我们48"];
    [xian1 addSubview:myDingDan2];
    
    UILabel *myDingDanLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(textX,CGRectGetMaxY(line1.frame) + textY, textW, textH)];
    myDingDanLabel2.text = @"关于我们";
    myDingDanLabel2.textColor = kColorSting(@"353535");
    myDingDanLabel2.font = kFont30px;
    [xian1 addSubview:myDingDanLabel2];
    
    UIImageView * next2= [[UIImageView alloc]initWithFrame:CGRectMake(nextX,CGRectGetMaxY(line1.frame) +  nextY,nextW, nextH)];
    next2.image = [UIImage imageNamed:@"NextEmail副本2拷贝"];
    [xian1 addSubview:next2];
    
    
    
    // 清除本地缓存
    UIView *middleView4 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(xian1.frame) + kFRate(10), kViewWidth,cellH)];
    middleView4.backgroundColor = [UIColor whiteColor];
    [self.myScrollView addSubview:middleView4];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapQingChu:)];
    [middleView4 addGestureRecognizer:tap4];
    
    
    
    UIImageView * myDingDan4= [[UIImageView alloc]initWithFrame:CGRectMake(buttonX, buttonY,buttonW, buttonH)];
    myDingDan4.image = [UIImage imageNamed:@"缓存48"];
    [middleView4 addSubview:myDingDan4];
    
    UILabel *myDingDanLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(textX,textY, textW, textH)];
    myDingDanLabel4.text = @"清除本地缓存";
    myDingDanLabel4.textColor = kColorSting(@"353535");
    myDingDanLabel4.font = kFont30px;
    [middleView4 addSubview:myDingDanLabel4];
    
    UIImageView * next4= [[UIImageView alloc]initWithFrame:CGRectMake(nextX,nextY,nextW, nextH)];
    next4.image = [UIImage imageNamed:@"NextEmail副本2拷贝"];
    [middleView4 addSubview:next4];
    
    UILabel *MoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(next4.frame) - textW - kFRate(5),textY, textW, textH)];
    MoreLabel.text = @"";
    MoreLabel.textColor = kColorSting(@"353535");
    MoreLabel.font = kFont30px;
    MoreLabel.textAlignment = NSTextAlignmentRight;
    [middleView4 addSubview:MoreLabel];
    
    
    //意见反馈
    UIView *middleView5 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(middleView4.frame) + kFRate(10), kViewWidth,cellH)];
    middleView5.backgroundColor = [UIColor whiteColor];
    [self.myScrollView addSubview:middleView5];
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBack:)];
    [middleView5 addGestureRecognizer:tap5];
    
    
    UIImageView * myDingDan5= [[UIImageView alloc]initWithFrame:CGRectMake(buttonX, buttonY,buttonW, buttonH)];
    myDingDan5.image = [UIImage imageNamed:@"意见反馈48"];
    [middleView5 addSubview:myDingDan5];
    
    UILabel *myDingDanLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(textX,textY, textW, textH)];
    myDingDanLabel5.text = @"意见反馈";
    myDingDanLabel5.textColor = kColorSting(@"353535");
    myDingDanLabel5.font = kFont30px;
    [middleView5 addSubview:myDingDanLabel5];
    
    UIImageView * next5= [[UIImageView alloc]initWithFrame:CGRectMake(nextX,nextY,nextW, nextH)];
    next5.image = [UIImage imageNamed:@"NextEmail副本2拷贝"];
    [middleView5 addSubview:next5];
    
}
#pragma mark -意见反馈
-(void)tapBack:(UIGestureRecognizer *)tap{
    if (![ASingleton shareInstance].loginModel) {
        IWLoginVC  *login = [[IWLoginVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    
    IWOpinionVC *opinionVC = [[IWOpinionVC alloc] init];
    [self.navigationController pushViewController:opinionVC animated:YES];
    
}
#pragma mark -地址
-(void)tapDiZhi:(UIGestureRecognizer *)tap{
    if (![ASingleton shareInstance].loginModel) {
        IWLoginVC  *login = [[IWLoginVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    
    IWAddressVC *vc = [[IWAddressVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark -加盟合作
-(void)tapBanZhu:(UIGestureRecognizer *)tap{
    
    IWWebViewVC *vc = [[IWWebViewVC alloc] init];
    vc.url = [ASingleton shareInstance].businessUrl;
    vc.navTitle = @"加盟合作";
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark -关于我们 
-(void)tapJiaMeng:(UIGestureRecognizer *)tap{
    
    IWWebViewVC *vc = [[IWWebViewVC alloc] init];
    vc.url = [ASingleton shareInstance].aboutUsUrl;
    vc.navTitle = @"关于我们";
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark -清除
-(void)tapQingChu:(UIGestureRecognizer *)tap{
    sleep(1.0);
    [[TKAlertCenter defaultCenter]postAlertWithMessage:@"缓存数据已经清理"];
}

@end
