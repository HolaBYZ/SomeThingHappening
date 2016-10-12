//
//  MCChooseView.h
//  AA
//
//  Created by admin001 on 15/1/28.
//  Copyright (c) 2015年 MingleChang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MCChooseView;
@protocol  MCChooseViewDelegate<NSObject>

-(void)MCChooseViewSelectIndex:(NSInteger)index;

@end

@interface MCChooseView : UIControl
@property(nonatomic,assign)IBOutlet id<MCChooseViewDelegate> delegate;

@property (nonatomic, readonly) NSInteger selectedIndex;
@property(nonatomic,strong)UIFont *buttonFont;

-(void)setAllTitiles:(NSArray *)titiles;//设置所有的标题,并默认选中第一个标题
-(void)selectIndex:(NSInteger)index withAnimation:(BOOL)isAnimation;//设置选中的标题
-(void)setButtonTitleWithString:(NSString*)title index:(NSInteger)index;
@end
