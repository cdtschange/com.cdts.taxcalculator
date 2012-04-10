//
//  ViewController.h
//  TaxCalculator
//
//  Created by Change Cdts on 12-3-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController,AppConfig,ADBanner;

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *adView;

@property (strong, nonatomic) RootViewController *rootViewController;
@property(strong,nonatomic) UINavigationController *navController;
@property(strong,nonatomic) AppConfig *config;
@property(strong,nonatomic) ADBanner *adBanner;

@end
