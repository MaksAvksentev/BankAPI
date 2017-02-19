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

- (IBAction)calculateAction:(id)sender {
    [API_MANAGER createDateIntervalFromDate:self.fromPicker.date toDate:self.toPicker.date];
    [self performSegueWithIdentifier:@"BankViewToCourseView" sender:self];
}

@end
