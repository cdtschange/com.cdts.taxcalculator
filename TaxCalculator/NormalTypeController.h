//
//  NormalTypeController.h
//  TaxCalculator
//
//  Created by Change Cdts on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaxIncome, NormalTypeTaxManager;

@interface NormalTypeController : UIViewController<UITextFieldDelegate>{
    NormalTypeTaxManager *manager;
}
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextView *txvDes;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryPreTax;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryAfterTax;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryForTax;
@property(strong,nonatomic) TaxIncome *income;
- (IBAction)calculateTax:(id)sender;
- (IBAction)reset:(id)sender;
-(void)goBack;

@end
