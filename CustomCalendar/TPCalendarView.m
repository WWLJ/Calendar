//
//  TPCalendarView.m
//  CustomCalendar
//
//  Created by YiTie on 16/3/29.
//  Copyright © 2016年 武文杰. All rights reserved.
//

#import "TPCalendarView.h"
#import "TPCalendarCell.h"
#import "NSDate+Helper.h"
@interface TPCalendarView()

@property (nonatomic , strong)  UICollectionView *collectionView;
@property (nonatomic , strong)  UILabel *monthLabel;

@property (nonatomic , strong) NSArray *weekDayArray;

@end




NSString *const TPCalendarCellIdentifier = @"TPCalendarCell";

@implementation TPCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        [self addSubview:self.collectionView];
        [self addSwipe];
        
        
    }
    return self;
}



#pragma -mark collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.weekDayArray.count;
    } else {
        return 42;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TPCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TPCalendarCellIdentifier forIndexPath:indexPath];
    /**
     *  星期
     */
    if (indexPath.section == 0) {
        [cell.dateLabel setText:_weekDayArray[indexPath.row]];
        [cell.dateLabel setTextColor:[UIColor greenColor]];
    } else {
        NSInteger daysInThisMonth = [_date totaldaysInThisMonth];
        NSInteger firstWeekday = [_date firstWeekdayInThisMonth];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i < firstWeekday) {
            [cell.dateLabel setText:@""];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            [cell.dateLabel setText:@""];
        }else{
            day = i - firstWeekday + 1;
            [cell.dateLabel setText:[NSString stringWithFormat:@"%ld",day]];
            [cell.dateLabel setTextColor:[UIColor redColor]];
            
//            //this month
//            if ([_today isEqualToDate:_date]) {
//                if (day == [_date day]) {
//                    [cell.dateLabel setTextColor:[UIColor redColor]];
//                } else if (day > [_date day]) {
//                    [cell.dateLabel setTextColor:[UIColor redColor]];
//                }
//            } else if ([_today compare:_date] == NSOrderedAscending) {
//                [cell.dateLabel setTextColor:[UIColor redColor]];
//            }
        }
    }
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSInteger daysInThisMonth = [_date totaldaysInThisMonth];
        NSInteger firstWeekday = [_date firstWeekdayInThisMonth];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i >= firstWeekday && i <= firstWeekday + daysInThisMonth - 1) {
            day = i - firstWeekday + 1;
            
            //this month
            if ([_today isEqualToDate:_date]) {
                if (day <= [_date day]) {
                    return YES;
                }
            } else if ([_today compare:_date] == NSOrderedDescending) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    NSInteger firstWeekday = [_date firstWeekdayInThisMonth];
    
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    day = i - firstWeekday + 1;
    if (self.calendarBlock) {
        self.calendarBlock(day, [comp month], [comp year]);
    }
    
}

- (void)addSwipe
{
    UISwipeGestureRecognizer *swipUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nexAction:)];
    swipUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipUp];
    
    UISwipeGestureRecognizer *swipDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previouseAction:)];
    swipDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipDown];
}

- (void)previouseAction:(id)sender
{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
        self.date = [self.date lastMonth];
    } completion:nil];
}

- (void)nexAction:(UIButton *)sender
{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        self.date = [self.date nextMonth];
    } completion:nil];
}

#pragma mark property init
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        CGFloat itemWidth = self.frame.size.width / 7;
        CGFloat itemHeight = self.frame.size.width / 7;
        
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        
        CGRect collectionViewFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.allowsSelection = YES;
        [_collectionView registerClass:[TPCalendarCell class] forCellWithReuseIdentifier:TPCalendarCellIdentifier];
    }
    return _collectionView;
}

-(void)setDate:(NSDate *)date
{
    _date = date;
    NSLog(@"%@",date);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"11" object:date];
    [_collectionView reloadData];
}

-(NSArray *)weekDayArray
{
    if (!_weekDayArray) {
        _weekDayArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    }
    return _weekDayArray;
}





@end
