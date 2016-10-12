//
//  MCQRCodeMaskView.h
//  QRCode_OC
//
//  Created by 常峻玮 on 16/1/7.
//  Copyright © 2016年 Mingle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCQRCodeMaskView : UIView

@property(nonatomic,assign)CGRect clearFrame;
@property(nonatomic,strong)UIColor *maskColor;
@property(nonatomic,strong)UIColor *boundsColor;
@property(nonatomic,strong)UIColor *cornerColor;
-(instancetype)initWithFrame:(CGRect)frame andClearFrame:(CGRect)clearFrame;
@end
