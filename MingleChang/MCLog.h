//
//  MCLog.h
//  MingleChang
//
//  Created by 常峻玮 on 16/5/12.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MCLogTest(s, ...)\
[MCLog log:([NSString stringWithFormat:@"%s(%d)\n%s==>%@\n\n",__FILE__,__LINE__,__FUNCTION__,[NSString stringWithFormat:(s), ##__VA_ARGS__]])]

@interface MCLog : NSObject

+(void)configureLog:(NSString *)log;
+(void)log:(NSString *)log;
+(NSArray *)allLogFiles;
+(NSString *)filePathByName:(NSString *)name;
+(void)cleanAllLogs;

@end
