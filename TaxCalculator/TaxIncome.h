//
//  TaxIncome.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaxIncome : NSObject
@property(assign,nonatomic) int ID;
@property(strong,nonatomic) NSString *Name;
@property(assign,nonatomic) int Type;
@property(strong,nonatomic) NSString *Description;
@property(assign,nonatomic) int IsBaseType;

@end
