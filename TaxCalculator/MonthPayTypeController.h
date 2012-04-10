//
//  MonthPayTypeController.h
//  TaxCalculator
//
//  Created by Change Cdts on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TaxIncome, MonthTypeTaxManager,TaxCity;

@interface MonthPayTypeController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate>{
    MonthTypeTaxManager *manager;
    BOOL isAntiCalculate;
}
@property(strong,nonatomic) TaxCity *city;
@property(strong,nonatomic) NSArray *cities;
@property(strong,nonatomic) TaxIncome *income;


@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryPreTax;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryAfterTax;
@property (strong, nonatomic) IBOutlet UITextField *txfSalaryForTax;
@property (strong, nonatomic) IBOutlet UIButton *btnCity;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)seeDetail:(id)sender;
- (IBAction)changeCity:(id)sender;
- (IBAction)calculateTax:(id)sender;
- (IBAction)antiCalculateTax:(id)sender;
- (IBAction)reset:(id)sender;
-(void)goBack;

@end
