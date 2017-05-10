//
//  IWGategoryModel.h
//  IWShopping0221
//
//  Created by admin on 2017/2/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWGategoryModel : NSObject
// 图片
@property (nonatomic,copy)NSString *img;
// 文字
@property (nonatomic,copy)NSString *name;

// frame
@property (nonatomic,readonly,assign)CGRect imgF;
@property (nonatomic,readonly,assign)CGRect nameF;
// cellH
@property (nonatomic,assign)CGFloat cellH;
// 按钮宽度集合
@property (nonatomic,strong)NSArray *btnArr;
@property (nonatomic,strong)NSMutableArray *btnWArr;
// 分类集合
@property (nonatomic,strong)NSArray *gateArr;
// 分类按钮frame集合
@property (nonatomic,strong)NSMutableArray *btnFArr;
// 分类滑动界面滑动高度
@property (nonatomic,assign)CGFloat scrollH;

- (id)initWithDic:(NSDictionary *)dic;
@end
