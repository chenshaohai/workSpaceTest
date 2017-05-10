//
//  IWSearchBar.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/23.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWSearchBar.h"

@interface IWSearchBar ()
// 背景图片
@property (nonatomic,weak)UIImageView *seachImg;
// 放大镜是否靠左
@property (nonatomic,assign)BOOL hasCenterPlaceholder;
// 放大镜图片
@property (nonatomic,copy)NSString *bigString;
@end

@implementation IWSearchBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.placeholder = @"搜索商家";
        self.keyboardType = UIKeyboardTypeDefault;
        // 图片
        UIImageView *seachImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        seachImg.image = _IMG(@"AFTSearchBar");
        self.seachImg = seachImg;
        
        // 白色背景
        UIView *seachView = [[UIView alloc] initWithFrame:self.bounds];
        seachView.backgroundColor = [UIColor whiteColor];
        seachView.layer.cornerRadius = 5.0f;
        seachView.layer.masksToBounds = YES;
        // 图片替换searchBar背景
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count >0) {
                [[view.subviews objectAtIndex:0] removeFromSuperview];
                [self insertSubview:seachView atIndex:0];
                break;
            }
        }
        // searchBar文本背景颜色透明色
        [self setSearchTextFieldBackgroundColor:[UIColor clearColor] searchBar:self];
    }
    return self;
}

// 自定义seachBar背景图片及提示文字
- (void)changeSearchBarBackGroundImage:(NSString *)imageString text:(NSString *)text
{
    self.placeholder = text;
    self.seachImg.image = _IMG(imageString);
}
/**
 *  searchBar设置背景图及提示文字 放大镜 文字剧中或左
 *
 *  @param imageString          背景图片
 *  @param text                 替换文字
 *  @param bigString            放大镜图标
 *  @param hasCenterPlaceholder 替换文字和放大镜 默认是否在中间，如果不是就靠左
 */
- (void)changeSearchBarBackGroundImage:(NSString *)imageString text:(NSString *)text bigImage:(NSString *)bigString hasCenterPlaceholder:(BOOL)hasCenterPlaceholder{
    [self  changeSearchBarBackGroundImage:imageString text:text];
    self.bigString = bigString;
    self.hasCenterPlaceholder = hasCenterPlaceholder;
}
//替换文字靠左
-(void)setHasCenterPlaceholder:(BOOL)hasCenterPlaceholder{
    _hasCenterPlaceholder = hasCenterPlaceholder;
    
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@",@"setCenter",@"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        NSMethodSignature *signature = [[UISearchBar class]instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        
        [invocation setSelector:centerSelector];
        [invocation setArgument:&_hasCenterPlaceholder atIndex:2];
        [invocation invoke];
    }
}

// searchBar文本背景颜色透明色
- (void)setSearchTextFieldBackgroundColor:(UIColor *)backgroundColor searchBar:(UISearchBar *)search

{
    UIView *searchTextField = nil;
    // 改变下barTintColor才能改变searchTextField的背景颜色
    search.barTintColor = [UIColor whiteColor];
    searchTextField = [[[search.subviews firstObject] subviews] lastObject];
    searchTextField.backgroundColor = backgroundColor;
}

//替换放大镜图标
-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (!self.bigString)
        return;
    for (UIView *subview in self.subviews) {
        for (UIView *subview11 in subview.subviews) {
            if (subview11.subviews && subview11.subviews.count > 2) {
                UIImageView *bigImageView = subview11.subviews[1];
                bigImageView.image = [UIImage imageNamed:self.bigString];
            }
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
