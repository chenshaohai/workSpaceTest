//
//  IWNearCommitPayVC.m
//  IWShopping0221
//
//  Created by FRadmin on 17/3/7.
//  Copyright © 2017年 sword. All rights reserved.
//  提交订单

#import "IWNearCommitBillVC.h"
#import "IWNearSurePayVC.h"
#import "IWPayFilishVC.h"
#import "IWTabBarViewController.h"
#import "WXApi.h"
#import "Order.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "IWMeOrderFormVC.h"
@interface IWNearCommitBillVC ()<UITextFieldDelegate>
// 店铺名称
@property (nonatomic,copy)NSString *shopName;

@property (nonatomic,weak)UILabel *tiShiPayLabel;
@property (nonatomic,weak)UITextField *totalMoney;
@property (nonatomic,weak)UITextField *discountMoney;
// 支付id
@property (nonatomic,copy)NSString *payId;
// 折扣
@property (nonatomic,copy)NSString *zhekou;
// 金额
@property (nonatomic,copy)NSString *money;
// 贝壳
@property (nonatomic,copy)NSString *beike;
@property (nonatomic,weak)UILabel *shoppingName;

@end

@implementation IWNearCommitBillVC
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
    
    self.title = @"提交订单";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *shoppingName = [[UILabel alloc]initWithFrame:CGRectMake(0,64 + kFRate(15), kViewWidth, kFRate(15))];
    shoppingName.font = kFont28px;
    shoppingName.textColor = [UIColor blackColor];
    shoppingName.textAlignment = NSTextAlignmentCenter;
    shoppingName.text = self.shopName;
    [self.view addSubview:shoppingName];
    self.shoppingName = shoppingName;
    
    UITextField *totalMoney = [[UITextField alloc]initWithFrame:CGRectMake(kFRate(35), CGRectGetMaxY(shoppingName.frame) + kFRate(10), kViewWidth - kFRate(35) * 2, kFRate(42))];
    totalMoney.borderStyle = UITextBorderStyleRoundedRect;
    totalMoney.keyboardType = UIKeyboardTypeDecimalPad;
    totalMoney.placeholder = @"请输入本次消费金额";
    [totalMoney addTarget:self action:@selector(groupTextFiled:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:totalMoney];
    totalMoney.delegate = self;
    self.totalMoney = totalMoney;
    
//    
//    UILabel *shuRuLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(totalMoney.frame) + kFRate(15), kViewWidth, kFRate(15))];
//    shuRuLabel.font = kFont22px;
//    shuRuLabel.textColor = [UIColor grayColor];
//    shuRuLabel.textAlignment = NSTextAlignmentCenter;
//    shuRuLabel.text = self.shopName;
//    [self.view addSubview:shuRuLabel];
//    
//    UITextField *discountMoney = [[UITextField alloc]initWithFrame:CGRectMake(kFRate(35), CGRectGetMaxY(shuRuLabel.frame) + kFRate(10), kViewWidth - kFRate(35) * 2, kFRate(42))];
//    discountMoney.placeholder = @"请输入不打折扣部分的消费金额";
//    [self.view addSubview:discountMoney];
//    self.discountMoney = discountMoney;
    
    
    UILabel *tiShiPayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(totalMoney.frame) + kFRate(10), kViewWidth, kFRate(15))];
    tiShiPayLabel.font = kFont26px;
    tiShiPayLabel.textColor = [UIColor grayColor];
    tiShiPayLabel.textAlignment = NSTextAlignmentCenter;
    tiShiPayLabel.text =  @"需要支付现金0.00 + 0个贝壳";
    [self.view addSubview:tiShiPayLabel];
    self.tiShiPayLabel = tiShiPayLabel;
    
    
    UIButton  *payButton = [[UIButton alloc]initWithFrame:CGRectMake(kFRate(30), CGRectGetMaxY(tiShiPayLabel.frame) + kFRate(40), kViewWidth - 2* kFRate(30), kFRate(43))];
    payButton.backgroundColor = IWColorRed;
    [payButton setTitle:@"买单" forState:UIControlStateNormal];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payButton.titleLabel.font = kFont28px;
    [self.view addSubview:payButton];
    [payButton addTarget: self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self updata];
    
    [self updataUserInfo];
    
    //检测是否装了微信软件
    if ([WXApi isWXAppInstalled]){ //监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXPay" object:nil];
    }
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(aliPayCallBack:) name:@"aliPayCallBack" object:nil];
}

 -(void)updataUserInfo{
  
     
     NSString  *url = [NSString stringWithFormat:@"%@/%@?userId=%@",kNetUrl,@"user/freshUserInfo",[ASingleton shareInstance].loginModel.userId];
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
         
         IWLog(@"--3414321---%@-----",contentDict);
         
         /*{
          birthday = "2017-03-23";
          createdTime = 1490079923000;
          email = "";
          isRemind = 0;
          nickName = "\U5e7f\U544a\U8d39\U65b9\U6cd5";
          parentId = "-1";
          payQrCode = "";
          phone = 18565822821;
          qrCode = "";
          region = "";
          sex = 1;
          shopId = 19;
          state = 0;
          updatedTime = 1490446594000;
          userAccount = 18565822821;
          userBalance = 0;
          userId = 36;
          userImg = "";
          userIntegral = 0;
          userName = "18565822821\U4e0d\U5305\U4e0d\U4e3a\U96be";
          }*/
         
     } failure:^(NSError *error) {
         [[ASingleton shareInstance] stopLoadingView];
         
         [weakSelf failSetup];
     }];
}

-(void)updata{
    NSString  *url = [NSString stringWithFormat:@"%@/%@?shopId=%@",kNetUrl,@"order/scanCodeShop",self.shopId];
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        IWLog(@"-----%@-----",url);
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
        
        IWLog(@"-----%@-----",contentDict);
        
        /*{
         city = "";
         country = "\U4e2d\U56fd";
         discountRatio = 70;
         district = "";
         province = "";
         shopAddress = "\U534e\U5f3a\U5317\U8def\U4e0a\U6b65\U5de5\U4e1a\U533a102\U680b\U4e8c\U697c";
         shopId = 17;
         shopLevel = 3;
         shopLogo = "/aigou/shop/20170312/2a2b2415-d149-4f38-a87f-500a1b92fb19.jpg";
         shopName = "\U9ea6\U5f53\U52b3(\U8302\U4e1a\U5e97)";
         shopNum = "";
         shopOfiiceTime = "9:00-22:00";
         shopPhone = 18565660736;
         shopQrCode = "/aigou/shop/20170312/8fdc95f7-fe77-479c-b6d3-78ae830c4798.jpg";
         shopSummary = "\U5e97\U94fa\U7b80\U4ecb";
         shopTel = "0755-83048959";
         shopType = 2;
         shopUrl = "http://www.taobao.com";
         shopX = "114.091549";
         shopY = "22.553081";
         }*/
        weakSelf.shopName = contentDict[@"shopName"]?contentDict[@"shopName"]:@"";
        weakSelf.zhekou = contentDict[@"discountRatio"]?contentDict[@"discountRatio"]:@"0";
        weakSelf.shoppingName.text = contentDict[@"shopName"]?contentDict[@"shopName"]:@"";
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        
        [weakSelf failSetup];
    }];
}

#pragma mark - textField
- (void)groupTextFiled:(UITextField *)textField
{
    CGFloat moneyF = [textField.text floatValue];
    CGFloat beike = [[ASingleton shareInstance].loginModel.userIntegral floatValue];
    if (moneyF * (1 - [_zhekou floatValue] / 100) < beike) {
        _beike = [NSString stringWithFormat:@"%.2f",moneyF * (1 - [_zhekou floatValue] / 100)];
        _money = [NSString stringWithFormat:@"%.2f",moneyF - moneyF * (1 - [_zhekou floatValue] / 100)];
    }else{
        _beike = [NSString stringWithFormat:@"%.2f",[[ASingleton shareInstance].loginModel.userIntegral floatValue]];
        _money = [NSString stringWithFormat:@"%.2f",moneyF - [[ASingleton shareInstance].loginModel.userIntegral floatValue]];
    }
    _tiShiPayLabel.text =  [NSString stringWithFormat:@"需要支付现金%@ + %@个贝壳",_money,_beike];
}

-(void)failSetup{


}
-(void)payButtonClick{

//    if (self.totalMoney.text.length > 0 && self.discountMoney.text.length > 0) {
//
//    }
    
//    IWNearSurePayVC *payVC = [[IWNearSurePayVC alloc]init];
//    
//    [self.navigationController pushViewController:payVC animated:YES];
    
    [self payWay];
    
}

- (BOOL)isEmpty:(NSString *)str
{
    if (!str) {
        return YES;
    }else{
        str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return YES;
        }else{
            return NO;
        }
    }
}

#pragma mark - 买单
- (void)payWay{
    if ([self isEmpty:_totalMoney.text]) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入金额"];
        [_totalMoney endEditing:YES];
        return;
    }
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/order/createShopOrder?userId=%@&userName=%@&shopId=%@&shopName=%@&payPrice=%@&integral=%@&type=%@",kNetUrl,[ASingleton shareInstance].loginModel.userId,[ASingleton shareInstance].loginModel.userName,_shopId,_shopName,_money,_beike,@"0"];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    IWLog(@"url==========%@",url);
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf failData:@"提交订单失败"];
            return ;
        }
        if (![json[@"code"] isEqual:@"0"]) {
            [weakSelf failData:json[@"message"]];
            return ;
        }
        // 订单id
        weakSelf.payId = json[@"data"]?json[@"data"]:@"";
        [weakSelf setupPickViewWithOrderIds:weakSelf.payId];
        
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf failData:@"提交订单失败"];
        return ;
    }];
}

#pragma mark - 支付
-(void)setupPickViewWithOrderIds:(NSString *)orderIds{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alerTure = [UIAlertController alertControllerWithTitle:@"" message:@"选择支付方式" preferredStyle:UIAlertControllerStyleActionSheet];
    // 添加按钮
    UIAlertAction *weiXing = [UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 请求
        [weakSelf payFromRow:0 orderIds:orderIds];
    }];
    [alerTure addAction:weiXing];
    // 添加按钮
    UIAlertAction *zhiFuBao = [UIAlertAction actionWithTitle:@"支付宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 请求
        [weakSelf payFromRow:1 orderIds:orderIds];
    }];
    [alerTure addAction:zhiFuBao];
    // 添加按钮
    UIAlertAction *yinLian = [UIAlertAction actionWithTitle:@"银联" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 请求
        [weakSelf payFromRow:2 orderIds:orderIds];
    }];
//    [alerTure addAction:yinLian];
    // 取消按钮
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //        IWTabBarViewController *tbVC = (IWTabBarViewController *)self.tabBarController;
        //        [tbVC from:2 To:3 isRootVC:NO currentVC:self];
        
        [weakSelf  payOrderFinishSuccess];
        
    }];
    [alerTure addAction:cancel];
    [weiXing setValue:[UIColor greenColor] forKey:@"titleTextColor"];
//    [zhiFuBao setValue:[UIColor greenColor] forKey:@"titleTextColor"];
//    [yinLian setValue:[UIColor greenColor] forKey:@"titleTextColor"];
    [cancel setValue:kRedColor forKey:@"titleTextColor"];
    [self presentViewController:alerTure animated:YES completion:nil];
}


- (void)filishPay:(NSInteger)index
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/order/payShopOrderFinish?orderId=%@",kNetUrl,_payId];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    IWLog(@"url==========%@",url);
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf failData:@"支付失败"];
            return ;
        }
        if (![json[@"code"] isEqual:@"0"]) {
            [weakSelf failData:json[@"message"]];
            return ;
        }
        NSDictionary *data = json[@"data"]?json[@"data"]:@{};
        IWPayFilishVC *vc = [[IWPayFilishVC alloc] init];
        vc.money = [_money floatValue];
        vc.beike = [_beike floatValue];
        vc.bianHao = data[@"orderNum"]?data[@"orderNum"]:@"";
        switch (index) {
            case 0:
                vc.fangShi = @"微信";
                break;
            case 1:
                vc.fangShi = @"支付宝";
                break;
            case 2:
                vc.fangShi = @"银联";
                break;
            default:
                break;
        }
        
        vc.shopId = _shopId;
        vc.orderId = data[@"orderId"]?data[@"orderId"]:@"";
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf failData:@"支付失败"];
        return ;
    }];
    
}

#pragma mark  付款
-(void)payFromRow:(int) index  orderIds:(NSString *)orderIds{
    switch (index) {
        case 0://微信
            if ([WXApi isWXAppInstalled]){
                [self sendNetWorking_WXPayWithOrderIds:orderIds payPrice:[NSString stringWithFormat:@"%.2f", [_money floatValue]]];
            }else{
                [self alert:@"提示" msg:@"未安装微信"];
            }
            break;
        case 1://支付宝
        {
//需要填写商户app申请的
            NSString *appID = kAliPayAppID;
//私钥
            NSString *rsa2PrivateKey = kRsa2PrivateKey;
            NSString *rsaPrivateKey = @"";
            /*
             *生成订单信息及签名
             */
            //将商品信息赋予AlixPayOrder的成员变量
            Order* order = [Order new];
            
            // NOTE: app_id设置
            order.app_id = appID;
            
            // NOTE: 支付接口名称
            order.method = @"alipay.trade.app.pay";
            
            // NOTE: 参数编码格式
            order.charset = @"utf-8";
            
            // NOTE: 当前时间点
            NSDateFormatter* formatter = [NSDateFormatter new];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            order.timestamp = [formatter stringFromDate:[NSDate date]];
            
            // NOTE: 支付版本
            order.version = @"1.0";
            
            // NOTE: sign_type 根据商户设置的私钥来决定
            order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
            
            // NOTE: 商品数据
            order.biz_content = [BizContent new];
            order.biz_content.body = @"";
            if ([_shopName isEqual:@""] || [_shopName isKindOfClass:[NSNull class]]) {
                _shopName = nil;
            }
            order.biz_content.subject = _shopName?:@"商店";
            
// 订单号
            order.biz_content.out_trade_no = orderIds; //订单ID（由商家自行制定）
            order.biz_content.timeout_express = @"30m"; //超时时间设置
            order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", [_money floatValue]]; //商品价格
            
            //将商品信息拼接成字符串
            NSString *orderInfo = [order orderInfoEncoded:NO];
            NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
            NSLog(@"orderSpec = %@",orderInfo);
            
            // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
            //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
            NSString *signedString = nil;
            RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
            if ((rsa2PrivateKey.length > 1)) {
                signedString = [signer signString:orderInfo withRSA2:YES];
            } else {
                signedString = [signer signString:orderInfo withRSA2:NO];
            }
            
            // NOTE: 如果加签成功，则继续执行支付
            if (signedString != nil) {
                //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
                NSString *appScheme = @"IWShopping";
                
                // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
                NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                         orderInfoEncoded, signedString];
                __weak typeof(self) weaKself = self;
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    
                    
                    NSLog(@"reslut = %@",resultDic);
                  
                }];
            }
        }
            break;
            
            
        default:[self payOrderFinishWIthOrderIds:orderIds];
            break;
    }
    
    
    
}
#pragma mark    支付宝付款通知
-(void)aliPayCallBack:(NSNotification*) notification{
    NSDictionary  *object =   [notification object];//通过这个获取到传递的对象
    /* result = "{\"alipay_trade_app_pay_response\":{\"code\":\"10000\",\"msg\":\"Success\",\"app_id\":\"2017040506558991\",\"auth_app_id\":\"2017040506558991\",\"charset\":\"utf-8\",\"timestamp\":\"2017-04-09 00:14:15\",\"total_amount\":\"0.01\",\"trade_no\":\"2017040921001004340257093639\",\"seller_id\":\"2088621609397812\",\"out_trade_no\":\"521\"},\"sign\":\"lGo6OGL8/DybIQblJHR4/M6OrR2mY0EhPmSePtWHxQFi5uuOXCx4UGZVgQRcOh28e7drAXCFN8wkeu8zz//ELvTl1FfZTM64W92Vxu6oRNLXWevkvW9FLSpJOf22OgFDQZPFLCz9vbq4C246U+1pw0EAn3MWXhHJAImxPCJeMPn5Y9XK0UIUTnS3o7axRubRQdPIs9FZHvhTyAbzc1kYmCD3RTUxiN/VqvrWWiWX7P7CUaK79k0ErY3dOveuodvam6kCSDtaIN5L8RjDRS9u7h6C4YkkMjP98EXkiDbJNTHQVJ5K2mkDrdPTZ63hVvtujXzItchjUSmQzdjm90M2rQ==\",\"sign_type\":\"RSA2\"}";
     resultStatus = 9000;*/
    //结果处理,其实就是取字典里面的内容,这个取字符串然后变个模型就好了 或者直接取不便模型,方法很多.
    NSLog(@"开始确认支付状态 %@",object[@"resultStatus"]);
    //状态返回9000为成功
    if ([object[@"resultStatus"] isEqual:@"9000"])
    {
        NSLog(@"支付宝交易成功");
        [self payOrderFinishWIthOrderIds:self.payId];
    }else if([object[@"resultStatus"] isEqual:@"6001"]){
        //用户取消
        NSLog(@"用户主动取消支付");
        [self payOrderFinishSuccess];
    }else{
        //失败
        [self payOrderFinishSuccess];
    }
}

#pragma mark   结束付款 回调
-(void)payOrderFinishWIthOrderIds:(NSString *)orderIds{
    [self filishPay:1];
}
#pragma mark 结束付款成功 回调
-(void)payOrderFinishSuccess{
    IWTabBarViewController *tbVC = (IWTabBarViewController *)self.tabBarController;
    [tbVC from:0 To:0 isRootVC:NO currentVC:self];
}


#pragma mark ************************************* 微信支付相关 ******************************
#pragma mark 微信支付
- (void)sendNetWorking_WXPayWithOrderIds:(NSString *)orderIds payPrice:(NSString *)payPrice{
    
    [[ASingleton shareInstance]startLoadingInView:self.view];
    NSString *url = [NSString stringWithFormat:@"%@/%@?payPrice=%@&orderIds=%@",kNetUrl,@"pay/weixin",payPrice,orderIds];
    
    __weak typeof(self) weakSelf = self;
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
        NSDictionary *contentDic = json[@"data"];
        if (!contentDic || ![contentDic isKindOfClass:[NSDictionary class]]) {
            [weakSelf failSetup];
            return ;
        }
        
        NSString *appid         = contentDic[@"appid"]?contentDic[@"appid"]:@"";
        NSString *noncestr      = contentDic[@"noncestr"]?contentDic[@"noncestr"]:@"";
        NSString *package       = contentDic[@"package"]?contentDic[@"package"]:@"";
        NSString *partnerid     = contentDic[@"partnerid"]?contentDic[@"partnerid"]:@"";
        NSString *sign          = contentDic[@"sign"]?contentDic[@"sign"]:@"";
        NSString *prepayid      = contentDic[@"prepayid"]?contentDic[@"prepayid"]:@"";
        NSString *timestamp     = contentDic[@"timestamp"]?contentDic[@"timestamp"]:@"";
        
        
        //调起微信支付
        PayReq* wxreq             = [[PayReq alloc] init];
        wxreq.openID              = appid; // 微信的appid
        wxreq.partnerId           = partnerid;
        wxreq.prepayId            = prepayid;
        wxreq.nonceStr            = noncestr;
        wxreq.timeStamp           = [timestamp intValue];
        wxreq.package             = package;
        wxreq.sign                = sign;
        [WXApi sendReq:wxreq];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [weakSelf failSetup];
    }];

}
#pragma mark - 事件
- (void)getOrderPayResult:(NSNotification *)notification{
    NSLog(@"userInfo: %@",notification.userInfo);
    if ([notification.object isEqualToString:@"success"]){
        //回调
        [self  payOrderFinishWIthOrderIds:self.payId];
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        [self alert:@"提示" msg:@"支付失败"];
        //回调
        [self  payOrderFinishSuccess];
    }
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}
#pragma mark 移除通知
- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)failData:(NSString *)str
{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:str];
    IWTabBarViewController *tbVC = (IWTabBarViewController *)self.tabBarController;
    [tbVC from:0 To:0 isRootVC:NO currentVC:self];
}

#pragma mark - 取消
- (void)cancelBtn
{
    IWTabBarViewController *tbVC = (IWTabBarViewController *)self.tabBarController;
    [tbVC from:0 To:0 isRootVC:NO currentVC:self];
}

@end
