//
//  DetailTableViewController.m
//  TaxCalculator
//
//  Created by Change Cdts on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailTableViewController.h"
#import "Tax.h"
#import "TaxManager.h"
#import "CommonUI.h"

@implementation DetailTableViewController

@synthesize dict;
@synthesize isAntiCalculate;
@synthesize delegate;

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
    
    self.title=@"缴费明细";

    headerArray=[NSArray arrayWithObjects:@"个人缴费",@"单位缴费",@"缴费基数", nil];
    listOfItems = [[NSMutableArray alloc]  init];
    listOfValues = [[NSMutableArray alloc]  init];
    listOfFields = [[NSMutableArray alloc]  init];
    NSArray * array1 = [NSArray arrayWithObjects:@"个人缴费合计",@"应纳税额总计",@"养老",@"医疗",@"失业",@"公积金", nil];
    NSArray * array2 = [NSArray arrayWithObjects:@"单位缴费合计",@"单位支出总计",@"养老",@"医疗",@"失业",@"工伤",@"生育",@"公积金", nil];
    NSArray * array3 = [NSArray arrayWithObjects:@"社保",@"公积金",@"封顶数",@"个税起征点", nil];

    
    [listOfItems addObject:array1];
    [listOfItems addObject:array2];
    [listOfItems addObject:array3];
    
    [listOfValues addObject:[self.dict objectForKey:@"pValues"]];
    [listOfValues addObject:[self.dict objectForKey:@"fValues"]];
    [listOfValues addObject:[self.dict objectForKey:@"baseValues"]];
    
    [listOfFields addObject:[self.dict objectForKey:@"pFields"]];
    [listOfFields addObject:[self.dict objectForKey:@"fFields"]];    
    
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
    self.dict=nil;
    self.delegate=nil;
    self.isAntiCalculate=nil;
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
    return [listOfItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [listOfItems objectAtIndex:section];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    if (((indexPath.section==0||indexPath.section==1)&&(indexPath.row==0||indexPath.row==1))||indexPath.section==2) {
        CellIdentifier = @"TotlalCell";

    }else{
         CellIdentifier = @"SubCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if (((indexPath.section==0||indexPath.section==1)&&(indexPath.row==0||indexPath.row==1))||indexPath.section==2) {
            
        }else{
            UILabel *lblDes=[[UILabel alloc] initWithFrame:CGRectMake(140, 20, 20, 20)];
            lblDes.font=[UIFont fontWithName:@"Georgia"  size:15];
            lblDes.text=@"%";
            lblDes.textColor=[UIColor grayColor];
            lblDes.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:lblDes];
            UITextField *valueField=[[UITextField alloc] initWithFrame:CGRectMake(70, 15, 60, 30)];
            valueField.font=[UIFont fontWithName:@"Georgia"  size:16];
            valueField.borderStyle=UITextBorderStyleRoundedRect;
            valueField.delegate=self;
            valueField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
            valueField.tag=2;
            valueField.keyboardType= UIKeyboardTypeNumbersAndPunctuation;
            valueField.returnKeyType=UIReturnKeyDone;
            [cell.contentView addSubview:valueField];
        }
        [cell.textLabel setFont:[UIFont  fontWithName:@"Georgia"  size:16]];
        cell.textLabel.backgroundColor=[UIColor clearColor];
        
        UILabel *valueLabel=[[UILabel alloc] initWithFrame:CGRectMake(-20, 0, 300, 60)];
        valueLabel.backgroundColor=[UIColor clearColor];
        valueLabel.font=[UIFont fontWithName:@"Georgia-Italic"  size:16];
        valueLabel.textAlignment=UITextAlignmentRight;
        valueLabel.textColor=indexPath.section==0?UIColorFromRGB(0xD12654):indexPath.section==1?UIColorFromRGB(0x248608):UIColorFromRGB(0x356FB0);
        valueLabel.tag=1;
        [cell.contentView addSubview:valueLabel];
    }
    
    NSArray *array = [listOfItems objectAtIndex:indexPath.section];
    NSString *cellValue = [array objectAtIndex:indexPath.row];   
    cell.textLabel.text = cellValue;
    
    
    
    UITextField *vField=(UITextField *)[cell.contentView viewWithTag:2];
    if (vField) {
        double rowF=[[[listOfFields objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] doubleValue];
        vField.text= [NSString stringWithFormat:@"%0.2f", rowF];
    }
    
    

    UILabel *vLabel=(UILabel *)[cell.contentView viewWithTag:1];
    if (vLabel) {
        vLabel.textColor=indexPath.section==0?UIColorFromRGB(0xD12654):indexPath.section==1?UIColorFromRGB(0x248608):UIColorFromRGB(0x356FB0);
        double rowV=[[[listOfValues objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] doubleValue];
        vLabel.text=[NSString stringWithFormat:@"%0.2f", rowV];
    }
        
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

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    header.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    UIImageView *headerImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:section==0?@"section_title_bg.png":section==1?@"section_title_bg2.png":@"section_title_bg3.png"]];
    headerImage.center=CGPointMake(160, 26);
    [header addSubview:headerImage];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label.text=[headerArray objectAtIndex:section];
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
    return 60;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSIndexPath *indexPath=[self.tableView indexPathForCell:(UITableViewCell *)[[textField superview] superview]];
    [textField resignFirstResponder];
    int section=indexPath.section;
    int row=indexPath.row;
    if ([delegate conformsToProtocol:@protocol(TaxesAction)]&&[delegate respondsToSelector:@selector(updateDetailPercent:::::)]) {
        [delegate updateDetailPercent:self.dict :section :row :[textField.text doubleValue]:isAntiCalculate];
    }
    [self.tableView reloadData];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(string&&string.length==0){
        return YES;
    }
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[0-9]"];
    if([pre evaluateWithObject:string]||[string characterAtIndex:0]=='.'){
        return YES;
    }       
    return NO;
}

@end
