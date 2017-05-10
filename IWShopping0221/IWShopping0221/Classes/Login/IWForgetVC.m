//
//  IWForgetVC.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/25.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWForgetVC.h"

@interface IWForgetVC ()
// 手机号码
@property (nonatomic,strong)UITextField *phoneText;
// 手机验证码
@property (nonatomic,strong)UITextField *testNumText;
// 密码
@property (nonatomic,strong)UITextField *passwdText;
// 再输入密码
@property (nonatomic,strong)UITextField *againPwdText;
// 发送验证码按钮
@property (nonatomic,weak)UIButton *testBtn;

@end
// 输入框高度
#define kTextH kRate(60)
@implementation IWForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"密码找回";
    // Do any additional setup after loading the view.
    // 输入框圆角背景
    CGFloat backH = kFRate(63) * 4;
    CGFloat backW = kViewWidth - kFRate(35);
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(kFRate(17.5), kFRate(58) + 64, backW, backH)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderWidth = kFRate(1);
    backView.layer.cornerRadius = kFRate(8);
    backView.layer.borderColor = [UIColor HexColorToRedGreenBlue:@"#d2d2d2"].CGColor;
    [self.view addSubview:backView];
    
    for (NSInteger i = 0; i < 3; i ++) {
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
    
    // 密码
    UIImageView *passImg = [[UIImageView alloc] initWithFrame:CGRectMake(kFRate(18.5), kFRate(63) * 2 + kFRate(19.5), kFRate(20), kFRate(24))];
    passImg.image = _IMG(@"IWHover");
    [backView addSubview:passImg];
    
    _passwdText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(testNumImg.frame) + kFRate(18.5), kFRate(63) * 2, backW - CGRectGetMaxX(testNumImg.frame) - kFRate(18.5), kFRate(62.5))];
    _passwdText.placeholder = @"请输入密码（6-18位）";
    _passwdText.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwdText.textColor = [UIColor blackColor];
    _passwdText.font = kFont32px;
    _passwdText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwdText.backgroundColor = [UIColor clearColor];
    [backView addSubview:_passwdText];
    
    // 再次输入密码
    UIImageView *againPassImg = [[UIImageView alloc] initWithFrame:CGRectMake(kFRate(18.5), kFRate(63) * 3 + kFRate(19.5), kFRate(20), kFRate(24))];
    againPassImg.image = _IMG(@"IWHover");
    [backView addSubview:againPassImg];
    
    _againPwdText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(testNumImg.frame) + kFRate(18.5), kFRate(63) * 3, backW - CGRectGetMaxX(testNumImg.frame) - kFRate(18.5), kFRate(62.5))];
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
    [loginBtn setTitle:@"提交" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kFont34px;
    loginBtn.layer.cornerRadius = kFRate(5.0f);
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

- (void)loginBtnClick
{
    if ([self isEmpty:_phoneText.text]) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入手机号"];
    }else if ([self isEmpty:_testNumText.text]){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入验证码"];
    }else if ([self isEmpty:_passwdText.text]){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入密码"];
    }else if ([self isEmpty:_againPwdText.text]){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请再次输入密码"];
    }else{
        if (![self.passwdText.text isEqual:self.againPwdText.text]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"密码输入不一致"];
        }else{
            [self requestChange];
        }
    }
}

#pragma mark - 提交请求
- (void)requestChange
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/resetPassword?userAccount=%@&code=%@&password=%@",kNetUrl,_phoneText.text,_testNumText.text,_passwdText.text];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (!json || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf allFailData:@"提交失败"];
            return ;
        }
        if (!json[@"code"] || ![json[@"code"] isEqual:@"0"]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"提交失败"];
            return ;
        }
        if (!json[@"data"] || ![json[@"data"] isKindOfClass:[NSDictionary class]]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"提交失败"];
            return ;
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf allFailData:@"提交失败"];
        return ;
    }];
}

- (void)allFailData:(NSString *)str
{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:str];
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

#pragma mark - 验证码
- (void)testBtnClick
{
    if ([self isEmpty:self.phoneText.text]) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入手机号"];
        return;
    }
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/getFindPwdValicationCode?phone=%@",kNetUrl,self.phoneText.text];
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
                dispatch_source_set_event_handler(_timer, ^{
                    
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //设置按钮的样式
                        [weakSelf.testBtn setTitle:@"验证码" forState:UIControlStateNormal];
                        [weakSelf.testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        weakSelf.testBtn.userInteractionEnabled = YES;
                    });
                });
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
