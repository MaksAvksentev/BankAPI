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

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)initWithCourse:(NSDictionary *) dictionary{
    
        self.purchaseRate.text = [NSString stringWithFormat:@"%1.2d",[dictionary objectForKey:@"purchaseRateNB"]];
        //self.saleRate.text = [dictionary objectForKey:@"saleRateNB"];
}

@end
