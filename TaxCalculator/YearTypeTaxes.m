//
//  YearTypeTaxes.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "YearTypeTaxes.h"
#import "Taxes.h"
#import "TaxesDetail.h"

@implementation YearTypeTaxes

@synthesize detail;
@synthesize salaryMonthGet;
@synthesize salaryOtherBonus;
@synthesize dmonthInsurance;
@synthesize dmonthTax;
@synthesize dleftYearSalary;
@synthesize dyearTax;

-(id)init{
    if ((self = [super init])) {
        self.detail=[[TaxesDetail alloc] init];
    }
    return self;
}

-(void)dealloc{
    self.detail=nil;
}

@end
