//
//  RootViewController.h
//  TaxCalculator
//
//  Created by Change Cdts on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tax, TaxService;

@interface RootViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>{
    NSArray *typeList;
    NSDictionary *source;
    TaxService *taxService;
}

@property(strong,nonatomic) Tax *tax;

-(void)gotoAbout;

@end
