//
//  MCDate+EHExtension.m
//  EasyHomePM
//
//  Created by MingleChang on 16/6/7.
//  Copyright © 2016年 wzkj. All rights reserved.
//

#import "MCDate+EHExtension.h"

@implementation MCDate (EHExtension)
-(NSString *)displayDateTimeStr{
    MCDate *date=[MCDate date];
    if (date.year==self.year) {
        return [self formattedDateWithFormat:@"MM-dd HH:mm"];
    }else{
        return [self formattedDateWithFormat:@"yyyy-MM-dd HH:mm"];
    }
}
-(NSString *)bbsDisplay{
    MCDate *lDate=[MCDate date];
    if([lDate minutesFrom:self]<1){
        return @"刚刚";
    }else if ([lDate hoursFrom:self]<1) {
        return [NSString stringWithFormat:@"%i分钟前",(int)[lDate minutesFrom:self]];
    }else if ([lDate daysFrom:self]<1){
        return [NSString stringWithFormat:@"%i小时前",(int)[lDate hoursFrom:self]];
    }else if([lDate daysFrom:self]<3){
        return [NSString stringWithFormat:@"%i天前",(int)[lDate daysFrom:self]];
    }else if (lDate.year==self.year) {
        return [self formattedDateWithFormat:@"MM月dd日"];
    }else{
        return [self formattedDateWithFormat:@"yyyy-MM-dd"];
    }
}
-(NSString *)lifeDisplayTimeStr{
    MCDate *date=[MCDate date];
    if (date.day == self.day) {
        return [self formattedDateWithFormat:@"HH:mm"];
    }else if (date.year==self.year) {
        return [self formattedDateWithFormat:@"MM-dd HH:mm"];
    }else{
        return [self formattedDateWithFormat:@"yyyy-MM-dd HH:mm"];
    }
}
@end
