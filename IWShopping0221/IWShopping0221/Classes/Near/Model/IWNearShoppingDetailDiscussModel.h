//
//  IWNearShoppingDetailDiscussModel.h
//  IWShopping0221
//
//  Created by FRadmin on 17/2/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWNearShoppingDetailDiscussModel : NSObject

/**
 *   ID
 */
@property (nonatomic,copy)NSString *modelId;
/**
 *   名字
 */
@property (nonatomic,copy)NSString *name;
/**
 * 内容
 */
@property (nonatomic,copy)NSString *content;
/**
 *  时间
 */
@property (nonatomic,copy)NSString *time;
/**
 *  图标
 */
@property (nonatomic,copy)NSString *logo;

/**
 *  星星
 */
@property (nonatomic,copy)NSString *score;
/**
 * Frame
 */
@property (nonatomic,assign)CGRect logoFrame;
/**
 * Frame
 */
@property (nonatomic,assign)CGRect nameFrame;
/**
 * Frame
 */
@property (nonatomic,assign)CGRect timeFrame;
/**
 * 内容Frame
 */
@property (nonatomic,assign)CGRect contentFrame;
/**
 * Frame
 */
@property (nonatomic,assign)CGRect lineFrame;

/**
 *  星星Frame
 */
@property (nonatomic,assign)CGRect starFrame;
/**
 * CellH
 */
@property (nonatomic,assign)CGFloat cellH;



+ (id)modelWithDic:(NSDictionary *)dic;
- (id)initWithDic:(NSDictionary *)dic;
@end
