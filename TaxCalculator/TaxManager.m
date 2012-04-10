//
//  TaxManager.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TaxManager.h"
#import "TaxesDetail.h"
#import "TaxCity.h"

@implementation TaxManager

-(id)initWithTaxes:(Taxes *)theTaxes{
    return self;
}

-(void)calculate{

}

-(void)antiCalculate{

}

-(void)clearTaxes{

}

-(void)copyCityToDetail:(TaxesDetail *)detail :(TaxCity *)city{
    if (city && detail) {
        [detail clear];
        
        detail.pPensionPercent=city.Pension;
        detail.pMedicarePercent=city.Medicare;
        detail.pUnemploymentInsurancePercent=city.UnemploymentInsurance;
        detail.pFundPercent=city.Fund;
        detail.fPensionPercent=city.PensionFirm;
        detail.fMedicarePercent=city.MedicareFirm;
        detail.fUnemploymentInsurancePercent=city.UnemploymentInsuranceFirm;
        detail.fFundPercent=city.FundFirm;
        detail.fIndustrialInjuryPercent=city.IndustrialInjuryFirm;
        detail.fMaternityInsurancePercent=city.MaternityInsuranceFirm;
        
        detail.insuranceMax=city.InsuranceMax;
        detail.threshold=city.Threshold;
        
        detail.insuranceMin=city.InsuranceMin;
        detail.fundMax=city.FundMax;
        detail.minWage=city.MinWage;
        detail.medicarePlan=city.MedicarePlan;
    }
}

-(NSMutableDictionary *)getDetailData:(TaxesDetail *)detail{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    if (detail) {
        NSMutableArray *pFields=[[NSMutableArray alloc] initWithObjects:
                 [NSNumber numberWithDouble: 0],
                 [NSNumber numberWithDouble: 0],
                 [NSNumber numberWithDouble: detail.pPensionPercent],
                 [NSNumber numberWithDouble: detail.pMedicarePercent],
                 [NSNumber numberWithDouble: detail.pUnemploymentInsurancePercent],
                 [NSNumber numberWithDouble: detail.pFundPercent], nil];
        NSMutableArray *fFields=[[NSMutableArray alloc] initWithObjects:
                 [NSNumber numberWithDouble: 0],
                 [NSNumber numberWithDouble: 0],
                 [NSNumber numberWithDouble:detail.fPensionPercent],
                 [NSNumber numberWithDouble:detail.fMedicarePercent],
                 [NSNumber numberWithDouble:detail.fUnemploymentInsurancePercent],
                 [NSNumber numberWithDouble:detail.fIndustrialInjuryPercent],
                 [NSNumber numberWithDouble:detail.fMaternityInsurancePercent],
                 [NSNumber numberWithDouble:detail.fFundPercent], nil];
        NSMutableArray *pValues=[[NSMutableArray alloc] initWithObjects:
                 [NSNumber numberWithDouble: detail.pTotal],
                 [NSNumber numberWithDouble: detail.pTaxTotal],
                 [NSNumber numberWithDouble: detail.pPension],
                 [NSNumber numberWithDouble: detail.pMedicare],
                 [NSNumber numberWithDouble: detail.pUnemploymentInsurance],
                 [NSNumber numberWithDouble: detail.pFund], nil];
        NSMutableArray *fValues=[[NSMutableArray alloc] initWithObjects:
                 [NSNumber numberWithDouble: detail.fTotal],
                 [NSNumber numberWithDouble: detail.fExpenseTotal],
                 [NSNumber numberWithDouble: detail.fPension],
                 [NSNumber numberWithDouble: detail.fMedicare],
                 [NSNumber numberWithDouble: detail.fUnemploymentInsurance],
                 [NSNumber numberWithDouble: detail.fIndustrialInjury],
                 [NSNumber numberWithDouble: detail.fMaternityInsurance],
                 [NSNumber numberWithDouble: detail.fFund], nil];
        NSMutableArray *baseValues=[[NSMutableArray alloc] initWithObjects:
                 [NSNumber numberWithDouble: detail.baseInsurance],
                 [NSNumber numberWithDouble: detail.baseFund],
                 [NSNumber numberWithDouble: detail.insuranceMax],
                 [NSNumber numberWithDouble: detail.threshold], nil];
        [dict setObject:pFields forKey:@"pFields"];
        [dict setObject:fFields forKey:@"fFields"];
        [dict setObject:pValues forKey:@"pValues"];
        [dict setObject:fValues forKey:@"fValues"];
        [dict setObject:baseValues forKey:@"baseValues"];
    }
    return dict;
}

-(void)updateDetailData:(TaxesDetail *)detail :(NSMutableDictionary *)dict{
    if (detail&&dict) {
        NSMutableArray *pValues=[dict objectForKey:@"pValues"];
        NSMutableArray *fValues=[dict objectForKey:@"fValues"];
        NSMutableArray *baseValues=[dict objectForKey:@"baseValues"];

        [pValues replaceObjectAtIndex:0 withObject:[NSNumber numberWithDouble:detail.pTotal]];
        [pValues replaceObjectAtIndex:1 withObject:[NSNumber numberWithDouble:detail.pTaxTotal]];
        [pValues replaceObjectAtIndex:2 withObject:[NSNumber numberWithDouble:detail.pPension]];
        [pValues replaceObjectAtIndex:3 withObject:[NSNumber numberWithDouble:detail.pMedicare]];
        [pValues replaceObjectAtIndex:4 withObject:[NSNumber numberWithDouble:detail.pUnemploymentInsurance]];
        [pValues replaceObjectAtIndex:5 withObject:[NSNumber numberWithDouble:detail.pFund]];
        
        [fValues replaceObjectAtIndex:0 withObject:[NSNumber numberWithDouble:detail.fTotal]];
        [fValues replaceObjectAtIndex:1 withObject:[NSNumber numberWithDouble:detail.fExpenseTotal]];
        [fValues replaceObjectAtIndex:2 withObject:[NSNumber numberWithDouble:detail.fPension]];
        [fValues replaceObjectAtIndex:3 withObject:[NSNumber numberWithDouble:detail.fMedicare]];
        [fValues replaceObjectAtIndex:4 withObject:[NSNumber numberWithDouble:detail.fUnemploymentInsurance]];
        [fValues replaceObjectAtIndex:5 withObject:[NSNumber numberWithDouble:detail.fIndustrialInjury]];
        [fValues replaceObjectAtIndex:6 withObject:[NSNumber numberWithDouble:detail.fMaternityInsurance]];
        [fValues replaceObjectAtIndex:7 withObject:[NSNumber numberWithDouble:detail.fFund]];
        [baseValues replaceObjectAtIndex:0 withObject:[NSNumber numberWithDouble:detail.baseInsurance]];
        [baseValues replaceObjectAtIndex:1 withObject:[NSNumber numberWithDouble:detail.baseFund]];
        [baseValues replaceObjectAtIndex:2 withObject:[NSNumber numberWithDouble:detail.insuranceMax]];
        [baseValues replaceObjectAtIndex:3 withObject:[NSNumber numberWithDouble:detail.threshold]];
        
    }
}

@end
