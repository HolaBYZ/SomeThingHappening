//
//  MCDottedLineView.h
//  LineView
//
//  Created by 常峻玮 on 15/5/7.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCLineView.h"

@interface MCDottedLineView : MCLineView
@property(nonatomic,strong)UIColor *dottedLineColor;
@property(nonatomic,assign)CGFloat dottedWidth;
@property(nonatomic,assign)CGFloat dottedDistance;
@end
