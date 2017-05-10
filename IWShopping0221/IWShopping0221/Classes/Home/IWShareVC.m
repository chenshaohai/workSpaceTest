//
//  IWShareVC.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/5.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWShareVC.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface IWShareVC ()
@property (nonatomic,copy)NSString *beikeNum;
@end

@implementation IWShareVC
- (void)collectionLeftCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary *configDic = [defaults objectForKey:@"configDic"];
    _beikeNum = configDic[@"shareConfig"]?:@"0";
    // 左按钮
    self.navigationItem.title = @"推荐分享";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    // Do any additional setup after loading the view.
    
    // 背景
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64)];
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight - 64)];
    backImg.image = _IMG(@"IWShareBack");
    backImg.userInteractionEnabled = YES;
    [scrollView addSubview:backImg];
    
    // 头
    UIImageView *topImg = [[UIImageView alloc] initWithFrame:CGRectMake((kViewWidth - kRate(282)) / 2, kRate(10), kRate(282), kRate(200))];
    topImg.image = _IMG(@"IIWShareTop");
    topImg.userInteractionEnabled = YES;
    [backImg addSubview:topImg];
    
    // 推荐好友关注公众号
    UILabel *tuijian = [[UILabel alloc] initWithFrame:CGRectMake(kRate(10), kRate(90), topImg.width / 2 - kRate(20), kRate(20))];
    tuijian.text = @"推荐好友关注公众号>>";
    tuijian.textColor = IWColor(20, 121, 134);
    tuijian.font = kFont20px;
    tuijian.textAlignment = NSTextAlignmentCenter;
    tuijian.backgroundColor = [UIColor whiteColor];
    tuijian.layer.cornerRadius = kRate(5);
    tuijian.layer.borderWidth = 1;
    tuijian.layer.masksToBounds = YES;
    tuijian.layer.borderColor = IWColor(20, 121, 134).CGColor;
    [topImg addSubview:tuijian];
    
    // 获取说明
    UIView *huoBack = [[UIView alloc] initWithFrame:CGRectMake(kRate(20), CGRectGetMaxY(tuijian.frame), topImg.width / 2 - kRate(40), kRate(70))];
    huoBack.layer.borderWidth = 1;
    huoBack.layer.borderColor = IWColor(20, 121, 134).CGColor;
    [topImg addSubview:huoBack];
    
    UILabel *huoqu = [[UILabel alloc] init];
    huoqu.text = @"立即获得";
    huoqu.textColor = IWColor(20, 121, 134);
    huoqu.font = kFont26px;
    huoqu.textAlignment = NSTextAlignmentCenter;
    [huoqu sizeToFit];
    huoqu.frame = CGRectMake(0, kRate(15), huoBack.width, huoqu.height);
    [huoBack addSubview:huoqu];
    
    UILabel *huoqu1 = [[UILabel alloc] init];
    huoqu1.text = [NSString stringWithFormat:@"%@个贝壳",_beikeNum];
    huoqu1.textColor = IWColor(20, 121, 134);
    huoqu1.font = kFont32pxBold;
    huoqu1.textAlignment = NSTextAlignmentCenter;
    [huoqu1 sizeToFit];
    huoqu1.frame = CGRectMake(0, CGRectGetMaxY(huoqu.frame) + kRate(5), huoBack.width, huoqu1.height);
    [huoBack addSubview:huoqu1];
    
    NSMutableAttributedString *noteString = [[NSMutableAttributedString alloc] initWithString:huoqu1.text];
    NSRange stringRange = NSMakeRange(1, 3); //该字符串的位置
    [noteString addAttribute:NSFontAttributeName value:kFont20px range:stringRange];
    [huoqu1 setAttributedText: noteString];
    
    // 分享按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((kViewWidth - kRate(260)) / 2, CGRectGetMaxY(topImg.frame) + kRate(10), kRate(260), kRate(42.675));
    [btn setImage:_IMG(@"IWShareBtn") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn];
    [self.view addSubview:scrollView];
    
    // 附加奖
    UILabel *fuJia = [[UILabel alloc] init];
    fuJia.text = @"分享说明";
    fuJia.textColor = [UIColor whiteColor];
    fuJia.font = kFont28pxBold;
    [fuJia sizeToFit];
    fuJia.frame = CGRectMake(kRate(20), kRate(20) + CGRectGetMaxY(btn.frame), fuJia.frame.size.width, fuJia.frame.size.height);
    [backImg addSubview:fuJia];
    
    NSString *fenxiang = [NSString stringWithFormat:@"每次分享成功，可获赠%@个贝壳",_beikeNum];
    NSArray *huoDongArr = @[fenxiang];
    // 累加label高度
    CGFloat tempF1 = 0.0f;
    for (NSInteger i = 0; i < huoDongArr.count; i ++) {
        UILabel *tempLabel = [[UILabel alloc] init];
        tempLabel.textColor = [UIColor whiteColor];
        tempLabel.text = huoDongArr[i];
        tempLabel.font = [UIFont systemFontOfSize:kRate(12)];
        tempLabel.numberOfLines = 0;
        CGSize size = [self initWithWidth:kViewWidth - kRate(40) height:MAXFLOAT font:[UIFont systemFontOfSize:kRate(12)] text:huoDongArr[i]];
        tempLabel.frame = CGRectMake(kRate(20), CGRectGetMaxY(fuJia.frame) + kRate(10) + tempF1, kViewWidth - kRate(40), size.height + kRate(4));
        tempF1 = tempF1 + tempLabel.frame.size.height;
        [backImg addSubview:tempLabel];
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

#pragma mark - 分享
- (void)shareBtnClick
{
    //1、创建分享参数
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    //读取数据
    NSDictionary *configDic = [defaults objectForKey:@"configDic"];
    NSString *path = [NSString stringWithFormat:@"%@%@",kImageUrl,configDic[@"shareImg"]?:@""];
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:data];
    NSArray* imageArray = @[img];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:configDic[@"shareTitle"]?:@""
                                         images:imageArray
                                            url:[NSURL URLWithString:configDic[@"shareUrl"]?:@""]
                                          title:configDic[@"shareDesc"]?:@""
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
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
