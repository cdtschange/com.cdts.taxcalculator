//
//  CompensationTypeTaxStrategy.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CompensationTypeTaxStrategy.h"
#import "TaxStrategy.h"
#import "CompensationTypeTaxes.h"
#import "TaxCalculator.h"

@implementation CompensationTypeTaxStrategy

+(void)calculate:(CompensationTypeTaxes *)taxes{
    double comBeforeF=taxes.salaryPreTax;
    double wagesAVGF=taxes.salaryYearAve;
    double comInsuranceF=taxes.salaryMonth;
    if (comBeforeF<wagesAVGF*3) {
        taxes.salaryForTax=0;
        taxes.salaryAfterTax=taxes.salaryPreTax;
    }else{
        double salario=(comBeforeF-wagesAVGF*3)/taxes.workYear;
        double taxF=[TaxCalculator getShuiji:salario :comInsuranceF];
        taxes.salaryForTax=taxF*taxes.workYear;
        taxes.salaryAfterTax=comBeforeF-taxes.salaryForTax;
    }
}

@end
