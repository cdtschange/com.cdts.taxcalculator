//
//  YearPayTypeController.m
//  TaxCalculator
//
//  Created by Change Cdts on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "YearPayTypeController.h"
#import "DetailTableViewController.h"
#import "TaxIncome.h"
#import "TaxCity.h"
#import "TaxManager.h"
#import "YearTypeTaxes.h"
#import "YearTypeTaxManager.h"
#import "CommonUI.h"
#import <QuartzCore/QuartzCore.h>

@implementation YearPayTypeController
@synthesize contentView;
@synthesize scrollView;
@synthesize btnCity;
@synthesize txfSalaryPreTax;
@synthesize txfSalaryMonthGet;
@synthesize txfSalaryOtherBonus;
@synthesize lblMonthTax;
@synthesize lblMonthInsurance;
@synthesize lblLeftYearSalary;
@synthesize lblYearTax;
@synthesize txfSalaryForTax;
@synthesize txfSalaryAfterTax;
@synthesize cities;
@synthesize income;
@synthesize city;

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

-(void)viewDidAppear:(BOOL)animated{
    if (manager&&manager.taxes) {
        if (manager.taxes.salaryPreTax>0) {
            txfSalaryPreTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryPreTax];
            
            lblMonthTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.dmonthTax];
            lblMonthInsurance.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.dmonthInsurance];
            lblLeftYearSalary.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.dleftYearSalary];
            lblYearTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.dyearTax];

        }
        if (manager.taxes.salaryAfterTax>0) {
            txfSalaryAfterTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryAfterTax];
        }
        if (manager.taxes.salaryForTax>0) {
            txfSalaryForTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryForTax];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=income.Name;
    
    self.scrollView.contentSize=self.scrollView.frame.size;
    
    YearTypeTaxes *taxes=[[YearTypeTaxes alloc] init];
    
    manager=[[YearTypeTaxManager alloc] initWithTaxes:taxes];

    self.city=[self.cities objectAtIndex:0];
    [manager copyToDetail:self.city];
    self.contentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"content_bg1.png"]];

    self.navigationItem.leftBarButtonItem=[CommonUI createBackButton:self];
    
    txfSalaryPreTax.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryPreTax.layer.borderWidth=1.0f;
    txfSalaryAfterTax.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryAfterTax.layer.borderWidth=1.0f;
    txfSalaryForTax.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryForTax.layer.borderWidth=1.0f;
    txfSalaryOtherBonus.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryOtherBonus.layer.borderWidth=1.0f;
    txfSalaryMonthGet.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryMonthGet.layer.borderWidth=1.0f;
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidUnload
{
    [self setBtnCity:nil];
    [self setTxfSalaryPreTax:nil];
    [self setTxfSalaryMonthGet:nil];
    [self setTxfSalaryOtherBonus:nil];
    [self setLblMonthTax:nil];
    [self setLblMonthInsurance:nil];
    [self setLblLeftYearSalary:nil];
    [self setLblYearTax:nil];
    [self setTxfSalaryForTax:nil];
    [self setTxfSalaryAfterTax:nil];
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

- (IBAction)changeCity:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    for (int i=0; i<self.cities.count; i++) {
        [sheet addButtonWithTitle:[[self.cities objectAtIndex:i] Name]];
    }
    [sheet addButtonWithTitle:@"取消"];
    sheet.cancelButtonIndex=self.cities.count;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (IBAction)calculateTax:(id)sender {
    if (txfSalaryPreTax.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入年薪！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if (txfSalaryMonthGet.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入每月领取！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }

    manager.taxes.salaryPreTax=[txfSalaryPreTax.text doubleValue];
    manager.taxes.salaryMonthGet=[txfSalaryMonthGet.text doubleValue];
    manager.taxes.salaryOtherBonus=[txfSalaryOtherBonus.text doubleValue];
    if(manager.taxes.salaryPreTax==0)
        return;
    [txfSalaryPreTax resignFirstResponder];
    [txfSalaryMonthGet resignFirstResponder];
    [txfSalaryOtherBonus resignFirstResponder];
    
    [manager calculate];
    
    txfSalaryAfterTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryAfterTax];
    txfSalaryForTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryForTax];
    
    lblMonthTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.dmonthTax];
    lblMonthInsurance.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.dmonthInsurance];
    lblLeftYearSalary.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.dleftYearSalary];
    lblYearTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.dyearTax];
}

- (IBAction)reset:(id)sender {
    txfSalaryPreTax.text=@"";
    txfSalaryAfterTax.text=@"";
    txfSalaryForTax.text=@"";
    
    txfSalaryMonthGet.text=@"";
    txfSalaryOtherBonus.text=@"";
    lblMonthTax.text=@"";
    lblMonthInsurance.text=@"";
    lblLeftYearSalary.text=@"";
    lblYearTax.text=@"";
    
    [manager clearTaxes];
    [manager copyToDetail:self.city];
    
}

- (IBAction)seeDetail:(id)sender {
    DetailTableViewController *controller=[[DetailTableViewController alloc] initWithNibName:@"DetailTableViewController" bundle:nil];
    
    controller.dict = [manager getDetail];
    controller.delegate=manager;
    controller.isAntiCalculate=NO;
    [self.navigationController pushViewController:controller animated:YES];
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

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    double offset=0;

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect=self.view.frame;
    rect.origin.y-=offset;
    self.view.frame = rect;
    [UIView commitAnimations];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect=self.view.frame;
    rect.origin.y=0;
    self.view.frame = rect;
    [UIView commitAnimations];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
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
}


@end
