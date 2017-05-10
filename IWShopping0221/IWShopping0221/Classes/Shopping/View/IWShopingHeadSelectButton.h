//
//  IWShopingHeadSelectButton.h
//  IWShopping0221
//
//  Created by FRadmin on 17/3/7.
//  Copyright © 2017年 sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWShopingHeadSelectButton : UIButton
@property(nonatomic,strong)NSIndexPath *indexpath;
@property(nonatomic,copy)void (^selectBtnClick)(IWShopingHeadSelectButton *cell);
@end
