//
//  NSDictionary+ADictionary.h

//
//  Created by admin on 16/8/23.
//  Copyright © 2016年  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ADictionary)
#pragma mark - 公有方法
//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj;
@end
