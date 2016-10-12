//
//  MCLineView.m
//  LineView
//
//  Created by 常峻玮 on 15/5/7.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCLineView.h"
#import "MingleChang.h"
@interface MCLineView()
@property(nonatomic,strong)IBOutlet NSLayoutConstraint *heightConstraint;
@end
@implementation MCLineView
-(instancetype)init{
    self=[super init];
    if (self) {
        [self createLineHeightConstraint];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self createLineHeightConstraint];
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
    [self createLineHeightConstraint];
}
-(void)createLineHeightConstraint{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    if (self.heightConstraint == nil) {
        self.heightConstraint=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:ONE_PIXEL];
        [self addConstraint:self.heightConstraint];
    }
    self.heightConstraint.constant=ONE_PIXEL;
}
#pragma mark - Setter And Getter
-(CGFloat)height{
    if (self.heightConstraint) {
        return self.heightConstraint.constant;
    }
    return ONE_PIXEL;
}
-(void)setHeight:(CGFloat)height{
    if (self.heightConstraint) {
        self.heightConstraint.constant = height;
    }
}
-(void)setLineColor:(UIColor *)lineColor{
    self.backgroundColor = lineColor;
}
-(UIColor *)lineColor{
    return self.backgroundColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
