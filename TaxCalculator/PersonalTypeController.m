//
//  PersonalTypeController.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PersonalTypeController.h"
#import "TaxIncome.h"
#import "TaxManager.h"
#import "PersonalTypeTaxes.h"
#import "PersonalTypeTaxManager.h"
#import "CommonUI.h"
#import <QuartzCore/QuartzCore.h>

@implementation PersonalTypeController
@synthesize income;
@synthesize txvDes;
@synthesize contentView;
@synthesize scrollView;
@synthesize txfSalaryPreTax;
@synthesize txfSalaryCost;
@synthesize txfSalaryAfterTax;
@synthesize txfSalaryForTax;

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
    
    PersonalTypeTaxes *taxes=[[PersonalTypeTaxes alloc] init];

    manager=[[PersonalTypeTaxManager alloc] initWithTaxes:taxes];
    
    self.txvDes.text=self.income.Description;
    
    self.contentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"content_bg2.png"]];

    self.navigationItem.leftBarButtonItem=[CommonUI createBackButton:self];
    
    txfSalaryPreTax.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryPreTax.layer.borderWidth=1.0f;
    txfSalaryAfterTax.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryAfterTax.layer.borderWidth=1.0f;
    txfSalaryForTax.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryForTax.layer.borderWidth=1.0f;
    txfSalaryCost.layer.borderColor=[UIColorFromRGB(0xAFA091) CGColor];
    txfSalaryCost.layer.borderWidth=1.0f;

}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [self setIncome:nil];
    [self setTxfSalaryPreTax:nil];
    [self setTxfSalaryCost:nil];
    [self setTxfSalaryAfterTax:nil];
    [self setTxfSalaryForTax:nil];
    [self setTxvDes:nil];
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
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入年度收入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    manager.taxes.salaryPreTax=[txfSalaryPreTax.text doubleValue];
    manager.taxes.salaryCost=[txfSalaryCost.text doubleValue];
    if(manager.taxes.salaryPreTax==0)
        return;
    [txfSalaryPreTax resignFirstResponder];
    [txfSalaryCost resignFirstResponder];
    
    [manager calculate];
    
    txfSalaryAfterTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryAfterTax];
    txfSalaryForTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryForTax];
}

- (IBAction)reset:(id)sender {
    txfSalaryPreTax.text=@"";
    txfSalaryAfterTax.text=@"";
    txfSalaryForTax.text=@"";
    txfSalaryCost.text=@"";
    
    [manager clearTaxes];
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

@end
