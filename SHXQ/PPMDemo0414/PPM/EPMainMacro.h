//
//  EPMainMacro.h
//  E-Platform
//
//  Created by xiaofan on 9/19/16.
//  Copyright © 2016 E-Lead. All rights reserved.
//

#ifndef EPMainMacro_h
#define EPMainMacro_h

// 导航栏返回按钮
#define navBarBackItem UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];\
temporaryBarButtonItem.title = @"";\
self.navigationItem.backBarButtonItem = temporaryBarButtonItem;

//搜索Bar的颜色
#define EPColor_SearchBar  COLOR_RGB(230, 230, 230)
//控制器背景色
#define EPColor_ControllerBG  COLOR_RGB(245,245,245)
//黑色
#define EPColor_Black  COLOR_HEX(0x252525)

//主题渲染颜色
#define EPColor_MainTint COLOR_HEX(0x2ec7c9)

//画图颜色
//紫色
#define EPColor_Purple COLOR_HEX(0xa48fd9)
//黄色
#define EPColor_Yellow COLOR_HEX(0xf9d546)
//蓝绿色
#define EPColor_BlueGreen COLOR_HEX(0x3fdec3)
//橙色
#define EPColor_Orange COLOR_HEX(0xfd964c)
//红色
#define EPColor_Red COLOR_HEX(0xff6969)
//蓝色
#define EPColor_Blue COLOR_HEX(0x12bdff)
//绿色
#define EPColor_Green COLOR_HEX(0x5fdd9e)
//深蓝
#define EPColor_DarkBlue COLOR_HEX(0x2e96c9)
//青色
#define EPColor_Cyan COLOR_HEX(0x93dc58)
//深绿
#define EPColor_DarkGreen COLOR_HEX(0x1eafad)

//字体颜色
//黑色
#define EPColor_Font_Black COLOR_HEX(0x001c58)
//黑灰
#define EPColor_Font_BlackGray COLOR_HEX(0x515974)
//深灰
#define EPColor_Font_DarkGray COLOR_HEX(0x7e8e9f)
//灰色
#define EPColor_Font_Gray COLOR_HEX(0x999999)
//浅灰
#define EPColor_Font_LightGray COLOR_HEX(0xcccccc)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define NAVBAR_HEIGHT 64
#define TABBAR_HEIGHT 49

#define COLOR_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif /* EPMainMacro_h */
