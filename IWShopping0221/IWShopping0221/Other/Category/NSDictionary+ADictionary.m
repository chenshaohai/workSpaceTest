//
//  NSDictionary+ADictionary.m

//
//  Created by admin on 16/8/23.
//  Copyright © 2016年  All rights reserved.
//

#import "NSDictionary+ADictionary.h"

@implementation NSDictionary (ADictionary)
//将NSDictionary中的Null类型的项目转化成@""
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    if ([@"(null)" isEqualToString:string]) {
        return @"";
    }
    
    if ([@"null" isEqualToString:string]) {
        return @"";
    }
    if ([@"NSNull" isEqualToString:string]) {
        return @"";
    }
    return string;
}
+(NSString *)numberToString:(NSNumber *)number{

    return [NSString stringWithFormat:@"%@",number];
}

//将Null类型的项目转化成@""
+(NSString *)nullToString
{
    return @"";
}

#pragma mark - 公有方法
//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]]){
        return [self nullDic:myObj];
    }else if([myObj isKindOfClass:[NSArray class]]){
        return [self nullArr:myObj];
    }else if([myObj isKindOfClass:[NSString class]]){
        return [self stringToString:myObj];
    }else if([myObj isKindOfClass:[NSNumber class]]){
        return [self numberToString:myObj];
    }else if([myObj isKindOfClass:[NSNull class]]){
        return [self nullToString];
    }else{
        return myObj;
    }
}

@end
