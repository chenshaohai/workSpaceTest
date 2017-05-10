//
//  IWMePersonCentreVC.m
//  IWShopping0221
//
//  Created by FRadmin on 17/3/10.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMePersonCentreVC.h"
#import "SystemCell.h"
#import "IWBatesButton.h"
#import "IWMePersonIconCell.h"
#import "IWModifyVC.h"
#import "IWLoginVC.h"
#import "IWTabBarViewController.h"
#import "IWChangePwdVC.h"
@interface IWMePersonCentreVC ()<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic)UIDatePicker *datePicker;
@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,weak)UITableView *tableView;
//日期 蒙版
@property(nonatomic,weak)UIView *birthdayMengBan;
//性别 蒙版
@property(nonatomic,weak)UIView *sexMengBan;
// 男
@property(nonatomic,weak)IWBatesButton *menButton;
//女
@property(nonatomic,weak)IWBatesButton *womenButton;
//头像cell
@property (nonatomic,weak)IWMePersonIconCell *personIconCell;
@end

@implementation IWMePersonCentreVC
NSString *SystemCellIdentifier = @"SystemCellIdentifier";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    
    
    self.dataArray =  @[@{@"icon": @"", @"title": @"用户名", @"selector": @"userName",@"showIcon": @"yes"},
                        @{@"icon": @"", @"title": @"昵称", @"selector": @"nickName",@"showIcon": @"yes"},
                        @{@"icon": @"", @"title": @"性别", @"selector": @"sex",@"showIcon": @"yes"},
                        @{@"icon": @"", @"title": @"出生日期", @"selector": @"chuShengRiQi",@"showIcon": @"yes"},
                        @{@"icon": @"", @"title": @"账户安全", @"selector": @"zhangHuAnQuan",@"showIcon": @"no"},
                        ];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [tableView registerClass:[SystemCell class] forCellReuseIdentifier:SystemCellIdentifier];
    self.view = tableView;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
}

# pragma mark  头部高度
/*
 *  头部高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2;
}
# pragma mark  高度
/*
 *  高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
        return 100;
    return 58;
}

# pragma mark  段数
/*
 *  段数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
# pragma mark  组数
/*
 *  组数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 1;
    return self.dataArray.count;
}

# pragma mark  具体的cell
/*
 *  具体的cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //第一行
    if (indexPath.section ==0) {
        // 1.创建cell
        IWMePersonIconCell *cell = [IWMePersonIconCell cellWithTableView:tableView];
        _personIconCell = cell;
        // 2. 取数据
        IWLoginModel *model = [ASingleton shareInstance].loginModel;
        // 3.传递模型
        cell.user = model;
        //显示尾部的箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
    SystemCell *cell = (SystemCell *)[tableView dequeueReusableCellWithIdentifier:SystemCellIdentifier forIndexPath:indexPath];
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    //    cell.iconImageView.image = [UIImage imageNamed:[dic objectForKey:@"icon"]];
    cell.titleLabel.text = [dic objectForKey:@"title"];
    if ([[dic objectForKey:@"showIcon"]isEqualToString:@"yes"]) {
        //显示尾部的箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        //不显示尾部的箭头
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    IWLoginModel *loginModel = [ASingleton shareInstance].loginModel;
    
    NSString *contentString = nil;
    switch (indexPath.row) {
        case 0:
            contentString = loginModel.userName;
            break;
        case 1:
            contentString = loginModel.nickName;
            break;
        case 2:{
            contentString = @"";
            if ([loginModel.sex isEqual:@"1"]) {
                contentString = @"男";
            }else if([loginModel.sex isEqual:@"2"]) {
                contentString = @"女";
            }
        }break;
        case 3:{
            NSString *birthday = loginModel.birthday;
            if (birthday && ![birthday isEqual:@""])
                contentString = birthday;
            else
                contentString = @"";
        }break;
        case 4:
            contentString = @"";
            break;
        default:
            contentString = @"";
            break;
    }
    cell.contentLabel.text = contentString;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0)
        return nil;
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, 102)];
    footView.backgroundColor = [UIColor clearColor];
    
    CGFloat buttonX = 40;
    CGFloat buttonY = 37;
    CGFloat buttonW = kViewWidth - 2 * buttonX;
    CGFloat buttonH = 40;
    
    UIButton  *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    button.titleLabel.font = kFont28px;
    button.titleLabel.textColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(signout) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = IWColorRed;
    [footView addSubview:button];
    
    return footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0)
        return 0;
    return 102;
}

# pragma mark  点击Cell
/*
 *  点击Cell
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消背景色变形
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        //图片处理
        /**
         *  弹出提示框
         */
        //初始化提示框
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        //按钮：从相册选择，类型：UIAlertActionStyleDefault
        UIAlertAction *xiangCe = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self xiangCe:0];
            
        }];
        [alert addAction:xiangCe];
        // 拍照
        UIAlertAction *paiZhao = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 请求
            
            [self xiangCe:1];
        }];
        [alert addAction:paiZhao];
        //按钮：取消，类型：UIAlertActionStyleCancel
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        
        
        NSDictionary *dic = [_dataArray objectAtIndex:indexPath.row];
        
        SEL selector = NSSelectorFromString([dic objectForKey:@"selector"]);
        
        if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selector withObject:nil];
#pragma clang diagnostic pop
        }
    }
}
# pragma mark 用户名
-(void)userName{
    IWModifyVC *modifyVC = [[IWModifyVC alloc]initWithTitle:@"修改用户名" contentString:[ASingleton shareInstance].loginModel.userName showString:nil];
    __weak typeof(self) weakSelf = self;
    modifyVC.sureButtonClick = ^(IWModifyVC *modifyVC ,NSString *modifyText){
        [weakSelf modifyInfoKey:@"userName" value:modifyText];
    };
    [self.navigationController pushViewController:modifyVC animated:YES];
}

# pragma mark 昵称
- (void)nickName{
    
    IWModifyVC *modifyVC = [[IWModifyVC alloc]initWithTitle:@"修改昵称" contentString:[ASingleton shareInstance].loginModel.nickName showString:nil];
    __weak typeof(self) weakSelf = self;
    modifyVC.sureButtonClick = ^(IWModifyVC *modifyVC ,NSString *modifyText){
        [weakSelf modifyInfoKey:@"nickName" value:modifyText];
    };
    [self.navigationController pushViewController:modifyVC animated:YES];
}
# pragma mark 性别
-(void)sex{
    //蒙版
    UIView  *sexMengBan = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight)];
    sexMengBan.backgroundColor = [UIColor lightGrayColor];
    //    sexMengBan.alpha = 0.2;
    [[UIApplication sharedApplication].keyWindow addSubview:sexMengBan];
    self.sexMengBan = sexMengBan;
    // 点击蒙版
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sexMengBanClick)];
    [sexMengBan addGestureRecognizer:tap];
    
    
    //
    CGFloat buttonW = 30;
    CGFloat buttonH = 30;
    //白色背景
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, kViewHeight/2 - 1.5 * buttonH ,kViewWidth,buttonH * 3)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [sexMengBan addSubview:whiteView];
    
    UILabel *tishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, buttonH)];
    tishiLabel.text = @"修改性别";
    [whiteView addSubview:tishiLabel];
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    tishiLabel.font = kFont28px;
    tishiLabel.textColor = [UIColor blackColor];
    
    
    // 分割线
    UIView *firstLin = [[UIView alloc] initWithFrame:CGRectMake(0, buttonH, kViewWidth, kFRate(0.5))];
    firstLin.backgroundColor = [UIColor HexColorToRedGreenBlue:@"#d8d8dd"];
    [whiteView addSubview:firstLin];
    
    
    IWBatesButton *menButton = [[IWBatesButton alloc]initFrame:CGRectMake(kViewWidth/2 - buttonW - 10, buttonH *1.5, buttonW, buttonH) Icon:nil selectIcon:nil iconFrame:CGRectZero title:@"男" titleFrame:CGRectMake(0, 0, buttonW, buttonH) titleFont:kFont28px titleColor:[UIColor blackColor] titleSelectColor:IWColorRed seleTitle:nil];
    [menButton addTarget:self action:@selector(menClick:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:menButton];
    menButton.backgroundColor = kColorRGB(239, 239, 239);
    self.menButton = menButton;
    
    IWBatesButton *womenButton = [[IWBatesButton alloc]initFrame:CGRectMake(kViewWidth/2 + 10, CGRectGetMinY(menButton.frame), buttonW, buttonH) Icon:nil selectIcon:nil iconFrame:CGRectZero title:@"女" titleFrame:CGRectMake(0, 0, buttonW, buttonH) titleFont:kFont28px titleColor:[UIColor blackColor] titleSelectColor:IWColorRed seleTitle:nil];
    
    [womenButton addTarget:self action:@selector(womenClick:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:womenButton];
    womenButton.backgroundColor = kColorRGB(239, 239, 239);
    self.womenButton = womenButton;
    
    if ([[ASingleton shareInstance].loginModel.sex isEqual:@"1"]) {
        menButton.selected = YES;
    }else if ([[ASingleton shareInstance].loginModel.sex isEqual:@"2"]){
        womenButton.selected = YES;
    }
}
# pragma mark 男点击
-(void)menClick:(IWBatesButton *)button{
    [self modifyInfoKey:@"sex" value:@"1"];
    [self.sexMengBan removeFromSuperview];
}
# pragma mark 女点击
-(void)womenClick:(IWBatesButton *)button{
    [self modifyInfoKey:@"sex" value:@"2"];
    [self.sexMengBan removeFromSuperview];
}
# pragma mark 性别蒙版点击 mengBan
-(void)sexMengBanClick{
    [self.sexMengBan removeFromSuperview];
    
}

# pragma mark 出生日期
- (void)chuShengRiQi{
    
    
    CGFloat whiteViewH = kFRate(280);
    
    UIView  *birthdayMengBan = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight)];
    birthdayMengBan.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:birthdayMengBan];
    self.birthdayMengBan = birthdayMengBan;
    
    //蒙版
    UIView  *tapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight - whiteViewH)];
    tapView.backgroundColor = [UIColor blackColor];
    tapView.alpha = 0.2;
    [birthdayMengBan addSubview:tapView];
    // 点击蒙版
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(birthdayMengBanClick)];
    [tapView addGestureRecognizer:tap];
    
    
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, kViewHeight - whiteViewH,kViewWidth, whiteViewH)];
    whiteView.backgroundColor = [UIColor lightGrayColor];
    [birthdayMengBan addSubview:whiteView];
    
    
    // 左取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(kFRate(17), kFRate(12), kFRate(33), kFRate(33));
    [cancelBtn setImage:[UIImage imageNamed:@"APMSetTimeDelete"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:cancelBtn];
    
    // 右确定按钮
    UIButton *trueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    trueBtn.frame = CGRectMake(kViewWidth - kFRate(17) - kFRate(22), kFRate(12), kFRate(33), kFRate(33));
    [trueBtn setImage:[UIImage imageNamed:@"APMSetTimeTrue"] forState:UIControlStateNormal];
    [trueBtn addTarget:self action:@selector(trueClick) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:trueBtn];
    
    // 分割线
    UIView *firstLin = [[UIView alloc] initWithFrame:CGRectMake(0, kFRate(55), kViewWidth, kFRate(0.5))];
    firstLin.backgroundColor = [UIColor HexColorToRedGreenBlue:@"#d8d8dd"];
    [whiteView addSubview:firstLin];
    
    
    UIDatePicker *datePickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(firstLin.frame), kViewWidth, whiteViewH - CGRectGetMaxY(firstLin.frame))];
    datePickerView.backgroundColor = [UIColor whiteColor];
    [whiteView addSubview:datePickerView];
    
    self.datePicker = datePickerView;
    
    // 年月日
    datePickerView.datePickerMode = UIDatePickerModeDate;
    datePickerView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
    // 设置通用日历
    datePickerView.calendar = nil;
    // 设置时区
    [datePickerView setTimeZone:[NSTimeZone localTimeZone]];
    
    NSString *birthday = [ASingleton shareInstance].loginModel.birthday;
    
    NSDate *date = [NSDate date];
    //没有取当前值
    if (birthday && ![birthday isEqual:@""]) {
        date = [NSDate dateFromString:birthday withFormat:@"yyyy-MM-dd"];
    }
    
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate:date];
    //    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    //
    //
    
    [datePickerView setDate:date animated:YES];
    
    // 设置最大事件(20年)
    NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:10 * 24 * 365 * 20];
    NSDate *minDate = [NSDate dateWithTimeIntervalSinceNow:-10000 * 24 * 365 * 20];
    datePickerView.minimumDate = minDate;
    datePickerView.maximumDate = maxDate;
}
#pragma mark - 删除日期编辑
- (void)cancelBtnClick{
    [self.birthdayMengBan removeFromSuperview];
}
#pragma mark - 确定日期编辑
- (void)trueClick{
    NSDate *birthday =  self.datePicker.date;
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate:birthday];
    //    NSDate *localeDate = [birthday  dateByAddingTimeInterval: interval];
    NSString *birthdayString = [NSDate dateToyyyyMMddString:birthday];
    IWLog(@"生日   %@，北京时间 %@",birthday,birthdayString);
    //   [self.moBan removeFromSuperview];
    [self modifyInfoKey:@"birthday" value:birthdayString];

    [self.birthdayMengBan removeFromSuperview];
}
#pragma mark -  修改数据上传，内部的更新
-(void)modifyInfoKey:(NSString *)key value:(NSString *)value{
    __weak typeof(self) weakSelf = self;
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@/user/editUser?%@=%@&userId=%@",kNetUrl,key,value,[ASingleton shareInstance].loginModel.userId];
    // 中文转码处理
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf modifyInfoFail];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf modifyInfoFail];
            return ;
        }
   
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *acount = [defaults objectForKey:@"userAccount"];
        NSString *password =  [defaults objectForKey:@"password"];
        
        [IWLoginVC loginWithUserAcount:acount passWord:password success:^(NSString *successString) {
            [weakSelf modifyInfoSuccess];
        } failure:^(NSString *failureString) {
            [weakSelf modifyInfoFail];
        }];
        
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf modifyInfoFail];
        return ;
    }];
}
#pragma mark - 设置失败
-(void)modifyInfoFail{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:@"设置失败，稍后重试"];
}
#pragma mark - 设置成功
-(void)modifyInfoSuccess{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:@"设置成功"];
    [self.tableView reloadData];
}

#pragma mark - 日期编辑 模板点击
-(void)birthdayMengBanClick{
    [self.birthdayMengBan removeFromSuperview];
}
# pragma mark 账户安全
-(void)zhangHuAnQuan{
    IWChangePwdVC *vc = [[IWChangePwdVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  注销
 */
- (void)signout
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"确定要退出吗？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    alertView.tag = 99;
    [alertView show];
}

#pragma mark UIAlertView Delegate
/**
 *  UIAlertView 代理方法
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) { // 注销
        // 将账号置为不是上一次登录
        //切换回第一个控制器
        [ASingleton shareInstance].loginModel = nil;
        [ASingleton shareInstance].homeVCNeedRefresh = NO;
        [ASingleton shareInstance].nearVCNeedRefresh = NO;
        [ASingleton shareInstance].shoppingVCNeedNoRefresh = NO;
        [ASingleton shareInstance].meVCNeedRefresh = NO;
        // 登录成功存储userId
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nil forKey:@"modelDic"];
        [defaults setObject:@"" forKey:@"userAccount"];
        [defaults setObject:@"" forKey:@"password"];
        
        [self.tableView reloadData];
        
        IWTabBarViewController *tbVC = (IWTabBarViewController *)self.tabBarController;
        [tbVC from:3 To:0 isRootVC:NO currentVC:self];
    }
}

#pragma mark - 相册/相机获取图片
- (void)xiangCe:(NSInteger)index
{
    //初始化UIImagePickerController
    UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
    //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
    //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
    //获取方方式3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
    switch (index) {
        case 0:
            PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//方式1
            break;

        default:
            PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;//方式2
            break;
    }
    //允许编辑，即放大裁剪
    PickerImage.allowsEditing = YES;
    //自代理
    PickerImage.delegate = self;
    //页面跳转
    [self presentViewController:PickerImage animated:YES completion:nil];
}

//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //把newPhono设置成头像
    _personIconCell.iconView.image = newPhoto;
    
    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/test.png"];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(newPhoto) writeToFile:imagePath atomically:YES];
    NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),@"test"];
    IWLog(@"newPhoto====%@",aPath3);
    
//    NSData *dataObj = UIImageJPEGRepresentation(newPhoto, 1.0);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:aPath3 forKey:@"image"];
    [dic setObject:[ASingleton shareInstance].loginModel.userId forKey:@"userId"];
    NSString *url = [NSString stringWithFormat:@"%@/user/uploadUserImg",kNetUrl];
    [IWHttpTool postWithURL:url params:dic success:^(id json) {
        IWLog(@"json==========%@",json);
    } failure:^(NSError *error) {
        IWLog(@"error==========%@",error);
    }];
    
//    __weak typeof(self) weakSelf = self;
//    NSString *url = [NSString stringWithFormat:@"%@/user/uploadUserImgNew?image=%@&userId=%@",kNetUrl,aPath3,[ASingleton shareInstance].loginModel.userId];
//    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
//    IWLog(@"url==========%@",url);
//    [[ASingleton shareInstance]startLoadingInView:self.view];
//    [IWHttpTool getWithURL:url params:nil success:^(id json) {
//        [[ASingleton shareInstance]stopLoadingView];
//        IWLog(@"json=======%@",json);
//        if (json == nil || ![json isKindOfClass:[NSDictionary class]]) {
//            [weakSelf failData:@"更换头像失败"];
//            return ;
//        }
//        if (![json[@"code"] isEqual:@"0"]) {
//            [[ASingleton shareInstance]stopLoadingView];
//            [weakSelf failData:@"更换头像失败"];
//        }
//        
//    } failure:^(NSError *error) {
//        [[ASingleton shareInstance]stopLoadingView];
//        [weakSelf failData:@"更换头像失败"];
//        return ;
//    }];
    
    //关闭当前界面，即回到主界面去
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)failData:(NSString *)str
{
    [[TKAlertCenter defaultCenter]postAlertWithMessage:str];
}

@end
