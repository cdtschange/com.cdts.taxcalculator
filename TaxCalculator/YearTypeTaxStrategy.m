//
//  YearTypeTaxStrategy.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "YearTypeTaxStrategy.h"
#import "TaxStrategy.h"
#import "YearTypeTaxes.h"
#import "TaxesDetail.h"
#import "TaxCalculator.h"

@implementation YearTypeTaxStrategy

+(void)calculate:(YearTypeTaxes *)taxes{
    double annualBonusF=taxes.salaryOtherBonus;
    double annualMonthSalaryF=taxes.salaryMonthGet;
    double annualPayF=taxes.salaryPreTax;
    TaxesDetail *detail=taxes.detail;
    double insuranceBase=annualPayF/12;
    insuranceBase=insuranceBase<detail.insuranceMax?insuranceBase:detail.insuranceMax;
    insuranceBase=insuranceBase>0?insuranceBase:annualPayF/12;
    insuranceBase=insuranceBase<detail.insuranceMin?detail.insuranceMin:insuranceBase;
    insuranceBase=insuranceBase>detail.insuranceMax?detail.insuranceMax:insuranceBase;
    double fundBase=annualPayF/12;
    fundBase=fundBase<detail.insuranceMax?fundBase:detail.insuranceMax;
    fundBase=fundBase>0?fundBase:annualPayF/12;
    fundBase=fundBase<detail.minWage?detail.minWage:fundBase;
    fundBase=fundBase>detail.insuranceMax?detail.insuranceMax:fundBase;
    
    //个人部分
    double pension=detail.pPensionPercent>0?detail.pPensionPercent:0;
    pension*=insuranceBase/100;
    double medicare=detail.pMedicarePercent>0?detail.pMedicarePercent:0;
    medicare*=insuranceBase/100;
    double unemploymentInsurance=detail.pUnemploymentInsurancePercent>0?detail.pUnemploymentInsurancePercent:0;
    unemploymentInsurance*=insuranceBase/100;
    double fund=detail.pFundPercent>0?detail.pFundPercent:0;
    fund*=insuranceBase/100;
    double threshold=detail.threshold;
    
    //企业部分
    double pensionFirm=detail.fPensionPercent>0?detail.fPensionPercent:0;
    pensionFirm*=insuranceBase/100;
    double medicareFirm=detail.fMedicarePercent>0?detail.fMedicarePercent:0;
    medicareFirm*=insuranceBase/100;
    double unemploymentInsuranceFirm=detail.fUnemploymentInsurancePercent>0?detail.fUnemploymentInsurancePercent:0;
    unemploymentInsuranceFirm*=insuranceBase/100;
    double fundFirm=detail.fFundPercent>0?detail.fFundPercent:0;
    fundFirm*=insuranceBase/100;
    double industrialInjuryFirm=detail.fIndustrialInjuryPercent>0?detail.fIndustrialInjuryPercent:0;
    industrialInjuryFirm*=insuranceBase/100;
    double maternityInsuranceFirm=detail.fMaternityInsurancePercent>0?detail.fMaternityInsurancePercent:0;
    maternityInsuranceFirm*=insuranceBase/100;
    
    double salary=[TaxCalculator getSalary:annualMonthSalaryF :detail :(detail.pPensionPercent+detail.pMedicarePercent+detail.pUnemploymentInsurancePercent)/100 :detail.pFundPercent/100 :detail.insuranceMax :detail.fundMax];
    if (salary*12>annualPayF) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"每月领取超出年薪！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    double personalTotal=pension+medicare+unemploymentInsurance+fund;
    double pretaxTotal=salary-personalTotal-threshold;
    pretaxTotal=pretaxTotal<0?0:pretaxTotal;
    
    double firmTotal=pensionFirm+medicareFirm+unemploymentInsuranceFirm+fundFirm+industrialInjuryFirm+maternityInsuranceFirm;
    double firmExpenseTotal=firmTotal+salary;
    double annualMonthTax=[TaxCalculator getShuiji:(salary-personalTotal) :threshold];
    double annualMonthInsurance=personalTotal;
    double annualSalary=annualPayF-(annualMonthSalaryF+annualMonthTax+annualMonthInsurance)*12;
    annualSalary=annualSalary<0?0:annualSalary;
    double annualTax=[TaxCalculator getShuijiNian:(annualSalary+annualBonusF)];
    double annualTaxTotal=annualMonthTax*12+annualTax;
    double annualIncome=annualMonthSalaryF*12+annualSalary+annualBonusF-annualTax;
    
    taxes.salaryForTax=annualTaxTotal;
    taxes.salaryAfterTax=annualIncome;
    taxes.detail.pTotal=personalTotal;
    taxes.detail.pTaxTotal=pretaxTotal;
    taxes.detail.pPension=pension;
    taxes.detail.pMedicare=medicare;
    taxes.detail.pUnemploymentInsurance=unemploymentInsurance;
    taxes.detail.pFund=fund;
    taxes.detail.fTotal=firmTotal;
    taxes.detail.fExpenseTotal=firmExpenseTotal;
    taxes.detail.fPension=pensionFirm;
    taxes.detail.fMedicare=medicareFirm;
    taxes.detail.fUnemploymentInsurance=unemploymentInsuranceFirm;
    taxes.detail.fFund=fundFirm;
    taxes.detail.fIndustrialInjury=industrialInjuryFirm;
    taxes.detail.fMaternityInsurance=maternityInsuranceFirm;
    taxes.detail.baseInsurance=insuranceBase;
    taxes.detail.baseFund=fundBase;

    taxes.dmonthTax=annualMonthTax;
    taxes.dmonthInsurance=annualMonthInsurance;
    taxes.dleftYearSalary=annualSalary;
    taxes.dyearTax=annualTax;
    

}

@end
