//
//  CompensationTypeTaxManager.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaxManager.h"

@class CompensationTypeTaxes;

@interface CompensationTypeTaxManager : TaxManager

@property(strong,nonatomic) CompensationTypeTaxes *taxes;


@end
