//
//  AddDetails.m
//  Natolli
//
//  Created by Nidhi Sharma on 07/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddDetails.h"
#import "Level1.h"
#import "Exterior.h"

@implementation AddDetails


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Add Details";

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


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	aCell.selectionStyle = UITableViewCellSelectionStyleNone;
	aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	if (indexPath.row == 0)
	{		
		UILabel *lblInterior  = [[[UILabel alloc] init]autorelease];
		[lblInterior setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblInterior setBackgroundColor:[UIColor clearColor]];
		lblInterior.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblInterior.font = [UIFont boldSystemFontOfSize:17];
		lblInterior.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblInterior setText:@"Inspect Interior Area"];
		lblInterior.numberOfLines =0;
		[aCell addSubview:lblInterior];
	}
	else if (indexPath.row == 1)
	{		
		UILabel *lblExterior  = [[[UILabel alloc] init]autorelease];
		[lblExterior setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblExterior setBackgroundColor:[UIColor clearColor]];
		lblExterior.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblExterior.font = [UIFont boldSystemFontOfSize:17];
		lblExterior.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblExterior setText:@"Inspect Exterior Area"];
		lblExterior.numberOfLines =0;
		[aCell addSubview:lblExterior];

	}

	return aCell;
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

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.row == 0) 
	{
		Level1 *objLevel1 = [[Level1 alloc] initWithNibName:@"Level1" bundle:nil];
		[self.navigationController pushViewController:objLevel1 animated:YES];
		[objLevel1 release];
	}
	else 
	{
		Exterior *objExterior = [[Exterior alloc] initWithNibName:@"Exterior" bundle:nil];
		[self.navigationController pushViewController:objExterior animated:YES];
		[objExterior release];
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

