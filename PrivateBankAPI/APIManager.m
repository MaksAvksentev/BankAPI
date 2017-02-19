//
//  APIManager.m
//  PrivateBankAPI
//
//  Created by Maksim Avksentev on 19.02.17.
//  Copyright © 2017 Maksim Avksentev. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking.h"

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


- (void)createDateIntervalFromDate:(NSString *)fromDate toDate:(NSString *) toDate {

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

- (void)getCourseFromDate:(NSString *) date{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{ @"date"       : date}];
                                                                                       
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                                 URLString:@"https://api.privatbank.ua/p24api/exchange_rates?json&"
                                                                                parameters:parameters
                                                                                     error:nil];
    NSLog(@"%@", request);
    NSLog(@"%@", [[self sendRequest:request] objectForKey:@"exchangeRate"]);
}


@end
