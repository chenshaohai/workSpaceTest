//
//  IWDetailSkuModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/14.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDetailSkuModel.h"
#import "IWDetailSkuInfosModel.h"

@interface IWDetailSkuModel ()
// btnFrame
@property (nonatomic,readonly,assign)CGRect btnF;
@end

@implementation IWDetailSkuModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _skuInfosModelArr = [[NSMutableArray alloc] init];
        
        _attributeId = dic[@"attributeId"]?dic[@"attributeId"]:@"";
        _attributeName = dic[@"attributeName"]?dic[@"attributeName"]:@"";
        // 规格数组
        _skuInfos = dic[@"skuValues"]?dic[@"skuValues"]:nil;
        
        if (_skuInfos && _skuInfos.count > 0) {
            for (NSDictionary *dic in _skuInfos) {
                IWDetailSkuInfosModel *model = [[IWDetailSkuInfosModel alloc] initWithDic:dic];
                [_skuInfosModelArr addObject:model];
            }
        }
        
        [self frame];
    }
    return self;
}

- (void)frame{
    // 规格名字
    _btnFArr = [[NSMutableArray alloc] init];
    CGSize nameSize = [self initWithWidth:kViewWidth height:MAXFLOAT font:kFont28px text:_attributeName];
    _nameF = CGRectMake(kFRate(10), kFRate(15), nameSize.width, nameSize.height);
    // 按钮Frame集合
    CGFloat tempX = 0.0f;
    CGFloat tempY = CGRectGetMaxY(_nameF);
    for (NSInteger i = 0; i < _skuInfosModelArr.count; i ++) {
        IWDetailSkuInfosModel *model = _skuInfosModelArr[i];
        CGSize btnSize = [self initWithWidth:MAXFLOAT height:MAXFLOAT font:kFont24px text:model.attributeValueName];
        // 换行
        if (kViewWidth - tempX - kFRate(10) < btnSize.width + kFRate(20)) {
            tempX = 0.0f;
            tempY = CGRectGetMaxY(_btnF);
        }
        _btnF = CGRectMake(kFRate(10) + tempX, kFRate(10) + tempY, btnSize.width + kFRate(20), btnSize.height + kFRate(10));
        tempX = CGRectGetMaxX(_btnF);
        [_btnFArr addObject:[NSValue valueWithCGRect:_btnF]];
    }
    if (CGRectGetMaxY(_btnF) && CGRectGetMaxY(_btnF) > CGRectGetMaxY(_nameF)) {
        _cellH = CGRectGetMaxY(_btnF) + kFRate(20);
    }else{
       _cellH = CGRectGetMaxY(_nameF) + kFRate(20);
    }
}

- (CGSize)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize;
}

@end
