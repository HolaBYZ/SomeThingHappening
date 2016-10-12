//
//  MCDevice.m
//  Category_OS
//
//  Created by admin001 on 14/12/2.
//  Copyright (c) 2014年 MingleChang. All rights reserved.
//

#import "MCDevice.h"

@implementation MCDevice
+(CGFloat)systemVersion{
    return [[[UIDevice currentDevice]systemVersion]floatValue];
}
+(NSString *)uuid{
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}
+(BOOL)iPhone{
    return [UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone;
}

+(BOOL)iPad{
    return [UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad;
}

+(BOOL)iPhoneOld{
    return CGSizeEqualToSize(CGSizeMake(640, 960), [UIScreen mainScreen].currentMode.size);
}

+(BOOL)iPhoneMini{
    return CGSizeEqualToSize(CGSizeMake(640, 1136), [UIScreen mainScreen].currentMode.size);
}

+(BOOL)iPhoneNormal{
    return CGSizeEqualToSize(CGSizeMake(750, 1334), [UIScreen mainScreen].currentMode.size);
}

+(BOOL)iPhonePlus{
    return CGSizeEqualToSize(CGSizeMake(1242, 2208), [UIScreen mainScreen].currentMode.size);
}

+(BOOL)isRetina{
    return ([UIScreen mainScreen].scale>=2.0);
}
+(CGRect)screenBounds{
    return [UIScreen mainScreen].bounds;
}
+(CGSize)screenSize{
    return [UIScreen mainScreen].bounds.size;
}
+(CGFloat)screenWidth{
    return [UIScreen mainScreen].bounds.size.width;
}
+(CGFloat)screenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}

#pragma mark - First View Controller
+(UIViewController *)getAppFrontViewController{
    UIViewController *result = nil;
    UIWindow * window = [self getAppFrontWindow];
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

+(UIWindow *)getAppFrontWindow{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    return window;
}
@end
