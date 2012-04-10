//
//  NormalTypeTaxStrategy.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NormalTypeTaxStrategy.h"
#import "TaxStrategy.h"
#import "NormalTypeTaxes.h"

@implementation NormalTypeTaxStrategy

+(void)calculate:(NormalTypeTaxes *)taxes{
    double resultTax=0;
    double salario=taxes.salaryPreTax;
    
    if ([taxes.normalType isEqualToString:@"年终奖"]) {
        double salarioV=salario/12;
        if (salarioV<=1500) {
            resultTax=(salario*0.03);
        }else if (salarioV<=4500) {
            resultTax=(salario*0.1-105);
        }else if (salarioV<=9000) {
            resultTax=(salario*0.2-555);
        }else if (salarioV<=35000) {
            resultTax=(salario*0.25-1005);
        }else if (salarioV<=55000) {
            resultTax=(salario*0.3-2755);
        }else if (salarioV<=80000) {
            resultTax=(salario*0.35-5505);
        }else{
            resultTax=(salario*0.45-13505);
        }
    }else if ([taxes.normalType isEqualToString:@"劳务报酬所得"]) {
        if(salario<4000){
            resultTax=(salario-800)*0.2;
            resultTax=resultTax<0?0:resultTax;
        }else{
            double extra=0;
            if (salario*0.8<20000) {
                extra=0;
            }else if(salario*0.8<50000){
                extra=(salario*0.8-20000)*0.2*0.5;
            }else{
                extra=(50000-20000)*0.2*0.5+(salario*0.8-50000)*0.2;
            }
            resultTax=salario*(1-0.2)*0.2+extra;
        }
    }else if ([taxes.normalType isEqualToString:@"特许权使用费所得"]||[taxes.normalType isEqualToString:@"财产租赁所得"]) {
        if(salario<4000){
            resultTax=(salario-800)*0.2;
            resultTax=resultTax<0?0:resultTax;
        }else{
            resultTax=salario*(1-0.2)*0.2;
        }
    }else if ([taxes.normalType isEqualToString:@"稿酬所得"]) {
        if(salario<=4000){
            resultTax=(salario-800)*0.2*(1-0.3);
            resultTax=resultTax<0?0:resultTax;
        }else{
            resultTax=salario*(1-0.2)*0.2*(1-0.3);
        }
    }else if ([taxes.normalType isEqualToString:@"财产转让所得"]||[taxes.normalType isEqualToString:@"利息、股息、红利所得"]||[taxes.normalType isEqualToString:@"偶然所得"]) {
        resultTax=salario*0.2;
    }
    
    
    taxes.salaryForTax=resultTax;
    taxes.salaryAfterTax=taxes.salaryPreTax-taxes.salaryForTax;
}

@end
