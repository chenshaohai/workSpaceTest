//
//  IWModifyVC.m
//  IWShopping0221
//
//  Created by s on 17/3/12.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWModifyVC.h"

@interface IWModifyVC ()<UITextFieldDelegate>
@property (nonatomic,copy)NSString *titleName;
@property (nonatomic,copy)NSString *contentString;
@property (nonatomic,copy)NSString *showString;
@property (nonatomic,weak)UITextField *textField;

@end

@implementation IWModifyVC
-(instancetype)initWithTitle:(NSString *)titleName contentString:(NSString *)contentString showString:(NSString *)showString{
    self = [super init];
    if (self) {
        _titleName = titleName;
        _contentString = contentString;
        _showString = showString;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _titleName;
    
    self.view.backgroundColor = kColorRGB(239, 239, 239);
    
    // 自定义导航右
    UIButton *modifOrOverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [modifOrOverBtn setTitle:@"确定" forState:UIControlStateNormal];
    modifOrOverBtn.titleLabel.textColor = [UIColor whiteColor];
    modifOrOverBtn.frame = CGRectMake(0, 0, 50, 30);
    [modifOrOverBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:modifOrOverBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    
    //文字
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 84, kViewWidth, kFRate(58))];
    [self.view addSubview:textField];
    textField.delegate = self;
    textField.backgroundColor = [UIColor whiteColor];
    textField.text = self.contentString;
    self.textField = textField;
    textField.font = kFont28px;
    
    
    //提示文字
//    UILabel *showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(textField.frame) + kRate(20) , kViewWidth, kFRate(28))];
//    [self.view addSubview:showLabel];
//    showLabel.backgroundColor = [UIColor whiteColor];
//    showLabel.text = self.showString;
//    showLabel.font = kFont24px;
    
}
#pragma mark - 确定按钮点击
-(void)sure:(UIButton *)button{
    [self.view endEditing:YES];
    NSString *modifyText = self.textField.text;
    if (self.sureButtonClick) {
        self.sureButtonClick(self,modifyText);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
