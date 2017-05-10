//
//  IWNearShoppingDetailServeCell.m
//  IWShopping0221
//
//  Created by s on 17/2/26.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWNearShoppingDetailServeCell.h"

@interface IWNearShoppingDetailServeCell()<UIWebViewDelegate>

@property(nonatomic ,strong)UIWebView *webView;

@property(nonatomic,assign)int count;
@end


// 随机色
//#define kArc4randomColor kColorRGB(arc4random_uniform(254), arc4random_uniform(254), arc4random_uniform(254))
#define kArc4randomColor [UIColor clearColor]


@implementation IWNearShoppingDetailServeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView  height:(CGFloat )height
{
    static NSString *identifierIWNearShoppingSearchResultCell = @"IWNearShoppingSearchResultCell";
    IWNearShoppingDetailServeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierIWNearShoppingSearchResultCell];
    if (cell == nil) {
        cell = [[IWNearShoppingDetailServeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierIWNearShoppingSearchResultCell  height:height];
        cell.backgroundColor = [UIColor whiteColor];
        // 去掉选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  height:(CGFloat )height
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIWebView *webView = [[UIWebView  alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, height)];
        [self addSubview:webView];
        self.webView = webView;
        webView.delegate = self;
        
        
        webView.scrollView.scrollEnabled = NO;
        
        _count = 0;
        
    }
    return self;
}

-(void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [self.webView loadRequest:request];
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //    [[ASingleton shareInstance]startLoadingInView:nil];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //    [[ASingleton shareInstance]stopLoadingView];
    
    if (self.count > 2) {
        return;
    }
    self.count ++;
    float width = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetWidth"] floatValue];
    float height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    NSLog(@"documentSize = {%f, %f}", width, height);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"IWNearShoppingDetailSerceWebViewHeight" object:nil userInfo:@{@"webViewH":[NSNumber numberWithFloat:height]}];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //    [[ASingleton shareInstance]stopLoadingView];
}


@end
