//
//  IWNearSurePayVC.m
//  IWShopping0221
//
//  Created by FRadmin on 17/3/7.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWNearSurePayVC.h"
#import "IWBatesButton.h"
#import "IWNearCommitDiscussVC.h"
#import "IWTabBarViewController.h"
@interface IWNearSurePayVC ()
// 店铺名称
@property (nonatomic,copy)NSString *shopName;
// 店铺Id
@property (nonatomic,copy)NSString *shopId;
@property (nonatomic,weak)UILabel *keyonghuibiCount;
@property (nonatomic,weak)UILabel *keyongyuer;
@property (nonatomic,weak)UILabel *keyongyuerCount;
@property (nonatomic,weak)UILabel *dingdangHao;
@property (nonatomic,weak)UILabel *xiaofeijine;
@property (nonatomic,weak)IWBatesButton *huibiButton;
@property (nonatomic,weak)IWBatesButton *yuerButton;
@property (nonatomic,weak)UILabel *haixuyaochifuLabel;
@property (nonatomic,weak)UILabel *kefanhuibiLabel;
@property (nonatomic,weak)IWBatesButton *zhifubaoButton;
@property (nonatomic,weak)IWBatesButton *yinglianButton;
@property (nonatomic,weak)IWBatesButton *xianjinButton;
@property (nonatomic,weak)IWBatesButton *selectPayTypeButton;


@property (nonatomic,weak)UIButton *payButton;
@end

@implementation IWNearSurePayVC
-(instancetype)initWithName:(NSString *)shopName andShoppingId:(NSString *)shopId{
    self = [super init];
    if (self) {
        _shopId = shopId;
        _shopName = shopName;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认支付";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat firstX = kFRate(10);
    CGFloat viewH = kFRate(15);
    
    
    UILabel *keyonghuibi = [[UILabel alloc]initWithFrame:CGRectMake(firstX,64 + kFRate(15), kFRate(75), viewH)];
    keyonghuibi.font = kFont30px;
    keyonghuibi.textColor = [UIColor blackColor];
    keyonghuibi.textAlignment = NSTextAlignmentLeft;
    keyonghuibi.text = @"可用贝壳:";
    [self.view addSubview:keyonghuibi];
    
    UILabel *keyonghuibiCount = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(keyonghuibi.frame),CGRectGetMinY(keyonghuibi.frame), kFRate(80), viewH)];
    keyonghuibiCount.font = kFont30px;
    keyonghuibiCount.textColor = IWColorRed;
    keyonghuibiCount.textAlignment = NSTextAlignmentLeft;
    keyonghuibiCount.text = @"0个";
    [self.view addSubview:keyonghuibiCount];
    self.keyonghuibiCount = keyonghuibiCount;
    
    
    UILabel *keyongyuer = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth / 2.0 + firstX,CGRectGetMinY(keyonghuibi.frame), kFRate(75),viewH)];
    keyongyuer.font = kFont30px;
    keyongyuer.textColor = [UIColor blackColor];
    keyongyuer.textAlignment = NSTextAlignmentLeft;
    keyongyuer.text = @"可用余额:";
    [self.view addSubview:keyongyuer];
    
    UILabel *keyongyuerCount = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(keyongyuer.frame),CGRectGetMinY(keyonghuibi.frame), kFRate(80), viewH)];
    keyongyuerCount.font = kFont30px;
    keyongyuerCount.textColor = kColorRGB(251, 22, 78);
    keyongyuerCount.textAlignment = NSTextAlignmentLeft;
    keyongyuerCount.text = @"400.00";
    [self.view addSubview:keyongyuerCount];
    self.keyongyuerCount = keyongyuerCount;
    
    
    UILabel *dingdangHao = [[UILabel alloc]initWithFrame:CGRectMake(firstX,CGRectGetMaxY(keyonghuibi.frame) + kFRate(30), kViewWidth - 2 * firstX, viewH)];
    dingdangHao.font = kFont30px;
    dingdangHao.textColor = [UIColor blackColor];
    dingdangHao.textAlignment = NSTextAlignmentLeft;
    dingdangHao.text =  @"订单号：898908908908400.00";
    [self.view addSubview:dingdangHao];
    self.dingdangHao = dingdangHao;
    
    
    
    UILabel *xiaofeijine = [[UILabel alloc]initWithFrame:CGRectMake(firstX,CGRectGetMaxY(dingdangHao.frame) + kFRate(27), kViewWidth - 2 * firstX, viewH)];
    xiaofeijine.font = kFont30px;
    xiaofeijine.textColor = [UIColor blackColor];
    xiaofeijine.textAlignment = NSTextAlignmentLeft;
    xiaofeijine.text =  @"消费金额：￥2.00 （其中不享受为9 ）";
    [self.view addSubview:xiaofeijine];
    self.xiaofeijine = xiaofeijine;
    
    
    IWBatesButton *huibiButton = [[IWBatesButton alloc]initFrame:CGRectMake(firstX, CGRectGetMaxY(xiaofeijine.frame) + kFRate(23), kViewWidth, viewH) Icon:@"IWShopping椭圆2拷贝" selectIcon:@"IWSelect" iconFrame:CGRectMake(0, 0, viewH, viewH) title:@"可支付贝壳0" titleFrame:CGRectMake(firstX + viewH, 0, 200, viewH) titleFont:kFont24px titleColor:kColorSting(@"666666") titleSelectColor:nil seleTitle:nil];
    self.huibiButton = huibiButton;
    [huibiButton addTarget:self action:@selector(huibiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:huibiButton];
    
    
    IWBatesButton *yuerButton = [[IWBatesButton alloc]initFrame:CGRectMake(firstX, CGRectGetMaxY(huibiButton.frame) + kFRate(8), kViewWidth, viewH) Icon:@"IWShopping椭圆2拷贝" selectIcon:@"IWSelect" iconFrame:CGRectMake(0, 0, viewH, viewH) title:@"可支付余额2.00" titleFrame:CGRectMake(firstX + viewH, 0, 200, viewH) titleFont:kFont24px titleColor:kColorSting(@"666666") titleSelectColor:nil seleTitle:nil];
    self.yuerButton = yuerButton;
    [yuerButton addTarget:self action:@selector(yuerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yuerButton];
    
    
    
    UILabel *haixuyaochifuLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(yuerButton.frame) + kFRate(27), kViewWidth,viewH)];
    haixuyaochifuLabel.font = kFont30px;
    haixuyaochifuLabel.textColor = [UIColor blackColor];
    haixuyaochifuLabel.textAlignment = NSTextAlignmentCenter;
    haixuyaochifuLabel.text = @"还需要支付￥3.00元";
    [self.view addSubview:haixuyaochifuLabel];
    
    
    
    UILabel *kefanhuibiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(haixuyaochifuLabel.frame), kViewWidth, viewH)];
    kefanhuibiLabel.font = kFont30px;
    kefanhuibiLabel.textColor = kColorSting(@"666666");
    kefanhuibiLabel.textAlignment = NSTextAlignmentCenter;
    kefanhuibiLabel.text = @"本次可返贝壳2.00个";
    [self.view addSubview:kefanhuibiLabel];
    self.kefanhuibiLabel = kefanhuibiLabel;
    
    
    
    IWBatesButton *zhifubaoButton = [[IWBatesButton alloc]initFrame:CGRectMake(firstX, CGRectGetMaxY(kefanhuibiLabel.frame) + kFRate(27), kViewWidth, viewH) Icon:@"IWShopping椭圆2拷贝" selectIcon:@"IWSelect" iconFrame:CGRectMake(0, 0, viewH, viewH) title:@"支付宝支付" titleFrame:CGRectMake(firstX + viewH, 0, 100, viewH) titleFont:kFont24px titleColor:kColorSting(@"666666") titleSelectColor:nil seleTitle:nil];
    self.zhifubaoButton = zhifubaoButton;
    [zhifubaoButton addTarget:self action:@selector(zhifubaoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhifubaoButton];
    
    //默认支付宝
    self.selectPayTypeButton = zhifubaoButton;
    zhifubaoButton.selected = YES;
    
    
    IWBatesButton *yinglianButton = [[IWBatesButton alloc]initFrame:CGRectMake(firstX, CGRectGetMaxY(zhifubaoButton.frame) + kFRate(22), kViewWidth, viewH) Icon:@"IWShopping椭圆2拷贝" selectIcon:@"IWSelect" iconFrame:CGRectMake(0, 0, viewH, viewH) title:@"银联支付" titleFrame:CGRectMake(firstX + viewH, 0, 100, viewH) titleFont:kFont24px titleColor:kColorSting(@"666666") titleSelectColor:nil seleTitle:nil];
    self.yinglianButton = yinglianButton;
    [yinglianButton addTarget:self action:@selector(yinglianButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:yinglianButton];
    
    
    IWBatesButton *xianjinButton = [[IWBatesButton alloc]initFrame:CGRectMake(firstX, CGRectGetMaxY(yinglianButton.frame) + kFRate(22), kViewWidth, viewH) Icon:@"IWShopping椭圆2拷贝" selectIcon:@"IWSelect" iconFrame:CGRectMake(0, 0, viewH, viewH) title:@"现金支付" titleFrame:CGRectMake(firstX + viewH, 0, 100, viewH) titleFont:kFont24px titleColor:kColorSting(@"666666") titleSelectColor:nil seleTitle:nil];
    self.xianjinButton = xianjinButton;
    [xianjinButton addTarget:self action:@selector(xianjinButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xianjinButton];
    
    
    
    
    
    UIButton  *payButton = [[UIButton alloc]initWithFrame:CGRectMake(kFRate(30), CGRectGetMaxY(xianjinButton.frame) + kFRate(70), kViewWidth - 2* kFRate(30), kFRate(43))];
    payButton.backgroundColor = IWColorRed;
    [payButton setTitle:@"确认支付" forState:UIControlStateNormal];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payButton.titleLabel.font = kFont28px;
    [self.view addSubview:payButton];
    [payButton addTarget: self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.payButton = payButton;
    
}


-(void)huibiButtonClick:(IWBatesButton *)button{
    button.selected =  !button.selected;
    
}

-(void)yuerButtonClick:(IWBatesButton *)button{
    button.selected =  !button.selected;
}

-(void)zhifubaoButtonClick:(IWBatesButton *)button{
    if (button.selected == NO) {
        self.selectPayTypeButton.selected = NO;
        self.selectPayTypeButton = button;
    }else{
        self.selectPayTypeButton = nil;
    }
    button.selected =  !button.selected;
}

-(void)yinglianButtonClick:(IWBatesButton *)button{
    if (button.selected == NO) {
        self.selectPayTypeButton.selected = NO;
        self.selectPayTypeButton = button;
    }else{
        self.selectPayTypeButton = nil;
    }
    button.selected =  !button.selected;
}

-(void)xianjinButtonClick:(IWBatesButton *)button{
    if (button.selected == NO) {
        self.selectPayTypeButton.selected = NO;
        self.selectPayTypeButton = button;
    }else{
        self.selectPayTypeButton = nil;
    }
    button.selected =  !button.selected;
}
# pragma mark  支付
/**
 * 支付
 */
-(void)payButtonClick{
    if (!self.selectPayTypeButton) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请选择一种支付方式"];
        return;
    }
    
    /*我要买单接口-第二期
     接口描述：我要买单，其实就是创建了一个线下门店的订单消费记录
     数据格式：JSON
     请求方式：POST
     接口URL： http://api.weiyunshidai.com/order/createShopOrder
     参数说明
     名称	类型	说明	是否必填	示例	默认值
     userId	string	用户ID	是
     userName	string	用户名称	是
     shopId	string	线下哪个门店	是
     shopName	string	店铺名称	是
     payPrice	string	付款金额	是
     integral	string	抵扣惠币，在我要买单后面会有一个提示xxx金额+yyy惠币，此时表示integral为yyy	是
     type	string	支付方式，默认0表示微信支付，1表示支付宝，2表示银联	是
     响应示例 异常示例
     {
     "code": "0",
     "data": "",
     "message": "success"
     }
     注意事项
     模拟请求：http://api.weiyunshidai.com/order/createShopOrder?userId=43&userName=18565660736&shopId=15&shopName=纯颂饮冷饮店&payPrice=90&integral=10&type=0 模拟请求是get，但是app提交时使用post。*/
    
    //调用接口
    NSString *url = [NSString stringWithFormat:@"%@/%@?",kNetUrl,@"order/payOrderFinish"];
    if (self.orderId) {
        url = [NSString stringWithFormat:@"%@/%@?orderIds=%@",kNetUrl,@"order/payOrderFinish",self.orderId];
    }
    
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"code"]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"支付失败"];
            return ;
        }
        if (![@"0" isEqual:json[@"code"]]){
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"支付失败"];
            return ;
        }
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"支付成功"];
        
        //切换回第一个控制器
        IWTabBarViewController *tbVC = (IWTabBarViewController *)weakSelf.tabBarController;
        [tbVC from:2 To:0 isRootVC:NO currentVC:weakSelf];

        
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"支付失败"];
    }];
    
    
    
    //    IWNearCommitDiscussVC *discussVC = [[IWNearCommitDiscussVC alloc]init];
    //
    //    [self.navigationController pushViewController:discussVC animated:YES];
}

@end
