//
//  NSString+MingleChang.m
//  MingleChang
//
//  Created by 常峻玮 on 16/3/27.
//  Copyright © 2016年 MingleChang. All rights reserved.
//

#import "NSString+MingleChang.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MC_Check)

-(BOOL)mc_isTelephone{
    NSPredicate *lPredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES '^(0|86|17951)?(13[0-9]|15[0-9]|17[0678]|18[0-9]|14[57])[0-9]{8}$'"];
    if (![lPredicate evaluateWithObject:self]) {
        return NO;
    }
    return YES;
}

@end

@implementation NSString (MC_Code)

-(NSString *)mc_md5{
    const char *cStr = [self UTF8String];
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

-(NSString *)mc_urlEncode{
//    [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *resultStr = self;
    
    CFStringRef originalString = (__bridge CFStringRef) self;
    CFStringRef leaveUnescaped = CFSTR(" ");
    CFStringRef forceEscaped = CFSTR("!*'();:@&=+$,/?%#[].");
    
    CFStringRef escapedStr;
    escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,originalString,leaveUnescaped,forceEscaped,kCFStringEncodingUTF8);
    
    if( escapedStr )
    {
        NSMutableString *mutableStr = [NSMutableString stringWithString:(__bridge NSString *)escapedStr];
        CFRelease(escapedStr);
        
        // replace spaces with plusses
        [mutableStr replaceOccurrencesOfString:@" " withString:@"%20" options:0 range:NSMakeRange(0, [mutableStr length])];
        resultStr = [mutableStr copy];
    }
    return resultStr;
}
-(NSString *)mc_urlDecode{
    return [self stringByRemovingPercentEncoding];
}
-(NSString *)mc_base64Encode{
    NSData *lData=[self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *baseString = [lData base64EncodedStringWithOptions:0];
    
//    baseString = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                                               (CFStringRef)baseString,
//                                                                               NULL,
//                                                                               CFSTR(":/?#[]@!$&’()*+,;="),
//                                                                               
//                                                                               kCFStringEncodingUTF8);
    return baseString;
}
@end

@implementation NSString (MC_Other)

-(NSString *)mc_getHeaderAlphabet{
    NSMutableString *str = [[NSMutableString alloc]initWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    if (str.length!=0) {
        NSString *lFirstChar=[[str substringToIndex:1] uppercaseString];
        NSArray *alphabets = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
        if ([alphabets containsObject:lFirstChar]) {
            return lFirstChar;
        }
        return @"#";
    }
    return @"#";
}
-(CGFloat)getHeightWithFont:(UIFont *)font andWidth:(CGFloat)width{
    CGSize lMaxSize=CGSizeMake(width, 10000);
    CGRect lRect=[self boundingRectWithSize:lMaxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    CGFloat lHeight=lRect.size.height;
    return ceil(lHeight);
}


-(NSString *)mc_removeFrontZero{
    NSString *lString=[self stringByAppendingString:@"#"];
    NSCharacterSet *lCharacterSet=[NSCharacterSet characterSetWithCharactersInString:@"0"];
    lString=[lString stringByTrimmingCharactersInSet:lCharacterSet];
    lString=[lString substringToIndex:lString.length-1];
    return lString;
}

-(NSString *)mc_removeBehindZero{
    NSString *lString=[@"#" stringByAppendingString:self];
    NSCharacterSet *lCharacterSet=[NSCharacterSet characterSetWithCharactersInString:@"0"];
    lString=[lString stringByTrimmingCharactersInSet:lCharacterSet];
    lString=[lString substringFromIndex:1];
    return lString;
}

-(NSString *)mc_getEffectDoubleWithMaxLength:(NSInteger)length{
    NSString *lDoubleStr=[self mc_getDoubleStrWithMaxLength:length];
    
    if (lDoubleStr.length==0) {
        return lDoubleStr;
    }
    
    if ([lDoubleStr containsString:@"."]) {
        NSArray *lArray=[lDoubleStr componentsSeparatedByString:@"."];
        NSString *integerString=lArray.firstObject;
        NSString *lDecimalStr=[lArray lastObject];
        lDecimalStr=[lDecimalStr mc_removeBehindZero];
        if (lDecimalStr.length==0) {
            return integerString;
        }else{
            lDoubleStr=[NSString stringWithFormat:@"%@.%@",integerString,lDecimalStr];
            return lDoubleStr;
        }
    }else{
        return lDoubleStr;
    }
}


-(NSString *)mc_getDoubleStrWithMaxLength:(NSInteger)length{
    NSScanner *lScanner=[NSScanner scannerWithString:self];
    double doubleValue=0;
    [lScanner scanDouble:&doubleValue];
    NSString *lDoubleStr=[self substringToIndex:lScanner.scanLocation];
    
    if ([lDoubleStr hasPrefix:@"."]) {
        lDoubleStr=[NSString stringWithFormat:@"0%@",lDoubleStr];
    }
    
    if (lDoubleStr.length==0) {
        return lDoubleStr;
    }
    
    if ([lDoubleStr containsString:@"."]) {
        NSArray *lArray=[lDoubleStr componentsSeparatedByString:@"."];
        NSString *integerString=lArray.firstObject;
        integerString=[integerString mc_removeFrontZero];
        if (integerString.length==0) {
            integerString=@"0";
        }
        lDoubleStr=[NSString stringWithFormat:@"%@.%@",integerString,lArray[1]];
    }else{
        lDoubleStr=[lDoubleStr mc_removeFrontZero];
        if (lDoubleStr.length==0) {
            lDoubleStr=@"0";
        }
    }
    if (lDoubleStr.length>length) {
        lDoubleStr=[lDoubleStr substringToIndex:length];
    }
    
    return lDoubleStr;
}
-(NSString *)mc_getDoubleStr{
    NSScanner *lScanner=[NSScanner scannerWithString:self];
    double doubleValue=0;
    [lScanner scanDouble:&doubleValue];
    NSString *lDoubleStr=[self substringToIndex:lScanner.scanLocation];
    if ([lDoubleStr hasPrefix:@"."]) {
        lDoubleStr=[NSString stringWithFormat:@"0%@",lDoubleStr];
    }
    return lDoubleStr;
}
@end