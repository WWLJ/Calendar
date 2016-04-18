//
//  ViewController.m
//  CustomCalendar
//
//  Created by YiTie on 16/3/29.
//  Copyright © 2016年 武文杰. All rights reserved.
//

#import "ViewController.h"
#import "TPCalendarView.h"
#import "NSDate+Helper.h"
@interface ViewController ()
@property(nonatomic, strong)TPCalendarView *calendarPicker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action:) name:@"11" object:nil];
    self.view.backgroundColor = [UIColor grayColor];
     _calendarPicker = [[TPCalendarView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width)];
    [self.view addSubview:_calendarPicker];
    _calendarPicker.today = [NSDate date];
    _calendarPicker.date = _calendarPicker.today;
    _calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
        
        NSLog(@"%i-%i-%i", year,month,day);
    };
}

- (void)action:(NSNotification *)noti
{
    NSDate *date = noti.object;
    NSInteger daysInThisMonth = [date totaldaysInThisMonth];
    NSInteger firstWeekday = [date firstWeekdayInThisMonth];
    CGFloat itemWidth = self.view.frame.size.width / 7;
    if (daysInThisMonth + firstWeekday > 35) {
        NSLog(@"正常");
        [UIView animateWithDuration:0.3 animations:^{
            [self.calendarPicker setFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width)];
        }];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            [self.calendarPicker setFrame:CGRectMake(0, 100, self.view.frame.size.width, 6 * itemWidth)];
        }];
        NSLog(@"少一行");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
