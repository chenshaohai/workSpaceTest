//
//  IWHomeCellModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/2/23.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWHomeCellModel.h"

@implementation IWHomeCellModel
- (id)initWithDic:(NSDictionary *)dic;
{
    self = [super init];
    if (self) {
        self.imgs = @[@"http://pic40.nipic.com/20140403/18349729_224700167315_2.jpg",@"http://pic33.photophoto.cn/20141204/0005018356673635_b.jpg",@"http://pic27.photophoto.cn/20130409/0005018377767177_b.jpg"];
        self.titles = @[@"人物壁纸",@"人物壁纸",@"人物壁纸"];
    }
    return self;
}
@end
