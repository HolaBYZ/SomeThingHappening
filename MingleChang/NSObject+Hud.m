//
//  NSObject+Hud.m
//  EasyHomePO
//
//  Created by 叩问九天 on 16/6/25.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import "NSObject+Hud.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>
#import "AppDelegate.h"

const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation NSObject (Hud)

- (void)showHud:(NSString *)hint
{
    [self showHud:hint detail:nil];
}

- (UIWindow *)win
{
    return objc_getAssociatedObject(self, &HttpRequestHUDKey);
}

- (void)setWin:(UIWindow *)win
{
    objc_setAssociatedObject(self, &HttpRequestHUDKey, win, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHud:(NSString *)hint detail:(NSString *)detail
{
    NSArray *windows = [[UIApplication sharedApplication] windows] ;
    UIWindow *lastWindow = windows.lastObject;
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor clearColor];
    window.windowLevel = lastWindow.windowLevel + 1;
    [window makeKeyAndVisible];
    self.win = window;
    self.win.userInteractionEnabled=NO;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.detailsLabelText = detail;
    hud.detailsLabelFont=[UIFont systemFontOfSize:16];
    hud.margin = 10.f;
    hud.yOffset = 150;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    [self performSelector:@selector(hide) withObject:nil afterDelay:2];
}

- (void)hide
{
    [self.win resignKeyWindow];
    self.win = nil;
//    [self.win removeFromSuperview];
}

@end
