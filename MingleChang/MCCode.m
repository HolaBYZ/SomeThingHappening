//
//  MCCode.m
//  Category_OS
//
//  Created by admin001 on 14/12/2.
//  Copyright (c) 2014年 MingleChang. All rights reserved.
//

#import "MCCode.h"
#import <CommonCrypto/CommonDigest.h>
@implementation MCCode
+(NSString *)encodeMd5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
+(NSString *)encodeBase64:(NSData *)data{
    NSString *baseString = [data base64EncodedStringWithOptions:0];
    
//  baseString = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                                                         (CFStringRef)imageBas464,
//                                                                                         NULL,
//                                                                                         CFSTR(":/?#[]@!$&’()*+,;="),
//                                                                                         
//                                                                                         kCFStringEncodingUTF8);
    return baseString;
}
@end
