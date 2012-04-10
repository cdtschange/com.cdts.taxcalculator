//
//  EnterpriseTypeTaxManager.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaxManager.h"

@class EnterpriseTypeTaxes;

@interface EnterpriseTypeTaxManager : TaxManager

@property(strong,nonatomic) EnterpriseTypeTaxes *taxes;



@end
