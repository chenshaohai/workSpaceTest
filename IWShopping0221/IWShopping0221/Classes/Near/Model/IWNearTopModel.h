
#import <Foundation/Foundation.h>

@interface IWNearTopModel : NSObject
/**
 *  cateId
 */
@property (nonatomic,copy)NSString *modelId;

/**
 *   名字
 */
@property (nonatomic,copy)NSString *nameTitle;
/**
 *   图片
 */
@property (nonatomic,copy)NSString *imageName;
/**
 *   控制器字符串
 */
@property (nonatomic,copy)NSString *nameVC;

/**
 *   孩子
 */
@property (nonatomic,strong)NSMutableArray *children;

@property (nonatomic,copy)NSString *parentId;

+ (id)nearTopModelWithDic:(NSDictionary *)dic;
- (id)initWithDic:(NSDictionary *)dic;

@end
