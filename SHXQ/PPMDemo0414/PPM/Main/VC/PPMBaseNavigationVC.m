//
//  PPMBaseNavigationVC.m
//  PPM
//
//  Created by lu_ios on 17/4/14.
//  Copyright © 2017年 e-lead. All rights reserved.
//

#import "PPMBaseNavigationVC.h"

@interface PPMBaseNavigationVC ()

@end

@implementation PPMBaseNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//支持旋转
-(BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}
//支持的方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

@end
