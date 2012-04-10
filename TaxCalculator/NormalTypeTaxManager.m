//
//  NormalTypeTaxManager.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NormalTypeTaxManager.h"
#import "NormalTypeTaxes.h"
#import "NormalTypeTaxStrategy.h"

@implementation NormalTypeTaxManager

@synthesize taxes;

-(id)initWithTaxes:(NormalTypeTaxes *)theTaxes{
    self.taxes=theTaxes;
    return self;
}

-(void)dealloc{
    self.taxes=nil;
}

-(void)calculate{
    if (taxes) {
        [NormalTypeTaxStrategy calculate:taxes];
    }
}

-(void)clearTaxes{
    self.taxes.salaryPreTax=0;
    self.taxes.salaryAfterTax=0;
    self.taxes.salaryForTax=0;
}

@end
