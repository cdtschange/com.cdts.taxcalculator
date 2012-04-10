//
//  PersonalTypeTaxStrategy.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PersonalTypeTaxStrategy.h"
#import "TaxStrategy.h"
#import "PersonalTypeTaxes.h"

@implementation PersonalTypeTaxStrategy

+(void)calculate:(PersonalTypeTaxes *)taxes{
    double beforeTax=taxes.salaryPreTax-taxes.salaryCost;
    if (beforeTax<0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的数据！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if (beforeTax<=15000) {
        taxes.salaryForTax=beforeTax*0.05;
        taxes.salaryAfterTax=beforeTax-taxes.salaryForTax;
    }else if (beforeTax<=30000) {
        taxes.salaryForTax=beforeTax*0.1-750;
        taxes.salaryAfterTax=beforeTax-taxes.salaryForTax;
    }else if (beforeTax<=60000) {
        taxes.salaryForTax=beforeTax*0.2-3750;
        taxes.salaryAfterTax=beforeTax-taxes.salaryForTax;
    }else if (beforeTax<=100000) {
        taxes.salaryForTax=beforeTax*0.3-9750;
        taxes.salaryAfterTax=beforeTax-taxes.salaryForTax;
    }else {
        taxes.salaryForTax=beforeTax*0.35-14750;
        taxes.salaryAfterTax=beforeTax-taxes.salaryForTax;
    }
}

@end
