//
//  IWToViewModel.h
//  IWShopping0221
//
//  Created by admin on 2017/3/13.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWToViewModel : NSObject
// 物流进度内容
@property (nonatomic,copy)NSString *AcceptStation;
// 时间
@property (nonatomic,copy)NSString *AcceptTime;
// Remark
@property (nonatomic,copy)NSString *Remark;


// Frame
@property (nonatomic,readonly,assign)CGRect contentF;
@property (nonatomic,readonly,assign)CGRect timeF;
@property (nonatomic,readonly,assign)CGRect imgF;
@property (nonatomic,readonly,assign)CGRect linXF;
@property (nonatomic,readonly,assign)CGRect linSF;
@property (nonatomic,assign)CGFloat cellH;
- (id)initWithDic:(NSDictionary *)dic;
@end
