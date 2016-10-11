//
//  CalenderView.m
//  NSClanderTest
//
//  Created by Valentin on 16/8/27.
//  Copyright © 2016年 Valentin. All rights reserved.
//

#import "CalenderView.h"
#import "CalenderCollectionViewCell.h"
#import "CalenderModel.h"
#import "MCDate.h"

@interface CalenderView()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;                //存储日期和空白的数组
@property (nonatomic, strong) NSCalendar *calendar;                     //日历
@property (nonatomic, assign) NSInteger frontBlankCount;                //每个月前面空白的个数
@property (nonatomic, assign) NSInteger dayCount;                       //每个月的天数
@property (nonatomic, assign) NSInteger backBlankCount;                 //每个月后面空白的个数
@property (nonatomic, strong) NSDateComponents *monthDateComponents;    //用于保存目前是几月
@property (nonatomic, strong) NSDate *today;                            //服务器返回的今天的日期，不能取本机时间，因为系统时间可以手动改
@property (nonatomic, strong) NSDateComponents *todayMonthDateComponents;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) NSIndexPath *selectedIndex;
@property (nonatomic, strong) NSDateComponents *defaultCompents;
@end

static NSString *calenderCell = @"calenderCell";
@implementation CalenderView

-(instancetype)initWithFrame:(CGRect)frame andDate:(MCDate *)date{
    self = [super initWithFrame:frame];
    if (self) {
        self.todayDate = date;
        [self setBase];
    }
    return self;
}
//-(instancetype)initWithFrame:(CGRect)frame{
//  self = [super initWithFrame:frame];
//    if (self) {
//        [self setBase];
//    }
//    return self;
//}
-(void)awakeFromNib{
    [self setBase];
}
-(void)setBase{
    [self configureUI];
    [self configureCalender];
    [self setCollectioonView];

}
-(void)configureUI{
//    self.selectedIndex = [NSIndexPath indexPathWithIndex:0];
    UIButton *frontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    frontBtn.frame = CGRectMake((SCREEN_WIDTH / 2.) - 85, 0, 45, 44);
    [frontBtn addTarget:self action:@selector(frontButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [frontBtn setImage:[UIImage imageNamed:@"chooseDateFront"] forState:UIControlStateNormal];
    [self addSubview:frontBtn];
    self.monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(frontBtn.frame), 0, 95, 44)];
    self.monthLabel.textColor = [UIColor colorWithRed:0 / 255. green:117 / 255. blue:255 / 255. alpha:1];
    self.monthLabel.backgroundColor = [UIColor whiteColor];
    self.monthLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.monthLabel];
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(CGRectGetMaxX(self.monthLabel.frame), 0, 45, 44);
    [nextBtn setImage:[UIImage imageNamed:@"chooseDateNext"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nextBtn];
    NSArray *weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i = 0; i < weekArray.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH / 7.) * i, 40, SCREEN_WIDTH / 7., 26)];
        label.text = weekArray[i];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:73 / 255. green:73 / 255. blue:73 / 255. alpha:1];
        label.backgroundColor = [UIColor colorWithRed:243 / 255. green:243 / 255. blue:243 / 255. alpha:1];
        [self addSubview:label];
    }
}
-(void)updateMonthLabel{
    self.monthLabel.text = [NSString stringWithFormat:@"%@年%@月", @(self.todayMonthDateComponents.year), @(self.todayMonthDateComponents.month)];
}
-(void)setCollectioonView{
    CGFloat itemWidth = floor((SCREEN_WIDTH) / 7.);
    CGFloat itemHeight = floor((SCREEN_WIDTH) / 7.);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.sectionInset = UIEdgeInsetsZero;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, self.bounds.size.height - 71) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.collectionView = collectionView;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CalenderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:calenderCell];
    [self addSubview:collectionView];
}
#pragma mark FrontButtonClicked
-(void)frontButtonClicked:(UIButton *)sender{
    self.selectedIndex = nil;
    NSDateComponents *previousDateComponents = [[NSDateComponents alloc] init];
    NSInteger year = self.todayMonthDateComponents.year;
    NSInteger month = self.todayMonthDateComponents.month - 1;
    if (month == 0) {
        month = 12;
        year = year - 1;
    }
    previousDateComponents.year = year;
    previousDateComponents.month = month;
    previousDateComponents.day = 1;
    self.todayMonthDateComponents = previousDateComponents;
    [self updateMonthLabel];
    [self setupWithMonthDateComponents: self.todayMonthDateComponents];
}
#pragma  mark NextButtonClicked
-(void)nextButtonClicked:(UIButton *)sender{
    self.selectedIndex = nil;
    NSDateComponents *nextDateComponents = [[NSDateComponents alloc] init];
    NSInteger year = self.todayMonthDateComponents.year;
    NSInteger month = self.todayMonthDateComponents.month + 1;
    if (month == 13) {
        month = 1;
        year = year + 1;
    }
    nextDateComponents.year = year;
    nextDateComponents.month = month;
    nextDateComponents.day = 1;
    self.todayMonthDateComponents = nextDateComponents;
    [self updateMonthLabel];
    [self setupWithMonthDateComponents: self.todayMonthDateComponents];
}

-(void)configureCalender{
    self.today = [NSDate date];//test,理论上应该从服务器获取
    NSDateComponents *dateComponents = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.today];
    self.todayMonthDateComponents = dateComponents;
    self.defaultCompents = dateComponents;
    [self setupWithMonthDateComponents:self.todayMonthDateComponents];
    MCDate *date = [MCDate dateWithYear:self.defaultCompents.year month:self.defaultCompents.month day:self.defaultCompents.day hour:0 minute:0 second:0];
    if (self.block) {
        self.block(date);
    }
    [self updateMonthLabel];
}
- (void)setupWithMonthDateComponents:(NSDateComponents *)components {
    self.monthDateComponents = components;
    NSDateComponents *firstDayComponents = [[NSDateComponents alloc] init];
    firstDayComponents.year = components.year;
    firstDayComponents.month = components.month;
    firstDayComponents.day = 1;
    NSDate *firstDay = [self.calendar dateFromComponents:firstDayComponents];
    NSDateComponents *dateComponents = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:firstDay];
    NSRange range = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:firstDay];//指定日期的day在month中的位置
    self.dayCount = range.length;
    self.dataArray = nil;
    self.frontBlankCount  = dateComponents.weekday - self.calendar.firstWeekday;
    if (self.frontBlankCount  < 0) {
        //这里，因为weekday周日是1，所以判断下
        self.frontBlankCount  += 7;
    }
    /** 每个月初多出来的cell */
    for (int i = 0; i < self.frontBlankCount; i++) {
        //这里是让每个月最开始的地方按需求空白
        CalenderModel *model = [[CalenderModel alloc] init];
        model.date = @"";
        [self.dataArray addObject:model];
    }
    for (int i = 0; i < range.length; i++) {
        CalenderModel *model = [[CalenderModel alloc] init];
        model.date = [NSString stringWithFormat:@"%@", @(i + 1)];
        if (self.defaultCompents.month == self.todayMonthDateComponents.month) {
            if (self.defaultCompents.day == i + 1) {
                model.isToday = YES;
            }else{
                model.isToday = NO;
            }
        }else{
            model.isToday = NO;
        }
        if (self.todayDate.month == self.todayMonthDateComponents.month) {
            if (self.todayDate.day == i + 1) {
                model.isChoosen = YES;
            }else{
                model.isChoosen = NO;
            }
        }else{
            model.isChoosen = NO;
        }

        [self.dataArray addObject:model];
    }
    NSInteger weeks = 0; //每个月有几周
    NSInteger aaa = self.dataArray.count / 7;
    NSInteger bbb = self.dataArray.count % 7;
    if (bbb == 0) {
        weeks = aaa;
    } else {
        weeks = aaa + 1;
    }
    /** 月末多出来的几个cell */
    self.backBlankCount = weeks * 7 - self.dataArray.count;
    for (int i = 0; i < self.backBlankCount; i++) {
        CalenderModel *model = [[CalenderModel alloc] init];
        model.date = @"";
        [self.dataArray addObject:model];
    }
    [self.collectionView reloadData];
}

#pragma mark - property
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [NSCalendar currentCalendar];
        _calendar.firstWeekday = 1;             //1是周日，2是周一，以此类推
        _calendar.minimumDaysInFirstWeek = 1;   //表示一个月的最初一周如果少于这个值，则算为上个月的最后一周，大约等于则算本月第一周，用1就好
    }
    return _calendar;
}
#pragma  mark UICollectionViewDelegate && UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalenderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:calenderCell forIndexPath:indexPath];
    CalenderModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell configCellWith:model];
    return cell;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.1;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row <= self.frontBlankCount - 1 || (self.dataArray.count - indexPath.row) <= self.backBlankCount){
        return;
    }else{
        CalenderModel *model = self.dataArray[indexPath.row];
        model.isChoosen = !model.isChoosen;
        if (self.selectedIndex == nil) {
            if ((self.todayDate.day + self.frontBlankCount) - 1 == indexPath.row) {
                return;
            }else{
                if (self.defaultCompents.month == self.todayMonthDateComponents.month) {
                    CalenderModel *defaultModel = self.dataArray[(self.todayDate.day + self.frontBlankCount) - 1];
                    if (self.todayDate.day != [MCDate date].day) {
                        defaultModel.isToday = NO;
                    }else{
                        defaultModel.isToday = YES;
                    }
                    defaultModel.isChoosen = NO;
                    [self.collectionView reloadItemsAtIndexPaths:@[indexPath , [NSIndexPath indexPathForRow:((self.todayDate.day + self.frontBlankCount) - 1) inSection:0]]];
                }else{
                    CalenderModel *defaultModel = self.dataArray[(self.todayDate.day + self.frontBlankCount) - 1];
                    defaultModel.isToday = NO;
                    defaultModel.isChoosen = NO;
                    [self.collectionView reloadItemsAtIndexPaths:@[indexPath , [NSIndexPath indexPathForRow:((self.todayDate.day + self.frontBlankCount) - 1) inSection:0]]];
                }
            }
        }else{
            NSInteger index;
            index = self.selectedIndex.row;
            if (index == indexPath.row) {
                CalenderModel *model1 = self.dataArray[indexPath.row];
                model1.isChoosen = !model1.isChoosen;
                [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }else{
                CalenderModel *model2 = self.dataArray[index];
                model2.isChoosen = !model2.isChoosen;
                [self.collectionView reloadItemsAtIndexPaths:@[indexPath , [NSIndexPath indexPathForRow:index inSection:0]]];
            }
        }
        CalenderModel *dayModel = self.dataArray[indexPath.row];
        self.selectedIndex = indexPath;
        MCDate *date = [MCDate dateWithYear:self.todayMonthDateComponents.year month:self.todayMonthDateComponents.month day:dayModel.date.integerValue hour:0 minute:0 second:0];
        if (self.block) {
            self.block(date);
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
