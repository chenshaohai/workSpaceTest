//
//  EPObPartProjectViewModel.h
//  E-Platform
//
//  Created by 陈敬 on 2017/3/21.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPObPartProjectViewModel : NSObject

@property (nonatomic, strong) NSString *headImageName;

@property (nonatomic, strong) NSString *topLabelText;

@property (nonatomic, strong) NSString *numberText;
@property (nonatomic, strong) NSString *adminText;
@property (nonatomic, strong) NSString *scheduleText;
@property (nonatomic, strong) NSString *deliverStateText;
@property (nonatomic, strong) NSString *deliverTimeText;


@property (nonatomic, assign) BOOL isShowWaring;

+ (id)modelWithDic:(NSDictionary *)dic;
- (id)initWithDic:(NSDictionary *)dic;
@end
