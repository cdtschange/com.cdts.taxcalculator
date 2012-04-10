//
//  TaxService.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Tax;

@class SQLiteHelper;

@interface TaxService : NSObject{
    SQLiteHelper *sqliteHelper;
    NSMutableDictionary *source;
}

-(void)fillTaxIncome:(Tax *)tax;
-(void)fillTaxCity:(Tax *)tax;

@end
