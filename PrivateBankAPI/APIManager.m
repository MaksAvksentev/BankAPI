//
//  APIManager.m
//  PrivateBankAPI
//
//  Created by Maksim Avksentev on 19.02.17.
//  Copyright © 2017 Maksim Avksentev. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking/AFNetworking.h"




@interface APIManager ()

@property (strong, nonatomic) NSURLSession *session;

@end

@implementation APIManager

+(APIManager *) sharedManager{

    static APIManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[APIManager alloc] init];
    });
    return manager;
}

+ (id)allocWithZone:(NSZone *)zone {
    
    static APIManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
    });
    
    return sharedInstance;
}

- (id)copy {
    
    return self;
}


- (void)createDateIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *) toDate {

    self.fromDate = fromDate;
    self.toDate= toDate;
    NSLog(@"%@ to %@", self.fromDate , self.toDate);

}

- (NSDictionary *) sendRequest:(NSMutableURLRequest *)request {
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    id data = [NSJSONSerialization JSONObjectWithData:responseData
                                              options:0
                                                error:nil];
    return data;
}

- (NSDictionary *)getCourseFromDate:(NSDate *) date{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{ @"date"       : [date stringDateWithNeedFormat]}];
                                                                                       
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                                 URLString:@"https://api.privatbank.ua/p24api/exchange_rates?json&"
                                                                                parameters:parameters
                                                                                     error:nil];
    return [[self sendRequest:request] objectForKey:@"exchangeRate"];
}

- (NSMutableArray *)createArrayOfDictionariesWithCourses{
    
    NSDate *currentDate = self.fromDate;
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    NSMutableArray *finishArray = [[NSMutableArray alloc] init];
    
    do {
       
        NSMutableArray *temp = [NSMutableArray array];

        

        NSDictionary *dict = [self getCourseFromDate:currentDate];
        
        for (NSDictionary *course in dict) {
            
            NSMutableDictionary* array = [NSMutableDictionary dictionary];
            
            [array setObject:currentDate forKey:@"currentDate"];

            if ([[course objectForKey:@"currency"]  isEqual: @"RUB"] || [[course objectForKey:@"currency"]  isEqual: @"EUR"] || [[course objectForKey:@"currency"]  isEqual: @"USD"]) {
                
                [array setObject:[course objectForKey:@"purchaseRate"] forKey:@"purchaseRate"];
                [array setObject:[course objectForKey:@"saleRate"] forKey:@"saleRate"];
                [array setObject:[course objectForKey:@"currency"] forKey:@"currency"];
                [temp addObject:array];
            }
            

        }
        
        [finishArray addObject:temp];

        currentDate = [theCalendar dateByAddingComponents:dayComponent toDate:currentDate options:0];
        
    } while (currentDate != self.toDate);
    
    return finishArray;
    
}

@end
