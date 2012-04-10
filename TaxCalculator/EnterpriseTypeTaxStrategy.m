//
//  EnterpriseTypeTaxStrategy.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EnterpriseTypeTaxStrategy.h"
#import "TaxStrategy.h"
#import "EnterpriseTypeTaxes.h"

@implementation EnterpriseTypeTaxStrategy

+(void)calculate:(EnterpriseTypeTaxes *)taxes{
    double beforeTax=taxes.salaryPreTax-3500*taxes.workMonth;
    if (beforeTax<0) {
        taxes.salaryForTax=0;
        taxes.salaryAfterTax=taxes.salaryPreTax-taxes.salaryForTax;
    }else if (beforeTax<=15000) {
        taxes.salaryForTax=beforeTax*0.05;
        taxes.salaryAfterTax=taxes.salaryPreTax-taxes.salaryForTax;
    }else if (beforeTax<=30000) {
        taxes.salaryForTax=beforeTax*0.1-750;
        taxes.salaryAfterTax=taxes.salaryPreTax-taxes.salaryForTax;
    }else if (beforeTax<=60000) {
        taxes.salaryForTax=beforeTax*0.2-3750;
        taxes.salaryAfterTax=taxes.salaryPreTax-taxes.salaryForTax;
    }else if (beforeTax<=100000) {
        taxes.salaryForTax=beforeTax*0.3-9750;
        taxes.salaryAfterTax=taxes.salaryPreTax-taxes.salaryForTax;
    }else {
        taxes.salaryForTax=beforeTax*0.35-14750;
        taxes.salaryAfterTax=taxes.salaryPreTax-taxes.salaryForTax;
    }

}

@end
