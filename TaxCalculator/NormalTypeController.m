//
//  NormalTypeController.m
//  TaxCalculator
//
//  Created by Change Cdts on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NormalTypeController.h"
#import "TaxIncome.h"
#import "TaxManager.h"
#import "NormalTypeTaxes.h"
#import "NormalTypeTaxManager.h"
#import "CommonUI.h"
#import <QuartzCore/QuartzCore.h>

@implementation NormalTypeController
@synthesize income;
@synthesize contentView;
@synthesize scrollView;
@synthesize txvDes;
@synthesize txfSalaryPreTax;
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
    
    self.title=income.Name;
    
    self.scrollView.contentSize=self.scrollView.frame.size;
    
    NormalTypeTaxes *taxes=[[NormalTypeTaxes alloc] init];
    taxes.normalType=income.Name;
    
    manager=[[NormalTypeTaxManager alloc] initWithTaxes:taxes];

    self.txvDes.text=self.income.Description;
    
    self.contentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"content_bg3.png"]];

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
    [self setTxvDes:nil];
    [self setIncome:nil];
    [self setTxfSalaryPreTax:nil];
    [self setTxfSalaryAfterTax:nil];
    [self setTxfSalaryForTax:nil];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self calculateTax:textField];
    return YES;
}

- (IBAction)calculateTax:(id)sender {
    manager.taxes.salaryPreTax=[txfSalaryPreTax.text doubleValue];
    if(manager.taxes.salaryPreTax==0)
        return;
    [txfSalaryPreTax resignFirstResponder];
    
    [manager calculate];
    
    txfSalaryAfterTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryAfterTax];
    txfSalaryForTax.text=[NSString stringWithFormat:@"%0.2f",manager.taxes.salaryForTax];
}

- (IBAction)reset:(id)sender {
    txfSalaryPreTax.text=@"";
    txfSalaryAfterTax.text=@"";
    txfSalaryForTax.text=@"";
    
    [manager clearTaxes];
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
