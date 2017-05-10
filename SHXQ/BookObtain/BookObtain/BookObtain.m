//
//  BookObtain.m
//  BookObtain
//
//  Created by lu_ios on 2017/5/10.
//  Copyright © 2017年 lu_ios. All rights reserved.
//

#import "BookObtain.h"

@implementation BookObtain
+(Book *)bookWithurl:(NSString *)url{

    Book *book = [Book bookWithDic:@{@"name":@"heheh",
                                     @"price":@"1.8",
                                     @"content":@"fjdklajfkl"
                                     }];
    return book;
}


@end
