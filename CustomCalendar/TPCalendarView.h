//
//  TPCalendarView.h
//  CustomCalendar
//
//  Created by YiTie on 16/3/29.
//  Copyright © 2016年 武文杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPCalendarView : UIView<UICollectionViewDelegate , UICollectionViewDataSource>
@property (nonatomic , strong) NSDate *date;
@property (nonatomic , strong) NSDate *today;
@property (nonatomic, copy) void(^calendarBlock)(NSInteger day, NSInteger month, NSInteger year);





@end
