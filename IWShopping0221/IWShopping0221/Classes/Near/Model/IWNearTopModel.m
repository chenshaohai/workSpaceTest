


#import "IWNearTopModel.h"
@implementation IWNearTopModel
+(id)nearTopModelWithDic:(NSDictionary *)dict
{
    return [[self alloc]initWithDic:dict];
}
-(id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        //        {
        //            cateIconImg = "6245eb70-eea1-43e8-8467-8f788b6763ec";
        //            cateId = 1;
        //            cateName = "\U7f8e\U98df";
        //            children =     (
        //                            {
        //                                cateIconImg = "6245eb70-eea1-43e8-8467-8f788b6763ec";
        //                                cateId = 1;
        //                                cateName = "\U7f8e\U98df";
        //                                parentId = "-1";
        //                            },
        //                            {
        //                                cateIconImg = "6245eb70-eea1-43e8-8467-8f788b6763ec";
        //                                cateId = 2;
        //                                cateName = "\U4f11\U95f2";
        //                                parentId = "-1";
        //                            },
        //                            );
        //            parentId = "-1";
        //        }
        
        _modelId = dic[@"cateId"]?dic[@"cateId"]:@"";
        _parentId = dic[@"parentId"]?dic[@"parentId"]:@"";
        _nameTitle = dic[@"cateName"]?dic[@"cateName"]:@"";
        _imageName = dic[@"cateIconImg"]?dic[@"cateIconImg"]:@"";
        _nameVC = dic[@"nameVC"]?dic[@"nameVC"]:@"";
        
        NSMutableArray *modelArray = [NSMutableArray array];
        NSArray *children = dic[@"children"]?dic[@"children"]:nil;
        if (children && [children isKindOfClass:[NSArray class]]) {
            for (NSDictionary *childrenDict in children) {
                IWNearTopModel *model =   [IWNearTopModel nearTopModelWithDic:childrenDict];
                [modelArray addObject:model];
                
            }
        }
        if (modelArray.count > 0) {
            _children = modelArray;
        }else{
            _children = nil;
        }
        
    }
    return self;
}
@end
