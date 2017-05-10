//
//  IWDetailImagesModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/14.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWDetailImagesModel : NSObject
// 图片
@property (nonatomic,copy)NSString *thumbImg;

- (id)initWithDic:(NSDictionary *)dic;
@end
