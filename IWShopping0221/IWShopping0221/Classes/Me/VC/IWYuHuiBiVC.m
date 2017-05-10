//
//  IWYuHuiBiVC.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/7.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWYuHuiBiVC.h"

@interface IWYuHuiBiVC ()

@end

@implementation IWYuHuiBiVC
- (void)collectionLeftCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 左按钮
    self.navigationItem.title = @"账户余币";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64)];
    webView.backgroundColor = [UIColor whiteColor];
    //自动对页面进行缩放以适应屏幕
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    NSURL* url = [NSURL URLWithString:[ASingleton shareInstance].loginModel.integralUrl];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
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
