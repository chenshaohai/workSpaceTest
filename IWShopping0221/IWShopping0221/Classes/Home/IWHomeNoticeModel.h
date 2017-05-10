//
//  IWHomeNoticeModel.h
//  IWShopping0221
//
//  Created by MacBook on 2017/3/7.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWHomeNoticeModel : NSObject
@property (nonatomic,copy)NSString *noticeDesc;
@property (nonatomic,copy)NSString *noticeId;

- (id)initWithDic:(NSDictionary *)dic;
@end
