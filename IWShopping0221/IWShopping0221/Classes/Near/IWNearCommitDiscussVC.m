//
//  IWNearCommitDiscussVC.m
//  IWShopping0221
//
//  Created by FRadmin on 17/3/10.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWNearCommitDiscussVC.h"
#import "TQStarRatingView.h"
#import "ATextView.h"
#import "IWMeOrderFormProductModel.h"

@interface IWNearCommitDiscussVC ()<StarRatingViewDelegate,UITextViewDelegate>
@property(nonatomic ,strong)TQStarRatingView *starView;
@property(nonatomic ,strong)ATextView *textView;
@property(nonatomic ,assign)CGFloat score;
@end

@implementation IWNearCommitDiscussVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"发表评论";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat imageW = kFRate(70);
    UIImageView  *successImageView  = [[UIImageView alloc]initWithFrame:CGRectMake((kViewWidth - imageW)/2,64 + kFRate(30), imageW, imageW)];
    successImageView.image = [UIImage imageNamed:@"IWNearDiscussSuccess"];
    [self.view addSubview:successImageView];
    
    
    UILabel *successLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(successImageView.frame) + kFRate(10), kViewWidth, kFRate(14))];
    successLabel.text = @"恭喜你，支付成功!";
    successLabel.textAlignment = NSTextAlignmentCenter;
    successLabel.font = kFont28px;
    successLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:successLabel];
    
    
    
    CGFloat starViewW = kFRate(150);
    CGFloat starViewH = kFRate(25);
    //星星
    self.starView = [[TQStarRatingView alloc] initWithFrame:CGRectMake((kViewWidth - starViewW)/2,CGRectGetMaxY(successLabel.frame) + kFRate(10), starViewW,starViewH) numberOfStar:5 large:NO];
    self.starView.contentMode = UIViewContentModeScaleAspectFill;
    self.starView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.starView];
    self.starView.delegate = self;
    self.starView.userInteractionEnabled = YES;
    [self.starView setRatingViewScore:0];
    
    
    
    self.score = 0;
    
    UIView *lineM = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.starView.frame) + kFRate(30), kViewWidth, 0.5)];
    lineM.backgroundColor = [UIColor HexColorToRedGreenBlue:@"#d8d8dd"];
    [self.view addSubview:lineM];
    
    
    // 输入框
    // 主题编辑内容
    ATextView *textView = [[ATextView alloc] initWithFrame:CGRectMake(kFRate(10) , CGRectGetMaxY(lineM.frame) + kFRate(5), kViewWidth - kFRate(20), kFRate(150))];
    textView.font = kFont28px;
    textView.editable = YES;   //是否允许编辑内容，默认为“YES”
    textView.textColor = IWColor(29, 29, 29);
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    textView.showsVerticalScrollIndicator = YES;
    textView.placeholder = @"此时此刻你想说的话……";
    textView.placeholderColor = IWColor(154, 154, 154);
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    UIView *lastLin = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame), kViewWidth, kFRate(0.5))];
    lastLin.backgroundColor = kLineColor;
    [self.view addSubview:lastLin];
    
    // 登陆按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(kFRate(35), CGRectGetMaxY(lastLin.frame) + kFRate(35), kViewWidth - kFRate(70), kFRate(45));
    loginBtn.backgroundColor = IWColor(252, 56, 100);
    [loginBtn setTitle:@"发布" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = kFont34px;
    loginBtn.layer.cornerRadius = kFRate(5.0f);
    [loginBtn addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}

- (void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    self.score = score;
    IWLog(@"分数————%f",score);
    
    //    //选择位置的百分比 * 总分 向上取整
    //    int intScore = (int)(score * 5 + 0.5);
}
-(void)commitClick{
    IWMeOrderFormModel *model = self.model;
    NSMutableString  *productId = [NSMutableString string];
    NSString *attributeValue = @"";
    int i = 0;
    for (IWMeOrderFormProductModel   *productModel in model.children) {
        [productId appendString:productModel.productId];
        i++;
        if (i < model.children.count)
            [productId appendString:@"-"];
        
        if (i == 1)
            attributeValue = productModel.attributeValue;
    }
    
    NSString *userId = [ASingleton shareInstance].loginModel.userId;
    NSString *userName = [ASingleton shareInstance].loginModel.userName;
    NSString *userImguserImg = [ASingleton shareInstance].loginModel.userImg;
    NSString *orderId = model.orderId;
    NSString *evaluateDesc = self.textView.text?self.textView.text:@"";
    NSString *score = [NSString stringWithFormat:@"%.1f",self.score];
    //调用接口
    NSString *urlString = [NSString stringWithFormat:@"%@/%@?userId=%@&userName=%@&userImguserImg=%@&orderId=%@&productId=%@&evaluateDesc=%@&score=%@&attributeValue=%@",kNetUrl,@"order/evaluateOrder",userId,userName,userImguserImg,orderId,productId,evaluateDesc,score,attributeValue];
    
    NSString *url = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    __weak typeof(self) weakSelf = self;
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"code"]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"评论失败"];
            return ;
        }
        if (![@"0" isEqual:json[@"code"]]){
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"评论失败"];
            return ;
        }
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"评论成功"];
        weakSelf.orderFormVC.needNoRefresh = NO;
#warning 0419
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"评论失败"];
    }];
}

@end
