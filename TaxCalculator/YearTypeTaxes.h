//
//  YearTypeTaxes.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Taxes.h"

@class TaxesDetail;

@interface YearTypeTaxes : Taxes

@property(strong,nonatomic) TaxesDetail *detail;

@property(assign,nonatomic) double salaryMonthGet;
@property(assign,nonatomic) double salaryOtherBonus;
@property(assign,nonatomic) double dmonthInsurance;
@property(assign,nonatomic) double dmonthTax;
@property(assign,nonatomic) double dleftYearSalary;
@property(assign,nonatomic) double dyearTax;

@end
