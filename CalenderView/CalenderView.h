//
//  CalenderView.h
//  NSClanderTest
//
//  Created by Valentin on 16/8/27.
//  Copyright © 2016年 Valentin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChoosedDateBlock)(id choosedDate);

@interface CalenderView : UIView

@property (copy , nonatomic) ChoosedDateBlock block;

@property (strong, nonatomic) MCDate *todayDate;

-(instancetype)initWithFrame:(CGRect)frame andDate:(MCDate *)date;

@end
