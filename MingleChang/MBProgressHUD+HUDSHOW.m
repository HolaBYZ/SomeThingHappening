//
//  MBProgressHUD+HUDSHOW.m
//
//  Created by Todd on 15/6/25.
//  Copyright (c) 2015年 Todd. All rights reserved.
//

#import "MBProgressHUD+HUDSHOW.h"

@implementation MBProgressHUD (HUDSHOW)

+(void)showHudWithTitle:(NSString*)title andSubtitle:(NSString*)subtitle toView:(UIView*)view{
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (title) {
       hud.labelText =title;
    }
    if (subtitle) {
       hud.detailsLabelText = subtitle;
    }
    hud.square = YES;
    hud.removeFromSuperViewOnHide = YES;
}

+(void)showHudWithTitle:(NSString *)title toView:(UIView *)view{
    [self showHudWithTitle:title andSubtitle:nil toView:view];
}

+(void)showSimpleHudtoView:(UIView*)view{
    [self showHudWithTitle:nil andSubtitle:nil toView:view];
}


+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.labelText = text;
    hud.userInteractionEnabled=NO;
    hud.detailsLabelText=text;
    // 设置图片
    if (icon) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    }
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 2秒之后再消失
    [hud hide:YES afterDelay:2.0];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

+ (void)show:(NSString *)text view:(UIView *)view{
    [self show:text icon:nil view:view];
}

+ (void)hideHUDForView:(UIView *)view{
     [self hideHUDForView:view animated:YES];
}

@end
