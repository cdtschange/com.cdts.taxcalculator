//
//  CompensationTypeTaxes.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Taxes.h"

@interface CompensationTypeTaxes : Taxes

@property(assign,nonatomic) double salaryYearAve;
@property(assign,nonatomic) double salaryMonth;
@property(assign,nonatomic) int workYear;

@end
