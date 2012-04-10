//
//  CompensationTypeController.m
//  TaxCalculator
//
//  Created by Change Cdts on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CompensationTypeController.h"
#import "TaxIncome.h"
#import "TaxManager.h"
#import "TaxCity.h"
#import "CompensationTypeTaxes.h"
#import "CompensationTypeTaxManager.h"
#import "CommonUI.h"
#import <QuartzCore/QuartzCore.h>

@implementation CompensationTypeController

@synthesize btnCity;
@synthesize txfSalaryPreTax;
@synthesize txfSalaryYearAve;
@synthesize txfSalaryMonth;
@synthesize btnWorkYear;
@synthesize txfSalaryForTax;
@synthesize txfSalaryAfterTax;
@synthesize txvDes;
@synthesize cities;
@synthesize income;
@synthesize city;
@synthesize contentView;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=income.Name;
    
    self.scrollView.contentSize=self.scrollView.frame.size;
    
    CompensationTypeTaxes *taxes=[[CompensationTypeTaxes alloc] init];
    taxes.workYear=12;
    
    manager=[[CompensationTypeTaxManager alloc] initWithTaxes:taxes];
    
    self.city=[self.cities objectAtIndex:0];

    self.txvDes.text=self.income.Description;
    self.txfSalaryYearAve.text=[NSString stringWithFormat:@"%0.2f", self.city.InsuranceMax*12/3 ];
    manager.taxes.salaryYearAve=self.city.InsuranceMax*12/3;
    
    self.contentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"content_bg1.png"]];

    self.navigationItem.leftBarButtonItem=[CommonUI createBackButton:self];
    
    txfSalaryPreTax.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryPreTax.layer.borderWidth=1.0f;
    txfSalaryAfterTax.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryAfterTax.layer.borderWidth=1.0f;
    txfSalaryForTax.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryForTax.layer.borderWidth=1.0f;
    txfSalaryMonth.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryMonth.layer.borderWidth=1.0f;
    txfSalaryYearAve.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryYearAve.layer.borderWidth=1.0f;

}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [self setBtnCity:nil];
    [self setTxfSalaryPreTax:nil];
    [self setBtnCity:nil];
    [self setTxfSalaryPreTax:nil];
    [self setTxfSalaryYearAve:nil];
    [self setTxfSalaryMonth:nil];
    [self setBtnWorkYear:nil];
    [self setTxfSalaryForTax:nil];
    [self setTxfSalaryAfterTax:nil];
    [self setTxvDes:nil];
    [self setIncome:nil];
    [self setCities:nil];
    [self setCity:nil];
    [self setContentView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)calculateTax:(id)sender {
    if (txfSalaryPreTax.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入税前补偿金！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    manager.taxes.salaryPreTax=[txfSalaryPreTax.text doubleValue];
    manager.taxes.salaryYearAve=[txfSalaryYearAve.text doubleValue];
    manager.taxes.salaryMonth=[txfSalaryMonth.text doubleValue];
    manager.taxes.workYear=[btnWorkYear.titleLabel.text intValue];
    if(manager.taxes.salaryPreTax==0)
        return;
    [txfSalaryPreTax resignFirstResponder];
    [txfSalaryYearAve resignFirstResponder];
    [txfSalaryMonth resignFirstResponder];
    
    [manager calculate];
    
    txfSalaryAfterTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryAfterTax];
    txfSalaryForTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryForTax];
}

- (IBAction)reset:(id)sender {
    txfSalaryPreTax.text=@"";
    txfSalaryAfterTax.text=@"";
    txfSalaryForTax.text=@"";
    
    txfSalaryYearAve.text=@"";
    txfSalaryMonth.text=@"";
    btnWorkYear.titleLabel.text=@"12";
    
    txfSalaryYearAve.text=[NSString stringWithFormat:@"%0.2f", self.city.InsuranceMax*12/3 ];
    manager.taxes.salaryYearAve=self.city.InsuranceMax*12/3;
    
    [manager clearTaxes];

}

- (IBAction)changeCity:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    for (int i=0; i<self.cities.count; i++) {
        [sheet addButtonWithTitle:[[self.cities objectAtIndex:i] Name]];
    }
    [sheet addButtonWithTitle:@"取消"];
    sheet.cancelButtonIndex=self.cities.count;
    sheetID=0;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (IBAction)changeWorkYear:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
    sheetID=1;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(string&&string.length==0){
        return YES;
    }
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[0-9]"];
    if([pre evaluateWithObject:string]||[string characterAtIndex:0]=='.'){
        return YES;
    }    
    return NO;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (sheetID==0) {
        if (buttonIndex>=self.cities.count) {
            return;
        }
        TaxCity *tCity=[self.cities objectAtIndex:buttonIndex];
        if (tCity==self.city) {
            return;
        }
        self.city=tCity;
        
        NSString *title=[NSString stringWithFormat: @"切换城市：%@ ",self.city.Name];
        
        [btnCity setTitle:title forState:UIControlStateNormal];
        [btnCity setTitle:title forState:UIControlEventTouchUpInside];
        
        [self reset:nil];
        self.txfSalaryYearAve.text=[NSString stringWithFormat:@"%0.2f", self.city.InsuranceMax*12/3 ];
        manager.taxes.salaryYearAve=self.city.InsuranceMax*12/3;
        
    } else if(sheetID==1){
        if (buttonIndex>11) {
            return;
        }
        NSString *year=[NSString stringWithFormat:@"%d",buttonIndex+1];
        [btnWorkYear setTitle:year forState:UIControlStateNormal];
        [btnWorkYear setTitle:year forState:UIControlEventTouchUpInside];
        manager.taxes.workYear=[year intValue];
    }
}



@end
