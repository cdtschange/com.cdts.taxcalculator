//
//  YearPayTypeController.h
//  TaxCalculator
//
//  Created by Change Cdts on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaxIncome, YearTypeTaxManager,TaxCity;

@interface YearPayTypeController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>{
    YearTypeTaxManager *manager;
}

@property(strong,nonatomic) NSArray *cities;
@property(strong,nonatomic) TaxIncome *income;
@property(strong,nonatomic) TaxCity *city;
-(void)goBack;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *btnCity;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryPreTax;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryMonthGet;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryOtherBonus;
@property (strong, nonatomic) IBOutlet UILabel *lblMonthTax;
@property (strong, nonatomic) IBOutlet UILabel *lblMonthInsurance;
@property (strong, nonatomic) IBOutlet UILabel *lblLeftYearSalary;
@property (strong, nonatomic) IBOutlet UILabel *lblYearTax;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryForTax;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryAfterTax;
- (IBAction)changeCity:(id)sender;
- (IBAction)calculateTax:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)seeDetail:(id)sender;

@end
