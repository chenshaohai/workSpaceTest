//
//  IWDetailModel.m
//  IWShopping0221
//
//  Created by MacBook on 2017/3/14.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWDetailModel.h"
#import "IWDetailImagesModel.h"
#import "IWDetailSkuModel.h"
#import "IWItemsModel.h"

@interface IWDetailModel ()<UIWebViewDelegate>

@end

@implementation IWDetailModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _imgModelArr = [[NSMutableArray alloc] init];
        _skuModelArr = [[NSMutableArray alloc] init];
        _itemsModelArr = [[NSMutableArray alloc] init];
        
        _expressConfig = dic[@"expressConfig"]?dic[@"expressConfig"]:@"";
        if ([dic[@"expressMoney"]?dic[@"expressMoney"]:@"" isEqual:@"0"]) {
            _expressMoney = @"包邮";
        }else{
            _expressMoney = dic[@"expressMoney"]?dic[@"expressMoney"]:@"";
        }
        // 图片数组
        _images = dic[@"images"]?dic[@"images"]:nil;
        // 会币
        if ([dic[@"integral"]?dic[@"integral"]:@"" isKindOfClass:[NSNull class]] || [dic[@"integral"]?dic[@"integral"]:@"" isEqual:@""]) {
            _integral = @"0";
        }else{
            _integral = dic[@"integral"]?dic[@"integral"]:@"0";
        }
        _productDescUrl = dic[@"productDescUrl"]?dic[@"productDescUrl"]:@"";
        _productId = dic[@"productId"]?dic[@"productId"]:@"";
        _productName = dic[@"productName"]?dic[@"productName"]:@"";
        _productNum = dic[@"productNum"]?dic[@"productNum"]:@"";
        _purchase = dic[@"purchase"]?dic[@"purchase"]:@"";
        _saleCount = dic[@"saleCount"]?dic[@"saleCount"]:@"";
        _salePrice = dic[@"salePrice"]?dic[@"salePrice"]:@"";
        _shopId = dic[@"shopId"]?dic[@"shopId"]:@"";
        // 规格
        _sku = dic[@"skuTitle"]?dic[@"skuTitle"]:nil;
        _skuCustom = dic[@"skuCustom"]?dic[@"skuCustom"]:@"";
        _smarketPrice = dic[@"smarketPrice"]?dic[@"smarketPrice"]:@"";
        _specAttributeIds = dic[@"specAttributeIds"]?dic[@"specAttributeIds"]:@"";
        _specConfig = dic[@"specConfig"]?dic[@"specConfig"]:@"";
        _stock = dic[@"stock"]?dic[@"stock"]:@"";
        _thumbImg = dic[@"thumbImg"]?dic[@"thumbImg"]:@"";
        // items
        _items = dic[@"items"]?dic[@"items"]:nil;
        
        // 图片集合
        if (_images && _images.count > 0) {
            for (NSDictionary *dic in _images) {
                IWDetailImagesModel *model = [[IWDetailImagesModel alloc] initWithDic:dic];
                [_imgModelArr addObject:model];
            }
        }
        
        // 规格
        if (_sku && _sku.count > 0) {
            for (NSDictionary *dic in _sku) {
                IWDetailSkuModel *model = [[IWDetailSkuModel alloc] initWithDic:dic];
                [_skuModelArr addObject:model];
            }
        }
        
        // items
        if (_items && _items.count > 0) {
            for (NSDictionary *dic in _items) {
                IWItemsModel *model = [[IWItemsModel alloc] initWithDic:dic];
                [_itemsModelArr addObject:model];
            }
        }
        [self frame];
    }
    return self;
}

- (void)frame{
    _nameH = [self getSpaceLabelHeight:_productName withFont:kFont32pxBold withWidth:kViewWidth - kFRate(20)];
}

-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 0;// 上距离
    paraStyle.hyphenationFactor = 0.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                          };// 上距离
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

- (CGFloat)initWithWidth:(CGFloat)width height:(CGFloat)heigth font:(UIFont *)font text:(NSString *)text
{
    CGSize maximumLabelSize = CGSizeMake(width, heigth);//labelsize的最大值
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize expectSize = [text boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return expectSize.height;
}

@end
