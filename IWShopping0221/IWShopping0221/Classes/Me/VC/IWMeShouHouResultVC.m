//
//  IWMeShouHouResultVC.m
//  IWShopping0221
//
//  Created by s on 17/3/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMeShouHouResultVC.h"
#import "Masonry.h"
#import "IWMeBackVC.h"
#warning 0419
#import "IWTabBarViewController.h"
@interface IWMeShouHouResultVC ()
@property(nonatomic,strong)UILabel *successLabel;

@end

@implementation IWMeShouHouResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"提交结果";
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *successLabel = [[UILabel alloc]init];
    successLabel.text = @"创建售后订单成功!";
    successLabel.textColor = [UIColor blackColor];
    successLabel.font = kFont28px;
    [self.view addSubview:successLabel];
    self.successLabel = successLabel;
    
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"客户审核通过后，退换货地址会以短信通知您，请您及时寄回商品并填写物流信息。";
    contentLabel.textColor = kRedColor;
    contentLabel.numberOfLines = 2;
    contentLabel.font = kFont28px;
    [self.view addSubview:contentLabel];
    
    //线
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
    [self.view addSubview:line];
    
    
    UIColor *lightGrayColor = [UIColor lightGrayColor];
    
    UIColor *grayColor = [UIColor grayColor];
    
    
    
    UILabel *bianHaoLabel = [[UILabel alloc]init];
    bianHaoLabel.text = @"订单编号  ";
    bianHaoLabel.textColor = lightGrayColor;
    bianHaoLabel.font = kFont28px;
    bianHaoLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:bianHaoLabel];
    
    UILabel *bianHaoContentLabel = [[UILabel alloc]init];
    bianHaoContentLabel.text = self.dataDic[@"orderId"]?self.dataDic[@"orderId"]:@"";
    bianHaoContentLabel.textColor = grayColor;
    bianHaoContentLabel.font = kFont28px;
    bianHaoContentLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:bianHaoContentLabel];
    
    
    UILabel *shiJianLabel = [[UILabel alloc]init];
    shiJianLabel.text = @"申请时间  ";
    shiJianLabel.textColor = lightGrayColor;
    shiJianLabel.font = kFont28px;
    shiJianLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:shiJianLabel];
    
    
   
    
    UILabel *shiJianContentLabel = [[UILabel alloc]init];
    
    shiJianContentLabel.textColor = grayColor;
    shiJianContentLabel.font = kFont28px;
    shiJianContentLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:shiJianContentLabel];
    
    NSString  *shijianString = self.dataDic[@"createdTime"]?self.dataDic[@"createdTime"]:@"";
    if ([shijianString isEqual:@""]) {
        shiJianContentLabel.text =@"";
    }else{
    shiJianContentLabel.text = [NSDate dateToyyyyMMddHHmmssStringWithInteger:[shijianString doubleValue]];
    }
    
    
//    {
//        attributeValue = "";
//        createdTime = 1490758660000;
//        itemId = 9120;
//        orderDetailId = 573;
//        orderId = 280;
//        productId = 16;
//        productName = "2017\U65b0\U6b3e\U76ae\U5939\U514b\U7537\U88c5\U6625\U5b63";
//        refundCount = 1;
//        refundId = 98;
//        refundMoney = 159;
//        refundNum = 1490163425712;
//        refundReason = "";
//        refundType = 2;
//        salePrice = 159;
//        shopId = 16;
//        shopName = "\U6021\U666f\U9ea6\U5f53\U52b3\U5206\U5e97";
//        smarketPrice = 499;
//        state = 0;
//        thumbImg = "/aigou/shop/20170312/e0bafff0-e8f3-4000-8290-05f91b29d503.jpg";
//        updatedTime = 1490758660000;
//    };

    
    
    
   
    UILabel *leiXinLabel = [[UILabel alloc]init];
    leiXinLabel.text = @"申请类型  ";
    leiXinLabel.textColor = lightGrayColor;
    leiXinLabel.font = kFont28px;
    leiXinLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:leiXinLabel];
    
    UILabel *leiXinContentLabel = [[UILabel alloc]init];
    leiXinContentLabel.text = @"123123123";
    leiXinContentLabel.textColor = grayColor;
    leiXinContentLabel.font = kFont28px;
    leiXinContentLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:leiXinContentLabel];
    
   // 1表示只退款，2表示只退货，3表示退款并退货，4表示换货
  NSString  *refundType = self.dataDic[@"refundType"]?self.dataDic[@"refundType"]:@"0";
    
    NSString *refundString =   @"只退款";
    if ([refundType isEqual:@"1"]) {
        refundString = @"只退款";
    }else if ([refundType isEqual:@"2"]) {
        refundString = @"只退货";
    }else if ([refundType isEqual:@"3"]) {
        refundString = @"退款并退货";
    }else if ([refundType isEqual:@"4"]) {
        refundString = @"只换货";
    }else{
    refundString = @"";
    }
    leiXinContentLabel.text = refundString;
    
    
    UILabel *jinELabel = [[UILabel alloc]init];
    jinELabel.text = @"退款金额  ";
    jinELabel.textColor = lightGrayColor;
    jinELabel.font = kFont28px;
    jinELabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:jinELabel];
    
    UILabel *JinEContentLabel = [[UILabel alloc]init];
    JinEContentLabel.text = self.dataDic[@"refundMoney"]?self.dataDic[@"refundMoney"]:@"";
    JinEContentLabel.textColor = grayColor;
    JinEContentLabel.font = kFont28px;
    JinEContentLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:JinEContentLabel];
    
    
    
    
    
    UILabel *zhuangTaiLabel = [[UILabel alloc]init];
    zhuangTaiLabel.text = @"订单状态  ";
    zhuangTaiLabel.textColor = lightGrayColor;
    zhuangTaiLabel.font = kFont28px;
    zhuangTaiLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:zhuangTaiLabel];
    
    UILabel *zhuangTaiContentLabel = [[UILabel alloc]init];
    zhuangTaiContentLabel.text = @"123123123";
    zhuangTaiContentLabel.textColor = kRedColor;
    zhuangTaiContentLabel.font = kFont28px;
    zhuangTaiContentLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:zhuangTaiContentLabel];
    
    
   // state退换状态，0表示待审核，1表示退换中，2表示退换完成，-1表示退换取消
    NSString  *state = self.dataDic[@"state"]?self.dataDic[@"state"]:@"0";
    
    NSString *stateString =   @"待审核";
    if ([state isEqual:@"0"]) {
        stateString = @"待审核";
    }else if ([state isEqual:@"1"]) {
        stateString = @"退换中";
    }else if ([state isEqual:@"2"]) {
        stateString = @"退换完成";
    }else if ([state isEqual:@"-1"]) {
        stateString = @"退换取消";
    }else{
        stateString = @"";
    }
    zhuangTaiContentLabel.text = stateString;
    
    
    
    
    
    
    UIView *lineD = [[UIView alloc]init];
    lineD.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
    [self.view addSubview:lineD];
    
    UIButton *payButton = [[UIButton alloc]init];
    payButton.layer.cornerRadius = 5;
     payButton.layer.masksToBounds = YES;
    payButton.backgroundColor = kRedColor;
    [payButton setTitle:@"查看售后订单" forState:UIControlStateNormal];
    payButton.titleLabel.font = kFont28px;
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payButton];
    
    
    
    CGFloat firstX = kFRate(5);
    __weak typeof(self) weakSelf = self;
    [_successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.view.mas_top).offset(64);
        make.left.mas_equalTo(firstX);
        make.width.mas_equalTo(kViewWidth);
        make.height.mas_equalTo(35);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_successLabel.mas_bottom);
        make.left.mas_equalTo(firstX);
        make.width.mas_equalTo(kViewWidth);
        make.height.mas_equalTo(35);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentLabel.mas_bottom).offset(7.5);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kViewWidth);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [bianHaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(10);
        make.left.mas_equalTo(firstX);
        make.width.mas_equalTo(kFRate(65));
        make.height.mas_equalTo(19);
    }];
    [bianHaoContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bianHaoLabel.mas_top);
        make.left.mas_equalTo(bianHaoLabel.mas_right).offset(5);
        make.width.mas_equalTo(kViewWidth - CGRectGetMaxX(bianHaoLabel.frame));
        make.height.mas_equalTo(bianHaoLabel.mas_height);
    }];
    
    
    
    [shiJianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bianHaoLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(firstX);
        make.width.mas_equalTo(bianHaoLabel.mas_width);
        make.height.mas_equalTo(bianHaoLabel.mas_height);
    }];
    
    [shiJianContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(shiJianLabel.mas_top);
        make.left.mas_equalTo(shiJianLabel.mas_right).offset(5);
        make.width.mas_equalTo(kViewWidth - CGRectGetMaxX(shiJianLabel.frame));
        make.height.mas_equalTo(shiJianLabel.mas_height);
    }];
    
    
    
    [leiXinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(shiJianLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(firstX);
        make.width.mas_equalTo(shiJianLabel.mas_width);
        make.height.mas_equalTo(shiJianLabel.mas_height);
    }];
    
    [leiXinContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leiXinLabel.mas_top);
        make.left.mas_equalTo(leiXinLabel.mas_right).offset(5);
        make.width.mas_equalTo(kViewWidth - CGRectGetMaxX(leiXinLabel.frame));
        make.height.mas_equalTo(leiXinLabel.mas_height);
    }];
    
    
    [jinELabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leiXinLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(firstX);
        make.width.mas_equalTo(shiJianLabel.mas_width);
        make.height.mas_equalTo(shiJianLabel.mas_height);
    }];
    
    [JinEContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(jinELabel.mas_top);
        make.left.mas_equalTo(jinELabel.mas_right).offset(5);
        make.width.mas_equalTo(kViewWidth - CGRectGetMaxX(jinELabel.frame));
        make.height.mas_equalTo(jinELabel.mas_height);
    }];
    
    
    [zhuangTaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(jinELabel.mas_bottom).offset(5);
        make.left.mas_equalTo(firstX);
        make.width.mas_equalTo(shiJianLabel.mas_width);
        make.height.mas_equalTo(shiJianLabel.mas_height);
    }];
    
    [zhuangTaiContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(zhuangTaiLabel.mas_top);
        make.left.mas_equalTo(leiXinLabel.mas_right).offset(5);
        make.width.mas_equalTo(kViewWidth - CGRectGetMaxX(leiXinLabel.frame));
        make.height.mas_equalTo(leiXinLabel.mas_height);
    }];
    
    
    
    [lineD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(zhuangTaiLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kViewWidth);
        make.height.mas_equalTo(0.5);
    }];
    
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineD.mas_bottom).offset(15);
        make.left.mas_equalTo(8);
        make.width.mas_equalTo(kViewWidth - 16);
        make.height.mas_equalTo(35);
    }];
    
}

#pragma mark  查看订单
-(void)pay:(UIButton *)button{
    
    IWMeBackVC  *backVC = [[IWMeBackVC alloc]init];
    [self.navigationController pushViewController:backVC animated:YES];
}
#warning 0419
#pragma mark  set方法
-(void)setNeedPOPToRootIndex:(NSInteger)needPOPToRootIndex{
    _needPOPToRootIndex = needPOPToRootIndex;
    [ASingleton shareInstance].orderFormbackCommit = ^(BOOL removeBlock){
        IWTabBarViewController *tbVC = (IWTabBarViewController *)self.tabBarController;
        [tbVC from:0 To:_needPOPToRootIndex isRootVC:NO currentVC:self];
        [ASingleton shareInstance].orderFormbackCommit = nil;
    };
}

@end
