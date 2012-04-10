//
//  RootViewController.m
//  TaxCalculator
//
//  Created by Change Cdts on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "NormalTypeController.h"
#import "MonthPayTypeController.h"
#import "YearPayTypeController.h"
#import "CompensationTypeController.h"
#import "PersonalTypeController.h"
#import "EnterpriseTypeController.h"
#import "AboutViewController.h"
#import "Tax.h"
#import "TaxIncome.h"
#import "TaxCity.h"
#import "TaxService.h"

@implementation RootViewController
@synthesize tax;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    self.title=@"个税计算器";
    
    self.tableView.separatorColor=[UIColor clearColor];
    
    self.tax=[[Tax alloc]init];
    taxService=[[TaxService alloc] init];
      
    [taxService fillTaxCity:self.tax];
    [taxService fillTaxIncome:self.tax];
    typeList=self.tax.Incomes;
    

    UIButton *btnAbout=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 42)];
    [btnAbout setImage:[UIImage imageNamed:@"toolbar_about.png"] forState:UIControlStateNormal];
    [btnAbout addTarget:self action:@selector(gotoAbout) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *btnAboutItem=[[UIBarButtonItem alloc] initWithCustomView:btnAbout];
    self.navigationItem.rightBarButtonItem=btnAboutItem;
}
-(void)gotoAbout{
    AboutViewController *controller= [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.tax=nil;
    
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"(IsBaseType==%d)",1];
    NSArray *baseArray=[typeList filteredArrayUsingPredicate:pre];
    if(section==0){
        
        return baseArray.count ;
    }
    return typeList.count-baseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"(IsBaseType==%d)",1];
    NSArray *baseArray=[typeList filteredArrayUsingPredicate:pre];
    
    TaxIncome *income=[typeList objectAtIndex:indexPath.row+baseArray.count*indexPath.section];
    NSString *str=income.Name;
    cell.textLabel.text=str;
    [cell.textLabel setFont:[UIFont fontWithName:@"Georgia"  size:16]];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"(IsBaseType==%d)",1];
    NSArray *baseArray=[typeList filteredArrayUsingPredicate:pre];
    TaxIncome *income=[typeList objectAtIndex:indexPath.row+baseArray.count*indexPath.section];
    NSInteger style=income.Type;
    if(style==0){
        NormalTypeController *controller= [[NormalTypeController alloc] initWithNibName:@"NormalTypeController" bundle:nil];
        controller.title=income.Name;
        controller.income=income;
        
        [self.navigationController pushViewController:controller animated:YES];
    }else if(style==1){
        MonthPayTypeController *controller= [[MonthPayTypeController alloc] initWithNibName:@"MonthPayTypeController" bundle:nil];
        controller.title=income.Name;
        controller.income=income;
        controller.cities=self.tax.Cities;
        [self.navigationController pushViewController:controller animated:YES];
    }else if(style==2){
        YearPayTypeController *controller= [[YearPayTypeController alloc] initWithNibName:@"YearPayTypeController" bundle:nil];
        controller.title=income.Name;
        controller.income=income;
        controller.cities=self.tax.Cities;
        [self.navigationController pushViewController:controller animated:YES];
    }else if(style==3){
        CompensationTypeController *controller= [[CompensationTypeController alloc] initWithNibName:@"CompensationTypeController" bundle:nil];
        controller.title=income.Name;
        controller.income=income;
        controller.cities=self.tax.Cities;
        [self.navigationController pushViewController:controller animated:YES];
    }else if(style==4){
        PersonalTypeController *controller= [[PersonalTypeController alloc] initWithNibName:@"PersonalTypeController" bundle:nil];
        controller.title=income.Name;
        controller.income=income;
        [self.navigationController pushViewController:controller animated:YES];
    }else if(style==5){
        EnterpriseTypeController *controller= [[EnterpriseTypeController alloc] initWithNibName:@"EnterpriseTypeController" bundle:nil];
        controller.title=income.Name;
        controller.income=income;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    header.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    UIImageView *headerImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:section==0?@"section_title_bg.png":@"section_title_bg2.png"]];
    headerImage.center=CGPointMake(160, 26);
    [header addSubview:headerImage];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label.text=section==0?@"基本类型": @"其他类型";
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


//-(void)finishFillDescription:(Tax *)ttax{
//    self.tax=ttax;
//}


@end
