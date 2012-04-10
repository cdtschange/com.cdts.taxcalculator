//
//  PersonalTypeController.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaxIncome, PersonalTypeTaxManager;

@interface PersonalTypeController : UIViewController<UITextFieldDelegate>{
    PersonalTypeTaxManager *manager;
}

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryPreTax;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryCost;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryAfterTax;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryForTax;
@property (strong, nonatomic) IBOutlet UITextView *txvDes;
@property(strong,nonatomic) TaxIncome *income;
- (IBAction)calculateTax:(id)sender;
- (IBAction)reset:(id)sender;
-(void)goBack;


@end
