//
//  IWShoppingSureVC.m
//  IWShopping0221
//
//  Created by FRadmin on 17/3/15.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWShoppingSureVC.h"
#import "IWAddressVC.h"
#import "IWAddNewAddressVC.h"
#import "IWShoppingModel.h"
#import "IWShoppingSureCell.h"
#import "IWShoppingField.h"
#import "IWNearSurePayVC.h"
#import "IWAddressVC.h"
#import "IWTabBarViewController.h"
#import "IWMeOrderFormVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import "WXApi.h"
#import "WXApiObject.h"
@interface IWShoppingSureVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)IWAddressModel *addressModel;
// 无数据
@property (nonatomic,strong)ANodataView *noDataView;

//添加列表
@property (nonatomic,weak)UITableView *tableView;

@property (nonatomic,weak)UIButton *payButton;

@property (nonatomic,weak)UILabel *priceLabel;
//地址
@property (nonatomic,weak)UILabel *locationLabel;
@property (nonatomic,weak)UILabel *shouHuoRenlabel;
@property (nonatomic,weak)UILabel *dianHualabel;


//实际需要付的款
@property (nonatomic,assign)CGFloat totalPayPrice;
//需要付的款,市场价
@property (nonatomic,assign)CGFloat totalSmarketPrice;
//总的运费
@property (nonatomic,assign)CGFloat totalExpressMoney;
//商品可以惠币合计
@property (nonatomic,assign)int totalintegral;
//可用惠币
@property (nonatomic,assign)int userIntegral;
//实际惠币
@property (nonatomic,assign)int shiJiIntegral;
//实际付款
@property (nonatomic,assign)CGFloat shiJiPay;

//支付的订单号
@property (nonatomic,copy)NSString *orderIds;
//支付商品名称
@property (nonatomic,copy)NSString *orderName;

//滑动开关
@property (nonatomic,strong)UISwitch *switchView;


@end

@implementation IWShoppingSureVC
#pragma mark 清空留言,总价，总实际价格
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    CGFloat totalPayPrice = 0;
    CGFloat totalSmarketPrice = 0;
    CGFloat totalintegral = 0;
    CGFloat totalExpressMoney = 0;
    
    for (NSArray *sectionArray in dataArray){
        for (IWShoppingModel *model in sectionArray) {
            //清空是因为没有建立组模型，避免第二次进入有初始值
            model.liuYan = @"";
            model.totalPrice = @"";
            model.payPrice = @"";
            //计算合计的价格
            totalPayPrice += [model.price floatValue] * [model.count integerValue];
            totalSmarketPrice += [model.smarketPrice floatValue] * [model.count integerValue];
            totalintegral += [model.integral intValue] * [model.count integerValue];
            totalExpressMoney += [model.expressMoney floatValue];
        }
    }
    self.totalPayPrice = totalPayPrice + totalintegral;
    self.totalSmarketPrice = totalSmarketPrice;
     self.totalintegral = totalintegral;
    self.totalExpressMoney = totalExpressMoney;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认订单";
    self.view.backgroundColor = kColorRGB(241, 246, 247);
    
    //获取个人可用贝壳
    [self getUserInfo];
    
    //从购物车页面进入，购物车页面不刷新
    if(self.fromShoppingVC) {
        [ASingleton shareInstance].shoppingVCNeedNoRefresh = YES;
    }else{
        [ASingleton shareInstance].shoppingVCNeedNoRefresh = NO;
    }
    
    
    //检测是否装了微信软件
    if ([WXApi isWXAppInstalled])
    {
        
        //监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXPay" object:nil];
          [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(aliPayCallBack:) name:@"aliPayCallBack" object:nil];
        
    }
}


#pragma mark  请求个人贝壳余额信息
-(void)getUserInfo{
        NSString  *url = [NSString stringWithFormat:@"%@/%@?userId=%@",kNetUrl,@"user/freshUserInfo",[ASingleton shareInstance].loginModel.userId];
        __weak typeof(self) weakSelf = self;
        [[ASingleton shareInstance]startLoadingInView:self.view];
        [IWHttpTool  getWithURL:url params:nil success:^(id json) {
            [[ASingleton shareInstance] stopLoadingView];
            if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"data"]) {
                [weakSelf failSetupGetUserInfo];
                return ;
            }
            if (![@"0" isEqual:json[@"code"]]){
                [weakSelf failSetupGetUserInfo];
                return ;
            }
            NSDictionary *contentDict = json[@"data"];
            if (!contentDict || ![contentDict isKindOfClass:[NSDictionary class]]|| [contentDict allKeys].count == 0) {
                [weakSelf failSetupGetUserInfo];
                return ;
            }
            
            IWLog(@"--3414321---%@-----",contentDict);
            
            //可用惠币
            NSString *userIntegralString = contentDict[@"userIntegral"]?contentDict[@"userIntegral"]:@"0";
            
            weakSelf.userIntegral = [userIntegralString intValue];
            
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
            
            
            //获取地址
            [weakSelf getAddress];
            
        } failure:^(NSError *error) {
            [[ASingleton shareInstance] stopLoadingView];
            
            [weakSelf failSetupGetUserInfo];
        }];
}
#pragma mark  获取贝壳失败处理
-(void)failSetupGetUserInfo{
    //可用惠币
    self.userIntegral = 0;
    //获取地址
    [self getAddress];
}

#pragma mark //请求数据
-(void)getAddress{
    [[ASingleton shareInstance]startLoadingInView:self.view];
    NSString *userId = [ASingleton shareInstance].loginModel.userId;
    NSString *url = [NSString stringWithFormat:@"%@/%@?userId=%@",kNetUrl,@"user/getUserAddress",userId];
    
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
        NSArray *contentArray = json[@"data"];
        if (!contentArray || ![contentArray isKindOfClass:[NSArray class]]) {
            [weakSelf failSetup];
            return ;
        }
        //无地址，添加一个
        if (contentArray.count == 0) {
            //跳转到 新增地址
            IWAddNewAddressVC *addVC = [[IWAddNewAddressVC alloc]init];
            addVC.isAdd = YES;
            addVC.saveSuccess = ^(IWAddNewAddressVC *vc,IWAddressModel *addressModel){
                //重新获取地址
                [weakSelf getAddress];
            };
            [weakSelf.navigationController pushViewController:addVC animated:YES];
        }else{
            for (NSDictionary *addressDic in contentArray) {
                IWAddressModel *model = [[IWAddressModel alloc] initWithDic:addressDic];
                //如果没有默认的，就直接取第一个
                if(!weakSelf.addressModel)
                    weakSelf.addressModel = model;
                //有默认的替换掉
                if (model.state == 1){
                    weakSelf.addressModel = model;
                    break;
                }
            }
        }
        
        //有地址  在生成界面，及数据展示
        if (weakSelf.addressModel) {
            [weakSelf  setupAllView];
        }
        
        /*{
         code = 0;
         data =     (
         {
         addressId = 24;
         city = "\U4e0a\U6d77\U5e02";
         consignee = "\U6d4b\U8bd5";
         detailAddress = "\U6d4b\U8bd5\U5730\U5740";
         district = "\U9ec4\U6d66\U533a";
         phone = 18219143000;
         province = "\U4e0a\U6d77";
         state = 0;
         userId = 32;
         userName = HuiShou;
         zipCode = "";
         },);
         message = success;
         }
         */
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [weakSelf failSetup];
    }];
}
#pragma mark 失败处理
-(void)failSetup{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:@"数据获取失败"];
    //3.无数据时的图标
    self.noDataView.tishiString = @"数据获取失败";
    self.noDataView.hidden = NO;
    __weak typeof(self) weakSelf = self;
    self.noDataView.refreshButtonClick = ^(ANodataView *noDataView,UIButton *refreshButton){
        [weakSelf getAddress];
    };
    [self.noDataView.refreshButton setTitle:@"重试" forState:UIControlStateNormal];
    self.noDataView.showRefreshButton = YES;
}

-(void)setupAllView{
    //底部
    UIView *payView = [[UIView alloc]initWithFrame:CGRectMake(0, kViewHeight - 40, kViewWidth, 40)];
    payView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:payView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, 0.5)];
    line.backgroundColor = kColorRGBA(255, 255, 255, 0.5);
    [payView addSubview:line];
    
    CGFloat buttonW = 85;
    UIButton *payButton = [[UIButton alloc]initWithFrame:CGRectMake(kViewWidth - buttonW, 0, buttonW, CGRectGetHeight(payView.frame))];
    payButton.backgroundColor = kColorRGB(221, 22, 78);
    [payButton setTitle:@"提交订单" forState:UIControlStateNormal];
    payButton.titleLabel.font = kFont24px;
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [payView addSubview:payButton];
    self.payButton = payButton;
    
    CGFloat totalLabelW = kFRate(80);
    CGFloat priceLabelW =  kFRate(95);
    UILabel *totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, totalLabelW, CGRectGetHeight(payView.frame))];
    totalLabel.text = @"实付金额:";
    totalLabel.font = kFont28px;
    totalLabel.textColor = kColorSting(@"353535");
    totalLabel.textAlignment = NSTextAlignmentRight;
    [payView addSubview:totalLabel];
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(totalLabel.frame), 0, priceLabelW, CGRectGetHeight(payView.frame))];
    
    self.shiJiPay = self.totalPayPrice + self.totalExpressMoney;
    priceLabel.text =[NSString stringWithFormat:@"￥%.2f",self.shiJiPay];
    priceLabel.font = kFont28px;
    priceLabel.textColor = kColorRGB(221, 22, 78);
    [payView addSubview:priceLabel];
    self.priceLabel= priceLabel;
    

    CGFloat tableViewH = CGRectGetMinY(payView.frame) - 64 - 5;

    //添加列表
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 5, kViewWidth,tableViewH) style:UITableViewStylePlain];
    //去掉下划线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 0.01);
    tableView.userInteractionEnabled = YES;
    self.tableView = tableView;
    
    
    //抵扣
    UIView *diKouView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, 40)];
    diKouView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:diKouView];
    
    CGFloat selectButtonW = 70;
    //1.UISwitch的初始化
    UISwitch *switchView = [[UISwitch alloc]initWithFrame:CGRectMake(kViewWidth - selectButtonW - 10,5, selectButtonW, CGRectGetHeight(diKouView.frame))];
    //2.设置UISwitch的初始化状态
    switchView.on = NO;//设置初始为ON的一边
    //3.UISwitch事件的响应
    [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [diKouView addSubview:switchView];
    self.switchView = switchView;
    
    UILabel *diKouLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, CGRectGetMinX(switchView.frame) - 20, CGRectGetHeight(diKouView.frame))];
    diKouLabel.text = [NSString stringWithFormat:@"可用%d贝壳抵扣￥%@",self.userIntegral,@30];
    diKouLabel.font = kFont28px;
    diKouLabel.textColor = kColorSting(@"353535");
    diKouLabel.textAlignment = NSTextAlignmentLeft;
    [diKouView addSubview:diKouLabel];
    
    
    //有一个为0 ，就隐藏
    if (self.userIntegral == 0  ||  self.totalintegral == 0) {
        diKouView.hidden = YES;
    }else{
        diKouView.hidden = NO;
        self.shiJiIntegral =    self.userIntegral < self.totalintegral?self.userIntegral : self.totalintegral;
        diKouLabel.text = [NSString stringWithFormat:@"可用%d贝壳抵扣￥%d",self.shiJiIntegral,self.shiJiIntegral];
        
    }
    
    self.tableView.tableFooterView = diKouView;
    
    //顶部视图
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kFRate(70 + 13))];
    whiteView.backgroundColor = [UIColor whiteColor];
    
    UILabel *shouHuoRenlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, kFRate(12), kViewWidth/2.0, kFRate(17))];
    shouHuoRenlabel.text = [NSString stringWithFormat:@"收货人：%@",self.addressModel.name];
    shouHuoRenlabel.font = kFont28px;
    shouHuoRenlabel.textColor = kColorSting(@"353535");
    [whiteView addSubview:shouHuoRenlabel];
    self.shouHuoRenlabel = shouHuoRenlabel;
    
    
    UILabel *dianHualabel = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth/2.0,CGRectGetMinY(shouHuoRenlabel.frame), kViewWidth/2.0 - 10, kFRate(17))];
    dianHualabel.text = self.addressModel.phone;
    dianHualabel.font = kFont28px;
    dianHualabel.textColor = kColorSting(@"353535");
    dianHualabel.textAlignment = NSTextAlignmentRight;
    [whiteView addSubview:dianHualabel];
    self.dianHualabel = dianHualabel;
    
    UIImage *locationImage = [UIImage imageNamed:@"IWNearLocation"];
    
    UIImageView *locationView = [[UIImageView alloc]initWithImage:locationImage];
    [whiteView addSubview:locationView];
    locationView.frame = CGRectMake(10, CGRectGetMaxY(shouHuoRenlabel.frame) + kFRate(10), kFRate(10),  kFRate(13));
    
    //地址
    UILabel *locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(locationView.frame) + kFRate(5), CGRectGetMaxY(shouHuoRenlabel.frame) + kFRate(10), kViewWidth - kFRate(40), kFRate(14))];
    locationLabel.backgroundColor = [UIColor clearColor];
    locationLabel.numberOfLines = 1;
    locationLabel.textColor = [UIColor HexColorToRedGreenBlue:@"353535"];
    locationLabel.font = kFont24px;
    locationLabel.text = [NSString stringWithFormat:@"%@%@%@%@",self.addressModel.province,self.addressModel.city,self.addressModel.district,self.addressModel.detailAddress];
    locationLabel.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:locationLabel];
    self.locationLabel = locationLabel;
    
    CGFloat nextW = kRate(9);
    CGFloat nextH = kFRate(17.5);
    CGFloat nextX = kViewWidth - kFRate(13) - nextW;
    UIImage *arrowImage = [UIImage imageNamed:@"IWNearShoppingDetailNext"];
    UIImageView *arrowView = [[UIImageView alloc]initWithImage:arrowImage];
    [whiteView addSubview:arrowView];
    arrowView.frame = CGRectMake(nextX, CGRectGetMaxY(shouHuoRenlabel.frame) + kFRate(10),nextW,nextH);
    
    
    UILabel *expressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(locationLabel.frame) + 10, kViewWidth - 20,  kFRate(13))];
    expressLabel.textAlignment = NSTextAlignmentRight;
    expressLabel.textColor = [UIColor HexColorToRedGreenBlue:@"353535"];
    expressLabel.font = kFont24px;
    expressLabel.text = [NSString stringWithFormat:@"运费：￥：%.2f",self.totalExpressMoney];
    [whiteView addSubview:expressLabel];
    
    self.tableView.tableHeaderView = whiteView;
    
    
    locationLabel.userInteractionEnabled = YES;
    whiteView.userInteractionEnabled = YES;
    //绑定点击手势识别 方法tapDetailView
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationViewTap)];
    // 添加手势识别
    [whiteView addGestureRecognizer:tap];
    
}
#pragma mark 开关切换
-(void)switchAction:(UISwitch *)switchBtn{
    if (switchBtn.on == YES) {
        self.shiJiPay =   self.totalPayPrice - self.shiJiIntegral + self.totalExpressMoney ;
    }else{
        self.shiJiPay = self.totalPayPrice + self.totalExpressMoney;
    }
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.shiJiPay];
}

#pragma mark 头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kFRate(34 +10);
}
#pragma mark 头部视图生成
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //没有建立组模型，是否选中和商店名称都放到 具体模型里面去了
    NSArray *sectionArray =  self.dataArray[section];
    IWShoppingModel *model = [sectionArray firstObject];
    
    CGFloat headW = kFRate(34);
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth,headW + kFRate(10))];
    headView.backgroundColor = kColorRGB(241, 246, 247);
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, kFRate(10), kViewWidth, headW - 0.5)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:whiteView];
    
    
    CGFloat iconW = kFRate(15);
    CGFloat iconY = (headW - iconW)/2.0;
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(kFRate(10), iconY, iconW, iconW)];
    icon.image = [UIImage imageNamed:@""];
    [whiteView addSubview:icon];
    
    
    
    UILabel *shoppingNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + kFRate(5),iconY, kViewWidth - CGRectGetMaxX(icon.frame) - kFRate(20), headW)];
    shoppingNameLabel.text = model.shopName;
    shoppingNameLabel.font = kFont28px;
    shoppingNameLabel.textColor = kColorSting(@"666666");
    shoppingNameLabel.backgroundColor = [UIColor clearColor];
    [whiteView addSubview:shoppingNameLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(headView.frame) - 0.5, kViewWidth, 0.5)];
    line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
    [headView addSubview:line];
    
    
    return headView;
}
#pragma mark
-(void)locationViewTap{
    IWAddressVC *addressVC = [[IWAddressVC alloc]init];
    addressVC.refreshBlock = ^(IWAddressVC *VC){
        
        [self getAddressRefresh];
        
    };
    [self.navigationController pushViewController:addressVC animated:YES];
}
#pragma mark //请求数据
-(void)getAddressRefresh{
    [[ASingleton shareInstance]startLoadingInView:self.view];
    NSString *userId = [ASingleton shareInstance].loginModel.userId;
    NSString *url = [NSString stringWithFormat:@"%@/%@?userId=%@",kNetUrl,@"user/getUserAddress",userId];
    
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
        NSArray *contentArray = json[@"data"];
        if (!contentArray || ![contentArray isKindOfClass:[NSArray class]]) {
            [weakSelf failSetup];
            return ;
        }
        //无地址，添加一个
        if (contentArray.count == 0) {
            //跳转到 新增地址
            IWAddNewAddressVC *addVC = [[IWAddNewAddressVC alloc]init];
            addVC.isAdd = YES;
            addVC.saveSuccess = ^(IWAddNewAddressVC *vc,IWAddressModel *addressModel){
                //重新获取地址
                [weakSelf getAddress];
            };
            [weakSelf.navigationController pushViewController:addVC animated:YES];
        }else{
            for (NSDictionary *addressDic in contentArray) {
                IWAddressModel *model = [[IWAddressModel alloc] initWithDic:addressDic];
                //如果没有默认的，就直接取第一个
                if(!weakSelf.addressModel)
                    weakSelf.addressModel = model;
                //有默认的替换掉
                if (model.state == 1){
                    weakSelf.addressModel = model;
                    break;
                }
            }
        }
        
        //有地址  在生成界面，及数据展示
        if (weakSelf.addressModel) {
            
            
            weakSelf.shouHuoRenlabel.text = [NSString stringWithFormat:@"收货人：%@",self.addressModel.name];
            weakSelf.dianHualabel.text = self.addressModel.phone;
            
            weakSelf.locationLabel.text = [NSString stringWithFormat:@"%@%@%@%@",self.addressModel.province,self.addressModel.city,self.addressModel.district,self.addressModel.detailAddress];
        }
        
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [weakSelf failSetup];
    }];
}

#pragma mark 底部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kFRate(34 + 34);
}
#pragma mark 底部视图生成
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    //没有建立组模型，是否选中和商店名称都放到 具体模型里面去了
    NSArray *sectionArray =  self.dataArray[section];
    IWShoppingModel *model = [sectionArray firstObject];
    
    CGFloat headH = kFRate(34);
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth,headH * 2)];
    headView.backgroundColor = [UIColor clearColor];
    
    //留言
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kViewWidth, headH)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:whiteView];
    
    UILabel *liuYanLabel = [[UILabel alloc]initWithFrame:CGRectMake(kFRate(10),0,kFRate(63), headH - 0.5)];
    liuYanLabel.text = @"买家留言";
    liuYanLabel.font = kFont28px;
    liuYanLabel.textColor = kColorSting(@"666666");
    liuYanLabel.backgroundColor = [UIColor clearColor];
    [whiteView addSubview:liuYanLabel];
    
    
    IWShoppingField *liuYanField = [[IWShoppingField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(liuYanLabel.frame) + kFRate(5), 0, kViewWidth - CGRectGetMaxX(liuYanLabel.frame)- kFRate(5) , headH - 0.5)];
    liuYanField.delegate = self;
    liuYanField.tag = section;
    liuYanField.placeholder = @"对本次交易的说明(选填)";
    [whiteView addSubview:liuYanField];
    liuYanField.model = model;
    liuYanField.delegate = self;
    if (![model.liuYan isEqual:@""])
        liuYanField.text = model.liuYan;
    
    
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(whiteView.frame) - 0.5, kViewWidth, 0.5)];
    line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
    [headView addSubview:line];
    
    
    //合计
    UIView *whiteView2 = [[UIView alloc]initWithFrame:CGRectMake(0,headH, kViewWidth, headH)];
    whiteView2.backgroundColor = [UIColor whiteColor];
    [headView addSubview:whiteView2];
    
    
    
    //计算商品个数及总的价格
    NSInteger count = 0;
    //总的实际价格
    CGFloat  totalMoney = 0;
    //总市场价和
    CGFloat  totalSmarketPriceMoney = 0;
    //计算
    for (IWShoppingModel *model in sectionArray) {
        NSInteger  subCount =  [model.count integerValue];
        count += subCount;
        totalMoney += subCount * ([model.price floatValue] + [model.integral floatValue]);
        totalSmarketPriceMoney += subCount * ([model.smarketPrice floatValue] + [model.integral floatValue]);
    }
    //赋值
    for (IWShoppingModel *model in sectionArray) {
        model.totalPrice = [NSString stringWithFormat:@"%.2f",totalSmarketPriceMoney];
        model.payPrice = [NSString stringWithFormat:@"%.2f",totalMoney];
    }
    
    
    //价格
    CGFloat priceLabelW = kFRate(53);
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kViewWidth - priceLabelW, 0, priceLabelW, headH - 0.5)];
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.numberOfLines = 1;
    priceLabel.textColor = kColorRGB(251, 22, 78);
    priceLabel.font = kFont28px;
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.text = [NSString stringWithFormat:@"￥%.2f",totalMoney];
    [priceLabel sizeToFit];
    priceLabel.frame = CGRectMake(kViewWidth - CGRectGetWidth(priceLabel.frame) - kFRate(10), 0, CGRectGetWidth(priceLabel.frame), headH - 0.5);
    [whiteView2 addSubview:priceLabel];
    
    
    UILabel *heJiLabel = [[UILabel alloc]initWithFrame:CGRectMake(kFRate(10),0,CGRectGetMinX(priceLabel.frame)- kFRate(10), headH - 0.5)];
    heJiLabel.text = [NSString stringWithFormat:@"共计 %ld 件商品,合计",count];
    heJiLabel.font = kFont28px;
    heJiLabel.textColor = kColorSting(@"666666");
    heJiLabel.backgroundColor = [UIColor clearColor];
    heJiLabel.textAlignment = NSTextAlignmentRight;
    [whiteView2 addSubview:heJiLabel];
    
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(whiteView2.frame) - 0.5, kViewWidth, 0.5)];
    line2.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
    [whiteView2 addSubview:line];
    
    
    return headView;
}

#pragma mark 高度cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFRate(95);
}

#pragma mark 组数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
#pragma mark 组内部cell数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *tempArray = self.dataArray[section];
    return tempArray.count;
}
#pragma mark 组内部cell实现
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IWShoppingSureCell *cell = [IWShoppingSureCell cellWithTableView:tableView];
    
    NSArray *tempArray = self.dataArray[indexPath.section];
    IWShoppingModel *model =  tempArray[indexPath.row];
    cell.model = model;
    
    return cell;
}
#pragma mark 结束编辑代理
-(void)textFieldDidEndEditing:(IWShoppingField *)textField{
    textField.model.liuYan = textField.text;
}
#pragma mark  提交订单
-(void)pay:(UIButton *)button{
    NSMutableArray *orders = [NSMutableArray array];
    for (NSArray *sectionArray in self.dataArray){
        
        NSMutableArray *products = [NSMutableArray array];
        
        int sectionTotalIntegral = 0;
        
        for (IWShoppingModel *model in sectionArray) {
            
            
            NSString *name = model.name;
            _orderName = model.name;
            NSString *content = model.content;
            NSString *thumbImg =model.logo;
            
            
            NSDictionary *modelDict = @{@"productId":model.modelId?model.modelId:@"",
                                        @"productName":name?name:@"",
                                        @"thumbImg":thumbImg?thumbImg:@"",
                                        @"smarketPrice":model.smarketPrice?model.smarketPrice:@"",
                                        @"salePrice":model.price?model.price:@"",
                                        @"count":model.count?model.count:@"0",
                                        @"attributeValue":content?content:@"",
                                        @"itemId":model.itemId?model.itemId:@"",
//                                        @"count":model.count?model.itemId:@"",
                                        @"expressPrice":model.expressMoney?model.expressMoney:@"0",
                                        };
            
            [products addObject:modelDict];
            
            sectionTotalIntegral += [model.count intValue] * [model.integral intValue];
        }
        
        IWShoppingModel *firsrModel = [sectionArray firstObject];
        
        
        if (products && products.count > 0 ) {
            NSString *liuYan = firsrModel.liuYan;
            NSDictionary *orderDict = @{@"shopId":firsrModel.shopId?firsrModel.shopId:@"",
                                        @"remark":liuYan?liuYan:@"",
                                        @"totalPrice":firsrModel.totalPrice?firsrModel.totalPrice:@"0",
                                        @"payPrice":firsrModel.payPrice?firsrModel.payPrice:@"0",
#warning  会币 分组累加 估计会有问题
                                        @"integral":[NSString stringWithFormat:@"%d",sectionTotalIntegral],
                                        @"products":products?products:@""
                                        };
            [orders addObject:orderDict];
            
        }
    }
    
    
    NSString  *dikou = @"0";
    if (self.switchView.on == YES) {
        dikou = [NSString stringWithFormat:@"%d",self.shiJiIntegral];
    }
    
    NSString *userName = [ASingleton shareInstance].loginModel.userName;
    NSDictionary  *lastDict = @{@"userId":[ASingleton shareInstance].loginModel.userId,
                                @"userName":userName,
                                @"addressId":self.addressModel.addressId,
                                @"orders":orders,
                                @"dikou":dikou
                                };
    
    
    NSData* jsonData = nil;
    NSError* jsonError = nil;
    
    //字典换成字符串
    jsonData = [NSJSONSerialization dataWithJSONObject:lastDict options:NSJSONWritingPrettyPrinted  error:&jsonError];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //去掉空格和回车
    NSString *body1=[body stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *body2=[body1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //转码  必须要这一步，要不就挂了
    NSString *lastString = [body1 stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[ASingleton shareInstance]startLoadingInView:self.view];
    NSString *url = [NSString stringWithFormat:@"%@/order/createOrder?ios=1&data=%@",kNetUrl,lastString];
    
    __weak typeof(self) weakSelf = self;
    [IWHttpTool postWithURL:url  params:lastDict success:^(id json) {
        [[ASingleton shareInstance] stopLoadingView];
        
        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"code"]) {
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"订单创建失败"];
            return ;
        }
        
        NSString *data = json[@"data"];
        
        if (!data || ![data isKindOfClass:[NSString class]] || [data isEqual:@""] ){
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"订单创建失败"];
            return ;
        }
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"订单创建成功"];
        
        [weakSelf  setupPickViewWithOrderIds:data];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"订单创建失败"];
    }];
}
#pragma mark   弹框
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
#pragma mark  付款
-(void)payFromRow:(int) index  orderIds:(NSString *)orderIds{
    self.orderIds = orderIds;
    switch (index) {
        case 0://微信
            if ([WXApi isWXAppInstalled]){
                [self sendNetWorking_WXPay];
            }else{
                [self alert:@"提示" msg:@"未安装微信"];
            }
            break;
        case 1://支付宝
        {
            NSString *appID = kAliPayAppID;
            // 私钥
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
            if ([_orderName isEqual:@""] || [_orderName isKindOfClass:[NSNull class]]) {
                _orderName = nil;
            }
            order.biz_content.subject = _orderName?:@"商品";
            
            order.biz_content.out_trade_no = orderIds; //订单ID（由商家自行制定）
            order.biz_content.timeout_express = @"30m"; //超时时间设置
            order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", self.shiJiPay]; //商品价格
            
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
        [self payOrderFinishWIthOrderIds:self.orderIds];
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
    //调用接口
    NSString *lastString = [NSString stringWithFormat:@"%@/%@?orderIds=%@",kNetUrl,@"order/payOrderFinish",orderIds];
    //转码  必须要这一步，要不就挂了
    NSString *url = [lastString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    __weak typeof(self) weakSelf = self;
    [IWHttpTool  getWithURL:url params:nil success:^(id json) {
        if (!json || ![json isKindOfClass:[NSDictionary class]] || !json[@"code"]) {
            [weakSelf payOrderFinishSuccess];
            return ;
        }
        if (![@"0" isEqual:json[@"code"]]){
            [weakSelf payOrderFinishSuccess];
            return ;
        }
        [weakSelf payOrderFinishSuccess];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance] stopLoadingView];
        [weakSelf payOrderFinishSuccess];
    }];
}
#pragma mark 结束付款成功 回调
-(void)payOrderFinishSuccess{
    IWMeOrderFormVC *orderFormVC = [[IWMeOrderFormVC alloc]initWithSelectIndex:0];
    orderFormVC.needPOPToRootIndex = 0;
    [self.navigationController pushViewController:orderFormVC animated:YES];
}


#pragma mark ************************************* 微信支付相关 ******************************
#pragma mark 微信支付
- (void)sendNetWorking_WXPay{
        [[ASingleton shareInstance]startLoadingInView:self.view];
        NSString *url = [NSString stringWithFormat:@"%@/%@?payPrice=%@&orderIds=%@",kNetUrl,@"pay/weixin",[NSString stringWithFormat:@"%.2f", self.shiJiPay],self.orderIds];
        
        __weak typeof(self) weakSelf = self;
        [IWHttpTool  getWithURL:url params:nil success:^(id json) {
            [[ASingleton shareInstance] stopLoadingView];
            [[TKAlertCenter defaultCenter]postAlertWithMessage:json[@"message"]];
            IWLog(@"%@",json);
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
        [self  payOrderFinishWIthOrderIds:self.orderIds];
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
@end
