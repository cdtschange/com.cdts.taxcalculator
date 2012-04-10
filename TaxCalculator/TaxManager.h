//
//  TaxManager.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Taxes, TaxesDetail, TaxCity;

@interface TaxManager : NSObject

-(id)initWithTaxes:(Taxes *)theTaxes;

-(void) calculate;

-(void) antiCalculate;

-(void) clearTaxes;

-(void) copyCityToDetail:(TaxesDetail *)detail:(TaxCity *)city;

-(NSMutableDictionary *) getDetailData:(TaxesDetail *)detail;

-(void) updateDetailData:(TaxesDetail *)detail:(NSMutableDictionary *)dict;

@end

@protocol TaxesAction <NSObject>

@optional

-(void) updateDetailPercent:(NSMutableDictionary *)dict:(int)section:(int)row:(double)value:(BOOL)isAntiCalculate;

@end
