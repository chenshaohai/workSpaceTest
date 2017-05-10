//
//  IWRegisterVC.m
//  IWShopping0221
//
//  Created by admin on 2017/2/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWRegisterVC.h"
#import "SGScanningQRCodeVC.h"
//#import "SGGenerateQRCodeVC.h"
#import "SGAlertView.h"
#import <AVFoundation/AVFoundation.h>
#import "IWRegisterModel.h"

@interface IWRegisterVC ()
// 手机号码
@property (nonatomic,strong)UITextField *phoneText;
// 手机验证码
@property (nonatomic,strong)UITextField *testNumText;
// 推荐码或手机号
@property (nonatomic,strong)UITextField *recommendText;
// 密码
@property (nonatomic,strong)UITextField *passwdText;
// 再输入密码
@property (nonatomic,strong)UITextField *againPwdText;
// 发送验证码按钮
@property (nonatomic,weak)UIButton *testBtn;

@end

// 输入框高度
#define kTextH kRate(60)

@implementation IWRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"注册";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SGScanningQRCode:) name:@"SGScanningQRCode" object:nil];
}

- (void)SGScanningQRCode:(NSNotification *)no
{
    NSDictionary *dic = no.userInfo;
    self.recommendText.text = dic[@"key"];
}

- (void)collectionLeftCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createView
{
    // 输入框圆角背景
    CGFloat backH = kFRate(63) * 5;
    CGFloat backW = kViewWidth - kFRate(35);
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(kFRate(17.5), kFRate(58) + 64, backW, backH)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderWidth = kFRate(1);
    backView.layer.cornerRadius = kFRate(8);
    backView.layer.borderColor = [UIColor HexColorToRedGreenBlue:@"#d2d2d2"].CGColor;
    [self.view addSubview:backView];
    
    for (NSInteger i = 0; i < 4; i ++) {
        UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(0, kFRate(63) * (i + 1) - kFRate(0.5), kViewWidth - kFRate(35), kFRate(0.5))];
        linView.backgroundColor = [UIColor HexColorToRedGreenBlue:@"#c9c9c9"];
        [backView addSubview:linView];
    }
    
    // 手机号码
    UIImageView *phoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(kFRate(18.5), kFRate(19), kFRate(16), kFRate(25))];
    phoneImg.image = _IMG(@"IWPhone");
    [backView addSubview:phoneImg];
    
    _phoneText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(phoneImg.frame) + kFRate(18.5), 0, backW - CGRectGetMaxX(phoneImg.frame) - kFRate(18.5), kFRate(62.5))];
    _phoneText.placeholder = @"请输入手机号码";
    _phoneText.autocorrectionType = UITextAutocorrectionTypeNo;
    _phoneText.textColor = [UIColor blackColor];
    _phoneText.font = kFont32px;
    _phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneText.backgroundColor = [UIColor clearColor];
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    [backView addSubview:_phoneText];
    
    // 手机验证码
    UIImageView *testNumImg = [[UIImageView alloc] initWithFrame:CGRectMake(kFRate(18.5), kFRate(63) + kFRate(19), kFRate(16), kFRate(25))];
    testNumImg.image = _IMG(@"IWTestNum");
    [backView addSubview:testNumImg];
    
    _testNumText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(testNumImg.frame) + kFRate(18.5), kFRate(63), backW - CGRectGetMaxX(testNumImg.frame) - kFRate(18.5) - kFRate(100), kFRate(62.5))];
    _testNumText.placeholder = @"手机验证码";
    _testNumText.autocorrectionType = UITextAutocorrectionTypeNo;
    _testNumText.textColor = [UIColor blackColor];
    _testNumText.font = kFont32px;
    _testNumText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _testNumText.backgroundColor = [UIColor clearColor];
    _testNumText.keyboardType = UIKeyboardTypeNumberPad;
    [backView addSubview:_testNumText];
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.frame = CGRectMake(CGRectGetMaxX(_testNumText.frame), kFRate(63) + kFRate(15), kFRate(95), kFRate(33));
    [testBtn setTitle:@"验证码" forState:UIControlStateNormal];
    testBtn.backgroundColor = IWColor(252, 56, 100);
    testBtn.layer.cornerRadius = kFRate(3.0f);
    [testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    testBtn.titleLabel.font = kFont28px;
    [testBtn addTarget:self action:@selector(testBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:testBtn];
    self.testBtn = testBtn;
    
    //推荐码
    UIImageView *recommendImg = [[UIImageView alloc] initWithFrame:CGRectMake(kFRate(18.5), kFRate(63) * 2 + kFRate(21.5), kFRate(18), kFRate(20))];
    recommendImg.image = _IMG(@"IWRecommend");
    [backView addSubview:recommendImg];
    
    _recommendText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(testNumImg.frame) + kFRate(18.5), kFRate(63) * 2, backW - CGRectGetMaxX(testNumImg.frame) - kFRate(18.5) - kFRate(40), kFRate(62.5))];
    _recommendText.placeholder = @"请输入推荐号码或手机号";
    _recommendText.autocorrectionType = UITextAutocorrectionTypeNo;
    _recommendText.textColor = [UIColor blackColor];
    _recommendText.font = kFont32px;
    _recommendText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _recommendText.backgroundColor = [UIColor clearColor];
    _recommendText.keyboardType = UIKeyboardTypeNumberPad;
    [backView addSubview:_recommendText];
    
    UIButton *recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    recommendBtn.frame = CGRectMake(CGRectGetMaxX(_recommendText.frame), kFRate(63) * 2 + kFRate(15), kFRate(35), kFRate(33));
    [recommendBtn setImage:_IMG(@"IWScanPhone") forState:UIControlStateNormal];
    [recommendBtn addTarget:self action:@selector(recommendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:recommendBtn];
    
    // 密码
    UIImageView *passImg = [[UIImageView alloc] initWithFrame:CGRectMake(kFRate(18.5), kFRate(63) * 3 + kFRate(19.5), kFRate(20), kFRate(24))];
    passImg.image = _IMG(@"IWHover");
    [backView addSubview:passImg];
    
    _passwdText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(testNumImg.frame) + kFRate(18.5), kFRate(63) * 3, backW - CGRectGetMaxX(testNumImg.frame) - kFRate(18.5), kFRate(62.5))];
    _passwdText.placeholder = @"请输入密码（6-18位）";
    _passwdText.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwdText.textColor = [UIColor blackColor];
    _passwdText.font = kFont32px;
    _passwdText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwdText.backgroundColor = [UIColor clearColor];
    [backView addSubview:_passwdText];
    
    // 再次输入密码
    UIImageView *againPassImg = [[UIImageView alloc] initWithFrame:CGRectMake(kFRate(18.5), kFRate(63) * 4 + kFRate(19.5), kFRate(20), kFRate(24))];
    againPassImg.image = _IMG(@"IWHover");
    [backView addSubview:againPassImg];
    
    _againPwdText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(testNumImg.frame) + kFRate(18.5), kFRate(63) * 4, backW - CGRectGetMaxX(testNumImg.frame) - kFRate(18.5), kFRate(62.5))];
    _againPwdText.placeholder = @"再一次确认密码（6-18位）";
    _againPwdText.autocorrectionType = UITextAutocorrectionTypeNo;
    _againPwdText.textColor = [UIColor blackColor];
    _againPwdText.font = kFont32px;
    _againPwdText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _againPwdText.backgroundColor = [UIColor clearColor];
    [backView addSubview:_againPwdText];
    
    // 注册
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(backView.frame.origin.x, CGRectGetMaxY(backView.frame) + kFRate(30), backView.frame.size.width, kFRate(45));
    loginBtn.backgroundColor = IWColor(252, 56, 100);
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kFont34px;
    loginBtn.layer.cornerRadius = kFRate(5.0f);
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    NSString *str1 = @"已有账号,去登录";
    NSString *str3 = @"登录";
    UIButton *forgateBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgateBtn1 setTitleColor:IWColor(100, 100, 100) forState:UIControlStateNormal];
    CGSize maximumLabelSize1 = CGSizeMake(MAXFLOAT, kFRate(15));//labelsize的最大值
    NSDictionary *attribute1 = @{NSFontAttributeName: kFont28px};
    CGSize expectSize1 = [str1 boundingRectWithSize:maximumLabelSize1 options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute1 context:nil].size;
    CGFloat forX1 = kViewWidth - expectSize1.width - kFRate(35);
    CGFloat forY1 = CGRectGetMaxY(loginBtn.frame) + kFRate(15);
    CGFloat forW1 = expectSize1.width;
    CGFloat forH1 = kFRate(20);
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",str1]];
    NSRange redRange = NSMakeRange([[str2 string] rangeOfString:str3].location, [[str2 string] rangeOfString:str3].length);
    [str2 addAttribute:NSForegroundColorAttributeName value:kRedColor range:redRange];
    
    forgateBtn1.frame = CGRectMake(forX1, forY1, forW1, forH1);
    [forgateBtn1 setAttributedTitle:str2 forState:UIControlStateNormal];
    forgateBtn1.backgroundColor = [UIColor whiteColor];
    forgateBtn1.titleLabel.font = kFont28px;
    [forgateBtn1 addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgateBtn1];
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

- (void)registerBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 注册
- (void)loginBtnClick
{
    if ([self isEmpty:_phoneText.text]) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入手机号"];
    }else if ([self isEmpty:_testNumText.text]){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入验证码"];
    }else if ([self isEmpty:_recommendText.text]){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入推荐人号码"];
    }else if ([self isEmpty:_passwdText.text]){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入密码"];
    }else if ([self isEmpty:_againPwdText.text]){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请再次输入密码"];
    }else{
        if (![self.passwdText.text isEqual:self.againPwdText.text]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"密码输入不一致"];
        }else{
            [self requestRegister];
        }
    }
}

#pragma mark - 注册请求
- (void)requestRegister
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/register?userAccount=%@&password=%@&code=%@&parentId=%@",kNetUrl,_phoneText.text,_passwdText.text,_testNumText.text,_recommendText.text];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (!json || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf allFailData:@"注册失败"];
            return ;
        }
        if (!json[@"code"] || ![json[@"code"] isEqual:@"0"]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"注册失败"];
            return ;
        }
        if (!json[@"data"] || ![json[@"data"] isKindOfClass:[NSDictionary class]]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"注册失败"];
            return ;
        }
        NSDictionary *dic = json[@"data"];
//        IWRegisterModel *model = [[IWRegisterModel alloc] initWithDic:dic];
        [self.navigationController popViewControllerAnimated:YES];
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"注册成功"];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf allFailData:@"注册失败"];
        return ;
    }];
}

- (void)allFailData:(NSString *)str
{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:str];
}

#pragma mark - 验证码
- (void)testBtnClick
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/getValicationCode?phone=%@",kNetUrl,self.phoneText.text];
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [weakSelf.testBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [weakSelf.testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                weakSelf.testBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [weakSelf.testBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [weakSelf.testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                weakSelf.testBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        if (json && [json[@"code"] isEqual:@"0"]) {
            if (json[@"data"]) {
                
            }else{
                [weakSelf allFailData:@"获取验证码失败"];
            }
        }else{
            [weakSelf allFailData:@"获取验证码失败"];
        }
        IWLog(@"%@",json);
    } failure:^(NSError *error) {
        [weakSelf allFailData:@"获取验证码失败"];
    }];
}

- (void)recommendBtnClick
{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
                        scanningQRCodeVC.inToType = @"1";
                        [self.navigationController pushViewController:scanningQRCodeVC animated:YES];
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
            SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
            [self.navigationController pushViewController:scanningQRCodeVC animated:YES];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
