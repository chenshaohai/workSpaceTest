//
//  IWLuckyVC.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/5.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWLuckyVC.h"
#import "IWLuckyModel.h"
#import "TurntableView.h"

@interface IWLuckyVC ()<CAAnimationDelegate>
{
    NSString *strPrise;
}
// 背景
@property (strong, nonatomic) UIView  *popView;
@property (strong, nonatomic) UILabel *labPrise;
@property (strong, nonatomic) UIButton *btn;
@property (nonatomic,strong) TurntableView * turntable;
@property (nonatomic,strong)NSMutableArray *myData;
@property (nonatomic,strong)UIImageView *oneImg;
// UIImageView *twoImg
@property (nonatomic,strong)UIImageView *twoImg;
// 中奖结果
@property (nonatomic,copy)NSString *itemStr;
@property (nonatomic,copy)NSString *beikeNum;
@end

@implementation IWLuckyVC

- (NSMutableArray *)myData
{
    if (_myData == nil) {
        _myData = [[NSMutableArray alloc] init];
    }
    return _myData;
}

- (void)collectionLeftCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Nav Right
- (void)collectionRightClick
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 左按钮
    self.navigationItem.title = @"抽奖";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.view.backgroundColor = IWColor(252, 69, 100);
    
    // 背景
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 - kRate(20), kViewWidth, kViewHeight - 64 + kRate(20))];
    
    // 抽奖
    _oneImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kRate(556.5))];
    _oneImg.image = _IMG(@"IWLuckyOne");
    _oneImg.userInteractionEnabled = YES;
    [myScrollView addSubview:_oneImg];
    
//    //转盘
//    _zhuanpan = [[UIImageView alloc] initWithFrame:CGRectMake((kViewWidth - kRate(276)) / 2,kRate(150) + kRate(40), kRate(276), kRate(276))];
//    _zhuanpan.image = [UIImage imageNamed:@"zhuanpan"];
//    _zhuanpan.userInteractionEnabled = YES;
//    [oneImg addSubview:_zhuanpan];
//    
//    //手指
//    UIImageView *hander = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kRate(30), kRate(30))];
//    hander.center = CGPointMake(_zhuanpan.center.x, _zhuanpan.center.y - kRate(30));
//    hander.userInteractionEnabled = YES;
//    hander.image = [UIImage imageNamed:@"hander.png"];
//    [oneImg addSubview:hander];
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, kRate(75), kRate(75));
//    btn.center = _zhuanpan.center;
//    btn.backgroundColor = [UIColor clearColor];
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [oneImg addSubview:btn];
//    self.btn = btn;
    
    // 活动说明
    _twoImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_oneImg.frame) - kRate(70), kViewWidth, kRate(450))];
    _twoImg.image = _IMG(@"IWLuckyTwo");
    [myScrollView addSubview:_twoImg];
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.bounces = NO;
    myScrollView.contentSize = CGSizeMake(kViewWidth, kRate(556.5) + kRate(450) - kRate(70));
    [self.view addSubview:myScrollView];
    
    [self requestData];
}

#pragma mark - 转盘&&活动说明
- (void)setViewShow
{
    // 转盘View
    self.turntable = [[TurntableView alloc] initWithFrame:CGRectMake((kViewWidth - kRate(276)) / 2,kRate(150) + kRate(40), kRate(276), kRate(276))];
    NSMutableArray *tempArr = [NSMutableArray new];
    for (IWLuckyModel *model in self.myData) {
        [tempArr addObject:model.gift];
    }
    IWLog(@"%@",tempArr);
    _turntable.numberArray = [NSArray arrayWithArray:tempArr];
    [self.turntable.playButton addTarget:self action:@selector(startAnimaition) forControlEvents:UIControlEventTouchUpInside];
    [_oneImg addSubview:self.turntable];
    
    // 活动说明
    UILabel *huoDong = [[UILabel alloc] init];
    huoDong.text = @"活动说明";
    huoDong.textColor = IWColor(26, 99, 118);
    huoDong.font = [UIFont systemFontOfSize:kRate(16)];
    [huoDong sizeToFit];
    huoDong.frame = CGRectMake(kRate(20), kRate(50), huoDong.frame.size.width, huoDong.frame.size.height);
    [_twoImg addSubview:huoDong];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary *configDic = [defaults objectForKey:@"configDic"];
    _beikeNum = configDic[@"winningConfig"]?:@"0";
    // 活动说明文字集合
    NSString *choujiang = [NSString stringWithFormat:@"1.每次抽奖消耗%@贝壳。",_beikeNum];
    NSArray *huoDongArr = @[@"活动规则",choujiang,@"2.抽检完成后平台将自动发货，请在个人中心—钱包—中奖纪录内查看",@"3.“服务热线400—6281688”。"];
    NSArray *zhuYiArr = @[@"",@"",@"",@""];
    
    // 纪录做后条活动说明的frame值
    CGRect tempR1;
    // 累加label高度
    CGFloat tempF1 = 0.0f;
    for (NSInteger i = 0; i < huoDongArr.count; i ++) {
        UILabel *tempLabel = [[UILabel alloc] init];
        tempLabel.textColor = IWColor(50, 66, 85);
        tempLabel.text = huoDongArr[i];
        tempLabel.font = [UIFont systemFontOfSize:kRate(12)];
        tempLabel.numberOfLines = 0;
        CGSize size = [self initWithWidth:kViewWidth - kRate(40) height:MAXFLOAT font:[UIFont systemFontOfSize:kRate(12)] text:huoDongArr[i]];
        tempLabel.frame = CGRectMake(kRate(20), CGRectGetMaxY(huoDong.frame) + kRate(10) + tempF1, kViewWidth - kRate(40), size.height + kRate(4));
        tempF1 = tempF1 + tempLabel.frame.size.height;
        
        tempR1 = tempLabel.frame;
        [_twoImg addSubview:tempLabel];
    }
    
    // 纪录做后条活动说明的frame值
    CGRect tempR2;
    // 累加label高度
    CGFloat tempF2 = 0.0f;
    for (NSInteger i = 0; i < zhuYiArr.count; i ++) {
        UILabel *tempLabel = [[UILabel alloc] init];
        tempLabel.textColor = IWColor(50, 66, 85);
        tempLabel.text = zhuYiArr[i];
        tempLabel.font = [UIFont systemFontOfSize:kRate(12)];
        tempLabel.numberOfLines = 0;
        CGSize size = [self initWithWidth:kViewWidth - kRate(40) height:MAXFLOAT font:[UIFont systemFontOfSize:kRate(12)] text:zhuYiArr[i]];
        tempLabel.frame = CGRectMake(kRate(20), CGRectGetMaxY(tempR1) + kRate(10) + tempF2, kViewWidth - kRate(40), size.height + kRate(4));
        tempF2 = tempF2 + tempLabel.frame.size.height;
        
        tempR2 = tempLabel.frame;
        [_twoImg addSubview:tempLabel];
    }
    
    
    // 活动奖品
    UILabel *jiangPin = [[UILabel alloc] init];
    jiangPin.text = @"奖品说明";
    jiangPin.textColor = IWColor(26, 99, 118);
    jiangPin.font = [UIFont systemFontOfSize:kRate(16)];
    [jiangPin sizeToFit];
    jiangPin.frame = CGRectMake(kRate(20), kRate(20) + CGRectGetMaxY(tempR2), jiangPin.frame.size.width, jiangPin.frame.size.height);
//    [_twoImg addSubview:jiangPin];
    
    NSArray *jiangPinArr = @[@"10会币 会币：10",@"牙膏礼盒 此物市值",@"10会币 会币：10",@"牙膏礼盒 此物市值"];
    // 纪录做后条活动说明的frame值
    //    CGRect tempR3;
    // 累加label高度
    CGFloat tempF3 = 0.0f;
    for (NSInteger i = 0; i < jiangPinArr.count; i ++) {
        UILabel *tempLabel = [[UILabel alloc] init];
        tempLabel.textColor = IWColor(50, 66, 85);
        tempLabel.text = jiangPinArr[i];
        tempLabel.font = [UIFont systemFontOfSize:kRate(12)];
        tempLabel.numberOfLines = 0;
        CGSize size = [self initWithWidth:kViewWidth - kRate(40) height:MAXFLOAT font:[UIFont systemFontOfSize:kRate(12)] text:jiangPinArr[i]];
        tempLabel.frame = CGRectMake(kRate(20), CGRectGetMaxY(jiangPin.frame) + kRate(10) + tempF3, kViewWidth - kRate(40), size.height + kRate(4));
        tempF3 = tempF3 + tempLabel.frame.size.height;
        //        tempR1 = tempLabel.frame;
//        [_twoImg addSubview:tempLabel];
    }
}

// label自适应文字
- (CGSize)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize;
}

-(void)startAnimaition
{
    self.turntable.playButton.enabled = NO;
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/platform/getWinning?userId=%@&userName=%@",kNetUrl,[ASingleton shareInstance].loginModel.userId,[ASingleton shareInstance].loginModel.userName];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf changeFail:json[@"message"]?:@"获取奖品失败"];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf changeFail:json[@"message"]?:@"获取奖品失败"];
            return ;
        }
        NSDictionary *dataDic = json[@"data"]?:nil;
        if (dataDic == nil || [dataDic isKindOfClass:[NSNull class]]) {
            [weakSelf changeFail:json[@"message"]?:@"获取奖品失败"];
            return ;
        }
        _itemStr = dataDic[@"item"]?:@"";
        [weakSelf thePrize];
    } failure:^(NSError *error) {
        [weakSelf changeFail:@"获取奖品失败"];
        return ;
    }];
}

//动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [UIView animateWithDuration:0
                     animations:^{
                         // 中奖动画背景
                         _popView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                         _popView.backgroundColor = [UIColor clearColor];
                         _popView.transform = CGAffineTransformMakeScale(2, 2);
                         [self.view addSubview:_popView];
                         
                         UIImageView *popImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 150, self.view.frame.size.width-200, self.view.frame.size.width-200)];
                         popImageView.image = [UIImage imageNamed:@""];
                         [_popView addSubview:popImageView];
                         self.turntable.playButton.enabled = YES;
                         
                     }
                     completion:^(BOOL finished) {
                         [_popView removeFromSuperview];
                         _labPrise.text = [NSString stringWithFormat:@"中奖结果 : %@",strPrise];
                         _btn.enabled = YES;
                         [[TKAlertCenter defaultCenter]postAlertWithMessage:strPrise];
                         self.turntable.playButton.enabled = YES;
                     }];
    
}

#pragma mark - 数据请求
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/platform/getGifts",kNetUrl];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf changeFail:json[@"message"]?:@"获取数据失败"];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf changeFail:json[@"message"]?:@"获取数据失败"];
            return ;
        }
        NSArray *dataArr = json[@"data"]?:@[];
        if (dataArr.count == 0) {
            [weakSelf changeFail:json[@"message"]?:@"获取数据失败"];
            return ;
        }
        
        for (NSDictionary *dic in dataArr) {
            IWLuckyModel *model = [[IWLuckyModel alloc] initWithDic:dic];
            [weakSelf.myData addObject:model];
        }
        [weakSelf setViewShow];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf changeFail:@"获取数据失败"];
        return ;
    }];
}

#pragma mark - 中奖结果
- (void)thePrize
{
    NSInteger turnAngle;
    NSInteger turnsNum = arc4random()%2+1;//控制圈数
    //    [[TKAlertCenter defaultCenter]postAlertWithMessage:[NSString stringWithFormat:@"%ld",randomNum]];
    if ([_itemStr isEqual:@"1"]) {
        
        turnAngle = 0;
        strPrise = self.turntable.numberArray[0];
        
    } else if ([_itemStr isEqual:@"2"]) {
        turnAngle = 45;
        strPrise = self.turntable.numberArray[7];
        
    } else if ([_itemStr isEqual:@"3"]) {
        
        turnAngle = 90;
        strPrise = self.turntable.numberArray[6];
        
    } else if([_itemStr isEqual:@"4"]){
        
        turnAngle = 135;
        strPrise = self.turntable.numberArray[5];
        
    }else if([_itemStr isEqual:@"5"]){
        
        turnAngle = 180;
        strPrise = self.turntable.numberArray[4];
        
    }else if([_itemStr isEqual:@"6"]){
        
        turnAngle = 225;
        strPrise = self.turntable.numberArray[3];
        
    }else if([_itemStr isEqual:@"7"]){
        
        turnAngle = 270;
        strPrise = self.turntable.numberArray[2];
        
    }else{
        
        turnAngle = 315;
        strPrise = self.turntable.numberArray[1];
        
    }
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:turnAngle*M_PI/180 + 2 * turnsNum*M_PI];
    // 转速
    rotationAnimation.duration = 3.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [self.turntable.rotateWheel.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


- (void)changeFail:(NSString *)str
{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:str];
    self.turntable.playButton.enabled = YES;
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
