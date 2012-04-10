//
//  TaxCalculator.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TaxCalculator.h"
#import "TaxesDetail.h"

@implementation TaxCalculator


+(double)getSalary:(double)afterSalary :(TaxesDetail *)detail :(double)percentInsurance :(double)percentFund :(double)insuranceMax :(double)fundMax{
    double thisInsurance=0;
    double thisFund=0;
    double insuranceBase=0;
    double fundBase=0;
    double salary=0;
    
    if (afterSalary<detail.threshold) {
        insuranceBase=(afterSalary+detail.medicarePlan)/(1-(percentInsurance+percentFund));
        fundBase=insuranceBase;
        insuranceBase=insuranceBase<detail.insuranceMin?detail.insuranceMin:insuranceBase;
        insuranceBase=insuranceBase>detail.insuranceMax?detail.insuranceMax:insuranceBase;
        fundBase=fundBase<detail.minWage?detail.minWage:fundBase;
        fundBase=fundBase>detail.insuranceMax?detail.insuranceMax:fundBase;
        
        thisInsurance=insuranceBase*percentInsurance+detail.medicarePlan;
        thisFund=fundBase*percentFund;
        salary=afterSalary+thisInsurance+thisFund;
        if (salary>insuranceBase) {
            insuranceBase=salary;
        }
        if (salary>fundBase) {
            fundBase=salary;
        }
        thisInsurance=insuranceBase*percentInsurance+detail.medicarePlan;
        thisFund=fundBase*percentFund;
        salary=afterSalary+thisInsurance+thisFund;
    }else{
        double percent=percentInsurance+percentFund;
        
        NSArray *array1=[NSArray arrayWithObjects:@"0",@"105",@"555",@"1005",@"2755",@"5505",@"13505", nil];
        NSArray *array2=[NSArray arrayWithObjects:@"0.03",@"0.1",@"0.2",@"0.25",@"0.3",@"0.35",@"0.45", nil];
        NSArray *array3=[NSArray arrayWithObjects:@"-1",@"1500",@"4500",@"9000",@"35000",@"55000",@"80000", nil];
        NSArray *array4=[NSArray arrayWithObjects:@"1500",@"4500",@"9000",@"35000",@"55000",@"80000",[NSNumber numberWithDouble:DBL_MAX], nil];
        
        int count=0;
        while (count<array1.count) {
            double value1=[[array1 objectAtIndex:count] doubleValue];
            double value2=[[array2 objectAtIndex:count] doubleValue];
            double value3=[[array3 objectAtIndex:count] doubleValue];
            double value4=[[array4 objectAtIndex:count] doubleValue];
            salary=(afterSalary-value1-(detail.threshold*value2)+(1-value2)*detail.medicarePlan)/(1-percent-value2+percent*value2);
            insuranceBase=salary<detail.insuranceMax?salary:detail.insuranceMax>0?detail.insuranceMax:salary;
            insuranceBase=insuranceBase<detail.insuranceMin?detail.insuranceMin:insuranceBase;
            insuranceBase=insuranceBase>detail.insuranceMax?detail.insuranceMax:insuranceBase;
            fundBase=salary<detail.insuranceMax?salary:detail.insuranceMax>0?detail.insuranceMax:salary;
            fundBase=fundBase<detail.minWage?detail.minWage:fundBase;
            fundBase=fundBase>detail.insuranceMax?detail.insuranceMax:fundBase;
            thisInsurance=insuranceBase*percentInsurance+detail.medicarePlan;
            thisFund=fundBase*percentFund;
            if (insuranceBase!=salary||fundBase!=salary) {
                salary=(afterSalary-value1-detail.threshold*value2+(thisInsurance+thisFund)*(1-value2))/(1-value2);
            }
            double thisAfterTax=salary-(thisInsurance+thisFund)-((salary-(thisInsurance+thisFund)-detail.threshold)*value2-value1);
            if(ceil(afterSalary)==ceil(thisAfterTax)&&(salary-(thisInsurance+thisFund)-detail.threshold)>value3&&(salary-(thisInsurance+thisFund)-detail.threshold)<=value4){
                break;
            }
            count++;
        }
    }
    return salary;
}

+(double) getShuiji:(double) salario: (double)threshold{
    if(salario<threshold)
        return 0;
    else{
        double salarioV=salario-threshold;
        if (salarioV<=1500) {
            return salarioV*0.03;
        }else if (salarioV<=4500) {
            return salarioV*0.1-105;
        }else if (salarioV<=9000) {
            return salarioV*0.2-555;
        }else if (salarioV<=35000) {
            return salarioV*0.25-1005;
        }else if (salarioV<=55000) {
            return salarioV*0.3-2755;
        }else if (salarioV<=80000) {
            return salarioV*0.35-5505;
        }else {
            return salarioV*0.45-13505;
        }
    }
}

+(double) getShuijiNian:(double) salario{
    double salarioV=salario/12;
    if (salarioV<=1500) {
        return salario*0.03;
    }else if (salarioV<=4500) {
        return salario*0.1-105;
    }else if (salarioV<=9000) {
        return salario*0.2-555;
    }else if (salarioV<=35000) {
        return salario*0.25-1005;
    }else if (salarioV<=55000) {
        return salario*0.3-2755;
    }else if (salarioV<=80000) {
        return salario*0.35-5505;
    }else {
        return salario*0.45-13505;
    }  
}


@end
