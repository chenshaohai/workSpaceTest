//
//  ALoadingView.m
//  自定义加载中
//
//  Created by FRadmin on 16/7/30.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ALoadingView.h"
#define KSCRWIDTH [UIScreen mainScreen].bounds.size.width
#define KSCRHEIGHT [UIScreen mainScreen].bounds.size.height
@interface ALoadingView()
@property (nonatomic,weak)UILabel *lblTitle;
@end
@implementation ALoadingView

static ALoadingView *mLoadingView = nil;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


///初始化加载框，这个函数是表示LoadingView的大小，如果是Yes，则loadView的大小为整个窗体，在这种情况下网络请求的时候会遮盖整个窗体，用户其他操作都是无效的相当于同步，如果是No，则loadView的大小为为150*80，用户的其他操作是有效的，这种情况相下需要保证loadingView唯一；
- (id)initIsLikeSynchro:(BOOL)isLikeSynchro{
    //    if (isLikeSynchro) {
    self = [super initWithFrame:CGRectMake(0, 0, KSCRWIDTH, KSCRHEIGHT)];
    //    }else{
    //        self = [super initWithFrame:CGRectMake((KSCRWIDTH-150)/2, ([UIApplication sharedApplication].keyWindow.bounds.size.height-150)/2, 150, 150)];
    //    }
    
    if (self) {
        self.isLikeSynchro = isLikeSynchro;
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        
        //        conerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        conerView = [[UIView alloc] initWithFrame:self.frame];
        
        [self setCenter:conerView withParentRect:self.frame];
        conerView.backgroundColor = [UIColor clearColor];
        [self addSubview:conerView];
        
        indicatorView = [[AActivityIndicicator alloc] init];
        indicatorView.bounds = CGRectMake(0, 0, kFRate(50),kFRate(50));
        if (isLikeSynchro) {
            indicatorView.center = CGPointMake(conerView.center.x, conerView.center.y - kFRate(30));
        }else{
            indicatorView.center = CGPointMake(conerView.center.x, kFRate(20));
        }
        [conerView addSubview:indicatorView];
        
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.bounds = CGRectMake(0, 0, kFRate(30), kFRate(30));
        iconView.center = indicatorView.center;
        iconView.image = _IMG(@"ALoding");
        [conerView addSubview:iconView];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(conerView.frame)/2 - kFRate(75), CGRectGetMaxY(indicatorView.frame) , 150, kFRate(20))];
        lblTitle.backgroundColor = [UIColor clearColor];
        lblTitle.textColor = [UIColor blackColor];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        lblTitle.bounds = CGRectMake(0, 0, kFRate(150),kFRate(20));
        if (isLikeSynchro) {
//            lblTitle.center = CGPointMake(conerView.center.x, conerView.center.y+75);
        }else{
//            lblTitle.center = CGPointMake(conerView.center.x, conerView.center.y+45);
        }
        lblTitle.text = @"Loading";
        
        lblTitle.font = [UIFont systemFontOfSize:14];
        [conerView addSubview:lblTitle];
        _lblTitle = lblTitle;
        
        conerView.layer.cornerRadius = 8;
        conerView.layer.masksToBounds = YES;
    }
    return self;
}

- (void)show{
    
    self.lblTitle.text =@"Loading";
    //    if ([UIApplication sharedApplication].keyWindow.rootViewController.navigationController) {
    //        [[UIApplication sharedApplication].keyWindow.rootViewController.navigationController.view addSubview:self];
    //    }else{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    //    }
    self.hidden = NO;
    self.userInteractionEnabled = YES;
    [indicatorView start];
}


- (void)showWithTitle:(NSString *)title{
    
    self.lblTitle.text = title;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.hidden = NO;
    self.userInteractionEnabled = YES;
    [indicatorView start];
}

- (void)loadingShow{
    self.lblTitle.text =@"Loading111";
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.hidden = NO;
    self.userInteractionEnabled = YES;
    [indicatorView start];
}

- (void)close{
    //    [self removeFromSuperview];
    self.hidden = YES;
    self.userInteractionEnabled = YES;
}


+ (ALoadingView *)shareLoadingView{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mLoadingView = [[[self class] alloc] initIsLikeSynchro:YES];
        
    });
    return mLoadingView;
}

+ (id)allocWithZone:(NSZone *)zone{
    if (mLoadingView==nil) {
        mLoadingView = [super allocWithZone:zone];
        return mLoadingView;
    }
    
    return  nil;
}

///设置子View在父View中居中
- (void)setCenter:(UIView *)child withParentRect:(CGRect)parentRect{
    CGRect rect = child.frame;
    rect.origin.x = (parentRect.size.width - child.frame.size.width)/2;
    rect.origin.y = (parentRect.size.height - child.frame.size.height)/2;
    child.frame = rect;
}

@end
