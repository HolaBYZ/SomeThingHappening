//
//  NSObject+Hud.h
//  EasyHomePO
//
//  Created by 叩问九天 on 16/6/25.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSObject (Hud)

@property (nonatomic, strong) UIWindow *win;

- (void)showHud:(NSString *)hint;

- (void)showHud:(NSString *)hint detail:(NSString *)detail;

@end
