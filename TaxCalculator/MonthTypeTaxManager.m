//
//  MonthTypeTaxManager.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MonthTypeTaxManager.h"
#import "MonthTypeTaxes.h"
#import "TaxesDetail.h"
#import "MonthTypeTaxStrategy.h"
#import "TaxCity.h"


@implementation MonthTypeTaxManager

@synthesize taxes;

-(id)initWithTaxes:(MonthTypeTaxes *)theTaxes{
    self.taxes=theTaxes;
    return self;
}

-(void)dealloc{
    self.taxes=nil;
}

-(void)calculate{
    if (taxes) {
        [MonthTypeTaxStrategy calculate:taxes];
    }
}

-(void)antiCalculate{
    if (taxes) {
        [MonthTypeTaxStrategy antiCalculate:taxes];
    }
}

-(void)clearTaxes{
    self.taxes.salaryPreTax=0;
    self.taxes.salaryAfterTax=0;
    self.taxes.salaryForTax=0;
    [self.taxes.detail clear];
}

-(void)copyToDetail:(TaxCity *)city{
    [self copyCityToDetail:self.taxes.detail :city];
}

-(NSMutableDictionary *)getDetail{
    return [self getDetailData:self.taxes.detail];
}

-(void)updateDetailPercent:(NSMutableDictionary *)dict:(int)section :(int)row :(double)value:(BOOL)isAntiCalculate{
    NSMutableArray *pFields=[dict objectForKey:@"pFields"];
    NSMutableArray *fFields=[dict objectForKey:@"fFields"];

    if (section==0) {
        [pFields replaceObjectAtIndex:row withObject:[NSNumber numberWithDouble:value]];
        switch (row-2) {
            case 0:
                self.taxes.detail.pPensionPercent=value;
                break;
            case 1:
                self.taxes.detail.pMedicarePercent=value;
                break;
            case 2:
                self.taxes.detail.pUnemploymentInsurancePercent=value;
                break;
            case 3:
                self.taxes.detail.pFundPercent=value;
                break;
            default:
                break;
        }
    }else if (section==1) {
        [fFields replaceObjectAtIndex:row withObject:[NSNumber numberWithDouble:value]];
        switch (row-2) {
            case 0:
                self.taxes.detail.fPensionPercent=value;
                break;
            case 1:
                self.taxes.detail.fMedicarePercent=value;
                break;
            case 2:
                self.taxes.detail.fUnemploymentInsurancePercent=value;
                break;
            case 3:
                self.taxes.detail.fIndustrialInjuryPercent=value;
                break;
            case 4:
                self.taxes.detail.fMaternityInsurancePercent=value;
                break;
            case 5:
                self.taxes.detail.fFundPercent=value;
                break;
            default:
                break;
        }
    }
    if (isAntiCalculate) {
        [self antiCalculate];
    }else{
        [self calculate];
    }
    
    [self updateDetailData:self.taxes.detail :dict];

}

@end
