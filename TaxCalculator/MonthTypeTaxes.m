//
//  MonthTypeTaxes.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MonthTypeTaxes.h"
#import "Taxes.h"
#import "TaxesDetail.h"

@implementation MonthTypeTaxes

@synthesize detail;

-(id)init{
    if ((self = [super init])) {
        self.detail=[[TaxesDetail alloc] init];
    }
    return self;
}

-(void)dealloc{
    self.detail=nil;
}

@end
