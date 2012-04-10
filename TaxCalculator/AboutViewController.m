//
//  AboutViewController.m
//  TaxCalculator
//
//  Created by Change Cdts on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"
#import <CdtsFramework/ResourceUtility.h>
#import <CdtsFramework/AppConfig.h>
#import "CommonUI.h"

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    subject=[AppConfig GlobalConfig].subject;
    emailBody=[AppConfig GlobalConfig].emailBody;
    smsBody=[AppConfig GlobalConfig].smsBody;
    linkUrl=[AppConfig GlobalConfig].linkUrl;
    appName=[AppConfig GlobalConfig].appName;

    self.title =@"关于我们";
    
    self.tableView.separatorColor=[UIColor clearColor];
    
    
    listOfItems = [[NSMutableArray alloc]  init];
    NSArray * shareArray = [NSArray arrayWithObjects:@"邮件推荐",@"短信推荐", nil];
    NSArray * rateArray = [NSArray arrayWithObjects:@"评价软件", nil];

    [listOfItems addObject:shareArray];
    [listOfItems addObject:rateArray];

    self.navigationItem.leftBarButtonItem=[CommonUI createBackButton:self];    
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([AppConfig GlobalConfig].isFree) {
        self.parentViewController.view.frame = [AppConfig GlobalConfig].contentFrame; 
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)sendEmail {
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));  
    NSString *msg;
	if (mailClass != nil) {   
        //检查邮件功能配置
		if ([mailClass canSendMail]) {
			[self displayMailComposerSheet];
            return;
		}
		else {			 
			msg = @"您使用的设备没有配置邮件帐号";
		}
	}
	else{		
		msg = @"您使用的设备不支持发送邮件";
	}
    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:nil
                                                   message:msg
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    [alert show];
}

- (void)sendSMS {
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    NSString *msg;
	if (messageClass != nil) { 			
		//检查短信功能配置
		if ([messageClass canSendText]) {
			[self displaySMSComposerSheet];
            return;
		}
		else {	
			msg = @"您使用的设备没有短信功能";
            
		}
	}
	else {
		msg= @"您使用的设备不支持发送短信";
	}
    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:nil
                                                   message:msg                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    [alert show];
    
}

- (void)softWareMark{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkUrl]];
}

#pragma mark -
#pragma mark Compose Mail/SMS

//显示发送邮件界面
-(void)displayMailComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:subject];
    
	// 邮件内容
	NSString *body =  [NSString stringWithFormat:emailBody,appName,linkUrl];
	[picker setMessageBody:body isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
}


// 显示发送短信界面 
-(void)displaySMSComposerSheet 
{ 
	MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
	picker.messageComposeDelegate = self;    
    picker.body=[NSString stringWithFormat:smsBody,appName,linkUrl];
   	
	[self presentModalViewController:picker animated:YES];
}
#pragma mark -
#pragma mark Dismiss Mail/SMS view controller

//邮件反馈信息
- (void)mailComposeController:(MFMailComposeViewController*)controller 
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
}


//短信反馈信息
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller 
                 didFinishWithResult:(MessageComposeResult)result {
	
 	[self dismissModalViewControllerAnimated:YES];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [listOfItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *array = [listOfItems objectAtIndex:section];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSArray *array = [listOfItems objectAtIndex:indexPath.section];
    NSString *cellValue = [array objectAtIndex:indexPath.row];   
    cell.textLabel.text = cellValue;    
    [cell.textLabel setFont:[UIFont  fontWithName:@"Georgia"  size:16]];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"section_row_bg.png"]];
    

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [listOfItems objectAtIndex:indexPath.section];
    NSString *selected = [array objectAtIndex :indexPath.row];
    if ([selected isEqualToString:@"短信推荐"]) {
        [self sendSMS];
    }    
    else if([selected isEqualToString:@"邮件推荐"]){
        [self sendEmail];
    }
    else if([selected isEqualToString:@"评价软件"]){
        [self softWareMark];
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    header.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    UIImageView *headerImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:section==0?@"section_title_bg.png":@"section_title_bg2.png"]];
    headerImage.center=CGPointMake(160, 26);
    [header addSubview:headerImage];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label.text=section==0?@"朋友分享": @"软件评价";
    [label setTextAlignment:UITextAlignmentCenter];
    label.center=CGPointMake(160, 23);
    label.textColor=[UIColor colorWithWhite:1 alpha:1];
    label.backgroundColor=[UIColor clearColor];
    [label setFont:[UIFont fontWithName:@"Georgia-Bold" size:15]];
    [header addSubview:label];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

@end
