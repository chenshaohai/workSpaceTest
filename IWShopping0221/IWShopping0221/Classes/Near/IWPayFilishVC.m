//
//  IWPayFilishVC.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/29.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWPayFilishVC.h"
#import "TQStarRatingView.h"
#import "ATextView.h"
#import "IWMeOrderFormProductModel.h"
#import "IWTabBarViewController.h"
#import "IWRecordVC.h"

@interface IWPayFilishVC ()<StarRatingViewDelegate,UITextViewDelegate>
@property(nonatomic ,strong)TQStarRatingView *starView;
@property(nonatomic ,strong)ATextView *textView;
@property(nonatomic ,copy)NSString *score;
@end

@implementation IWPayFilishVC
- (void)collectionLeftCilck
{
    IWTabBarViewController *tbVC = (IWTabBarViewController *)self.tabBarController;
    [tbVC from:0 To:0 isRootVC:NO currentVC:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"支付结果";
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64)];
    [self.view addSubview:myScrollView];
    
    CGFloat imageW = kFRate(70);
    UIImageView  *successImageView  = [[UIImageView alloc]initWithFrame:CGRectMake((kViewWidth - imageW)/2, kFRate(30), imageW, imageW)];
    successImageView.image = [UIImage imageNamed:@"IWNearDiscussSuccess"];
    [myScrollView addSubview:successImageView];
    
    
    UILabel *successLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(successImageView.frame) + kFRate(10), kViewWidth, kFRate(30))];
    successLabel.text = @"支付成功";
    successLabel.textColor = IWColor(50, 50, 50);
    successLabel.textAlignment = NSTextAlignmentCenter;
    successLabel.font = kFont40px;
    [myScrollView addSubview:successLabel];
    
    // 金额
    NSString *str = [NSString stringWithFormat:@"¥%.2f+%.2f贝壳",_money,_beike];
    NSString *string = [NSString stringWithFormat:@"共支付：%@",str];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(successLabel.frame) + kFRate(15), kViewWidth, kFRate(14))];
    label2.textColor = IWColor(135, 135, 135);
    label2.font = kFont32px;
    label2.textAlignment = NSTextAlignmentCenter;
    [myScrollView addSubview:label2];

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange redRange = NSMakeRange([[attStr string] rangeOfString:str].location, [[attStr string] rangeOfString:str].length);
    [attStr addAttribute:NSForegroundColorAttributeName value:IWColor(252, 82, 114) range:redRange];
    [label2 setAttributedText:attStr];
    
    // 分割线
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame) + kFRate(15), kViewWidth, kFRate(0.5))];
    linView.backgroundColor = kLineColor;
    [myScrollView addSubview:linView];
    
    // 订单内容
    // 订单编号
    UILabel *dingDan = [[UILabel alloc] init];
    dingDan.text = @"订单编号";
    dingDan.textColor = IWColor(168, 168, 168);
    dingDan.font = kFont28px;
    [dingDan sizeToFit];
    dingDan.frame = CGRectMake(kFRate(10), CGRectGetMaxY(linView.frame) + kFRate(15), dingDan.width, dingDan.height);
    [myScrollView addSubview:dingDan];
    
    UILabel *bianHao = [[UILabel alloc] init];
    bianHao.text = _bianHao?_bianHao:@"";
    bianHao.textColor = IWColor(50, 50, 50);
    bianHao.font = kFont28px;
    [bianHao sizeToFit];
    bianHao.frame = CGRectMake(CGRectGetMaxX(dingDan.frame) + kFRate(10), dingDan.y, bianHao.width, bianHao.height);
    [myScrollView addSubview:bianHao];
    // 支付方式
    UILabel *zhiFu = [[UILabel alloc] init];
    zhiFu.text = @"支付方式";
    zhiFu.textColor = IWColor(168, 168, 168);
    zhiFu.font = kFont28px;
    [zhiFu sizeToFit];
    zhiFu.frame = CGRectMake(dingDan.x, CGRectGetMaxY(dingDan.frame) + kFRate(10), zhiFu.width, zhiFu.height);
    [myScrollView addSubview:zhiFu];
    
    UILabel *fangShi = [[UILabel alloc] init];
    fangShi.text = _fangShi;
    fangShi.textColor = IWColor(50, 50, 50);
    fangShi.font = kFont28px;
    [fangShi sizeToFit];
    fangShi.frame = CGRectMake(CGRectGetMaxX(zhiFu.frame) + kFRate(10), zhiFu.y, fangShi.width, fangShi.height);
    [myScrollView addSubview:fangShi];
    // 支付金额
    UILabel *fuKuan = [[UILabel alloc] init];
    fuKuan.text = @"支付金额";
    fuKuan.textColor = IWColor(168, 168, 168);
    fuKuan.font = kFont28px;
    [fuKuan sizeToFit];
    fuKuan.frame = CGRectMake(dingDan.x, CGRectGetMaxY(zhiFu.frame) + kFRate(10), fuKuan.width, fuKuan.height);
    [myScrollView addSubview:fuKuan];
    
    UILabel *jinE = [[UILabel alloc] init];
    jinE.text = [NSString stringWithFormat:@"¥%.2f",_money];
    jinE.textColor = IWColor(50, 50, 50);
    jinE.font = kFont28px;
    [jinE sizeToFit];
    jinE.frame = CGRectMake(CGRectGetMaxX(fuKuan.frame) + kFRate(10), fuKuan.y, jinE.width, jinE.height);
    [myScrollView addSubview:jinE];
    // 支付会币
    UILabel *fuQian = [[UILabel alloc] init];
    fuQian.text = @"支付贝壳";
    fuQian.textColor = IWColor(168, 168, 168);
    fuQian.font = kFont28px;
    [fuQian sizeToFit];
    fuQian.frame = CGRectMake(dingDan.x, CGRectGetMaxY(fuKuan.frame) + kFRate(10), fuQian.width, fuQian.height);
    [myScrollView addSubview:fuQian];
    
    UILabel *beiKe = [[UILabel alloc] init];
    beiKe.text = [NSString stringWithFormat:@"%.2f贝壳",_beike];
    beiKe.textColor = IWColor(50, 50, 50);
    beiKe.font = kFont28px;
    [beiKe sizeToFit];
    beiKe.frame = CGRectMake(CGRectGetMaxX(fuQian.frame) + kFRate(10), fuQian.y, beiKe.width, beiKe.height);
    [myScrollView addSubview:beiKe];
    
    // 下分割线
    UIView *xiaLin = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fuQian.frame) + kFRate(15), kViewWidth, kFRate(0.5))];
    xiaLin.backgroundColor = kLineColor;
    [myScrollView addSubview:xiaLin];
    
    CGFloat starViewW = kFRate(140);
    CGFloat starViewH = kFRate(25);
    //星星
    UILabel *pingFen = [[UILabel alloc] init];
    pingFen.textColor = IWColor(50, 50, 50);
    pingFen.text = @"给商家评分";
    pingFen.font = kFont28px;
    [pingFen sizeToFit];
    pingFen.frame = CGRectMake(dingDan.x, CGRectGetMaxY(xiaLin.frame), pingFen.width, kFRate(55));
    [myScrollView addSubview:pingFen];
    
    self.starView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pingFen.frame) + kFRate(15),CGRectGetMaxY(xiaLin.frame) + kFRate(15), starViewW,starViewH) numberOfStar:5 large:NO];
    self.starView.contentMode = UIViewContentModeScaleAspectFill;
    self.starView.backgroundColor = [UIColor clearColor];
    [myScrollView addSubview:self.starView];
    self.starView.delegate = self;
    self.starView.userInteractionEnabled = YES;
    [self.starView setRatingViewScore:0];
    self.score = 0;
    
    UIView *lineM = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(pingFen.frame), kViewWidth, 0.5)];
    lineM.backgroundColor = [UIColor HexColorToRedGreenBlue:@"#d8d8dd"];
    [myScrollView addSubview:lineM];
    
    
    // 输入框
    // 主题编辑内容
    ATextView *textView = [[ATextView alloc] initWithFrame:CGRectMake(kFRate(10) , CGRectGetMaxY(lineM.frame) + kFRate(5), kViewWidth - kFRate(20), kFRate(150))];
    textView.font = kFont28px;
    textView.editable = YES;   //是否允许编辑内容，默认为“YES”
    textView.textColor = IWColor(29, 29, 29);
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    textView.showsVerticalScrollIndicator = YES;
    textView.placeholder = @"请输入评价内容...";
    textView.placeholderColor = IWColor(154, 154, 154);
    textView.delegate = self;
    [myScrollView addSubview:textView];
    self.textView = textView;
    
    UIView *lastLin = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame), kViewWidth, kFRate(0.5))];
    lastLin.backgroundColor = kLineColor;
    [myScrollView addSubview:lastLin];
    
    // 登陆按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(kFRate(35), CGRectGetMaxY(lastLin.frame) + kFRate(35), kViewWidth - kFRate(70), kFRate(45));
    loginBtn.backgroundColor = IWColor(252, 56, 100);
    [loginBtn setTitle:@"发布" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kFont34px;
    loginBtn.layer.cornerRadius = kFRate(5.0f);
    [loginBtn addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:loginBtn];
    
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(kViewWidth, CGRectGetMaxY(loginBtn.frame) + kFRate(30));
    // Do any additional setup after loading the view.
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

#pragma mark - 发布评价
- (void)commitClick
{
//    if ([self isEmpty:self.textView.text]) {
//        [self.textView endEditing:YES];
//        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请留下您的宝贵评价"];
//        return;
//    }
    
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/order/addShopEvaluate?evaluateDesc=%@&score=%@&shopId=%@&orderId=%@&userId=%@&userName=%@&userImg=%@",kNetUrl,self.textView.text,_score,_shopId,_orderId,[ASingleton shareInstance].loginModel.userId,[ASingleton shareInstance].loginModel.userName,[ASingleton shareInstance].loginModel.userImg];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    IWLog(@"url==========%@",url);
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf failData:@"评价失败"];
            return ;
        }
        if (json[@"code"] && [json[@"code"] isEqual:@"0"]) {
            IWRecordVC *vc = [[IWRecordVC alloc] init];
            vc.isMendian = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [weakSelf failData:@"评价失败"];
            return ;
        }
        
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf failData:@"评价失败"];
        return ;
    }];
}

- (void)failData:(NSString *)str
{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:str];
    IWTabBarViewController *tbVC = (IWTabBarViewController *)self.tabBarController;
    [tbVC from:0 To:0 isRootVC:NO currentVC:self];
}

- (void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    self.score = [NSString stringWithFormat:@"%.1f",score * 5];
    IWLog(@"分数————%f",[self.score floatValue]);
    
    //    //选择位置的百分比 * 总分 向上取整
    //    int intScore = (int)(score * 5 + 0.5);
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
