//
//  PersonalTypeTaxManager.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaxManager.h"

@class PersonalTypeTaxes;

@interface PersonalTypeTaxManager : TaxManager

@property(strong,nonatomic) PersonalTypeTaxes *taxes;



@end
