//
//  APIManager.h
//  PrivateBankAPI
//
//  Created by Maksim Avksentev on 19.02.17.
//  Copyright © 2017 Maksim Avksentev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NeedDateFormat)

- (NSString *)stringDateWithNeedFormat;

@end

@implementation NSDate (NeedDateFormat)

- (NSString *)stringDateWithNeedFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    return [NSString stringWithString:[dateFormatter stringFromDate:self]];
}

@end

@interface APIManager : NSObject

@property (strong, nonatomic) NSDate *fromDate;
@property (strong, nonatomic) NSDate *toDate;
@property (assign, nonatomic) BOOL firstTimeAppear;

+ (APIManager*)sharedManager;
+ (id)allocWithZone:(NSZone *)zone;
- (id)copy;

- (void)createDateIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *) toDate;

- (NSArray *)getCourseFromDate:(NSDate *) date;

@end
