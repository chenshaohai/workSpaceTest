//
//  EPObPartProjectViewCell.h
//  E-Platform
//
//  Created by 陈敬 on 2017/3/9.
//  Copyright © 2017年 MEAGUT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPObPartProjectViewModel.h"

@interface EPObPartProjectViewCell : UITableViewCell
@property (nonatomic, strong) EPObPartProjectViewModel *model;
/**
 *  隐藏下画线
 */
@property (nonatomic, assign)BOOL hiddenDownLine;
@end
