//
//  PersonalTypeTaxManager.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PersonalTypeTaxManager.h"
#import "PersonalTypeTaxes.h"
#import "PersonalTypeTaxStrategy.h"

@implementation PersonalTypeTaxManager
@synthesize taxes;

-(id)initWithTaxes:(PersonalTypeTaxes *)theTaxes{
    self.taxes=theTaxes;
    return self;
}

-(void)dealloc{
    self.taxes=nil;
}

-(void)calculate{
    if (taxes) {
        [PersonalTypeTaxStrategy calculate:taxes];
    }
}

-(void)clearTaxes{
    self.taxes.salaryPreTax=0;
    self.taxes.salaryAfterTax=0;
    self.taxes.salaryForTax=0;
    self.taxes.salaryCost=0;
}


@end
