//
//  IWGoodsThreeModel.h
//  IWShopping0221
//
//  Created by admin on 2017/3/28.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWGoodsThreeModel : NSObject
@property (nonatomic,copy)NSString *orderContent;
@property (nonatomic,copy)NSString *content;

@property (nonatomic,assign,readonly)CGRect orderContentF;
// 表头
@property (nonatomic,assign,readonly)CGRect tableOneF;
// 原因
@property (nonatomic,assign,readonly)CGRect contentF;
// 分割线
@property (nonatomic,assign,readonly)CGRect linOneF;
// cellH
@property (nonatomic,assign)CGFloat cellH;
- (id)initWithDic:(NSDictionary *)dic;
@end
