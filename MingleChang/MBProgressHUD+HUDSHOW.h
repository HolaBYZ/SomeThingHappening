//
//  MBProgressHUD+HUDSHOW.h
//
//  Created by Todd on 15/6/25.
//  Copyright (c) 2015年 Todd. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (HUDSHOW)
/**
 *  显示一个带有子标题的HUD
 *
 *  @param title
 *  @param subtitle
 *  @param view
 */
+ (void)showHudWithTitle:(NSString*)title andSubtitle:(NSString*)subtitle toView:(UIView*)view;
/**
 *  显示一个带有标题的HUD
 *
 *  @param title
 *  @param view
 */
+ (void)showHudWithTitle:(NSString *)title toView:(UIView *)view;
/**
 *  显示一个只有加载图标的HUD,不带文字
 *
 *  @param view
 */
+ (void)showSimpleHudtoView:(UIView*)view;
/**
 *  显示自定义，自定义图标和文字的HUD
 *
 *  @param text
 *  @param icon 图片的名称
 *  @param view
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
/**
 *  只显示文字的HUD
 *
 *  @param text
 *  @param view
 */
+ (void)show:(NSString *)text view:(UIView *)view;
/**
 *  隐藏HUD
 *
 *  @param view
 */
+ (void)hideHUDForView:(UIView *)view;

@end
