//
//  NSDictionary+Null.m
//  E-Platform
//
//  Created by Apple on 2017/3/16.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import "NSDictionary+Null.h"

@implementation NSDictionary (Null)
- (NSString *)getSafeStringWithKey:(NSString *)key
{
    if ([self valueForKey:key] && [[self valueForKey:key] isKindOfClass:[NSString class]]) {
        NSString *str = [self valueForKey:key];
        if (![str.lowercaseString containsString:@"null"]) {
            return str;
        }
    }else  if ([self valueForKey:key] && [[self valueForKey:key] isKindOfClass:[NSNumber class]])
    {
        NSNumber *num = [self valueForKey:key];
        return [NSString stringWithFormat:@"%@",num]; 
    }
    return @"";
}
@end
