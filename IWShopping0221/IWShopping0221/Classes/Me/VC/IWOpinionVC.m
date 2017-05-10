//
//  IWOpinionVC.m
//  IWShopping0221
//
//  Created by admin on 2017/3/3.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWOpinionVC.h"
#import "ATextView.h"

@interface IWOpinionVC ()<UITextViewDelegate>
@property (nonatomic,weak)ATextView *itemContent;
@end

@implementation IWOpinionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 左按钮
    self.navigationItem.title = @"意见反馈";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    // 意见反馈
    UILabel *opinionLabel = [[UILabel alloc] init];
    opinionLabel.text = @"意见反馈";
    opinionLabel.textColor = IWColor(29, 29, 29);
    opinionLabel.font = kFont32px;
    [opinionLabel sizeToFit];
    opinionLabel.frame = CGRectMake(kFRate(10), 64, opinionLabel.frame.size.width, kFRate(45));
    [self.view addSubview:opinionLabel];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(opinionLabel.frame) + kFRate(5), 64, kViewWidth - CGRectGetMaxX(opinionLabel.frame) - kFRate(5), kFRate(45))];
    descriptionLabel.textColor = IWColor(154, 154, 154);
    descriptionLabel.text = @"(请留下您的意见反馈,我们会及时处理)";
    descriptionLabel.font = kFont24px;
    [self.view addSubview:descriptionLabel];
    
    // 分割线
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(0, kFRate(45) + 64, kViewWidth, kFRate(0.5))];
    linView.backgroundColor = kLineColor;
    [self.view addSubview:linView];
    
    // 输入框
    // 主题编辑内容
    ATextView *itemContent = [[ATextView alloc] initWithFrame:CGRectMake(kFRate(10) , CGRectGetMaxY(linView.frame) + kFRate(5), kViewWidth - kFRate(20), kFRate(150))];
    itemContent.font = kFont28px;
    itemContent.editable = YES;   //是否允许编辑内容，默认为“YES”
    itemContent.textColor = IWColor(29, 29, 29);
    itemContent.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    itemContent.showsVerticalScrollIndicator = YES;
    itemContent.placeholder = @"最多只能800字...";
    itemContent.placeholderColor = IWColor(154, 154, 154);
    itemContent.delegate = self;
    [self.view addSubview:itemContent];
    self.itemContent = itemContent;
    
    UIView *lastLin = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(itemContent.frame), kViewWidth, kFRate(0.5))];
    lastLin.backgroundColor = kLineColor;
    [self.view addSubview:lastLin];
    
    // 登陆按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(kFRate(35), CGRectGetMaxY(lastLin.frame) + kFRate(35), kViewWidth - kFRate(70), kFRate(45));
    loginBtn.backgroundColor = IWColor(252, 56, 100);
    [loginBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kFont34px;
    loginBtn.layer.cornerRadius = kFRate(5.0f);
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

- (void)collectionLeftCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 提交
- (void)loginBtnClick
{
    [self.itemContent endEditing:YES];
    if ([self isEmpty:self.itemContent.text] == NO) {
        __weak typeof(self) weakSelf = self;
        NSString *url = [NSString stringWithFormat:@"%@/user/suggest?userId=%@&userName=%@&description=%@",kNetUrl,[ASingleton shareInstance].loginModel.userId,[ASingleton shareInstance].loginModel.userName,self.itemContent.text];
        url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
        [[ASingleton shareInstance]startLoadingInView:self.view];
        [IWHttpTool getWithURL:url params:nil success:^(id json) {
            [[ASingleton shareInstance]stopLoadingView];
            IWLog(@"json=======%@",json);
            if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
                [weakSelf allFailData:@"意见反馈失败"];
                return ;
            }
            if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
                [weakSelf allFailData:json[@"message"]];
                return ;
            }
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"意见反馈成功"];
        } failure:^(NSError *error) {
            [[ASingleton shareInstance]stopLoadingView];
            [weakSelf allFailData:@"意见反馈失败"];
            return ;
        }];
    }else{
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入您的宝贵意见"];
    }
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
