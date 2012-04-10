//
//  TaxCity.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaxCity : NSObject

@property(assign,nonatomic) int ID;
@property(strong,nonatomic) NSString *Name;
@property(assign,nonatomic) double InsuranceMax;
@property(assign,nonatomic) double FundMax;
@property(assign,nonatomic) double Pension;
@property(assign,nonatomic) double Medicare;
@property(assign,nonatomic) double UnemploymentInsurance;
@property(assign,nonatomic) double Fund;
@property(assign,nonatomic) double Threshold;
@property(assign,nonatomic) double PensionFirm;
@property(assign,nonatomic) double MedicareFirm;
@property(assign,nonatomic) double UnemploymentInsuranceFirm;
@property(assign,nonatomic) double FundFirm;
@property(assign,nonatomic) double IndustrialInjuryFirm;
@property(assign,nonatomic) double MaternityInsuranceFirm;
@property(assign,nonatomic) double MinWage;
@property(assign,nonatomic) double MedicarePlan;
@property(assign,nonatomic) double InsuranceMin;
@end
