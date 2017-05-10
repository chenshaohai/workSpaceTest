//
//  PPMProgressView.m
//  PPM
//
//  Created by lu_ios on 17/4/14.
//  Copyright © 2017年 e-lead. All rights reserved.
//

#import "PPMProgressView.h"
#import "UIView+Frame.h"
#import "UIImage+MJ.h"
@interface PPMProgressView()
@property(nonatomic,weak)UILabel *startDayLabel;
@property(nonatomic,weak)UILabel *endDayLabel;
@property(nonatomic,weak)UILabel *titleLabel;
@property(nonatomic,weak)UIImageView *colorView;
@end
@implementation PPMProgressView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView *backgroundView = [[UIView alloc]initWithFrame:frame];
        backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:backgroundView];
        
        CGFloat height = frame.size.height;
        CGFloat width = frame.size.width;
        
        UILabel *startDayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height/3)];
        startDayLabel.backgroundColor = [UIColor clearColor];
        startDayLabel.font = MyFont(10);
        startDayLabel.textColor = COLOR_HEX(0x999999);
        [self addSubview:startDayLabel];
        self.startDayLabel = startDayLabel;
        
        
        UIImageView *colorView = [[UIImageView alloc]initWithFrame:CGRectMake(0, height/3, width, height/3)];
        
//        colorView.image = [UIImage resizedImageWithName:@"PPMProjectDetailProgessOrange"];
        
       UIImage *image = [UIImage imageNamed:@"PPMProjectDetailProgessOrange"];
      colorView.image =  [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:0];
        
        [self addSubview:colorView];
        self.colorView = colorView;
        
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:colorView.bounds];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = MyFont(10);
        titleLabel.textColor = [UIColor whiteColor];
        [colorView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        
        
        UILabel *endDayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 2 * height / 3, width, height / 3)];
        endDayLabel.backgroundColor = [UIColor clearColor];
        endDayLabel.font = MyFont(10);
        endDayLabel.textColor = COLOR_HEX(0x999999);
        endDayLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:endDayLabel];
        self.endDayLabel = endDayLabel;
        
    }
    return self;
}


-(void)setModel:(PPMProgressModel *)model{
    _model = model;

    self.startDayLabel.text = model.startDay;
    self.endDayLabel.text = model.endDay;
    self.titleLabel.text = model.title;
    
    if (model.progressType == PPMProgressPlan){
    
    self.colorView.image = [UIImage resizedImageWithName:@"PPMProjectDetailProgessOrange"];
    }else{
    self.colorView.image = [UIImage resizedImageWithName:@"PPMProjectDetailProgessGreen"];
    }

}
@end
