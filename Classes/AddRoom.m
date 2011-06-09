//
//  AddRoom.m
//  Natolli
//
//  Created by Nidhi Sharma on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AddRoom.h"

@implementation AddRoom

@synthesize tf, txtViewDesc;

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
			[self.tableView reloadData];
			[CCommon AddRoomToLocaldb:lstrValue];
		}
	}
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	IsDoneClicked = FALSE;
	self.title = @"Add room";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(cancelEdit:)];
	
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
}




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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark -
#pragma mark Table view data source

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
			return 124.0f;
		default:
			return 44.0f;
	}
	
	//return 80.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (IsDoneClicked) 
	{
		return 2;
	}
	else
	{
		return 1;
	}
}


// Number of rows per section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	switch (section) 
	{
		case 0:
			return 1;
		case 1:
			return 1;
		default:
			return 1;
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	/* static NSString *CellIdentifier = @"Cell";
	 
	 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	 if (cell == nil) {
	 cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	 }
	 
	 // Configure the cell...
	 
	 return cell;*/
	
	
	NSInteger row = [indexPath row];
	NSInteger section = [indexPath section];
	UITableViewCell *cell;
	
	switch (section) 
	{
		case 0:
			if (row == 0) {
				// Add a text field to the cell
				cell = [tableView dequeueReusableCellWithIdentifier:@"textCell"];
				if (!cell) {
					cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"textCell"] autorelease];
					
					UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 10.0f, 200.0f, 20.0f)];
					[label setText:@"Room:"];
					[cell addSubview:label];
					[label release];
					
					[cell addSubview:[[UITextField alloc] initWithFrame:CGRectMake(20.0f, 40.0f, 280.0f, 30.0f)]];
					
					tf = [[cell subviews] lastObject];
					tf.placeholder = @"Room";
					tf.delegate = self;
					tf.borderStyle = UITextBorderStyleBezel;
					
					cell.selectionStyle = UITableViewCellSelectionStyleNone;
					
				}
				
				return cell;
			}	
			
			break;
		case 1:
			
			if (IsDoneClicked) 
			{
				cell = [tableView dequeueReusableCellWithIdentifier:@"textCell"];
				if (!cell) {
					cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"textCell"] autorelease];
				}
				
				if (row == 0) 
				{
					/*UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
					button.titleLabel.text = @"Foo Bar";								
					[button setFrame:CGRectMake(-20.0f, 8.0f, 80.0f, 30.0f)];
					[cell.contentView addSubview:button];
					
					UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 12.0f, 200.0f, 20.0f)];
					[label setText:@"Add Room"];
					[cell addSubview:label];
					[label release];
					[cell addSubview:[[UITextField alloc] initWithFrame:CGRectMake(100.0f, 40.0f, 280.0f, 30.0f)]];
					 */
				
					txtViewDesc = [[UITextView alloc] initWithFrame:CGRectMake(12.0f, 5.0f, 294.0f, 115.0f)];
					txtViewDesc.text = @"some text";
					txtViewDesc.backgroundColor = [UIColor clearColor];
					txtViewDesc.delegate = self;
					//some other setup like setting the font for the UITextView...
					[cell addSubview:txtViewDesc];
					//[myTextView sizeToFit];
				}
				
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				return cell;
			}
			break;
	
		default:
			break;
	}
	
	// Return a generic cell if all else fails
	cell = [tableView dequeueReusableCellWithIdentifier:@"any-cell"];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"any-cell"] autorelease];
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

