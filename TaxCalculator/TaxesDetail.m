//
//  TaxesDetail.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TaxesDetail.h"

@implementation TaxesDetail

@synthesize pPensionPercent;
@synthesize pMedicarePercent;
@synthesize pUnemploymentInsurancePercent;
@synthesize pFundPercent;
@synthesize fPensionPercent;
@synthesize fMedicarePercent;
@synthesize fUnemploymentInsurancePercent;
@synthesize fFundPercent;
@synthesize fIndustrialInjuryPercent;
@synthesize fMaternityInsurancePercent;

@synthesize pTotal;
@synthesize pTaxTotal;
@synthesize pPension;
@synthesize pMedicare;
@synthesize pUnemploymentInsurance;
@synthesize pFund;

@synthesize fTotal;
@synthesize fExpenseTotal;
@synthesize fPension;
@synthesize fMedicare;
@synthesize fUnemploymentInsurance;
@synthesize fFund;
@synthesize fIndustrialInjury;
@synthesize fMaternityInsurance;

@synthesize baseInsurance;
@synthesize baseFund;
@synthesize insuranceMax;
@synthesize threshold;

@synthesize insuranceMin;
@synthesize fundMax;
@synthesize minWage;
@synthesize medicarePlan;

-(void)clear{
    self.pPensionPercent=0;
    self.pMedicarePercent=0;
    self.pUnemploymentInsurancePercent=0;
    self.pFundPercent=0;
    self.fPensionPercent=0;
    self.fMedicarePercent=0;
    self.fUnemploymentInsurancePercent=0;
    self.fFundPercent=0;
    self.fIndustrialInjuryPercent=0;
    self.fMaternityInsurancePercent=0;
    
    self.pTotal=0;
    self.pTaxTotal=0;
    self.pPension=0;
    self.pMedicare=0;
    self.pUnemploymentInsurance=0;
    self.pFund=0;
    
    
    self.fTotal=0;
    self.fExpenseTotal=0;
    self.fPension=0;
    self.fMedicare=0;
    self.fUnemploymentInsurance=0;
    self.fFund=0;
    self.fIndustrialInjury=0;
    self.fMaternityInsurance=0;
    
    self.baseInsurance=0;
    self.baseFund=0;
    self.insuranceMax=0;
    self.threshold=0;
    
    self.insuranceMin=0;
    self.fundMax=0;
    self.minWage=0;
    self.medicarePlan=0;
}

@end
