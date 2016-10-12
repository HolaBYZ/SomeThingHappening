//
//  MCChooseView.m
//  AA
//
//  Created by admin001 on 15/1/28.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import "MCChooseView.h"
#import "MCDevice.h"
#import "MingleChang.h"

#define BUTTON_MIN_TAG 1000
#define MIN_WIDTH ([MCDevice screenWidth] / 5.0)
#define BUTTON_FONT [UIFont systemFontOfSize:15]
#define SELECTED_COLOR [UIColor colorWithRed:0 / 255. green:117 / 255. blue:255 / 255. alpha:1]
//#define SELECTED_COLOR [UIColor whiteColor]
#define NORMAL_COLOR [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0]
#define LINE_COLOR [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0]

@interface MCChooseView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong)UIButton *selectedButton;
@property(nonatomic,strong)UIView *selectedView;
@end

@implementation MCChooseView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        if (!self.scrollView)
        {
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
            [self addSubview:scrollView];
            self.scrollView = scrollView;
            
        }
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
    self.backgroundColor = [UIColor whiteColor];
    if (!self.scrollView)
    {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        scrollView.showsVerticalScrollIndicator=NO;
        scrollView.showsHorizontalScrollIndicator=NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
    }
}

-(void)setAllTitiles:(NSArray *)titiles{
    CGFloat screenWith=[MCDevice screenWidth];
    CGFloat labelWidth=screenWith/titiles.count;
    if (labelWidth<MIN_WIDTH) {
        labelWidth=MIN_WIDTH;
        self.scrollView.contentSize=CGSizeMake(labelWidth*titiles.count, self.scrollView.frame.size.height);
    }
    for (int i=0; i<titiles.count; i++) {
        NSString *lTitle=[titiles objectAtIndex:i];
        UIButton *lButton=[[UIButton alloc]initWithFrame:CGRectMake(labelWidth*i, 0, labelWidth, self.scrollView.frame.size.height)];
        lButton.tag=BUTTON_MIN_TAG+i;
        [lButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        lButton.titleLabel.font=self.buttonFont;
        [lButton setTitleColor:NORMAL_COLOR forState:UIControlStateNormal];
        [lButton setTitle:lTitle forState:UIControlStateNormal];
        [self.scrollView addSubview:lButton];
        
        UIView *lView=[[UIView alloc]initWithFrame:CGRectMake(labelWidth*i-ONE_PIXEL, 10, ONE_PIXEL, self.frame.size.height-20)];
        lView.backgroundColor=LINE_COLOR;
        [self.scrollView addSubview:lView];
        
        if (i==0) {
            self.selectedButton=lButton;
            [self.selectedButton setTitleColor:SELECTED_COLOR forState:UIControlStateNormal];
        }
    }
    
    UIView *lLineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.scrollView.frame.size.height-ONE_PIXEL, labelWidth<MIN_WIDTH?self.scrollView.contentSize.width:screenWith, ONE_PIXEL)];
    lLineView.backgroundColor=LINE_COLOR;
    [self.scrollView addSubview:lLineView];
                       
    self.selectedView=[[UIView alloc]initWithFrame:CGRectMake(0, self.scrollView.frame.size.height-2,labelWidth, 2)];
    self.selectedView.backgroundColor=SELECTED_COLOR;
    [self.scrollView addSubview:self.selectedView];
    self.scrollView.scrollsToTop = NO;

    [self sendActionsForControlEvents:UIControlEventValueChanged];

}

#pragma mark - Select Button
-(void)selectButton:(UIButton *)sender withAnimation:(BOOL)isAnimation{
    if ([self.selectedButton isEqual:sender]) {
        return;
    }
    
    [self.selectedButton setTitleColor:NORMAL_COLOR forState:UIControlStateNormal];
    [sender setTitleColor:SELECTED_COLOR forState:UIControlStateNormal];
    self.selectedButton=sender;
    CGPoint offset=sender.frame.origin;
    if (sender.frame.origin.x+self.scrollView.frame.size.width>self.scrollView.contentSize.width) {
        offset=CGPointMake(self.scrollView.contentSize.width-self.scrollView.frame.size.width, offset.y);
    }
    if (self.scrollView.contentSize.width>[UIScreen mainScreen].bounds.size.width) {
        [self.scrollView setContentOffset:offset animated:isAnimation];
    }
    [UIView animateWithDuration:isAnimation?0.2:0 animations:^{
        CGRect lFrame=self.selectedView.frame;
        lFrame.origin.x=sender.frame.origin.x;
        self.selectedView.frame=lFrame;
    }];
}

-(void)selectIndex:(NSInteger)index withAnimation:(BOOL)isAnimation{
    UIButton *lButton=(UIButton *)[self.scrollView viewWithTag:BUTTON_MIN_TAG+index];
    [self selectButton:lButton withAnimation:isAnimation];
}

#pragma mark - Button Click
-(void)buttonClick:(UIButton *)sender{
    [self selectButton:sender withAnimation:YES];
    if ([self.delegate respondsToSelector:@selector(MCChooseViewSelectIndex:)]) {
        [self.delegate MCChooseViewSelectIndex:sender.tag-BUTTON_MIN_TAG];
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (NSInteger)selectedIndex
{
    return self.selectedButton.tag - BUTTON_MIN_TAG;
}


-(void)setButtonTitleWithString:(NSString*)title index:(NSInteger)index{
    NSInteger tag=index+BUTTON_MIN_TAG;
    UIButton *lButton=(UIButton *)[self.scrollView viewWithTag:tag];
    [lButton setTitle:title forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIFont *)buttonFont{
    if (_buttonFont) {
        return _buttonFont;
    }
    return BUTTON_FONT;
}
@end
