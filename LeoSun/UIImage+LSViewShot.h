//
//  UIImage+LSViewShot.h
//  EasyHomePM
//
//  Created by Leo on 16/8/18.
//  活的view的截图
//  Copyright © 2016年 wzkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LSViewShot)
+ (UIImage *)getViewShot:(UIView *)view withImageName:(NSString *)imageName;
@end
