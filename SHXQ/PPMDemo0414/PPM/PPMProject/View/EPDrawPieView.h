//
//  EPDrawPieView.h
//  2-13view
//
//  Created by luchanghao on 17/2/14.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPDrawPieModel.h"

typedef void (^DrawPieTouchBlock)(long index);


@interface EPDrawPieView : UIView
@property (nonatomic, assign) BOOL couldTouch;
@property (nonatomic, strong) EPDrawPieModel *model;
@property (nonatomic, copy) DrawPieTouchBlock block;

@property (nonatomic, assign) long selectIndex;
@end
