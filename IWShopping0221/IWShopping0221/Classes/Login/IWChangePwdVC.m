//
//  IWChangePwdVC.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/26.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWChangePwdVC.h"

@interface IWChangePwdVC ()
// 账号
@property (nonatomic,weak)UITextField *userAcuont;
// 密码
@property (nonatomic,weak)UITextField *pwd;
// 再次确认密码
@property (nonatomic,weak)UITextField *againPwd;
@end

@implementation IWChangePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"修改密码";
    // 圆角背景
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(kFRate(35), kFRate(60) + 64, kViewWidth - kFRate(70), kFRate(135))];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderWidth = kFRate(1);
    backView.layer.cornerRadius = kFRate(8);
    backView.layer.borderColor = [UIColor HexColorToRedGreenBlue:@"#d2d2d2"].CGColor;
    [self.view addSubview:backView];
    
    // 账号
    UIImageView *nameImg = [[UIImageView alloc] initWithFrame:CGRectMake(kFRate(30), kFRate(12.5), kFRate(17.5), kFRate(20))];
    nameImg.image = _IMG(@"IWSecrect");
    [backView addSubview:nameImg];
    
    // 账号输入框
    CGFloat userX = CGRectGetMaxX(nameImg.frame) + kFRate(20);
    UITextField *userAcuont = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameImg.frame) + kFRate(20), 0, backView.frame.size.width - userX, kFRate(44))];
    userAcuont.placeholder = @"请输入旧密码";
//    userAcuont.autocorrectionType = UITextAutocorrectionTypeNo;
    userAcuont.textColor = [UIColor blackColor];
//    userAcuont.keyboardType = UIKeyboardTypeNumberPad;
    userAcuont.font = kFont32px;
    userAcuont.clearButtonMode = UITextFieldViewModeWhileEditing;
    userAcuont.secureTextEntry = YES;
    userAcuont.backgroundColor = [UIColor clearColor];
    [backView addSubview:userAcuont];
    self.userAcuont = userAcuont;
    
    // 分界线
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(0, kFRate(44), backView.frame.size.width, kFRate(1))];
    linView.backgroundColor = [UIColor HexColorToRedGreenBlue:@"#d2d2d2"];
    [backView addSubview:linView];
    
    // 密码输入框
    UIImageView *pwdImg = [[UIImageView alloc] initWithFrame:CGRectMake(nameImg.frame.origin.x, CGRectGetMaxY(nameImg.frame) + kFRate(25), kFRate(17.5), kFRate(20))];
    pwdImg.image = _IMG(@"IWSecrect");
    [backView addSubview:pwdImg];
    
    UITextField *pwd = [[UITextField alloc]initWithFrame:CGRectMake(userX, kFRate(45), userAcuont.frame.size.width , userAcuont.frame.size.height)];
    pwd.placeholder = @"请输入新密码";
    pwd.textColor = [UIColor blackColor];
    pwd.font = kFont32px;
    pwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    pwd.secureTextEntry = YES;
    pwd.backgroundColor = [UIColor clearColor];
    [backView addSubview:pwd];
    self.pwd = pwd;
    
    // 分界线
    UIView *linView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pwd.frame), backView.frame.size.width, kFRate(1))];
    linView1.backgroundColor = [UIColor HexColorToRedGreenBlue:@"#d2d2d2"];
    [backView addSubview:linView1];
    
    UIImageView *pwdImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(pwdImg.frame.origin.x, CGRectGetMaxY(pwdImg.frame) + kFRate(25), kFRate(17.5), kFRate(20))];
    pwdImg1.image = _IMG(@"IWSecrect");
    [backView addSubview:pwdImg1];
    
    UITextField *againPwd = [[UITextField alloc]initWithFrame:CGRectMake(userX, CGRectGetMaxY(linView1.frame), userAcuont.frame.size.width , userAcuont.frame.size.height)];
    againPwd.placeholder = @"请再次输入密码";
    againPwd.textColor = [UIColor blackColor];
    againPwd.font = kFont32px;
    againPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    againPwd.secureTextEntry = YES;
    againPwd.backgroundColor = [UIColor clearColor];
    [backView addSubview:againPwd];
    self.againPwd = againPwd;
    
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
    // 获取登录信息
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *pwd = [defaults objectForKey:@"password"]?[defaults objectForKey:@"password"]:@"";
    if ([self isEmpty:_userAcuont.text]) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入旧密码"];
        return;
    }
    if ([self isEmpty:_pwd.text]){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入新密码"];
        return;
    }
    if ([self isEmpty:_againPwd.text]){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请再次输入新密码"];
        return;
    }
    if (![pwd isEqual:_userAcuont.text]) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"旧密码输入错误"];
        return;
    }
    if (![_pwd.text isEqual:_againPwd.text]) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"新密码输入不一致"];
        return;
    }
    [self requestChange];
}

#pragma mark - 提交请求
- (void)requestChange
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/changePassword?oldPassword=%@&newPassword=%@&userId=%@",kNetUrl,_userAcuont.text,_pwd.text,[ASingleton shareInstance].loginModel.userId];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (!json || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf allFailData:@"修改密码失败"];
            return ;
        }
        if (!json[@"code"] || ![json[@"code"] isEqual:@"0"]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"修改密码失败"];
            return ;
        }
        if (!json[@"data"] || ![json[@"data"] isKindOfClass:[NSDictionary class]]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"修改密码失败"];
            return ;
        }
        [ASingleton shareInstance].loginModel.passwd = _pwd.text;
        [self.navigationController popViewControllerAnimated:YES];
        [weakSelf allFailData:@"修改密码成功"];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf allFailData:@"修改密码失败"];
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
