//
//  IWAddNewAddressVC.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/10.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWAddNewAddressVC.h"
#import "AddressPickerView.h"
#import "ATextView.h"

#define SCREEN [UIScreen mainScreen].bounds.size
#define kFontColor IWColor(57, 57, 57)
@interface IWAddNewAddressVC ()<AddressPickerViewDelegate>
@property (nonatomic ,strong) AddressPickerView * pickerView;

@property (nonatomic ,strong) UIButton          * addressBtn;

@property (nonatomic ,strong) UILabel           * addressLabel;
//人名
@property (nonatomic,weak)UITextField *nameText;
//电话
@property (nonatomic,weak)UITextField *phoneText;
//邮编
@property (nonatomic,weak)UITextField *youBianText;
//收货地址
@property (nonatomic,weak)UILabel *addText;
//详细地址
@property (nonatomic,weak)ATextView *addressText;
// 所选的省份，城市，区域
@property (nonatomic,copy)NSString *p;
@property (nonatomic,copy)NSString *c;
@property (nonatomic,copy)NSString *a;
@end

@implementation IWAddNewAddressVC
- (void)collectionLeftCilck
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 左按钮
    self.navigationItem.title = @"新增收货地址";
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ABleft"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(collectionLeftCilck) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = IWColor(240, 240, 240);
    // Do any additional setup after loading the view.
    // 提交按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, kViewHeight - kFRate(45), kViewWidth, kFRate(45));
    addBtn.backgroundColor = IWColor(252, 56, 100);
    [addBtn setTitle:@"提交" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.titleLabel.font = kFont34px;
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kViewWidth, kViewHeight - 64 - kFRate(45))];
    myScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myScrollView];
    
    // 人名
    NSString *nameStr = @"*  收货人:";
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = kFontColor;
    nameLabel.font = kFont32px;
    [nameLabel setAttributedText:[self changeColorStr:nameStr]];
    [nameLabel sizeToFit];
    nameLabel.frame = CGRectMake(kFRate(10), kFRate(25), nameLabel.frame.size.width, nameLabel.frame.size.height);
    [myScrollView addSubview:nameLabel];
    
    CGFloat nameTextX = kFRate(10) + CGRectGetMaxX(nameLabel.frame);
    UITextField *nameText = [[UITextField alloc] initWithFrame:CGRectMake(nameTextX, nameLabel.frame.origin.y, kViewWidth - nameTextX - kFRate(10), nameLabel.frame.size.height)];
    nameText.placeholder = @"请填写收货人姓名";
    nameText.autocorrectionType = UITextAutocorrectionTypeNo;
    nameText.textColor = kFontColor;
    nameText.font = kFont32px;
    nameText.text = self.model.name;
    nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameText.backgroundColor = [UIColor clearColor];
//    nameText.keyboardType = UIKeyboardTypeNumberPad;
    [myScrollView addSubview:nameText];
    self.nameText = nameText;
    
    UIView *linOne = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame) + kFRate(15), kViewWidth, kFRate(0.5))];
    linOne.backgroundColor = kLineColor;
    [myScrollView addSubview:linOne];
    
    // 手机号码
    NSString *phoneStr = @"*  手机号码:";
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.textColor = kFontColor;
    phoneLabel.font = kFont32px;
    [phoneLabel setAttributedText:[self changeColorStr:phoneStr]];
    [phoneLabel sizeToFit];
    phoneLabel.frame = CGRectMake(kFRate(10), CGRectGetMaxY(linOne.frame) + kFRate(15), phoneLabel.frame.size.width, phoneLabel.frame.size.height);
    [myScrollView addSubview:phoneLabel];
    
    CGFloat phoneTextX = kFRate(10) + CGRectGetMaxX(phoneLabel.frame);
    UITextField *phoneText = [[UITextField alloc] initWithFrame:CGRectMake(phoneTextX, phoneLabel.frame.origin.y, kViewWidth - phoneTextX - kFRate(10), phoneLabel.frame.size.height)];
    phoneText.placeholder = @"请填写收货人手机号码";
    phoneText.autocorrectionType = UITextAutocorrectionTypeNo;
    phoneText.textColor = kFontColor;
    phoneText.font = kFont32px;
    phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneText.backgroundColor = [UIColor clearColor];
    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    phoneText.text = self.model.phone;
    [myScrollView addSubview:phoneText];
    self.phoneText = phoneText;
    
    UIView *linTwo = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(phoneLabel.frame) + kFRate(15), kViewWidth, kFRate(0.5))];
    linTwo.backgroundColor = kLineColor;
    [myScrollView addSubview:linTwo];
    
    // 邮政编码
    NSString *youBianStr = @"   邮政编码:";
    UILabel *youBianLabel = [[UILabel alloc] init];
    youBianLabel.textColor = kFontColor;
    youBianLabel.font = kFont32px;
    [youBianLabel setAttributedText:[self changeColorStr:youBianStr]];
    [youBianLabel sizeToFit];
    youBianLabel.frame = CGRectMake(kFRate(10), CGRectGetMaxY(linTwo.frame) + kFRate(15), youBianLabel.frame.size.width, youBianLabel.frame.size.height);
    [myScrollView addSubview:youBianLabel];
    
    CGFloat youBianTextX = kFRate(10) + CGRectGetMaxX(youBianLabel.frame);
    UITextField *youBianText = [[UITextField alloc] initWithFrame:CGRectMake(youBianTextX, youBianLabel.frame.origin.y, kViewWidth - youBianTextX - kFRate(10), youBianLabel.frame.size.height)];
    youBianText.placeholder = @"请填写邮政编码";
    youBianText.autocorrectionType = UITextAutocorrectionTypeNo;
    youBianText.textColor = kFontColor;
    youBianText.font = kFont32px;
    youBianText.clearButtonMode = UITextFieldViewModeWhileEditing;
    youBianText.backgroundColor = [UIColor clearColor];
    youBianText.keyboardType = UIKeyboardTypeNumberPad;
    youBianText.text = self.model.zipCode;
    [myScrollView addSubview:youBianText];
    self.youBianText = youBianText;
    
    UIView *linThree = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(youBianLabel.frame) + kFRate(15), kViewWidth, kFRate(0.5))];
    linThree.backgroundColor = kLineColor;
    [myScrollView addSubview:linThree];
    
    // 收货地址
    UIView *addView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(linThree.frame), kViewWidth, kFRate(65))];
    addView.backgroundColor = [UIColor whiteColor];
    [myScrollView addSubview:addView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [addView addGestureRecognizer:tap];
    
    NSString *chooseStr = @"*  选择收获地址:";
    UILabel *chooseLabel = [[UILabel alloc] init];
    chooseLabel.textColor = kFontColor;
    chooseLabel.font = kFont32px;
    [chooseLabel setAttributedText:[self changeColorStr:chooseStr]];
    [chooseLabel sizeToFit];
    chooseLabel.frame = CGRectMake(kFRate(10), 0, chooseLabel.frame.size.width, kFRate(65));
    [addView addSubview:chooseLabel];
    
    CGFloat addX = kFRate(10) + CGRectGetMaxX(chooseLabel.frame);
    UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(addX, 0 ,kViewWidth - addX - kFRate(35), kFRate(65))];
    addLabel.textColor = kFontColor;
    addLabel.font = kFont32px;
    addLabel.numberOfLines = 0;
    if (self.model.province == nil || [self.model.province isEqual:@""] || [self.model.province isKindOfClass:[NSNull class]]) {
        addLabel.text = @"";
    }else{
        addLabel.text = [NSString stringWithFormat:@"%@%@%@",self.model.province,self.model.city,self.model.district];
    }
    [addView addSubview:addLabel];
    self.addText = addLabel;
    
    // 有图标
    UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(kViewWidth - kFRate(35), 0, kFRate(35), kFRate(65))];
    rightImg.image = _IMG(@"IWNearShoppingDetailNext");
    rightImg.userInteractionEnabled = YES;
    rightImg.contentMode = UIViewContentModeCenter;
    [addView addSubview:rightImg];
    
    UIView *linFour = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rightImg.frame), kViewWidth, kFRate(0.5))];
    linFour.backgroundColor = kLineColor;
    [addView addSubview:linFour];
    
    // 详细地址
    NSString *addressStr = @"*  详细地址:";
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.textColor = kFontColor;
    addressLabel.font = kFont32px;
    [addressLabel setAttributedText:[self changeColorStr:addressStr]];
    [addressLabel sizeToFit];
    addressLabel.frame = CGRectMake(kFRate(10), kFRate(15) + CGRectGetMaxY(addView.frame), addressLabel.frame.size.width, addressLabel.frame.size.height);
    [myScrollView addSubview:addressLabel];
    
    CGFloat addressX = kFRate(10) + CGRectGetMaxX(addressLabel.frame);
    ATextView *addressText = [[ATextView alloc] initWithFrame:CGRectMake(addressX , addressLabel.frame.origin.y - kFRate(7), kViewWidth - addressX - kFRate(10), kFRate(100))];
    addressText.font = kFont32px;
    addressText.editable = YES;   //是否允许编辑内容，默认为“YES”
    addressText.textColor = kFontColor;
    addressText.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    addressText.showsVerticalScrollIndicator = YES;
    if (self.model.detailAddress == nil || [self.model.detailAddress isEqual:@""] || [self.model.detailAddress isKindOfClass:[NSNull class]]) {
        addressText.placeholder = @"请填写详细地址";
    }else{
        addressText.placeholder = @"";
    }
    addressText.placeholderColor = IWColor(154, 154, 154);
    addressText.text = self.model.detailAddress;
    [myScrollView addSubview:addressText];
    self.addressText = addressText;
    [self.view addSubview:self.pickerView];
}

- (NSMutableAttributedString *)changeColorStr:(NSString *)str
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange redRange = NSMakeRange([[attStr string] rangeOfString:@"*"].location, [[attStr string] rangeOfString:@"*"].length);
    [attStr addAttribute:NSForegroundColorAttributeName value:IWColor(252, 82, 114) range:redRange];
    return attStr;
}

- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREEN.height , SCREEN.width, 215)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}

#pragma mark - 城市选择器展示
- (void)tap{
    [self.view endEditing:YES];
    [self.pickerView show];
}

#pragma mark - 完成或者取消
- (void)cancelBtnClick{
    NSLog(@"点击了取消按钮");
    [self.pickerView hide];
}
- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area{
    self.addText.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    _p = province;
    _c = city;
    _a = area;
    [self.pickerView hide];
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

#pragma mark - 提交
- (void)addBtnClick
{
    __weak typeof(self) weakSelf = self;
    NSString *url;
    
    
    NSString *userId = [ASingleton shareInstance].loginModel.userId;

    
    if (_isAdd) {
        url = [NSString stringWithFormat:@"%@/user/setUserAddress?method=%@&userId=%@&userName=%@&consignee=%@&province=%@&city=%@&district=%@&detailAddress=%@&zipCode=%@&phone=%@&state=%@",kNetUrl,@"save",[ASingleton shareInstance].loginModel.userId,[ASingleton shareInstance].loginModel.userName,self.nameText.text,_p,_c,_a,_addressText.text,_youBianText.text,_phoneText.text,@"0"];
        if ([self isEmpty:_nameText.text]) {
            [self addressFail:@"请填写收货人"];
            return;
        }else if ([self isEmpty:_phoneText.text]) {
            [self addressFail:@"请填写手机号码"];
            return;
        }else if ([self isEmpty:_addText.text]) {
            [self addressFail:@"请选择收货地址"];
            return;
        }else if ([self isEmpty:_addressText.text]) {
            [self addressFail:@"请填写详细地址"];
            return;
        }
    }else{
        NSString *state;
        if (_model.state) {
            state = @"1";
        }else{
            state = @"0";
        }
        url = [NSString stringWithFormat:@"%@/user/setUserAddress?method=%@&userId=%@&addressId=%@&state=%@",kNetUrl,@"edit",[ASingleton shareInstance].loginModel.userId,_model.addressId,state];
        if ([self isEmpty:_nameText.text]) {
            [self addressFail:@"请填写收货人"];
            return;
        }else if ([self isEmpty:_phoneText.text]) {
            [self addressFail:@"请填写手机号码"];
            return;
        }else if ([self isEmpty:_addText.text]) {
            [self addressFail:@"请选择收货地址"];
            return;
        }else if ([self isEmpty:_addressText.text]) {
            [self addressFail:@"请填写详细地址"];
            return;
        }
    }
    IWLog(@"url=================%@",url);
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)url, NULL, NULL,  kCFStringEncodingUTF8 ));
    [[ASingleton shareInstance]startLoadingInView:self.view];
    [IWHttpTool getWithURL:url params:nil success:^(id json) {
        [[ASingleton shareInstance]stopLoadingView];
        IWLog(@"json=======%@",json);
        if (json== nil || ![json isKindOfClass:[NSDictionary class]]) {
            [weakSelf addressFail:@"提交失败"];
            return ;
        }
        if (json[@"code"] == nil || ![json[@"code"] isEqual:@"0"]) {
            [weakSelf addressFail:@"提交失败"];
            return ;
        }
        // 修改或添加成功返回上一级
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addOrEdinAddress" object:nil];
        
        if (weakSelf.saveSuccess) {
            weakSelf.saveSuccess(weakSelf,weakSelf.model);
        }
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [[ASingleton shareInstance]stopLoadingView];
        [weakSelf addressFail:@"提交失败"];
        return ;
    }];
}

#pragma mark - 添加或编辑地址失败
- (void)addressFail:(NSString *)str
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
