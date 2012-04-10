//
//  CompensationTypeTaxManager.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CompensationTypeTaxManager.h"
#import "CompensationTypeTaxes.h"
#import "CompensationTypeTaxStrategy.h"

@implementation CompensationTypeTaxManager
@synthesize taxes;

-(id)initWithTaxes:(CompensationTypeTaxes *)theTaxes{
    self.taxes=theTaxes;
    return self;
}

-(void)dealloc{
    self.taxes=nil;
}

-(void)calculate{
    if (taxes) {
        [CompensationTypeTaxStrategy calculate:taxes];
    }
}

-(void)clearTaxes{
    self.taxes.salaryPreTax=0;
    self.taxes.salaryAfterTax=0;
    self.taxes.salaryForTax=0;
    self.taxes.salaryYearAve=0;
    self.taxes.salaryMonth=0;
    self.taxes.workYear=12;
}

@end
