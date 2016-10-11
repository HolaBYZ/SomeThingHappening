//
//  CalenderModel.h
//  NSClanderTest
//
//  Created by Valentin on 16/8/27.
//  Copyright © 2016年 Valentin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalenderModel : NSObject

@property (nonatomic , copy) NSString *date;

@property (nonatomic , assign) BOOL isChoosen;

@property (nonatomic , assign) BOOL isToday;

@end
