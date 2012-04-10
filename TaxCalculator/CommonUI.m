//
//  CommonUI.m
//  TaxCalculator
//
//  Created by Change Cdts on 12-3-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommonUI.h"

@implementation CommonUI

static NSMutableArray *controllers;

+(UIBarButtonItem *)createBackButton:(UIViewController *)viewController{
    if (!controllers) {
        controllers=[[NSMutableArray alloc]init];
    }
    [controllers addObject:viewController];
    UIButton *btnBack=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 42)];
    [btnBack setImage:[UIImage imageNamed:@"toolbar_back.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(goBack) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *btnBackItem=[[UIBarButtonItem alloc] initWithCustomView:btnBack];
    return btnBackItem;

}

+(void)goBack{
    if (!controllers) {
        return;
    }
    UIViewController *controller=[controllers lastObject];
    if (controller&&[controller respondsToSelector:@selector(goBack)]) {
        [controller performSelector:@selector(goBack)];
        [controllers removeLastObject];
    }
}

@end
