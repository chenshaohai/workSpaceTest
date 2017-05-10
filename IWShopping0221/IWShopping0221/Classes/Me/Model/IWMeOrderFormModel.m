//
//  IWMeOrderFormModel.m
//  IWShopping0221
//
//  Created by s on 17/3/4.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWMeOrderFormModel.h"
#import "IWMeOrderFormProductModel.h"
@implementation IWMeOrderFormModel
+(id)modelWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        /*
         
         {
         addressId = 36;
         addressInfo = "";
         children =             (
         {
         attributeValue = "";
         count = 1;
         orderDetailId = 28;
         productId = 14;
         productName = "\U5e05\U6c14\U4f11\U95f2\U886c\U8863\U7537\U88c5";
         salePrice = 69;
         smarketPrice = 169;
         thumbImg = "/aigou/shop/20170312/53db2923-6413-474d-ac03-0d9f86a87add.jpg";
         }
         );
         createdTime = 1489514010000;
         expressNum = 755300189836;
         expressPrice = 0;
         orderId = 24;
         orderNum = 1489514010670;
         payPrice = 399;
         shopId = 14;
         shopName = "\U6fb3\U54c1\U835f";
         state = 1;
         updatedTime = 1489931125000;
         },
         
         
         {
         addressId = 6;
         addressInfo =     {
         addressId = 6;
         city = "\U5317\U4eac\U5e02";
         consignee = ddd;
         detailAddress = ggg;
         district = "\U4e1c\U57ce\U533a";
         phone = 555;
         province = "\U5317\U4eac\U5e02";
         state = 0;
         userId = 118;
         userName = 18565822821;
         zipCode = 55;
         };
         children =     (
         {
         attributeValue = "\U89c4\U683c:175/100A/L";
         count = 1;
         itemId = 100;
         orderDetailId = 151;
         productId = 7;
         productName = "\U7537\U88c5(UT)AEFUTURA\U5370\U82b1T\U6064(\U77ed\U8896)194453\U4f18\U8863\U5e93UNIQLO";
         salePrice = 99;
         smarketPrice = 99;
         thumbImg = "/aigou/shop/20170417/40d1874c-8958-49be-a63a-09d180de0227.jpg";
         }
         );
         createdTime = 1492693586000;
         expressNum = "";
         expressPrice = 0;
         orderId = 134;
         orderNum = 1492693586714;
         payPrice = 199;
         shopId = 10;
         shopName = "\U4f18\U8863\U5e93";
         state = 0;
         updatedTime = 1492693586000;
         
         integral = 20；
         }

         
         
        
         */
        _createdTime = dic[@"createdTime"]?dic[@"createdTime"]:@"";
        _expressNum = dic[@"expressNum"]?dic[@"expressNum"]:@"";
        
        NSString  *expressPrice = dic[@"expressPrice"]?dic[@"expressPrice"]:@"0";
        
        _expressPrice = [NSString stringWithFormat:@"%.2f",[expressPrice floatValue]];
        _orderId = dic[@"orderId"]?dic[@"orderId"]:@"";
        _orderNum = dic[@"orderNum"]?dic[@"orderNum"]:@"0";
        
        
        NSString  *payPrice = dic[@"payPrice"]?dic[@"payPrice"]:@"0";
        
        _payPrice = [NSString stringWithFormat:@"%.2f",[payPrice floatValue]];
//        _payPrice = dic[@"payPrice"]?dic[@"payPrice"]:@"0";
        _shopId = dic[@"shopId"]?dic[@"shopId"]:@"";
        _addressId = dic[@"addressId"]?dic[@"addressId"]:@"";
        _addressInfo = dic[@"addressInfo"]?dic[@"addressInfo"]:nil;
        _shopName = dic[@"shopName"]?dic[@"shopName"]:@"";

        
        _state = dic[@"state"]?dic[@"state"]:@0;
        _updatedTime = dic[@"updatedTime"]?dic[@"updatedTime"]:@"";
        NSArray *children = dic[@"children"]?dic[@"children"]:nil;
        NSMutableArray *childrenArray = [NSMutableArray array];
        if (!children || ![children isKindOfClass:[NSArray class]] || children.count == 0) {
            
        }else{
            for (NSDictionary *childreDic in children) {
                IWMeOrderFormProductModel *model = [IWMeOrderFormProductModel modelWithDic:childreDic];
                [childrenArray addObject:model];
            }
        }
        _children = [NSArray arrayWithArray:childrenArray];
   
        
    }
    return self;
}

@end
