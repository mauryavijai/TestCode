//
//  Exterior.m
//  Natolli
//
//  Created by Nidhi Sharma on 07/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Exterior.h"
#import "AddExteriorDetails.h"

@implementation Exterior


#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
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
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
   if (section == 0)
   {
	   return 1;
   }
   else {
	   return 3;
   }

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (indexPath.section == 1)
	{
		if (indexPath.row == 0)
		{
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
										   reuseIdentifier:CellIdentifier] autorelease]; 
			
			UIButton *btnAddGarden = [UIButton buttonWithType:UIButtonTypeContactAdd];
			btnAddGarden.titleLabel.text = @"Foo Bar";								
			[btnAddGarden setFrame:CGRectMake(-20.0f, 8.0f, 80.0f, 30.0f)];
			//[btnAddGarden addTarget:self action:@selector(AddNewFloor:) forControlEvents:UIControlEventTouchUpInside];
			[cell.contentView addSubview:btnAddGarden];
			
			UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 12.0f, 200.0f, 20.0f)];
			label.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			label.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
			[label setText:@"Add Garden"];
			[cell addSubview:label];
			[label release];
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
		}//END - if (row == 0)
		else if(indexPath.row == 1)
		{

				cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
											   reuseIdentifier:CellIdentifier] autorelease]; 
				
				UIButton *btnAddGaraze = [UIButton buttonWithType:UIButtonTypeContactAdd];
				btnAddGaraze.titleLabel.text = @"Foo Bar";								
				[btnAddGaraze setFrame:CGRectMake(-20.0f, 8.0f, 80.0f, 30.0f)];
				//[btnAddGarden addTarget:self action:@selector(AddNewFloor:) forControlEvents:UIControlEventTouchUpInside];
				[cell.contentView addSubview:btnAddGaraze];
				
				UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 12.0f, 200.0f, 20.0f)];
				label.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
				label.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
				[label setText:@"Add Garage"];
				[cell addSubview:label];
				[label release];
				
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				
			}//END - if (row == 1)
			else if(indexPath.row == 2)
			{
			
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
										   reuseIdentifier:CellIdentifier] autorelease]; 
			
				UIButton *btnAddBalcony = [UIButton buttonWithType:UIButtonTypeContactAdd];
				btnAddBalcony.titleLabel.text = @"Foo Bar";								
				[btnAddBalcony setFrame:CGRectMake(-20.0f, 8.0f, 80.0f, 30.0f)];
				//[btnAddGarden addTarget:self action:@selector(AddNewFloor:) forControlEvents:UIControlEventTouchUpInside];
				[cell.contentView addSubview:btnAddBalcony];
			
				UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 12.0f, 200.0f, 20.0f)];
				label.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
				label.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
				[label setText:@"Add Balcony"];
				[cell addSubview:label];
				[label release];
			
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			}//END - if (row == 0)
		}
		
	//}//END - if (section == 1)
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
		
		/*if ([arrFloorID count] != 0)
		{
			[lblRoomTitle setText:[arrFloor objectAtIndex:indexPath.row]];
			//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			
			btnDeleteDesc.tag = [[arrFloorID objectAtIndex:indexPath.row] intValue];
			[btnDeleteDesc addTarget:self action:@selector(DeleteFloor:) forControlEvents: UIControlEventTouchUpInside];
			[cell addSubview:btnDeleteDesc];
		}
		else
		{*/
			[lblRoomTitle setText:@"No floor added"];
		//}
		
		cell.accessoryType = UITableViewCellAccessoryNone;
		[btnDeleteDesc release];
		
		[cell addSubview:lblRoomTitle];
		[lblRoomTitle release];
		
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
	}
	
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
		AddExteriorDetails *objAddExteriorDetails = [[AddExteriorDetails alloc] initWithNibName:@"AddExteriorDetails" bundle:nil];
		if (indexPath.row == 0) 
		{
			objAddExteriorDetails.Mode = @"GARDEN";
		}
		else if (indexPath.row == 1) 
		{	
			objAddExteriorDetails.Mode = @"GARAGE";
		}
		else if (indexPath.row == 2) 
		{
			objAddExteriorDetails.Mode = @"BALCONY";
		}
		
		[self.navigationController pushViewController:objAddExteriorDetails animated:YES];
		[objAddExteriorDetails release];
			
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

