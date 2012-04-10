//
//  EnterpriseTypeController.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaxIncome, EnterpriseTypeTaxManager;

@interface EnterpriseTypeController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>{
    EnterpriseTypeTaxManager *manager;
}

@property(strong,nonatomic) TaxIncome *income;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryPreTax;
@property (strong, nonatomic) IBOutlet UIButton *btnWorkMonth;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryAfterTax;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryForTax;
@property (strong, nonatomic) IBOutlet UITextView *txvDes;
- (IBAction)calculateTax:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)changeWorkMonth:(id)sender;
-(void)goBack;

@end
