//
//  TaxCalculator.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TaxesDetail;

@interface TaxCalculator : NSObject

+(double)getSalary:(double)afterSalary :(TaxesDetail *)detail :(double)percentInsurance :(double)percentFund :(double)insuranceMax :(double)fundMax;

+(double) getShuiji:(double) salario: (double)threshold;
+(double) getShuijiNian:(double) salario;

@end
