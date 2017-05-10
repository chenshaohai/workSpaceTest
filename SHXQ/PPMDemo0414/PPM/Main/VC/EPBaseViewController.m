//
//  EPBaseViewController.m
//  E-Platform
//
//  Created by elead_liys on 16/10/10.
//  Copyright © 2016年 MEAGUT. All rights reserved.
//

#import "EPBaseViewController.h"

@implementation EPBaseViewController


- (void)dealloc
{

     NSLog(@"%@ \n-------- %s",self.class,__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self unifyBackButton];
    [self printStack];
    
}




- (void)unifyBackButton{
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


-(void)printStack
{
    
    if (self.navigationController.viewControllers.count>0)
    {
        NSLog(@"+++++++++++++++++++++++++++++++++++++");
        for (NSInteger i = 0; i<self.navigationController.viewControllers.count; i++)
        {
            UIViewController *VC = self.navigationController.viewControllers[i];
            NSLog(@"栈编号%ld,类名==%@",(long)i,NSStringFromClass([VC class]));
        }
        NSLog(@"+++++++++++++++++++++++++++++++++++++");
    }
    
    
}
//支持旋转
-(BOOL)shouldAutorotate
{
    return YES;
}
//支持的方向 因为默认我们只需要支持竖屏
 - (UIInterfaceOrientationMask)supportedInterfaceOrientations {
     return UIInterfaceOrientationMaskPortrait;
}


@end
