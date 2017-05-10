//
//  AFTSearchBar.h

//
//  Created by admin on 2016/11/2.
//  Copyright © 2016年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFTSearchBar : UISearchBar
// searchBar设置背景图及提示文字
- (void)changeSearchBarBackGroundImage:(NSString *)imageString text:(NSString *)text;

/**
 *  searchBar设置背景图及提示文字 放大镜 文字剧中或左
 *
 *  @param imageString          背景图片
 *  @param text                 替换文字
 *  @param bigString            放大镜图标
 *  @param hasCenterPlaceholder 替换文字和放大镜 默认是否在中间，如果不是就靠左
 */
- (void)changeSearchBarBackGroundImage:(NSString *)imageString text:(NSString *)text bigImage:(NSString *)bigString hasCenterPlaceholder:(BOOL)hasCenterPlaceholder;
@end
