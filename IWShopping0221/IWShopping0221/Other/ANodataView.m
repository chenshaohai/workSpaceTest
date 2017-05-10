//
//  CTDAvenueFRNodataView.m
//  CTDAvenueCI
//
//  Created by admin on 16/3/12.
//  Copyright © 2016年 CTD. All rights reserved.
//


#import "ANodataView.h"
@interface ANodataView()
@property (nonatomic, weak)UIImageView *noDataImageView;
@property (nonatomic, weak)UILabel *tishi;
//@property (nonatomic, weak)UIButton *refreshButton;
@end
@implementation ANodataView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        
        
        
        UIImageView *nodataimage = [[UIImageView alloc]init];
        nodataimage.image = _IMG(@"ic_nodata");
        nodataimage.userInteractionEnabled = YES;
        [self addSubview:nodataimage];
        _noDataImageView = nodataimage;
        
        UILabel *tishi = [[UILabel alloc]init];
        tishi.text = self.tishiString;
//        tishi.textColor =[UIColor colorWithHexRGBString:@"#3a3e55"];
        tishi.font = [UIFont systemFontOfSize:15];
        tishi.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tishi];
        _tishi = tishi;
        
        UIButton *refreshButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
        [refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
        refreshButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [refreshButton setBackgroundColor:IWColorRed];
        refreshButton.layer.cornerRadius = 5;
        [refreshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [refreshButton addTarget:self action:@selector(refreshButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        refreshButton.userInteractionEnabled = YES;
        //默认隐藏
        refreshButton.hidden = YES;
        //添加
        [self  addSubview:refreshButton];
        self.refreshButton = refreshButton;
    }
    return self;
}
- (void)layoutSubviews{
    
    
    UIImage *iconImage = _IMG(@"ic_nodata");
    CGFloat iconImageW = iconImage.size.width;
    CGFloat iconImageH = iconImage.size.height;
    _noDataImageView.frame = CGRectMake((self.frame.size.width - iconImageW)/2, (self.frame.size.height- iconImageH)/2 - 40, iconImageW, iconImageH);
    _tishi.frame = CGRectMake(0, _noDataImageView.frame.origin.y +_noDataImageView.frame.size.height + 5, kViewWidth, 30);
    
    //刷新按钮位置
   CGRect  refreshFrame = self.refreshButton.frame;
    refreshFrame.origin.x = (self.frame.size.width - refreshFrame.size.width)/2;
    refreshFrame.origin.y = CGRectGetMaxY(_tishi.frame) + 5;
    self.refreshButton.frame = refreshFrame;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    
}
-(void)setTishiString:(NSString *)tishiString
{
    _tishiString = tishiString;
    _tishi.text = tishiString;
}
/**
 *  刷新按钮点击
 *
 *  @param button 按钮本身
 */
-(void)refreshButtonClick:(UIButton *)button
{
    //回调显示或隐藏无数据视图
    if (self.refreshButtonClick) {
        self.refreshButtonClick(self,button);
    }
}
/**
 *  刷新按钮是否显示的set方法
 *
 *  @param showRefreshButton 刷新按钮是否显示的set方法
 */
-(void)setShowRefreshButton:(BOOL)showRefreshButton
{
_showRefreshButton = showRefreshButton;
self.refreshButton.hidden = !showRefreshButton;

}

-(void)setNoDataImage:(UIImage *)noDataImage{
    _noDataImage = noDataImage;
    _noDataImageView.image = noDataImage;
}
@end
