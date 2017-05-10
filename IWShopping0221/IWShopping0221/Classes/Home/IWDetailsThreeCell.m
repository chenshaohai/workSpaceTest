//
//  IWDetailsThreeCell.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/26.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDetailsThreeCell.h"

@interface IWDetailsThreeCell ()<UIWebViewDelegate>

@property (nonatomic,assign)NSInteger tempNum;
@end

@implementation IWDetailsThreeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    NSString *ID = [NSString stringWithFormat:@"IWDetailsThreeCell"];
    IWDetailsThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWDetailsThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _tempNum = 0;
        UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight - 64 - kFRate(50) - kFRate(50))];
        webView.backgroundColor = [UIColor whiteColor];
        webView.delegate = self;
        webView.scrollView.scrollEnabled = NO;
        //自动对页面进行缩放以适应屏幕
        webView.scalesPageToFit = YES;
        [self.contentView addSubview:webView];
        self.webView = webView;
    }
    return self;
}

- (void)webViewDidFinishLoad:(UIWebView *)wb
{
    if (_tempNum == 1) {
        float width = [[wb stringByEvaluatingJavaScriptFromString:@"document.body.offsetWidth"] floatValue];
        float height = [[wb stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
        NSLog(@"documentSize = {%f, %f}", width, height);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"IWWebViewHeight" object:nil userInfo:@{@"webViewH":[NSNumber numberWithFloat:height]}];
    }
}

- (void)setDetailModel:(IWDetailModel *)detailModel
{
    _detailModel = detailModel;
    NSURL* url = [NSURL URLWithString:_detailModel.productDescUrl];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    if (_tempNum == 0) {
        [self.webView loadRequest:request];//加载
    }
    _tempNum ++;
}

#pragma mark - UIWebViewDelegate


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
