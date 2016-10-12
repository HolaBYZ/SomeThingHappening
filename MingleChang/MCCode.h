//
//  MCCode.h
//  Category_OS
//
//  Created by admin001 on 14/12/2.
//  Copyright (c) 2014年 MingleChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCCode : NSObject
+(NSString *)encodeMd5:(NSString *)string;
+(NSString *)encodeBase64:(NSData *)data;
@end
