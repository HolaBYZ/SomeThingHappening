//
//  CalenderCollectionViewCell.h
//  NSClanderTest
//
//  Created by Valentin on 16/8/27.
//  Copyright © 2016年 Valentin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CalenderModel;
@interface CalenderCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;

-(void)configCellWith:(CalenderModel *)model;

@end
