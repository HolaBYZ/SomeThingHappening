//
//  CalenderCollectionViewCell.m
//  NSClanderTest
//
//  Created by Valentin on 16/8/27.
//  Copyright © 2016年 Valentin. All rights reserved.
//

#import "CalenderCollectionViewCell.h"
#import "CalenderModel.h"

@implementation CalenderCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)configCellWith:(CalenderModel *)model{
    if (model.isChoosen && model.isToday) {
        self.bgImageView.hidden = NO;
        self.bgImageView.image = [UIImage imageNamed:@"chooseDateselected"];
        self.dateLabel.textColor = [UIColor whiteColor];
    }else if (model.isChoosen && !model.isToday){
        self.bgImageView.hidden = NO;
        self.bgImageView.image = [UIImage imageNamed:@"chooseDateselected"];
        self.dateLabel.textColor = [UIColor whiteColor];
    }else{
        self.dateLabel.textColor = [UIColor darkGrayColor];
        if (model.isToday) {
            self.bgImageView.hidden = NO;
            self.bgImageView.image = [UIImage imageNamed:@"chooseDateUnselected"];
        }else{
            self.bgImageView.hidden = YES;
        }
    }
    self.dateLabel.text = model.date;
}
@end
