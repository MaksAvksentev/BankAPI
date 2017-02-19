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
#import "TableViewCell.h"

@interface NSCalendar (MySpecialCalculations)

-(NSInteger)daysWithinEraFromDate:(NSDate *) startDate toDate:(NSDate *) endDate;

@end

@implementation NSCalendar (MySpecialCalculations)

-(NSInteger)daysWithinEraFromDate:(NSDate *) startDate toDate:(NSDate *) endDate {
    
    NSInteger startDay=[self ordinalityOfUnit:NSDayCalendarUnit inUnit: NSEraCalendarUnit forDate:startDate];
    
    NSInteger endDay=[self ordinalityOfUnit:NSDayCalendarUnit inUnit: NSEraCalendarUnit forDate:endDate];
    
    return endDay-startDay;
}

@end

@interface CoursesViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonnull) NSMutableArray* coursesArray;

@end

@implementation CoursesViewController

- (void)viewDidLoad{

    [super viewDidLoad];
    
    self.coursesArray = [API_MANAGER createArrayOfDictionariesWithCourses];
    
    self.currentDate = [API_MANAGER fromDate];
}

- (IBAction)backToIntervalChoosing:(id)sender {
    
    //NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //NSLog(@"%ld", [calendar daysWithinEraFromDate:[API_MANAGER fromDate] toDate:[API_MANAGER toDate]] + 1);
    [self performSegueWithIdentifier:@"CourseViewToBankView" sender:self];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [calendar daysWithinEraFromDate:[API_MANAGER fromDate] toDate:[API_MANAGER toDate]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:self.currentDate options:0];

    /*
    NSDictionary *dict = [NSDictionary dictionary];
    NSInteger index = indexPath.row;
    
    
    do{
        dict = [NSDictionary dictionaryWithDictionary:[[API_MANAGER getCourseFromDate:self.currentDate] objectAtIndex:index]];
        index++;
    }while (![dict objectForKey:@"purchaseRate"]);
    */
    
    //NSLog(@"%@", [[self.coursesArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
    [cell initWithCourse:[[self.coursesArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    
    
    self.currentDate = nextDate;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   // NSLog(@"%@", [[self.coursesArray objectAtIndex:section] objectForKey:@"currentDate"]);
    return [[[[self.coursesArray objectAtIndex:section] objectAtIndex:0] objectForKey:@"currentDate"] stringDateWithNeedFormat];
}

@end
