//
//  MonthTypeTaxStrategy.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MonthTypeTaxStrategy.h"
#import "TaxStrategy.h"
#import "MonthTypeTaxes.h"
#import "TaxesDetail.h"
#import "TaxCalculator.h"

@implementation MonthTypeTaxStrategy

+(void)calculate:(MonthTypeTaxes *)taxes{
    double salary=taxes.salaryPreTax;
    TaxesDetail *detail=taxes.detail;
    if (salary<detail.minWage&&detail.minWage>0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"还不到当地最低工资哦！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    double insuranceBase=salary<detail.insuranceMax?salary:detail.insuranceMax;
    insuranceBase=insuranceBase<detail.insuranceMin?detail.insuranceMin:insuranceBase;
    insuranceBase=insuranceBase>detail.insuranceMax?detail.insuranceMax:insuranceBase;
    
    double fundBase=salary<detail.insuranceMax?salary:detail.insuranceMax;
    fundBase=fundBase<detail.minWage?detail.minWage:fundBase;
    fundBase=fundBase>detail.insuranceMax?detail.insuranceMax:fundBase;
    //个人部分
    double pension=detail.pPensionPercent>0?detail.pPensionPercent:0;
    pension*=insuranceBase/100;
    double medicare=detail.pMedicarePercent>0?detail.pMedicarePercent:0;
    medicare*=insuranceBase/100;
    medicare+=detail.medicarePlan;
    double unemploymentInsurance=detail.pUnemploymentInsurancePercent>0?detail.pUnemploymentInsurancePercent:0;
    unemploymentInsurance*=insuranceBase/100;
    double fund=detail.pFundPercent>0?detail.pFundPercent:0;
    fund*=fundBase/100;
    double threshold=detail.threshold;
    double personalTotal=pension+medicare+unemploymentInsurance+fund;
    if (salary<personalTotal) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"工资真的这么少吗！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    double pretaxTotal=salary-personalTotal-threshold;
    pretaxTotal=pretaxTotal<0?0:pretaxTotal;
    double taxx=[TaxCalculator getShuiji:(salary-personalTotal) :threshold];
    double afterTax=salary-personalTotal-taxx;
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
    double firmTotal=pensionFirm+medicareFirm+unemploymentInsuranceFirm+fundFirm+industrialInjuryFirm+maternityInsuranceFirm;
    double firmExpenseTotal=firmTotal+salary;
    
    
    taxes.salaryForTax=taxx;
    taxes.salaryAfterTax=afterTax;
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
}

+(void)antiCalculate:(MonthTypeTaxes *)taxes{
    double afterSalary=taxes.salaryAfterTax;
    TaxesDetail *detail=taxes.detail;
    double insuranceBase=0;
    double fundBase=0;
    double salary=0;
    double percentInsurance=(detail.pPensionPercent+detail.pMedicarePercent+detail.pUnemploymentInsurancePercent)/100;
    double percentFund=detail.pFundPercent/100;
    salary=[TaxCalculator getSalary:afterSalary :detail :percentInsurance :percentFund :detail.insuranceMax :detail.fundMax];
    if (salary<detail.minWage) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"还不到当地最低工资哦！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    insuranceBase=salary<detail.insuranceMax?salary:detail.insuranceMax>0?detail.insuranceMax:salary;
    insuranceBase=insuranceBase<detail.insuranceMin?detail.insuranceMin:insuranceBase;
    insuranceBase=insuranceBase>detail.insuranceMax?detail.insuranceMax:insuranceBase;
    fundBase=salary<detail.insuranceMax?salary:detail.insuranceMax>0?detail.insuranceMax:salary;
    fundBase=fundBase<detail.minWage?detail.minWage:fundBase;
    fundBase=fundBase>detail.insuranceMax?detail.insuranceMax:fundBase;
    //个人部分
    double pension=detail.pPensionPercent>0?detail.pPensionPercent:0;
    pension*=insuranceBase/100;
    double medicare=detail.pMedicarePercent>0?detail.pMedicarePercent:0;
    medicare*=insuranceBase/100;
    medicare+=detail.medicarePlan;
    double unemploymentInsurance=detail.pUnemploymentInsurancePercent>0?detail.pUnemploymentInsurancePercent:0;
    unemploymentInsurance*=insuranceBase/100;
    double fund=detail.pFundPercent>0?detail.pFundPercent:0;
    fund*=insuranceBase/100;
    double threshold=detail.threshold;
    double personalTotal=pension+medicare+unemploymentInsurance+fund;
    double pretaxTotal=salary-personalTotal-threshold;
    pretaxTotal=pretaxTotal<0?0:pretaxTotal;
    double taxx=[TaxCalculator getShuiji:(salary-personalTotal) :threshold];
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
    double firmTotal=pensionFirm+medicareFirm+unemploymentInsuranceFirm+fundFirm+industrialInjuryFirm+maternityInsuranceFirm;
    double firmExpenseTotal=firmTotal+salary;
    
    taxes.salaryForTax=taxx;
    taxes.salaryPreTax=salary;
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

}

@end
