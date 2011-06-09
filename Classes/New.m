//
//  New.m
//  Natolli
//
//  Created by Nidhi Sharma on 09/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "New.h"
#import "AddFloor.h"
#import "AddRoom.h"

@implementation New
@synthesize tf, arrFloor, Mode, SelectedFloor, arrFloorID;

#pragma mark -
#pragma mark View lifecycle

- (void) cancelEdit: (id) sender
{
	NSString *lstrValue = tf.text;
	
	if ([lstrValue length] == 0)
	{
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@""
							  message:@"Please enter title"
							  delegate:self
							  cancelButtonTitle:@"OK"
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else
	{	
		if (IsDoneClicked) {
			[self.navigationController popViewControllerAnimated:YES];
		}
		else {
			IsDoneClicked = TRUE;
			[tf resignFirstResponder];
			//[self.tableView reloadData];
			[CCommon AddPropertyTitleToLocaldb:lstrValue];
		}
	}
}
- (void)viewDidLoad {
    [super viewDidLoad];
	IsDoneClicked = FALSE;
	arrFloor = [[NSMutableArray alloc] init];
	arrFloorID = [[NSMutableArray alloc] init];
	//self.title = @"";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(cancelEdit:)];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {

	arrFloor = [[NSMutableArray alloc] init];
	arrFloorID = [[NSMutableArray alloc] init] ;
	arrFloor =[CCommon GetFloorTitles];
	arrFloorID= [CCommon GetFloorTitleIDs];
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

- (void)AddNewFloor:(id)sender
{
		
	NSString *lstrValue = tf.text;
	
	if ([lstrValue length] == 0)
	{
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@""
							  message:@"Please enter title"
							  delegate:self
							  cancelButtonTitle:@"OK"
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else
	{	
		//[CCommon AddFloorToLocaldb:lstrValue];
		
		AddFloor *aAddFloor = [[AddFloor alloc] initWithNibName:@"AddFloor" bundle:nil];
		aAddFloor.Mode = self.Mode;
		aAddFloor.SelectedFloor = self.SelectedFloor;
		[self.navigationController pushViewController:aAddFloor animated:YES];
		[aAddFloor release];
		
		/*AddRoom *aAddFloor = [[AddRoom alloc] initWithNibName:@"AddRoom" bundle:nil];
		[self.navigationController pushViewController:aAddFloor animated:YES];
		[aAddFloor release];*/
	}

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark -
#pragma mark Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	// create the parent view that will hold header Label
	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(12.0, 0.0, 300.0, 22.0)];
	// create the button object
	UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	headerLabel.backgroundColor = [UIColor clearColor];
	headerLabel.opaque = NO;
	headerLabel.textColor = [UIColor darkGrayColor];
	headerLabel.highlightedTextColor = [UIColor whiteColor];
	headerLabel.font = [UIFont boldSystemFontOfSize:20];
	headerLabel.frame = CGRectMake(14.0, 0.0, 300.0, 24.0);
	
	// If you want to align the header text as centered
	// headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
	
	headerLabel.text = @"Floors:"; // i.e. array element
	
	if (section == 1 )
	{
		[customView addSubview:headerLabel];
	}
	return customView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if (section == 1 ) 
	{
		return 28.0;
	}
	else
	{
		return 0.0;
	}
}


// Heights per row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	int section = [indexPath section];
	int row = [indexPath row];
	
	switch (section) 
	{
		case 0:
			if (row == 0) 
				return 80.0f;
			//return 350.0f;
		case 1:
			return 44.0f;
		default:
			return 44.0f;
	}
	
	//return 80.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	return 2;	
}
// Number of rows per section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	switch (section) 
	{
		case 0:
			return 2;
		case 1:
		{
			NSString *value =tf.text;
			if ([value length] != 0) 
			{
				if ([arrFloor count] == 0)
				{
					return 1;
				}
				else 
				{
					return [arrFloor count];
				}
			}
			else {
				return 1;
			}
		}

		default:
			return 1;
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSInteger row = [indexPath row];
	NSInteger section = [indexPath section];
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (section == 0)
	{
		if (row == 0)
		{
			if (cell == nil) 
			{ 
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
											   reuseIdentifier:CellIdentifier] autorelease]; 
				
				UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 10.0f, 200.0f, 20.0f)];
				[label setText:@"Property Name:"];
				[cell addSubview:label];
				[label release];
				
				[cell addSubview:[[UITextField alloc] initWithFrame:CGRectMake(20.0f, 40.0f, 280.0f, 30.0f)]];
				
				tf = [[cell subviews] lastObject];
				tf.placeholder = @"Property Name";
				tf.delegate = self;
				tf.borderStyle = UITextBorderStyleBezel;
				
				cell.selectionStyle = UITableViewCellSelectionStyleNone;			
			}
		}
		else if (row == 1) 
		{
			if (cell == nil) 
			{ 
				cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
											   reuseIdentifier:CellIdentifier] autorelease]; 
				UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
				button.titleLabel.text = @"Foo Bar";								
				[button setFrame:CGRectMake(-20.0f, 8.0f, 80.0f, 30.0f)];
				[button addTarget:self action:@selector(AddNewFloor:) forControlEvents:UIControlEventTouchUpInside];
				[cell.contentView addSubview:button];
				self.Mode = @"ADD";
				
				UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 12.0f, 200.0f, 20.0f)];
				[label setText:@"Add Floor"];
				[cell addSubview:label];
				[label release];
				//[cell addSubview:[[UITextField alloc] initWithFrame:CGRectMake(100.0f, 40.0f, 280.0f, 30.0f)]];
				
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
			}
		}
	}
	else 
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
									   reuseIdentifier:CellIdentifier] autorelease]; 
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 12.0f, 200.0f, 20.0f)];
		
		NSString *value = tf.text;
		
		if ([value length] == 0) {
			[label setText:@"No Floor added"];
		}
		else {
			if ([arrFloor count] != 0)
			{
				[label setText:[arrFloor objectAtIndex:indexPath.row]];
			}
			else
			{ 
				[label setText:@"No Floor added"];
			}
		}

		
		
		[cell addSubview:label];
		[label release];
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

	if (indexPath.section == 0)
	{
		if (indexPath.row == 1)
		{
			self.Mode = @"ADD";
			[self performSelector:@selector(AddNewFloor:)];
		}
	}
	else if(indexPath.section == 1)
	{
		if ([arrFloor count] != 0) {
			self.SelectedFloor = [arrFloor objectAtIndex:indexPath.row];
		}
		[CCommon setLastAdded_FloorID:[arrFloorID objectAtIndex:indexPath.row]];
		self.Mode = @"EDIT";
		[self performSelector:@selector(AddNewFloor:)];
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

