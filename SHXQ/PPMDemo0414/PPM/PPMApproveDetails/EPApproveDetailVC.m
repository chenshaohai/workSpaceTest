//
//  EPApproveDetailVC.m
//  审批详情
//
//  Created by 许立强 on 17/4/13.
//  Copyright © 2017年 E-lead. All rights reserved.
//

#import "EPApproveDetailVC.h"
#import "EPOpinionsVC.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define UILABEL_LINE_SPACE 4


@interface EPApproveDetailVC ()

@property(nonatomic,strong)UIScrollView* scrollView;
@property(nonatomic,strong)UIView* textView;
@property(nonatomic,strong)UIView* approveView;

@property (nonatomic, strong) UIButton *agreeButton;
@property (nonatomic, strong) UIButton *unAgreeButton;


@end

@implementation EPApproveDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"审批详情";
    self.view.backgroundColor = COLOR_HEX(0xf5f5f5);

    [self configSubviews];
}

//初始化
-(void)configSubviews{
    [self configScrollView];
    [self configHeadView];
    [self configTextView];
    [self configApproveDetailView];
    [self configFootView];

    
}

-(void)configScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50-64)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
}

-(void)configHeadView{
    UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:headView];
    
    UILabel* headLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, SCREEN_WIDTH-16*2, 40)];
    headLabel.backgroundColor = [UIColor whiteColor];
    headLabel.textColor = COLOR_HEX(0x333333);
    headLabel.font = [UIFont systemFontOfSize:14];
    headLabel.text = @"面板不良率偏高";
    [headView addSubview:headLabel];
    
    UIView* line = [[UIView alloc]initWithFrame:CGRectMake(16, 40-0.5, SCREEN_WIDTH-16*2, 0.5)];
    line.backgroundColor = COLOR_HEX(0xdedede);
    [headView addSubview:line];
    
}

-(void)configTextView{
    _textView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0)];
    _textView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:_textView];
    
    NSArray* textArray = @[@{@"编号：":@"Q0000001"},@{@"面板/模组型号：":@"TM050JDHN19-02"},@{@"分辨率：":@"WQHD"},@{@"尺寸：":@"4.97"},@{@"产品线：":@"Asi"},@{@"产业基地：":@"上海天马"},@{@"客户：":@"三星"},@{@"产品阶段：":@"ES1"},@{@"不良分类：":@"显示异常"},@{@"紧急程度：":@"Critical"},@{@"不良描述：":@"面板不良,不良数500"}];
    
    CGFloat viewY = 13;
    for (NSInteger i = 0; i < textArray.count; i++) {
        NSDictionary* dic = textArray[i];
        
        //左边的label
        UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, viewY, [self sizeWithText:dic.allKeys[0] font:[UIFont systemFontOfSize:12] maxHeight:[UIFont systemFontOfSize:12].lineHeight].width, [UIFont systemFontOfSize:12].lineHeight)];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = COLOR_HEX(0x666666);
        titleLabel.text = dic.allKeys[0];
        [self.textView addSubview:titleLabel];
        
        //右边的label
        UILabel* infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.right, viewY, SCREEN_WIDTH-titleLabel.right-16, 0)];
        infoLabel.textColor = COLOR_HEX(0x666666);
        infoLabel.font = [UIFont systemFontOfSize:12];
        infoLabel.numberOfLines = 0;
        [self.textView addSubview:infoLabel];
        
        CGFloat height = [self sizeWithText:dic.allValues[0] font:[UIFont systemFontOfSize:12] maxWidth:infoLabel.width].height;
        if (height > [UIFont systemFontOfSize:12].lineHeight) {
            infoLabel.height = [self getSpaceLabelHeight:dic.allValues[0] withFont:[UIFont systemFontOfSize:12] withWidth:infoLabel.width];
            [self setLabelSpace:infoLabel withValue:dic.allValues[0] withFont:[UIFont systemFontOfSize:12]];
        }else{
            infoLabel.height = height;
            infoLabel.text = dic.allValues[0];
        }
        
        viewY += infoLabel.height+9;
        
        if (i == textArray.count-1) {
            self.textView.height = viewY+4;
        }
    }

}

-(void)configApproveDetailView{
    _approveView = [[UIView alloc]initWithFrame:CGRectMake(0, self.textView.bottom, SCREEN_WIDTH, 0)];
    _approveView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.approveView];
    
    NSArray* dataArray = @[@{@"state":@"0", @"name":@"邹宇", @"title":@"发现"},@{@"state":@"1", @"name":@"陈宝怡", @"title":@"过滤"},@{@"state":@"2", @"name":@"胡珊珊", @"title":@"责任人"},@{@"state":@"2", @"name":@"杨明", @"title":@"审核"},@{@"state":@"2", @"name":@"艾玛", @"title":@"标准化执行"},@{@"state":@"2", @"name":@"袁杰", @"title":@"标准化及流程审核"},@{@"state":@"2", @"name":@"系统", @"title":@"自动判定"}];
    
    for (NSInteger i = 0; i < 7; i++) {
        NSDictionary* dic = dataArray[i];
        
        //左边的线条
        UIView* lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor clearColor];
        [self.approveView addSubview:lineView];
        
        UIImageView* iconImageView = [[UIImageView alloc]init];
        UIImage* iconImg = [UIImage imageNamed:@"aggred"];
        iconImageView.frame = CGRectMake(0, 0, iconImg.size.width, iconImg.size.height);
        [lineView addSubview:iconImageView];
        
        UIView* topLine = [[UIView alloc]init];
        [lineView addSubview:topLine];
        
        UIView* bottomLine = [[UIView alloc]init];
        [lineView addSubview:bottomLine];

        //右边的审批详情视图
        UIView* detailView = [[UIView alloc]init];
        detailView.backgroundColor = [UIColor clearColor];
        [self.approveView addSubview:detailView];
        
        UIImage* bubbleImg = [UIImage imageNamed:@"rectangular"];
        UIImageView* bubbleImageView = [[UIImageView alloc]initWithImage:[bubbleImg resizableImageWithCapInsets:UIEdgeInsetsMake(60, 40, 20, 20) resizingMode:UIImageResizingModeStretch]];
        [detailView addSubview:bubbleImageView];
        
        UIImage* headImg = [UIImage imageNamed:[NSString stringWithFormat:@"head_0%ld",i+1]];
        UIImageView* headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 13, headImg.size.width, headImg.size.height)];
        headImageView.image = headImg;
        [detailView addSubview:headImageView];
        
        UILabel* timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH-80-10, [UIFont systemFontOfSize:10].lineHeight)];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = [UIFont systemFontOfSize:10];
        timeLabel.textColor = COLOR_HEX(0x999999);
        [detailView addSubview:timeLabel];
        
        UILabel* stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, timeLabel.bottom+10, SCREEN_WIDTH-80-10, [UIFont systemFontOfSize:14].lineHeight)];
        stateLabel.font = [UIFont systemFontOfSize:14];
        stateLabel.textAlignment = NSTextAlignmentRight;
        if ([dic[@"state"] isEqualToString:@"0"]) {
            stateLabel.text = @"已提交";
            stateLabel.textColor = COLOR_HEX(0x2ec7c9);
        }else if ([dic[@"state"] isEqualToString:@"1"]){
            stateLabel.text = @"审批中";
            stateLabel.textColor = COLOR_HEX(0xfe974b);
        }
        [detailView addSubview:stateLabel];
        
        UILabel* nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(headImageView.right+10, 18, 150, [UIFont systemFontOfSize:14].lineHeight)];
        nameLabel.textColor = COLOR_HEX(0x333333);
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.text = dic[@"name"];
        [detailView addSubview:nameLabel];
        
        UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(headImageView.right+10, nameLabel.bottom+5, SCREEN_WIDTH-80-headImageView.right-10-10, [UIFont systemFontOfSize:12].lineHeight)];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = COLOR_HEX(0x999999);
        titleLabel.text = dic[@"title"];
        [detailView addSubview:titleLabel];
        
        if (i == 0) {
            lineView.frame = CGRectMake(0, 0, 40, 30+98);
            iconImageView.image = [UIImage imageNamed:@"aggred"];
            iconImageView.center = CGPointMake(20, 30+34);
            topLine.backgroundColor = COLOR_HEX(0x2dc7c8);
            topLine.frame = CGRectMake(19.5, 0, 1, 30+34-iconImg.size.height/2);
            bottomLine.backgroundColor = COLOR_HEX(0x2dc7c8);
            bottomLine.frame = CGRectMake(19.5, iconImageView.bottom, 1, 34-iconImg.size.height/2+30);
            
            detailView.frame = CGRectMake(40, 30, SCREEN_WIDTH-40-40, 98);
            bubbleImageView.frame = detailView.bounds;
            timeLabel.text = @"2016-12-23 15:12";
            
            UIView* separatorLine = [[UIView alloc]initWithFrame:CGRectMake(18, 68, detailView.width-18-10, 0.5)];
            separatorLine.backgroundColor = COLOR_HEX(0xdedede);
            [detailView addSubview:separatorLine];
            
            UILabel* opinionLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 68.5, detailView.width-18-10, 29.5)];
            opinionLabel.text = @"审批意见：ok";
            opinionLabel.textColor = COLOR_HEX(0x999999);
            opinionLabel.font = [UIFont systemFontOfSize:12];
            [detailView addSubview:opinionLabel];
            
        }else{
            lineView.frame = CGRectMake(0, 30+98+(18+68)*(i-1), 40, 18+68);
            if ([dic[@"state"] isEqualToString:@"1"]) {
                iconImageView.image = [UIImage imageNamed:@"applying"];
            }else{
                iconImageView.image = [UIImage imageNamed:@"unapplying"];
            }
            iconImageView.center = CGPointMake(20, 18+34);
            topLine.frame = CGRectMake(19.5, 0, 1, 18+34-iconImg.size.height/2);
            bottomLine.backgroundColor = COLOR_HEX(0xdedede);
            bottomLine.frame = CGRectMake(19.5, iconImageView.bottom, 1, 34-iconImg.size.height/2);
            if (i == 1) {
                topLine.backgroundColor = COLOR_HEX(0x2dc7c8);
            }else{
                topLine.backgroundColor = COLOR_HEX(0xdedede);
            }
            
            detailView.frame = CGRectMake(40, 30+98+18+(18+68)*(i-1), SCREEN_WIDTH-40-40, 68);
            bubbleImageView.frame = detailView.bounds;
            stateLabel.top = 25;

        }
        
        if (i == 6) {
            bottomLine.hidden = YES;
            self.approveView.height = lineView.bottom+30;
            self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.approveView.bottom);
        }
        
    }
    
}

-(void)configFootView{
    UIView* footView = [[UIView alloc]initWithFrame:CGRectMake(0, self.scrollView.bottom, SCREEN_WIDTH, 50)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    
    [footView addSubview:self.agreeButton];
    [footView addSubview:self.unAgreeButton];
    
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-0.25, 10, 0.5, 30)];
    separatorLine.backgroundColor = COLOR_HEX(0xdedede);
    [footView addSubview:separatorLine];

    UIView* line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = COLOR_HEX(0xdedede);
    [footView addSubview:line];
    
}


- (UIButton *)agreeButton{
    if (!_agreeButton) {
        _agreeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _agreeButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 50);
        [_agreeButton setTitle:@"同意" forState:UIControlStateNormal];
        [_agreeButton setTitleColor:COLOR_HEX(0x2ec7c9) forState:UIControlStateNormal];
        [_agreeButton setBackgroundColor:[UIColor whiteColor]];
        _agreeButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_agreeButton addTarget:self action:@selector(agreeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _agreeButton;
}

- (UIButton *)unAgreeButton{
    if (!_unAgreeButton) {
        _unAgreeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _unAgreeButton.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 50);
        [_unAgreeButton setTitle:@"拒绝" forState:UIControlStateNormal];
        [_unAgreeButton setTitleColor:COLOR_HEX(0x2ec7c9) forState:UIControlStateNormal];
        _unAgreeButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_unAgreeButton setBackgroundColor:[UIColor whiteColor]];
        [_unAgreeButton addTarget:self action:@selector(unAgreeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unAgreeButton;
}


#pragma mark --点击事件
- (void)agreeButtonClick{
    EPOpinionsVC* vc = [[EPOpinionsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    NSLog(@"确认");
}

- (void)unAgreeButtonClick{
    EPOpinionsVC* vc = [[EPOpinionsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    NSLog(@"拒绝");
}


#pragma mark - 辅助方法
// 根据指定文本,字体和最大高度计算尺寸
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxHeight:(CGFloat)height
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}


//给UILabel设置行间距和字间距

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    //设置字间距 NSKernAttributeName:@1.5f
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    
    label.attributedText = attributeStr;
    
}

//计算UILabel的高度(带有行间距的情况)
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
    
}




@end
