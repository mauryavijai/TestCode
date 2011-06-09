//
//  Level2.m
//  Natolli
//
//  Created by Nidhi Sharma on 09/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level2.h"
#import"Level2_Details.h"

@implementation Level2

@synthesize arrRoom, arrRoomID, arrRoomNotes, arrRoomLocations;

#pragma mark -
#pragma mark View lifecycle

- (void)AddNewRoom:(id)sender
{	
	[CCommon AddRoomToLocaldb:@"abc"];
	
	Level2_Details *objLevel_2 = [[Level2_Details alloc] initWithNibName:@"Level2_Details" bundle:nil];
	[self.navigationController pushViewController:objLevel_2 animated:YES];
	[objLevel_2 release];

}//END - AddNewRoom


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Add Room";
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.46 
																		green:0.70
																		 blue:0.08
																		alpha:1.0f];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Room" style:UIBarButtonItemStyleBordered target:self action:@selector(AddNewRoom:)];

	arrRoom =[[NSMutableArray alloc] init];
	arrRoomID =[[NSMutableArray alloc] init];
	arrRoomNotes =[[NSMutableArray alloc] init];
//	arrRoomImages =[[NSMutableArray alloc] init];
	arrRoomLocations =[[NSMutableArray alloc] init];
	
	arrRoom = [CCommon GetRoomTitles];
	arrRoomID = [CCommon GetRoomTitleIDs];
	arrRoomNotes = [CCommon GetRoomDescription];
	//arrRoomImages = [CCommon GetFloorImages];
	arrRoomLocations = [CCommon GetRoomLocation];
	
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	arrRoom =[[NSMutableArray alloc] init];
	arrRoomID =[[NSMutableArray alloc] init];
	arrRoomNotes =[[NSMutableArray alloc] init];
	//	arrRoomImages =[[NSMutableArray alloc] init];
	arrRoomLocations =[[NSMutableArray alloc] init];
	
	arrRoom = [CCommon GetRoomTitles];
	arrRoomID = [CCommon GetRoomTitleIDs];
	arrRoomNotes = [CCommon GetRoomDescription];
	//arrRoomImages = [CCommon GetFloorImages];
	arrRoomLocations = [CCommon GetRoomLocation];
	
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
			if ([arrRoomID count] == 0)
				return 1;
			else 
				return [arrRoomID count];
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

			cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
										   reuseIdentifier:CellIdentifier] autorelease]; 
			
			UIButton *btnAddNewRoom = [UIButton buttonWithType:UIButtonTypeContactAdd];
			btnAddNewRoom.titleLabel.text = @"Foo Bar";								
			[btnAddNewRoom setFrame:CGRectMake(-20.0f, 8.0f, 80.0f, 30.0f)];
			[btnAddNewRoom addTarget:self action:@selector(AddNewRoom:) forControlEvents:UIControlEventTouchUpInside];
			[cell.contentView addSubview:btnAddNewRoom];
			
			UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 12.0f, 200.0f, 20.0f)];
			label.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			label.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
			[label setText:@"Add Room"];
			[cell addSubview:label];
			[label release];
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
	}//END - if (section == 1)
	else {
		
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
									   reuseIdentifier:CellIdentifier] autorelease]; 
		
		UILabel *lblRoomTitle = [[UILabel alloc] initWithFrame:CGRectMake(17.0f, 12.0f, 200.0f, 20.0f)];
		lblRoomTitle.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblRoomTitle.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		
		
		//	NSLog(@"value: %@ :: %d", [arrFloor objectAtIndex:indexPath.row], indexPath.row);
		
		if ([arrRoomID count] != 0)
		{
			[lblRoomTitle setText:[arrRoom objectAtIndex:indexPath.row]];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		else
		{
			[lblRoomTitle setText:@"No room added"];
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
		
		
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
			[self performSelector:@selector(AddNewRoom:)];
		}
	}
	else {
		if ([arrRoomID count] != 0)
		{
			Level2_Details *objLevel_1 = [[Level2_Details alloc] initWithNibName:@"Level2_Details" bundle:nil];
			
			if ([arrRoomID count] != 0)
			{
				
				objLevel_1.SelectedFloorID = [arrRoomID objectAtIndex:indexPath.row];
				objLevel_1.SelectedFloorTitle = [arrRoom objectAtIndex:indexPath.row];
			}
			else
			{
				//objLevel_1.SelectedFloorNotes = @"";
				objLevel_1.SelectedFloorID = @"";
				objLevel_1.SelectedFloorTitle = @"";
				//objLevel_1.SelectedFloorImage = @"";
			}
			
			if ([arrRoomNotes count] != 0)
				objLevel_1.SelectedFloorNotes = [arrRoomNotes objectAtIndex:indexPath.row];
			else
				objLevel_1.SelectedFloorNotes = @"";
			
			/*if ([arrFloorImages count] != 0)
				objLevel_1.SelectedFloorImage = [arrRoomImages objectAtIndex:indexPath.row];
			else*/
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

