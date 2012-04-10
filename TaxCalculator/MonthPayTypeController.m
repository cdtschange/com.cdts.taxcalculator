//
//  MonthPayTypeController.m
//  TaxCalculator
//
//  Created by Change Cdts on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MonthPayTypeController.h"
#import "DetailTableViewController.h"
#import "TaxIncome.h"
#import "TaxCity.h"
#import "TaxManager.h"
#import "MonthTypeTaxes.h"
#import "MonthTypeTaxManager.h"
#import "CommonUI.h"
#import <QuartzCore/QuartzCore.h>

@implementation MonthPayTypeController

@synthesize city;
@synthesize cities;
@synthesize income;
@synthesize contentView;

@synthesize txfSalaryAfterTax;
@synthesize txfSalaryPreTax;
@synthesize txfSalaryForTax;
@synthesize btnCity;
@synthesize scrollView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    if (manager&&manager.taxes) {
        if (manager.taxes.salaryPreTax>0) {
            txfSalaryPreTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryPreTax];
        }
        if (manager.taxes.salaryAfterTax>0) {
            txfSalaryAfterTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryAfterTax];
        }
        if (manager.taxes.salaryForTax>0) {
            txfSalaryForTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryForTax];
        }
    }
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
    
    MonthTypeTaxes *taxes=[[MonthTypeTaxes alloc] init];
    
    manager=[[MonthTypeTaxManager alloc] initWithTaxes:taxes];
    
    self.contentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"content_bg.png"]];

    isAntiCalculate=NO;
    self.city=[self.cities objectAtIndex:0];
    [manager copyToDetail:self.city];
    
    self.navigationItem.leftBarButtonItem=[CommonUI createBackButton:self];  
    
    txfSalaryPreTax.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryPreTax.layer.borderWidth=1.0f;
    txfSalaryAfterTax.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryAfterTax.layer.borderWidth=1.0f;
    txfSalaryForTax.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryForTax.layer.borderWidth=1.0f;
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [self setCity:nil];
    [self setCities:nil];
    [self setIncome:nil];

    [self setTxfSalaryPreTax:nil];
    [self setTxfSalaryAfterTax:nil];
    [self setTxfSalaryForTax:nil];
    [self setBtnCity:nil];

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

- (IBAction)seeDetail:(id)sender {
    DetailTableViewController *controller=[[DetailTableViewController alloc] initWithNibName:@"DetailTableViewController" bundle:nil];
    
    controller.dict = [manager getDetail];
    controller.delegate=manager;
    controller.isAntiCalculate=isAntiCalculate;
    [self.navigationController pushViewController:controller animated:YES];
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
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入税前收入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    manager.taxes.salaryPreTax=[txfSalaryPreTax.text doubleValue];
    if(manager.taxes.salaryPreTax==0)
        return;
    [txfSalaryPreTax resignFirstResponder];
    [txfSalaryAfterTax resignFirstResponder];
    
    [manager calculate];
    
    txfSalaryAfterTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryAfterTax];
    txfSalaryForTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryForTax];

    isAntiCalculate=NO;
}



- (IBAction)antiCalculateTax:(id)sender {
    if (txfSalaryAfterTax.text.length==0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入税后收入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    manager.taxes.salaryAfterTax=[txfSalaryAfterTax.text doubleValue];
    if(manager.taxes.salaryAfterTax==0)
        return;
    [txfSalaryPreTax resignFirstResponder];
    [txfSalaryAfterTax resignFirstResponder];
    
    [manager antiCalculate];
    
    txfSalaryPreTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryPreTax];
    txfSalaryForTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryForTax];
    
    isAntiCalculate=YES;
}

- (IBAction)reset:(id)sender {
    isAntiCalculate=NO;
    txfSalaryPreTax.text=@"";
    txfSalaryAfterTax.text=@"";
    txfSalaryForTax.text=@"";
    
    [manager clearTaxes];
    [manager copyToDetail:self.city];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField==self.txfSalaryPreTax) {
        [self calculateTax:textField];
    }else if (textField==self.txfSalaryAfterTax) {
        [self antiCalculateTax:textField];
    }
    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==self.txfSalaryPreTax) {
        self.txfSalaryAfterTax.text=@"";
        self.txfSalaryForTax.text=@"";
    }else if (textField==self.txfSalaryAfterTax) {
        self.txfSalaryPreTax.text=@"";
        self.txfSalaryForTax.text=@"";
    }
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
    if (textField==self.txfSalaryPreTax) {
        offset=0;
    }else if(textField==self.txfSalaryAfterTax){
        offset=20;
    }
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
