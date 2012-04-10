//
//  EnterpriseTypeController.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EnterpriseTypeController.h"
#import "TaxIncome.h"
#import "TaxManager.h"
#import "EnterpriseTypeTaxes.h"
#import "EnterpriseTypeTaxManager.h"
#import "CommonUI.h"
#import <QuartzCore/QuartzCore.h>

@implementation EnterpriseTypeController
@synthesize txfSalaryPreTax;
@synthesize btnWorkMonth;
@synthesize txfSalaryAfterTax;
@synthesize txfSalaryForTax;
@synthesize txvDes;
@synthesize income;
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
    
    EnterpriseTypeTaxes *taxes=[[EnterpriseTypeTaxes alloc] init];
    taxes.workMonth=12;
    
    manager=[[EnterpriseTypeTaxManager alloc] initWithTaxes:taxes];

    self.txvDes.text=self.income.Description;
    
     self.contentView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"content_bg2.png"]];

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
    [self setTxfSalaryPreTax:nil];
    [self setBtnWorkMonth:nil];
    [self setTxfSalaryAfterTax:nil];
    [self setTxfSalaryForTax:nil];
    [self setTxvDes:nil];
    [self setIncome:nil];
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
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入税前收入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    manager.taxes.salaryPreTax=[txfSalaryPreTax.text doubleValue];
    manager.taxes.workMonth=[btnWorkMonth.titleLabel.text intValue];
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
    
    btnWorkMonth.titleLabel.text=@"12";
    
    [manager clearTaxes];
    

}

- (IBAction)changeWorkMonth:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
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
    if (buttonIndex>11) {
        return;
    }
    NSString *month=[NSString stringWithFormat:@"%d",buttonIndex+1];
    [btnWorkMonth setTitle:month forState:UIControlStateNormal];
    [btnWorkMonth setTitle:month forState:UIControlEventTouchUpInside];
    manager.taxes.workMonth=[month intValue];
}

@end
