//
//  TableViewCell.m
//  PrivateBankAPI
//
//  Created by Maksim Avksentev on 19.02.17.
//  Copyright © 2017 Maksim Avksentev. All rights reserved.
//

#import "TableViewCell.h"
@interface TableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *purchaseRate;
@property (weak, nonatomic) IBOutlet UILabel *saleRate;
@property (weak, nonatomic) IBOutlet UILabel *convertFromTo;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)initWithCourse:(NSDictionary *) dictionary{
    
    
    NSString *key = [[NSString alloc] init];
    
    self.convertFromTo.text = [NSString stringWithFormat:@"UAH to %@", [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"currency"]]];
    
    if ([dictionary objectForKey:@"purchaseRate"]) {
        
        key = @"purchaseRate";
    }else{
    
        key = @"purchaseRateNB";
    }
    
    self.purchaseRate.text = [NSString stringWithFormat:@"%@", [dictionary objectForKey:key]];
    
    if ([dictionary objectForKey:@"saleRate"]){
        
        key = @"saleRate";
    }else{
    
        key = @"saleRateNB";
    }
    
    self.saleRate.text = [NSString stringWithFormat:@"%@",[dictionary objectForKey:key]];
}

@end
