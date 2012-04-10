//
//  MonthTypeTaxes.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Taxes.h"

@class TaxesDetail;

@interface MonthTypeTaxes : Taxes

@property(strong,nonatomic) TaxesDetail *detail;

@end
