//
//  EnterpriseTypeTaxManager.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EnterpriseTypeTaxManager.h"
#import "EnterpriseTypeTaxes.h"
#import "EnterpriseTypeTaxStrategy.h"

@implementation EnterpriseTypeTaxManager
@synthesize taxes;

-(id)initWithTaxes:(EnterpriseTypeTaxes *)theTaxes{
    self.taxes=theTaxes;
    return self;
}

-(void)dealloc{
    self.taxes=nil;
}

-(void)calculate{
    if (taxes) {
        [EnterpriseTypeTaxStrategy calculate:taxes];
    }
}

-(void)clearTaxes{
    self.taxes.salaryPreTax=0;
    self.taxes.salaryAfterTax=0;
    self.taxes.salaryForTax=0;
    self.taxes.workMonth=12;
}

@end
