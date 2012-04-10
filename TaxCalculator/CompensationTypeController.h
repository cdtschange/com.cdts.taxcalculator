//
//  CompensationTypeController.h
//  TaxCalculator
//
//  Created by Change Cdts on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaxIncome, CompensationTypeTaxManager,TaxCity;

@interface CompensationTypeController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>{
    CompensationTypeTaxManager *manager;
    int sheetID;
}

@property(strong,nonatomic) NSArray *cities;
@property(strong,nonatomic) TaxIncome *income;
@property(strong,nonatomic) TaxCity *city;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *btnCity;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryPreTax;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryYearAve;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryMonth;
@property (strong, nonatomic) IBOutlet UIButton *btnWorkYear;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryForTax;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryAfterTax;
@property (strong, nonatomic) IBOutlet UITextView *txvDes;
- (IBAction)calculateTax:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)changeCity:(id)sender;
- (IBAction)changeWorkYear:(id)sender;
-(void)goBack;

@end
