//
//  MonthTypeTaxManager.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaxManager.h"

@class MonthTypeTaxes,TaxCity;

@interface MonthTypeTaxManager : TaxManager<TaxesAction>

@property(strong,nonatomic) MonthTypeTaxes *taxes;

-(void) copyToDetail:(TaxCity *)city;
-(NSMutableDictionary *) getDetail;

@end
