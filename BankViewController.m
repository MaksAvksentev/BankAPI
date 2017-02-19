//
//  BankViewController.m
//  PrivateBankAPI
//
//  Created by Maksim Avksentev on 18.02.17.
//  Copyright © 2017 Maksim Avksentev. All rights reserved.
//

#import "BankViewController.h"
#import "APIManager.h"
#import "Constants.h"

@interface BankViewController ()

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *fromPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *toPicker;

@end

@implementation BankViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)calculateAction:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    [API_MANAGER createDateIntervalFromDate:[NSString stringWithString:[dateFormatter stringFromDate:self.fromPicker.date]] toDate:[NSString stringWithString:[dateFormatter stringFromDate:self.toPicker.date]]];
    [self performSegueWithIdentifier:@"BankViewToCourseView" sender:self];
}



@end
