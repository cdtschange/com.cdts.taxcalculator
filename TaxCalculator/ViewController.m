//
//  ViewController.m
//  TaxCalculator
//
//  Created by Change Cdts on 12-3-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "RootViewController.h"
#import <CdtsFramework/AppConfig.h>
#import <CdtsFramework/ADBanner.h>
#import <CdtsFramework/ADBannerFactory.h>
#import <CdtsFramework/ResourceUtility.h>

@implementation ViewController
@synthesize contentView;
@synthesize adView;
@synthesize rootViewController;
@synthesize navController;
@synthesize config;
@synthesize adBanner;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.config=[AppConfig GlobalConfig];
    
    self.contentView.frame = CGRectMake(0, 0, 320, 460);
    self.adView.frame = CGRectMake(0, 480, 320, 50);

    // Do any additional setup after loading the view, typically from a nib.
    self.rootViewController=[[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    self.navController=[[UINavigationController alloc] initWithRootViewController:self.rootViewController];
    
    if (self.config.isFree) {
        adBanner = [ADBannerFactory createADBanner:@"AdMob" position:UIADBannerBottom root:self.rootViewController isStatic:YES delegate:self defaultImage:[UIImage imageNamed:@"Banner_320x50.png"] adID:self.config.adMobAdUnitID];
        [adBanner createAD];
        [self.adView addSubview:adBanner];
        
        double adHeight=[adBanner getBannerHeight];
        self.contentView.frame = CGRectMake(0, 0, 320, 460-adHeight);
        self.adView.frame = CGRectMake(0, 460-adHeight, 320, adHeight);
    }
    
    [AppConfig GlobalConfig].contentFrame=self.contentView.frame;
    [AppConfig GlobalConfig].adFrame=self.adView.frame;

    self.navController.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    [self.navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"toolbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    self.navController.view.frame=self.contentView.frame;
    [self.contentView addSubview:self.navController.view];
}

- (void)viewDidUnload
{
    [self setContentView:nil];
    [self setAdView:nil];
    [self setRootViewController:nil];
    [self setNavController:nil];
    [self setConfig:nil];
    [self setAdBanner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

@end
