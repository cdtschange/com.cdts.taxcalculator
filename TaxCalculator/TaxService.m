//
//  TaxService.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TaxService.h"
#import "Tax.h"
#import "TaxCity.h"
#import "TaxIncome.h"
#import <CdtsFramework/SQLiteHelper.h>
#import <CdtsFramework/AppConfig.h>

@implementation TaxService

-(id)init{
    if ((self = [super init])) {
        sqliteHelper=[[SQLiteHelper alloc] initWithDBFilename:[AppConfig GlobalConfig].databaseName andTableName:@"City"];
    }
    return self;
}

-(void)fillTaxCity:(Tax *)tax{
    sqliteHelper.tableName=@"City";
    NSArray *array=[sqliteHelper getRows:@""];
    tax.Cities=[[NSMutableArray alloc] init];
    for (int i=0; i<array.count; i++) {
        NSDictionary *dict=[array objectAtIndex:i];
        TaxCity *city=[[TaxCity alloc] init];
        city.ID=[[dict objectForKey:@"ID"] intValue];
        city.Name=[dict objectForKey:@"Name"];
        city.InsuranceMax=[[dict objectForKey:@"InsuranceMax"] doubleValue];
        city.FundMax=[[dict objectForKey:@"FundMax"] doubleValue];
        city.Pension=[[dict objectForKey:@"Pension"] doubleValue];
        city.Medicare=[[dict objectForKey:@"Medicare"] doubleValue];
        city.UnemploymentInsurance=[[dict objectForKey:@"UnemploymentInsurance"] doubleValue];
        city.Fund=[[dict objectForKey:@"Fund"] doubleValue];
        city.Threshold=[[dict objectForKey:@"Threshold"] doubleValue];
        city.PensionFirm=[[dict objectForKey:@"PensionFirm"] doubleValue];
        city.MedicareFirm=[[dict objectForKey:@"MedicareFirm"] doubleValue];
        city.UnemploymentInsuranceFirm=[[dict objectForKey:@"UnemploymentInsuranceFirm"] doubleValue];
        city.FundFirm=[[dict objectForKey:@"FundFirm"] doubleValue];
        city.IndustrialInjuryFirm=[[dict objectForKey:@"IndustrialInjuryFirm"] doubleValue];
        city.MaternityInsuranceFirm=[[dict objectForKey:@"MaternityInsuranceFirm"] doubleValue];
        city.MinWage=[[dict objectForKey:@"MinWage"] doubleValue];
        city.MedicarePlan=[[dict objectForKey:@"MedicarePlan"] doubleValue];
        city.InsuranceMin=[[dict objectForKey:@"InsuranceMin"] doubleValue];
        [tax.Cities addObject:city];
    }
}

-(void)fillTaxIncome:(Tax *)tax{
    sqliteHelper.tableName=@"Income";
    NSArray *array=[sqliteHelper getRows:@""];
    tax.Incomes=[[NSMutableArray alloc] init];
    for (int i=0; i<array.count; i++) {
        NSDictionary *dict=[array objectAtIndex:i];
        TaxIncome *income=[[TaxIncome alloc] init];
        income.ID=[[dict objectForKey:@"ID"] intValue];
        income.Name=[dict objectForKey:@"Name"];
        income.Type=[[dict objectForKey:@"Type"] intValue];
        income.Description=[dict objectForKey:@"Description"];
        income.IsBaseType=[[dict objectForKey:@"IsBaseType"] intValue];
        [tax.Incomes addObject:income];
    }
}


@end
