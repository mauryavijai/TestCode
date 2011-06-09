//
//  List.m
//  Natolli
//
//  Created by Nidhi Sharma on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "List.h"
#import "Level0.h"


@implementation List
@synthesize arrInventoryType, arrStartDate, arrStartTime, arrEndDate, arrEndTime, arrInspectionStatus;

#pragma mark -
#pragma mark View lifecycle

- (void)aButtonClicked:(id)sender {
/*	Login *aLogin = [[Login alloc] initWithNibName:@"Login" bundle:nil];
	[self.navigationController pushViewController:aLogin animated:NO];
	[aLogin release];
	[[UIApplication sharedApplication] terminateWithSuccess];
*/	
}



- (void)viewDidLoad {
    [super viewDidLoad];
	
	sharedInstance =[CCommon objCCommon];
	
	arrInventoryType =[[NSMutableArray alloc] init];
	arrStartDate =[[NSMutableArray alloc] init];
	arrStartTime =[[NSMutableArray alloc] init];
	arrEndDate =[[NSMutableArray alloc] init];
	arrEndTime =[[NSMutableArray alloc] init];
	arrInspectionStatus =[[NSMutableArray alloc] init];
	
	arrInventoryType = [CCommon Get_InventoryType];
	arrStartDate = [CCommon Get_StartDate];
	arrStartTime = [CCommon Get_StartTime];
	arrEndDate = [CCommon Get_EndDate];
	arrEndTime = [CCommon Get_EndTime];
	arrInspectionStatus = [CCommon Get_InspectionStatus];
	
	self.title = @"Upcoming Inspections";
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.46 
																		green:0.70
																		 blue:0.08
																		alpha:1.0f];
	
	//self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(aButtonClicked:)];
	
}



- (void)viewWillAppear:(BOOL)animated {
	
	sharedInstance =[CCommon objCCommon];
	
	arrInventoryType =[[NSMutableArray alloc] init];
	arrStartDate =[[NSMutableArray alloc] init];
	arrStartTime =[[NSMutableArray alloc] init];
	arrEndDate =[[NSMutableArray alloc] init];
	arrEndTime =[[NSMutableArray alloc] init];
	arrInspectionStatus =[[NSMutableArray alloc] init];
	
	arrInventoryType = [CCommon Get_InventoryType];
	arrStartDate = [CCommon Get_StartDate];
	arrStartTime = [CCommon Get_StartTime];
	arrEndDate = [CCommon Get_EndDate];
	arrEndTime = [CCommon Get_EndTime];
	arrInspectionStatus = [CCommon Get_InspectionStatus];
	
	
	[self.tableView reloadData];
    [super viewWillAppear:animated];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}



-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 6;
    return 1.0;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 6.0;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	static NSString *CellIdentifier = @"Cell"; 
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; 
	//if (cell == nil) 
//	{ 
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,100, 201, 47) 
									   reuseIdentifier:CellIdentifier] autorelease]; 
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
	//	cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table_view_cell_over.png"]] autorelease];
		
		NSString *strHeading =@"";
		NSString *strSubHeading = @"";
		NSString *strDateTime = @"";
		strHeading = [arrInventoryType objectAtIndex:indexPath.section];
		strDateTime = [arrStartDate objectAtIndex:indexPath.section];
		
		if (indexPath.section == 0) {

			//strHeading =@"Check In";
			//strHeading = [arrInventoryType objectAtIndex:[indexPath.section]];
			strSubHeading =@"2144 SW13 9RU";
			//strDateTime = @"18/03/11 10:45:00";
		}
		if (indexPath.section == 1) {
			//strHeading =@"Inventory Make";
			strSubHeading =@"Lilten Road, SW6 1U";
			//strDateTime = @"17/03/11 09:00:00";
		}		
		if (indexPath.section == 2) {
			//strHeading =@"Inventory Check In";
			strSubHeading =@"2144 SW13 9RU";
			//strDateTime = @"18/03/11 10:45:00";
		}
		if (indexPath.section == 3) {
			//strHeading =@"Mid Term Inspection";
			strSubHeading =@"Lilten Road, SW6 1U";
			//strDateTime = @"17/03/11 09:00:00";
		}
		
		UIImage *cellSeperator; 
		NSString *imageName = @"dotted_sap.png"; 
		cellSeperator = [UIImage imageNamed:imageName]; 
		
		UILabel *lblheading = [[UILabel alloc] initWithFrame:CGRectMake(10,5, 239, 21)];
		lblheading.backgroundColor	= [UIColor clearColor];
		lblheading.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		lblheading.font = [UIFont fontWithName:@"Arial-BoldMT" size:17.0f]; 
		lblheading.text =strHeading;
		
		UILabel *lblSubHeading = [[UILabel alloc] initWithFrame:CGRectMake(10,20, 239, 21)];
		lblSubHeading.backgroundColor	= [UIColor clearColor];
		lblSubHeading.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		lblSubHeading.font = [UIFont fontWithName:@"Arial" size:11.0f]; 
		lblSubHeading.text =strSubHeading;
		
		UILabel *lblDateTime = [[UILabel alloc] initWithFrame:CGRectMake(10,35, 239, 21)];
		lblDateTime.backgroundColor	= [UIColor clearColor];
		lblDateTime.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		lblDateTime.font = [UIFont fontWithName:@"Arial" size:11.0f]; 
		lblDateTime.text =strDateTime;
		
		UIImageView *imgVw = [[UIImageView alloc]initWithImage:cellSeperator];
		imgVw.frame = CGRectMake(0, 64, 320, 1);
		
		UIView	 *vw = [[[UIView alloc] init]autorelease];
		[vw insertSubview:lblheading atIndex:0];
		[vw insertSubview:lblSubHeading atIndex:1];
		[vw insertSubview:lblDateTime atIndex:2];
		[vw insertSubview:imgVw atIndex:3];
		cell.backgroundView = vw;
		
		//UIImageView *normalBackground = [[[UIImageView alloc] init] autorelease];
		//normalBackground.image = rowBackground; 
		//[normalBackground insertSubview:lblheading atIndex:0]; 
		//[normalBackground insertSubview:lblSubHeading atIndex:1]; 
		//cell.backgroundView = normalBackground; 

		
		[lblheading release];
	//} 
	return cell;
	
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	
	sharedInstance.mstrSelectedInType =[arrInventoryType objectAtIndex:indexPath.section];
	sharedInstance.mstrSelectedSDate =[arrStartDate objectAtIndex:indexPath.section];
	sharedInstance.mstrSelectedStartTime = [arrStartTime objectAtIndex:indexPath.section];
	sharedInstance.mstrSelectedEndDate = [arrEndDate objectAtIndex:indexPath.section];
	sharedInstance.mstrSelectedEndTime = [arrEndTime objectAtIndex:indexPath.section];
	sharedInstance.mstrSelectedInStatus = [arrInspectionStatus objectAtIndex:indexPath.section];
	
	if (indexPath.section	== 0)
	{
		sharedInstance.mstrSelectedInspectionID = @"1";
	}
	else if (indexPath.section == 1)
	{
		sharedInstance.mstrSelectedInspectionID = @"2";
	}
	else if (indexPath.section == 2)
	{
		sharedInstance.mstrSelectedInspectionID = @"3";
	}
	else 
	{
		sharedInstance.mstrSelectedInspectionID = @"4";
	}
	
	Level0 *detailViewController = [[Level0 alloc] initWithNibName:@"Level0" bundle:nil];
	[self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

