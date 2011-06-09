//
//  Level1.m
//  Natolli
//
//  Created by Nidhi Sharma on 04/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level1.h"
#import "Level1_Details.h"

@implementation Level1

@synthesize arrFloor, arrFloorID, arrFloorNotes, arrFloorImages, strDeleteditemID;

#pragma mark -
#pragma mark View lifecycle



- (void)AddNewFloor:(id)sender
{	
	//Calling function to add floor to database.
	/*[CCommon AddFloorToLocaldb:@"abc"];*/
	
	int CountOfRows = [self.tableView numberOfRowsInSection:0];
	
	if ([arrFloorID count] == 0)
	{
		if (CountOfRows == 1) {
			CountOfRows = 1;
		}
		else {
			CountOfRows += 1;
		}
	}
	else {
		CountOfRows += 1;
	}

	
	NSString *value = [@"Floor" stringByAppendingFormat:@"%d", CountOfRows];
	
	[CCommon AddFloorToLocaldb:value];
	
	Level1_Details *objLevel_1 = [[Level1_Details alloc] initWithNibName:@"Level1_Details" bundle:nil];
	[self.navigationController pushViewController:objLevel_1 animated:YES];
	[objLevel_1 release];
	
	/*UIAlertView *baseAlert = [[UIAlertView alloc] 
							  initWithTitle:@"" message:@"New folder has been added successfully"
							  delegate:self cancelButtonTitle:nil
							  otherButtonTitles:@"OK",nil];
	[baseAlert show];
	[baseAlert release];*/
	
}//END - AddNewFloor

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 1) //If user pressed OK button
	{
		[CCommon DeleteFloor_Level_1:self.strDeleteditemID];
		
		arrFloor =[[NSMutableArray alloc] init];
		arrFloorID =[[NSMutableArray alloc] init];
		arrFloorNotes =[[NSMutableArray alloc] init];
		arrFloorImages =[[NSMutableArray alloc] init];
		
		arrFloor = [CCommon GetFloorTitles];
		arrFloorID = [CCommon GetFloorTitleIDs];
		arrFloorNotes = [CCommon GetFloorNotes];
		arrFloorImages = [CCommon GetFloorImages];
		
		[self.tableView reloadData];
	}
	
	//[alertView release];
}


-(void)DeleteFloor:(id)sender
{
	self.strDeleteditemID =[@"" stringByAppendingFormat:@"%d",  [sender tag]];
	
	UIAlertView *baseAlert = [[UIAlertView alloc] 
							  initWithTitle:@"" message:@"Are you sure you want to delete this record" 
							  delegate:self cancelButtonTitle:nil
							  otherButtonTitles:@"Cancel", @"OK", nil];
	
	[baseAlert show];
	[baseAlert release];
	
}//DeleteRoom

- (void)aButtonClicked:(id)sender {
	
	/*[CCommon UpdateInspectionDetails:[[CCommon objCCommon]mstrSelectedSDate] StartTime:[[CCommon objCCommon]mstrSelectedStartTime] EndDate:[[CCommon objCCommon]mstrSelectedEndDate] EndTime:[[CCommon objCCommon]mstrSelectedEndTime] InventoryType:[[CCommon objCCommon]mstrSelectedInType] InventoryStatus:[[CCommon objCCommon]mstrSelectedInStatus] Notes:[[CCommon objCCommon]mstrNotes]];
	
	Level1 *objLevel1 = [[Level1 alloc] initWithNibName:@"Level1" bundle:nil];
	[self.navigationController pushViewController:objLevel1 animated:NO];
	[objLevel1 release];*/
}


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Floors";
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.46 
																		green:0.70
																		 blue:0.08
																		alpha:1.0f];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Floor" style:UIBarButtonItemStyleBordered target:self action:@selector(AddNewFloor:)];
	
//	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

	arrFloor =[[NSMutableArray alloc] init];
	arrFloorID =[[NSMutableArray alloc] init];
	arrFloorNotes =[[NSMutableArray alloc] init];
	arrFloorImages =[[NSMutableArray alloc] init];
	
	arrFloor = [CCommon GetFloorTitles];
	arrFloorID = [CCommon GetFloorTitleIDs];
	arrFloorNotes = [CCommon GetFloorNotes];
	arrFloorImages = [CCommon GetFloorImages];

}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	arrFloor =[[NSMutableArray alloc] init];
	arrFloorID =[[NSMutableArray alloc] init];
	arrFloorNotes =[[NSMutableArray alloc] init];
	arrFloorImages =[[NSMutableArray alloc] init];
	
	arrFloor = [CCommon GetFloorTitles];
	arrFloorID = [CCommon GetFloorTitleIDs];
	arrFloorNotes = [CCommon GetFloorNotes];
	arrFloorImages = [CCommon GetFloorImages];
	
		
	[self.tableView reloadData];
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

/*-(CGFloat)tableView:(UITableView *)tableView widthForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return 20.0;
}*/

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 6;
    return 1.0;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 8.0;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) 
	{
		case 0:
			if ([arrFloorID count] == 0)
				return 1;
			else 
				return [arrFloorID count];
		case 1:
			return 1;
		default:
			return 1;

	}//END - switch (section)}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   // if (cell == nil) {
     //   cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
   // }
    
	if (indexPath.section == 1)
	{
		if (indexPath.row == 0)
		{
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
										   reuseIdentifier:CellIdentifier] autorelease]; 
			
			UIButton *btnAddNewFloor = [UIButton buttonWithType:UIButtonTypeContactAdd];
			btnAddNewFloor.titleLabel.text = @"Foo Bar";								
			[btnAddNewFloor setFrame:CGRectMake(-20.0f, 8.0f, 80.0f, 30.0f)];
			[btnAddNewFloor addTarget:self action:@selector(AddNewFloor:) forControlEvents:UIControlEventTouchUpInside];
			[cell.contentView addSubview:btnAddNewFloor];
			
			UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 12.0f, 200.0f, 20.0f)];
			label.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			label.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
			[label setText:@"Add Floor"];
			[cell addSubview:label];
			[label release];
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
		}//END - if (row == 0)
	}//END - if (section == 1)
	else {
		
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
									  reuseIdentifier:CellIdentifier] autorelease]; 
		
		UILabel *lblRoomTitle = [[UILabel alloc] initWithFrame:CGRectMake(17.0f, 12.0f, 200.0f, 20.0f)];
		lblRoomTitle.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblRoomTitle.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		
		UIButton *btnDeleteDesc = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		btnDeleteDesc.frame= CGRectMake(235,-18, 100, 78);
		
		[btnDeleteDesc setImage:[UIImage imageNamed:@"btn_delete1.png"] forState:UIControlStateNormal];
	
	//	NSLog(@"value: %@ :: %d", [arrFloor objectAtIndex:indexPath.row], indexPath.row);
		
		if ([arrFloorID count] != 0)
		{
			[lblRoomTitle setText:[arrFloor objectAtIndex:indexPath.row]];
			//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			
			btnDeleteDesc.tag = [[arrFloorID objectAtIndex:indexPath.row] intValue];
			[btnDeleteDesc addTarget:self action:@selector(DeleteFloor:) forControlEvents: UIControlEventTouchUpInside];
			[cell addSubview:btnDeleteDesc];
		}
		else
		{
			[lblRoomTitle setText:@"No floor added"];
		}
		
		cell.accessoryType = UITableViewCellAccessoryNone;
		[btnDeleteDesc release];
		
		[cell addSubview:lblRoomTitle];
		[lblRoomTitle release];
	
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
	}

	
	/*UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
	[button setBackgroundColor:[UIColor redColor]];
	button.titleLabel.text = @"Foo Bar";
	[cell.contentView addSubview:button];*/
	
    // Configure the cell...
    
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
	
	if (indexPath.section == 1)
	{
		if (indexPath.row == 0)
		{
			[self performSelector:@selector(AddNewFloor:)];
		}
	}
	else {
		if ([arrFloorID count] != 0)
		{
			Level1_Details *objLevel_1 = [[Level1_Details alloc] initWithNibName:@"Level1_Details" bundle:nil];
			
			if ([arrFloorID count] != 0)
			{
				
				objLevel_1.SelectedFloorID = [arrFloorID objectAtIndex:indexPath.row];
				objLevel_1.SelectedFloorTitle = [arrFloor objectAtIndex:indexPath.row];
			}
			else
			{
				//objLevel_1.SelectedFloorNotes = @"";
				objLevel_1.SelectedFloorID = @"";
				objLevel_1.SelectedFloorTitle = @"";
				//objLevel_1.SelectedFloorImage = @"";
			}
			
			if ([arrFloorNotes count] != 0)
				objLevel_1.SelectedFloorNotes = [arrFloorNotes objectAtIndex:indexPath.row];
			else
				objLevel_1.SelectedFloorNotes = @"";
			
			if ([arrFloorImages count] != 0)
			objLevel_1.SelectedFloorImage = [arrFloorImages objectAtIndex:indexPath.row];
			else
				objLevel_1.SelectedFloorImage = @"";
			
			
			objLevel_1.Mode = @"UPDATE";
			[self.navigationController pushViewController:objLevel_1 animated:YES];
			[objLevel_1 release];
			
		}//END - if ([arrFloorID count] != 0)
	}

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

