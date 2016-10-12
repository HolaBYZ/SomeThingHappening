//
//  MCOwner.h
//  Category_OS
//
//  Created by admin001 on 14/12/2.
//  Copyright (c) 2014年 MingleChang. All rights reserved.
//

/*
 需要添加的静态库有libz.dylib
 */

#ifndef _MINGLE_CHANG_h
#define _MINGLE_CHANG_h

#import "MCLog.h"
#import "MCCode.h"
#import "MCDate.h"
#import "MCDevice.h"
#import "MCLineView.h"
#import "MCDottedLineView.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "MBProgressHUD+HUDSHOW.h"
//#import "KeyboardManager.h"
#import "EHBaseModel.h"
//#import "EHAppManager.h"
//#import "EHNetworkHelper.h"
#import "NSString+MingleChang.h"

#import "EHUploadImageModel.h"
//#import "EHUserModel.h"
//#import "EHUserCommunityInfoModel.h"
//#import "EHUserHouseResultModel.h"
//#import "EHUserHouseResultHouseInfoModel.h"
//#import "EHUserOrganizationModel.h"
//#import "EHUserRoleInfoModel.h"
//#import "EHUserOwnerModel.h"
//#import "EHMoneyModel.h"
//#import "EHImageModel.h"
//#import "EHIMManager.h"
#import "EHLoginModel.h"
#import "UIImage+MingleChang.h"
#import "MCDate+EHExtension.h"
#import "MCChooseView.h"

/***********自定义的打印方法*************/
#define __MCLOG(s, ...) \
NSLog(@"%s==>%@",__FUNCTION__,[NSString stringWithFormat:(s), ##__VA_ARGS__])
#ifdef DEBUG
#define MCLOG(...) __MCLOG(__VA_ARGS__)//如果是debug状态则打印值
#else
#define MCLOG(...) do {} while (0)//如果不是debug状态则无操作
#endif
//建议之后一直使用MCLOG代替NSLog
/*************************************/

#define ONE_PIXEL 1/[UIScreen mainScreen].scale//一个像素

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]//宏定义颜色获取方法，alpha不可设置，默认为1.0
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]//宏定义颜色获取方法，alpha可设置

typedef void (^emptyBlock)();
typedef void(^boolBlock)(BOOL);
typedef void(^integerBlock)(NSInteger);
typedef void(^stringBlock)(NSString *);

#endif
