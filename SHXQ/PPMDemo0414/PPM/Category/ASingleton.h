//
//  ASingleton.h

//
//  Created by admin on 16/8/23.
//  Copyright © 2016年 All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "IWLoginModel.h"
@class ALoadingView;
//语言类型
typedef enum {
    languageTypeChinese = 1, //中文
    languageTypeEnglish = 2, //英文
    languageTypeOther = 3, //其它
} ASinglanguageType;
@interface ASingleton : NSObject
/**
 * 经纬度
 */
@property(nonatomic,assign)CGFloat latitude;
/**
 * 经纬度
 */
@property(nonatomic,assign)CGFloat longitude;
/**
 *  定位城市名字
 */
@property(nonatomic,copy)NSString *city;
//@property(nonatomic,copy)NSString *cityId;
@property(nonatomic,copy)ALoadingView *loadingView;
@property (nonatomic,assign) NSUInteger loadingCount;
@property (nonatomic,assign)ASinglanguageType languageType;

// 门店分类
@property (nonatomic,strong)NSArray *storeCateList;
// 商品分类
@property (nonatomic,strong)NSArray *productCateList;
// 关于我们
@property (nonatomic,copy)NSString *aboutUsUrl;
// 加盟合作
@property (nonatomic,copy)NSString *businessUrl;



// 用户Id
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *userName;
// 余额url
@property(nonatomic,copy)NSString *balanceUrl;
@property(nonatomic,copy)NSString *integralUrl;
/**
 * 登陆模型
 */
//@property (nonatomic,strong)IWLoginModel *loginModel;
/**
 * 首页是否需要刷新
 */
@property (nonatomic,assign)BOOL homeVCNeedRefresh;
/**
 * 附近是否需要刷新
 */
@property (nonatomic,assign)BOOL nearVCNeedRefresh;
/**
 * 购物车是否需要刷新
 */
@property (nonatomic,assign)BOOL shoppingVCNeedRefresh;

/**
 * 购物车是否不需要刷新
 */
@property (nonatomic,assign)BOOL shoppingVCNeedNoRefresh;
/**
 * 我是否需要刷新
 */
@property (nonatomic,assign)BOOL meVCNeedRefresh;

/**
 *  我的订单回退到的控制器  removeblock 是否需要清除block
 */
@property(nonatomic,copy)void(^orderFormbackCommit)(BOOL removeblock);

+ (instancetype)shareInstance;
// webservice开始
- (void)startLoadingInView:(UIView *)view;
// webservice结束
- (void)stopLoadingView;
// webservice立刻结束
- (void)mustStopLoadingView;
@end
