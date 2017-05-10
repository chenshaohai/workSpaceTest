//
//  IWGategoryModel.m
//  IWShopping0221
//
//  Created by admin on 2017/2/27.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWGategoryModel.h"

@implementation IWGategoryModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.img = @"http://pic40.nipic.com/20140403/18349729_224700167315_2.jpg";
        self.name = @"游戏";
        _btnArr = @[@"为你推荐",@"家电",@"食品",@"百货",@"女装",@"男装"];
        _gateArr = @[@"为你推荐",@"家电",@"食品",@"百货",@"女装",@"男装",@"为你推荐",@"家电",@"食品",@"百货",@"女装",@"男装",@"为你推荐",@"家电",@"食品",@"百货",@"女装",@"男装",@"为你推荐",@"家电",@"食品",@"百货",@"女装",@"男装",@"为你推荐",@"家电",@"食品",@"百货",@"女装",@"男装",@"食品",@"百货",@"女装",@"男装",@"食品",@"百货",@"女装",@"男装",@"食品",@"百货",@"女装",@"男装",@"食品",@"百货",@"女装",@"男装"];
        _btnWArr = [[NSMutableArray alloc] init];
        
        [self frame];
    }
    return self;
}

- (void)frame{
    
    // 按钮宽度集合
    for (NSInteger i = 0; i < _btnArr.count; i ++) {
        CGSize maximumLabelSize = CGSizeMake(kRate(90), MAXFLOAT);//labelsize的最大值
        NSDictionary *attribute = @{NSFontAttributeName: kFont24px};
        CGSize expectSize = [_btnArr[i] boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        [_btnWArr addObject:[NSNumber numberWithFloat:expectSize.width]];
    }
    
    _imgF = CGRectMake(0, 0, kRate(90), kRate(90));
    CGSize maximumLabelSize = CGSizeMake(kRate(90), MAXFLOAT);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName: kFont24px};
    CGSize expectSize = [self.name boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    CGFloat commentH;
    if (expectSize.height >= kRate(30)) {
        commentH = expectSize.height + kRate(10);
    }else if(expectSize.height > kRate(20)){
        commentH = kRate(40);
    }else{
        commentH = kRate(30);
    }
    _nameF = CGRectMake(0, kRate(90), kRate(90), commentH);
    _cellH = CGRectGetMaxY(_nameF);
    
    // 分类展示按钮frame集合
    NSInteger linNum;
    if (_gateArr.count % 3 > 0) {
        linNum = _gateArr.count / 3 + 1;
    }else{
        linNum = _gateArr.count / 3;
    }
    // 按钮宽
    CGFloat btnW = (kViewWidth - kFRate(20)) / 3;
    CGFloat btnH = kFRate(25);
    _btnFArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < linNum; i ++) {
        for (NSInteger j = 0; j < 3; j ++) {
            CGRect btnF = CGRectMake(j * btnW, btnH * i, btnW, btnH);
            [_btnFArr addObject:[NSValue valueWithCGRect:btnF]];
        }
    }
    _scrollH = linNum * btnH;
}
@end
