//
//  MCQRCodeMaskView.m
//  QRCode_OC
//
//  Created by 常峻玮 on 16/1/7.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import "MCQRCodeMaskView.h"

@implementation MCQRCodeMaskView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.maskColor=[UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:0.5];
        self.cornerColor=[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
        self.boundsColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.clearFrame=CGRectMake(frame.size.width*0.1, frame.size.height/2-frame.size.width*0.4, frame.size.width*0.8, frame.size.width*0.8);
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame andClearFrame:(CGRect)clearFrame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.maskColor=[UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:0.5];
        self.cornerColor=[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
        self.boundsColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.clearFrame=clearFrame;
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self resetMaskRect:rect inContext:context];
    [self resetCenterClearRect:self.clearFrame inContext:context];
    [self resetBoundsRect:self.clearFrame inContext:context];
    [self resetCornerLineWithRect:self.clearFrame inContext:context];
}

-(void)resetMaskRect:(CGRect)rect inContext:(CGContextRef)context{
    const CGFloat *components=CGColorGetComponents(self.maskColor.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    CGFloat a = components[3];
    CGContextSetRGBFillColor(context, r,g,b,a);
    CGContextFillRect(context, rect);
}

- (void)resetCenterClearRect:(CGRect)rect inContext:(CGContextRef)context{
    CGContextClearRect(context, rect);
}
- (void)resetBoundsRect:(CGRect)rect inContext:(CGContextRef)context{
    CGContextStrokeRect(context, rect);
    const CGFloat *components=CGColorGetComponents(self.boundsColor.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    CGFloat a = components[3];
    CGContextSetRGBStrokeColor(context, r,g,b,a);
    CGContextSetLineWidth(context, 1);
    CGContextAddRect(context, rect);
    CGContextStrokePath(context);
}
- (void)resetCornerLineWithRect:(CGRect)rect inContext:(CGContextRef)context{
    
    //画四个边角
    CGContextSetLineWidth(context, 2);
    const CGFloat *components=CGColorGetComponents(self.cornerColor.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    CGFloat a = components[3];
    CGContextSetRGBStrokeColor(context,r,g,b,a);
    
    //左上角
    CGPoint poinsTopLeftA[] = {
        CGPointMake(rect.origin.x+0.7, rect.origin.y),
        CGPointMake(rect.origin.x+0.7 , rect.origin.y + 15)
    };
    
    CGPoint poinsTopLeftB[] = {CGPointMake(rect.origin.x, rect.origin.y +0.7),CGPointMake(rect.origin.x + 15, rect.origin.y+0.7)};
    [self addLine:poinsTopLeftA pointB:poinsTopLeftB ctx:context];
    
    //左下角
    CGPoint poinsBottomLeftA[] = {CGPointMake(rect.origin.x+ 0.7, rect.origin.y + rect.size.height - 15),CGPointMake(rect.origin.x +0.7,rect.origin.y + rect.size.height)};
    CGPoint poinsBottomLeftB[] = {CGPointMake(rect.origin.x , rect.origin.y + rect.size.height - 0.7) ,CGPointMake(rect.origin.x+0.7 +15, rect.origin.y + rect.size.height - 0.7)};
    [self addLine:poinsBottomLeftA pointB:poinsBottomLeftB ctx:context];
    
    //右上角
    CGPoint poinsTopRightA[] = {CGPointMake(rect.origin.x+ rect.size.width - 15, rect.origin.y+0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y +0.7 )};
    CGPoint poinsTopRightB[] = {CGPointMake(rect.origin.x+ rect.size.width-0.7, rect.origin.y),CGPointMake(rect.origin.x + rect.size.width-0.7,rect.origin.y + 15 +0.7 )};
    [self addLine:poinsTopRightA pointB:poinsTopRightB ctx:context];
    
    CGPoint poinsBottomRightA[] = {CGPointMake(rect.origin.x+ rect.size.width -0.7 , rect.origin.y+rect.size.height+ -15),CGPointMake(rect.origin.x-0.7 + rect.size.width,rect.origin.y +rect.size.height )};
    CGPoint poinsBottomRightB[] = {CGPointMake(rect.origin.x+ rect.size.width - 15 , rect.origin.y + rect.size.height-0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y + rect.size.height - 0.7 )};
    [self addLine:poinsBottomRightA pointB:poinsBottomRightB ctx:context];
    CGContextStrokePath(context);
}
- (void)addLine:(CGPoint[])pointA pointB:(CGPoint[])pointB ctx:(CGContextRef)context {
    CGContextAddLines(context, pointA, 2);
    CGContextAddLines(context, pointB, 2);
}
@end
