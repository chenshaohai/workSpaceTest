//
//  IWHomeBanderModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/1.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWHomeBanderModel : NSObject
// id
@property (nonatomic,copy) NSString *bannerId;
// 图片
@property (nonatomic,copy) NSString *bannerImg;
// name
@property (nonatomic,copy) NSString *bannerName;
// url
@property (nonatomic,copy) NSString *targetUrl;

- (id)initWithDic:(NSDictionary *)dic;
@end
