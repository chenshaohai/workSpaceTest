//
//  Book.m
//  BookObtain
//
//  Created by lu_ios on 2017/5/10.
//  Copyright © 2017年 lu_ios. All rights reserved.
//

#import "Book.h"

@implementation Book
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self)
    {
        _name = dic[@"name"]?dic[@"name"]:@"";
        _price = dic[@"price"]?dic[@"price"]:@"";
        _content = dic[@"content"]?dic[@"content"]:@"";
    }
    return self;

}
+ (id)bookWithDic:(NSDictionary *)dic{

 return [[self alloc]initWithDic:dic];
}
@end
