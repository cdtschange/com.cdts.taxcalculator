//
//  DetailTableViewController.h
//  TaxCalculator
//
//  Created by Change Cdts on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaxManager.h"

#define UIColorFromRGB(rgbValue) [UIColor \
    colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 \
    green:((float)((rgbValue&0x00FF00)>>8))/255.0 \
    blue:((float)(rgbValue&0x0000FF))/255.0 alpha:1.0]

@interface DetailTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    NSMutableArray *listOfItems;
    NSMutableArray *listOfValues;
    NSMutableArray *listOfFields;
    NSArray *headerArray;
}

@property(strong,nonatomic) NSMutableDictionary *dict;
@property(assign,nonatomic) BOOL isAntiCalculate;
@property(strong,nonatomic) id<TaxesAction> delegate;

-(void)goBack;

@end
