

#import <Foundation/Foundation.h>


@interface IWNearShoppingModel : NSObject
/**
 *   shopId
 */
@property (nonatomic,copy)NSString *modelId;
@property (nonatomic,copy)NSString *businessCateId;
@property (nonatomic,copy)NSString *ainitId;
@property (nonatomic,copy)NSString *shopOfiiceTime;
@property (nonatomic,copy)NSString *shopType;
@property (nonatomic,copy)NSString *shopX;
@property (nonatomic,copy)NSString *shopY;
@property (nonatomic,copy)NSString *state;

/**
 *   名字
 */
@property (nonatomic,copy)NSString *name;
/**
 *
 */
@property (nonatomic,copy)NSString *score;

/* businessCateId = 1;
 discountRatio = 90;
 initId = 1;
 juli = 5301;
 shopId = 1;
 shopLevel = 5;
 shopLogo = "73178cb6-2c47-41cb-9ee1-ab80e0eec3f9";
 shopName = "\U9f99\U534e\U548c\U695a\U5c45\U9526\U7ee3\U6c5f\U5357";
 shopOfiiceTime = "9:00-22:00";
 shopSummary = "\U4e3b\U6253\U6e58\U83dc\U62db\U724c\Uff0c\U5241\U6912\U9c7c\U5934\Uff0c\U519c\U5bb6\U5c0f\U7092\U8089";
 shopType = 2;
 shopX = "114.031949";
 shopY = "22.643367";
 state = 1;*/
/**
 *
 */
@property (nonatomic,copy)NSString *count;
/**
 *
 */
@property (nonatomic,copy)NSString *content;
/**
 *
 */
@property (nonatomic,copy)NSString *distance;
/**
 *
 */
@property (nonatomic,copy)NSString *discount;
/**
 *  图标
 */
@property (nonatomic,copy)NSString *logo;


+ (id)modelWithDic:(NSDictionary *)dic;
- (id)initWithDic:(NSDictionary *)dic;
@end
