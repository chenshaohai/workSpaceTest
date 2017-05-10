//
//  IWLoginVC.m
//  IWShopping0221
//
//  Created by admin on 2017/2/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWLoginVC.h"
#import "IWHomeViewController.h"
#import "IWRegisterVC.h"
#import "IWLoginModel.h"
#import "IWForgetVC.h"

@interface IWLoginVC ()
// 账号
@property (nonatomic,weak)UITextField *userAcuont;
// 密码
@property (nonatomic,weak)UITextField *pwd;
// 账号
@property (nonatomic,copy)NSString *userAccount;
// 密码
@property (nonatomic,copy)NSString *password;
// model
@property (nonatomic,strong)IWLoginModel *loginModel;
@end

@implementation IWLoginVC

- (void)viewWillAppear:(BOOL)animated
{
    // 获取登录信息
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    self.userAcuont.text = [defaults objectForKey:@"userAccount"]?[defaults objectForKey:@"userAccount"]:@"";//根据键值取出账号密码;
    self.pwd.text = [defaults objectForKey:@"password"]?[defaults objectForKey:@"password"]:@"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取登录信息
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *userAccountStr = [defaults objectForKey:@"userAccount"]?[defaults objectForKey:@"userAccount"]:@"";//根据键值取出账号密码;
    NSString *passwordStr = [defaults objectForKey:@"password"]?[defaults objectForKey:@"password"]:@"";
    
    self.navigationItem.title = @"登陆";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 圆角背景
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(kFRate(35), kFRate(60) + 64, kViewWidth - kFRate(70), kFRate(90))];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderWidth = kFRate(1);
    backView.layer.cornerRadius = kFRate(8);
    backView.layer.borderColor = [UIColor HexColorToRedGreenBlue:@"#d2d2d2"].CGColor;
    [self.view addSubview:backView];
    
    // 账号
    UIImageView *nameImg = [[UIImageView alloc] initWithFrame:CGRectMake(kFRate(30), kFRate(12.5), kFRate(17.5), kFRate(20))];
    nameImg.image = _IMG(@"IWLoginName");
    [backView addSubview:nameImg];
    
    // 账号输入框
    CGFloat userX = CGRectGetMaxX(nameImg.frame) + kFRate(20);
    UITextField *userAcuont = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameImg.frame) + kFRate(20), 0, backView.frame.size.width - userX, kFRate(44))];
    userAcuont.placeholder = @"请输入手机号";
    userAcuont.autocorrectionType = UITextAutocorrectionTypeNo;
    userAcuont.textColor = [UIColor blackColor];
    userAcuont.keyboardType = UIKeyboardTypeNumberPad;
    userAcuont.font = kFont32px;
    userAcuont.clearButtonMode = UITextFieldViewModeWhileEditing;
    userAcuont.backgroundColor = [UIColor clearColor];
    userAcuont.text = userAccountStr;
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
    pwd.placeholder = @"请输入密码";
    pwd.textColor = [UIColor blackColor];
    pwd.font = kFont32px;
    pwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    pwd.secureTextEntry = YES;
    pwd.backgroundColor = [UIColor clearColor];
    pwd.text = passwordStr;
    [backView addSubview:pwd];
    self.pwd = pwd;
    
    // 登陆按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(backView.frame.origin.x, CGRectGetMaxY(backView.frame) + kFRate(30), backView.frame.size.width, kFRate(45));
    loginBtn.backgroundColor = IWColor(252, 56, 100);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kFont34px;
    loginBtn.layer.cornerRadius = kFRate(5.0f);
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    // 忘记密码
    NSString *str = @"忘记密码?";
    UIButton *forgateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize maximumLabelSize = CGSizeMake(MAXFLOAT, kFRate(15));//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName: kFont28px};
    CGSize expectSize = [str boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    CGFloat forX = loginBtn.x;
    CGFloat forY = CGRectGetMaxY(loginBtn.frame) + kFRate(15);
    CGFloat forW = expectSize.width;
    CGFloat forH = kFRate(20);
    forgateBtn.frame = CGRectMake(forX, forY, forW, forH);
    [forgateBtn setTitle:str forState:UIControlStateNormal];
    [forgateBtn setTitleColor:IWColor(252, 56, 100) forState:UIControlStateNormal];
    forgateBtn.backgroundColor = [UIColor whiteColor];
    forgateBtn.titleLabel.font = kFont28px;
    [forgateBtn addTarget:self action:@selector(forgateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgateBtn];
    
    NSString *str1 = @"没有账号,去注册";
    NSString *str3 = @"注册";
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

#pragma mark - 登陆
- (void)loginBtnClick
{
    if ([self isEmpty:self.userAcuont.text]) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入手机号"];
    }else if ([self isEmpty:self.pwd.text]){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入密码"];
    }else{
       [self requestLogin];
    }
}

#pragma mark - 注册
- (void)registerBtnClick
{
    IWRegisterVC *registerVC = [[IWRegisterVC alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
#pragma mark - 忘记密码
- (void)forgateBtnClick
{
    IWForgetVC *vc = [[IWForgetVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)collectionLeftCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 登录请求
- (void)requestLogin
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/login?userAccount=%@&password=%@",kNetUrl,self.userAcuont.text,self.pwd.text];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        
        if (!json || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf allFailData:@"账号或密码错误"];
            return ;
        }
        if (!json[@"code"] || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf allFailData:@"账号或密码错误"];
            return ;
        }
        if (!json[@"data"] || ![json[@"data"] isKindOfClass:[NSDictionary class]]) {
            [weakSelf allFailData:@"账号或密码错误"];
            return ;
        }
        NSDictionary *dataDic = json[@"data"];
        weakSelf.loginModel = [[IWLoginModel alloc] initWithDic:dataDic];
        
        
        [ASingleton shareInstance].loginModel = weakSelf.loginModel;
        [ASingleton shareInstance].homeVCNeedRefresh = YES;
        [ASingleton shareInstance].nearVCNeedRefresh = YES;
         [ASingleton shareInstance].shoppingVCNeedNoRefresh = NO;
        [ASingleton shareInstance].meVCNeedRefresh = YES;
        
        // 登录成功存储userId
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:weakSelf.userAcuont.text forKey:@"userAccount"];
        [defaults setObject:weakSelf.pwd.text forKey:@"password"];
        [defaults setObject:dataDic forKey:@"modelDic"];
        // 登录成功单利赋值
        [weakSelf.navigationController popViewControllerAnimated:YES];
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"登录成功"];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf allFailData:@"账号或密码错误"];
        return ;
    }];
}

- (void)allFailData:(NSString *)str
{
    [ASingleton shareInstance].loginModel = nil;
    [ASingleton shareInstance].homeVCNeedRefresh = NO;
    [ASingleton shareInstance].nearVCNeedRefresh = NO;
    [ASingleton shareInstance].shoppingVCNeedRefresh = NO;
    [ASingleton shareInstance].meVCNeedRefresh = NO;
    
    // 登录成功存储userId
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:@"userAccount"];
    [defaults setObject:@"" forKey:@"password"];
    [defaults setObject:nil forKey:@"modelDic"];
    [[TKAlertCenter defaultCenter]postAlertWithMessage:str];
}

#pragma mark - 登录请求,用于修改个人数据后 刷新数据
+(void)loginWithUserAcount:(NSString *)acount passWord:(NSString *)passWord success:(void (^)(NSString *))success failure:(void (^)(NSString *))failure
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/login?userAccount=%@&password=%@",kNetUrl,acount,passWord];
    [[ASingleton shareInstance]startLoadingInView:nil];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        
        if (!json || ![json isKindOfClass:[NSDictionary class]]) {
            if (failure) {
                failure(@"获取数据失败");
            }
            return ;
        }
        if (!json[@"code"] || ![json[@"code"] isEqual:@"0"]) {
            if (failure) {
                failure(@"获取数据失败");
            }
            return ;
        }
        if (!json[@"data"] || ![json[@"data"] isKindOfClass:[NSDictionary class]]) {
            if (failure) {
                failure(@"获取数据失败");
            }
            return ;
        }
        NSDictionary *dataDic = json[@"data"];
        IWLoginModel *loginModel = [[IWLoginModel alloc] initWithDic:dataDic];
        
        
        [ASingleton shareInstance].loginModel = loginModel;
        [ASingleton shareInstance].meVCNeedRefresh = YES;
        
        // 登录成功存储userId
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:passWord forKey:@"password"];
        [defaults setObject:dataDic forKey:@"modelDic"];
        if (success) {
            success(@"获取数据成功");
        }
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        if (failure) {
            failure(@"获取数据失败");
        }
        return ;
    }];
}

@end
