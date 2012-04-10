//
//  AboutViewController.h
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AboutViewController : UITableViewController<MFMailComposeViewControllerDelegate, 
MFMessageComposeViewControllerDelegate, UITableViewDataSource,UITableViewDelegate> {    
    UILabel *feedbackMsg;
    NSMutableArray *listOfItems;
    NSString *subject;
    NSString *emailBody;
    NSString *smsBody;
    NSString *linkUrl;
    NSString *appName;
}

/// <summary>
/// 发送邮件
/// <summary>
- (void)sendEmail;

/// <summary>
/// 发送短信
/// <summary>
- (void)sendSMS;

/// <summary>
/// 软件评分
/// <summary>
- (void)softWareMark ;

/// <summary>
/// 显示发送邮件界面
/// <summary>
-(void)displayMailComposerSheet ;

/// <summary>
/// 显示发送短信界面
/// <summary>
-(void)displaySMSComposerSheet;

-(void)goBack;
@end
