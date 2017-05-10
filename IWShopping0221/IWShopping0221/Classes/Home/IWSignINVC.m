//
//  IWSignINVC.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/25.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWSignINVC.h"
#import "XFCalendarView.h"

@interface IWSignINVC ()
@property (nonatomic ,strong ) XFCalendarView *calendarView;
@property (nonatomic,weak)UIButton *signBtn;
// 今日日期
@property (nonatomic,assign)NSInteger tadayNum;
// 选中参数
@property (nonatomic,strong)NSNumber *selectDay;
// 贝壳数
@property (nonatomic,copy)NSString *beiKeNum;
@end

@implementation IWSignINVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary *configDic = [defaults objectForKey:@"configDic"];
    _beiKeNum = configDic[@"signConfig"]?:@"0";
    // 左按钮
    self.navigationItem.title = @"签到";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 签到页面高度
    CGFloat signH = (kViewWidth - kFRate(66)) / 7 * 6 + kFRate(50);
    _calendarView = [[XFCalendarView alloc] init];
    _calendarView.frame = CGRectMake(kFRate(33), 64, kViewWidth - kFRate(66), signH);
    [self.view addSubview:_calendarView];
    
    //设置已经签到的天数日期
    NSMutableArray* _signArray = [[NSMutableArray alloc] init];
    //    [_signArray addObject:[NSNumber numberWithInt:1]];
    //    [_signArray addObject:[NSNumber numberWithInt:5]];
    //    [_signArray addObject:[NSNumber numberWithInt:9]];
    //    [_signArray addObject:[NSNumber numberWithInt:22]];
    _calendarView.signArray = _signArray;
    _calendarView.date = [NSDate date];
    
    // 签到按钮
    UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signBtn.frame = CGRectMake(kFRate(20), CGRectGetMaxY(_calendarView.frame), kViewWidth - kFRate(40), kFRate(44));
    signBtn.backgroundColor = IWColor(252, 56, 100);
    [signBtn setTitle:@"我要签到" forState:UIControlStateNormal];
    [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    signBtn.titleLabel.font = kFont30px;
    signBtn.layer.cornerRadius = kFRate(5.0f);
    [signBtn addTarget:self action:@selector(signBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signBtn];
    self.signBtn = signBtn;
    
    // 说明一
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = [NSString stringWithFormat:@"签到说明:每日签到送%@贝壳",_beiKeNum];
    label1.textColor = [UIColor HexColorToRedGreenBlue:@"#8f8f8f"];
    label1.font = kFont26px;
    label1.textAlignment = NSTextAlignmentCenter;
    [label1 sizeToFit];
    label1.frame = CGRectMake(0, CGRectGetMaxY(signBtn.frame) + kFRate(16), kViewWidth, label1.frame.size.height);
    [self.view addSubview:label1];

//    // 说明二
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame) + kFRate(10), kViewWidth, kFRate(14))];
//    NSString *str = @"《积分说明》";
//    NSString *string = @"详细积分情况请看 《积分说明》";
//    label2.textColor = IWColor(173, 173, 173);
//    label2.font = kFont24px;
//    label2.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:label2];
//    
//    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
//    NSRange redRange = NSMakeRange([[attStr string] rangeOfString:str].location, [[attStr string] rangeOfString:str].length);
//    [attStr addAttribute:NSForegroundColorAttributeName value:IWColor(252, 82, 114) range:redRange];
//    [label2 setAttributedText:attStr];
    
    // 补签通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeSignDay:) name:@"IWHomeSignDay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeSignToday:) name:@"IWHomeSignToday" object:nil];
    
}

#pragma mark - 签到
- (void)signBtnClick
{
    [self requestData];
}

- (void)collectionLeftCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)homeSignDay:(NSNotification *)no
{
    [self.signBtn setTitle:@"我要补签" forState:UIControlStateNormal];
    _selectDay = no.userInfo[@"otherDayBtn"];
}

- (void)homeSignToday:(NSNotification *)no
{
    [self.signBtn setTitle:@"我要签到" forState:UIControlStateNormal];
    _selectDay = no.userInfo[@"todayBtn"];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 请求数据
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSString *url = [NSString stringWithFormat:@"%@/user/sign?userId=%@",kNetUrl,[ASingleton shareInstance].loginModel.userId];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf changeFail:json[@"message"]?:@"签到失败"];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf changeFail:json[@"message"]?:@"签到失败"];
            return ;
        }
        if (_selectDay) {
            [_calendarView.signArray addObject:_selectDay];
        }else{
            [_calendarView.signArray addObject:[NSNumber numberWithInteger:_calendarView.todayNum]];
        }
        _calendarView.date = [NSDate date];
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"签到成功"];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf changeFail:@"签到失败"];
        return ;
    }];
}

- (void)changeFail:(NSString *)str
{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:str];
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
