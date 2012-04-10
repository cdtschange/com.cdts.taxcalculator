//
//  TaxesDetail.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaxesDetail : NSObject

@property(assign,nonatomic) double pPensionPercent;
@property(assign,nonatomic) double pMedicarePercent;
@property(assign,nonatomic) double pUnemploymentInsurancePercent;
@property(assign,nonatomic) double pFundPercent;
@property(assign,nonatomic) double fPensionPercent;
@property(assign,nonatomic) double fMedicarePercent;
@property(assign,nonatomic) double fUnemploymentInsurancePercent;
@property(assign,nonatomic) double fFundPercent;
@property(assign,nonatomic) double fIndustrialInjuryPercent;
@property(assign,nonatomic) double fMaternityInsurancePercent;

@property(assign,nonatomic) double pTotal;
@property(assign,nonatomic) double pTaxTotal;
@property(assign,nonatomic) double pPension;
@property(assign,nonatomic) double pMedicare;
@property(assign,nonatomic) double pUnemploymentInsurance;
@property(assign,nonatomic) double pFund;


@property(assign,nonatomic) double fTotal;
@property(assign,nonatomic) double fExpenseTotal;
@property(assign,nonatomic) double fPension;
@property(assign,nonatomic) double fMedicare;
@property(assign,nonatomic) double fUnemploymentInsurance;
@property(assign,nonatomic) double fFund;
@property(assign,nonatomic) double fIndustrialInjury;
@property(assign,nonatomic) double fMaternityInsurance;

@property(assign,nonatomic) double baseInsurance;
@property(assign,nonatomic) double baseFund;
@property(assign,nonatomic) double insuranceMax;
@property(assign,nonatomic) double threshold;

@property(assign,nonatomic) double insuranceMin;
@property(assign,nonatomic) double fundMax;
@property(assign,nonatomic) double minWage;
@property(assign,nonatomic) double medicarePlan;


-(void)clear;

@end
