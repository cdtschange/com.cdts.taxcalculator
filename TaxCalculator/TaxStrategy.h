//
//  TaxStrategy.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Taxes;

@protocol TaxStrategy <NSObject>

@required
+(void)calculate:(Taxes *)taxes;

@optional
+(void)antiCalculate:(Taxes *)taxes;

@end
