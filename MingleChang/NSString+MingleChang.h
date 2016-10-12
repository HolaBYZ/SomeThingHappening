//
//  NSString+MingleChang.h
//  MingleChang
//
//  Created by 常峻玮 on 16/3/27.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (MC_Check)
-(BOOL)mc_isTelephone;
@end
@interface NSString (MC_Code)

/**
 *  MD5加密
 *
 *  @return NSString,MD5加密之后的字符串
 */
-(NSString *)mc_md5;
/**
 *  对字符串进行URLEncode
 *
 *  @return NSString,URLEncode得到的字符串
 */
-(NSString *)mc_urlEncode;
-(NSString *)mc_urlDecode;
/**
 *  对字符串进行base64加密
 *
 *  @return NSString,base64得到的字符串
 */
-(NSString *)mc_base64Encode;
@end
@interface NSString (MC_Other)
-(NSString *)mc_getHeaderAlphabet;
-(CGFloat)getHeightWithFont:(UIFont *)font andWidth:(CGFloat)width;
-(NSString *)mc_getDoubleStr;

-(NSString *)mc_getDoubleStrWithMaxLength:(NSInteger)length;
@end
