//
//  MCDottedLineView.m
//  LineView
//
//  Created by 常峻玮 on 15/5/7.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCDottedLineView.h"
#import "MingleChang.h"

@implementation MCDottedLineView
-(instancetype)init{
    self=[super init];
    if (self) {
        [self setDefaultInfo];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setDefaultInfo];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setDefaultInfo];
}
-(void)setDefaultInfo{
    self.lineColor=[UIColor clearColor];
    self.dottedLineColor=RGB(153, 153, 153);
    self.dottedWidth=2;
    self.dottedDistance=2;
}
#pragma mark - Setter And Getter
-(void)setDottedLineColor:(UIColor *)dottedLineColor{
    if ([dottedLineColor isEqual:_dottedLineColor]) {
        return;
    }
    _dottedLineColor=dottedLineColor;
    [self setNeedsDisplay];
}
-(void)setDottedDistance:(CGFloat)dottedDistance{
    if (_dottedDistance==dottedDistance) {
        return;
    }
    _dottedDistance=dottedDistance;
    [self setNeedsDisplay];
}
-(void)setDottedWidth:(CGFloat)dottedWidth{
    if (_dottedWidth==dottedWidth) {
        return;
    }
    _dottedWidth=dottedWidth;
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, self.height<1?1:self.height);
    CGContextSetStrokeColorWithColor(context, self.dottedLineColor.CGColor);
    CGFloat lengths[] = {self.dottedWidth,self.dottedDistance};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, rect.size.width,0.0);
    CGContextStrokePath(context);
//    CGContextClosePath(context);
}

@end
