//
//  EPOpinionsVC.m
//  审批详情
//
//  Created by 许立强 on 17/4/14.
//  Copyright © 2017年 E-lead. All rights reserved.
//

#import "EPOpinionsVC.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface EPOpinionsVC ()<UITextViewDelegate>

@property(nonatomic,strong)UITextView* textView;
@property(nonatomic,strong)UILabel* placeholderLabel;


@end

@implementation EPOpinionsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = COLOR_HEX(0xf5f5f5);
    self.navigationItem.title = @"审批意见";

    [self configSubviews];

}

-(void)configSubviews{
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 247)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(16, 0, SCREEN_WIDTH-16*2, 247)];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.delegate = self;
    _textView.textColor = COLOR_HEX(0x666666);
    _textView.font = [UIFont systemFontOfSize:12];
    [backView addSubview:self.textView];
    
    _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 8, _textView.width-5*2, [UIFont systemFontOfSize:12].lineHeight)];
    _placeholderLabel.textColor = COLOR_HEX(0x999999);
    _placeholderLabel.text = @"审批意见（选填）";
    _placeholderLabel.font = [UIFont systemFontOfSize:12];
    [self.textView addSubview:self.placeholderLabel];
    
    UIButton* submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, backView.bottom+40, SCREEN_WIDTH-16*2, 40)];
    [self.view addSubview:submitBtn];
    submitBtn.layer.cornerRadius = 3;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.backgroundColor = COLOR_HEX(0x2ec7c9);
    [submitBtn setTitleColor:COLOR_HEX(0xffffff) forState:(UIControlStateNormal)];
    [submitBtn addTarget:self action:@selector(clickToSubmit) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:submitBtn];
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChangeSelection:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.placeholderLabel.hidden = YES;
    }
    if (textView.text.length < 1) {
        self.placeholderLabel.hidden = NO;
    }
}

#pragma mark - 点击事件
-(void)clickToSubmit{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}





@end
