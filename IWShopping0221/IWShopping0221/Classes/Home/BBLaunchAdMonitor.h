//
//  BBLaunchAdMonitor.h
//  Search
//
//  Created by iXcoder on 15/4/22.
//  Copyright (c) 2015年 iXcoder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *BBLaunchAdDetailDisplayNotification;

@interface BBLaunchAdMonitor : NSObject

+ (void)showAdAtPath:(NSString *)path onView:(UIView *)container timeInterval:(NSTimeInterval)interval detailParameters:(NSDictionary *)param;

@end
