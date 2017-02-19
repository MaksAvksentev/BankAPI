//
//  APIManager.h
//  PrivateBankAPI
//
//  Created by Maksim Avksentev on 19.02.17.
//  Copyright © 2017 Maksim Avksentev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

@property (strong, nonatomic) NSString *fromDate;
@property (strong, nonatomic) NSString *toDate;

+ (APIManager*)sharedManager;
+ (id)allocWithZone:(NSZone *)zone;
- (id)copy;

- (void)createDateIntervalFromDate:(NSString *)fromDate toDate:(NSString *) toDate;

- (void)getCourseFromDate:(NSString *) date;

@end
