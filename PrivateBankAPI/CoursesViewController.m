//
//  CoursesViewController.m
//  PrivateBankAPI
//
//  Created by Maksim Avksentev on 18.02.17.
//  Copyright © 2017 Maksim Avksentev. All rights reserved.
//

#import "CoursesViewController.h"
#import "APIManager.h"
#import "Constants.h"
@interface CoursesViewController ()

@end

@implementation CoursesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [API_MANAGER getCourseFromDate:[API_MANAGER fromDate]];
}

@end
