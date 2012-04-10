//
//  CommonUI.h
//  TaxCalculator
//
//  Created by Change Cdts on 12-3-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



#import <Foundation/Foundation.h>

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 \
green:((float)((rgbValue&0x00FF00)>>8))/255.0 \
blue:((float)(rgbValue&0x0000FF))/255.0 alpha:1.0]


@interface CommonUI : NSObject

+(UIBarButtonItem *)createBackButton:(UIViewController *)viewController;
+(void)goBack;

@end
