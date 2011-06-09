//
//  DetailView.m
//  Natolli
//
//  Created by Nidhi Sharma on 25/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailView.h"
#import "MapViewController.h"

@implementation DetailView
@synthesize Mode, ID;

#pragma mark -
#pragma mark View lifecycle

- (void)ShowMap:(id)sender
{
	MapViewController *objMapViewController = [[MapViewController alloc] initWithNibName:@"MapView" bundle:nil];
	
	if (self.Mode == @"PROPERTY") {
		objMapViewController.address = @"Dubai";
	}
	else if (self.Mode == @"LANDLORD")
	{
		objMapViewController.address = @"London";
	}
	else if (self.Mode == @"CLERK")
	{
		objMapViewController.address = @"Australia";
	}
	else if (self.Mode == @"EA")
	{
		objMapViewController.address = @"South Africa";
	}
	
	
	[self.navigationController pushViewController:objMapViewController animated:YES];
	[objMapViewController release];
}

- (void)aButtonClicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

	
	//self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
	
	if (self.Mode == @"PROPERTY")
	{
		self.title = @"Property Details";
	}
	else if (self.Mode == @"LANDLORD")
	{
		self.title = @"Landlord Details";
	}
	else if (self.Mode == @"CLERK")
	{
		self.title = @"Clerk Details";
	}
	else if (self.Mode == @"EA")
	{
		self.title = @"EA Details";
	}
	
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.46 
																		green:0.70
																		 blue:0.08
																		alpha:1.0f];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(aButtonClicked:)];
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Map View" style:UIBarButtonItemStyleBordered target:self action:@selector(ShowMap:)];
	self.navigationItem.hidesBackButton = YES;
	
	
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
    return 11;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];	
	aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	aCell.selectionStyle = UITableViewCellSelectionStyleNone;
	aCell.accessoryType = UITableViewCellAccessoryNone;
	
	if (indexPath.row == 0)
	{		
		UILabel *lblHouseNumber  = [[[UILabel alloc] init] autorelease];
		[lblHouseNumber setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblHouseNumber setBackgroundColor:[UIColor clearColor]];
		lblHouseNumber.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblHouseNumber.font = [UIFont boldSystemFontOfSize:17];
		lblHouseNumber.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		
		if (self.Mode == @"PROPERTY") {
			[lblHouseNumber setText:@"House No."];
		}
		else {
			[lblHouseNumber setText:@"Title"];
		}

		
		lblHouseNumber.numberOfLines =0;
		[aCell addSubview:lblHouseNumber];

		UILabel *lblHouseNumber_value  = [[[UILabel alloc] init]autorelease];
		[lblHouseNumber_value setFrame:CGRectMake(190,10, 200,24.0f)];		
		[lblHouseNumber_value setBackgroundColor:[UIColor clearColor]];
		lblHouseNumber_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblHouseNumber_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblHouseNumber_value setText:@"11"];
		}
		else {
			[lblHouseNumber_value setText:@"Mr"];
		}

		lblHouseNumber_value.numberOfLines =0;
		[aCell addSubview:lblHouseNumber_value];
	}
	else if (indexPath.row == 1)
	{		
		UILabel *lblAddress1  = [[[UILabel alloc] init]autorelease];
		[lblAddress1 setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblAddress1 setBackgroundColor:[UIColor clearColor]];
		lblAddress1.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblAddress1.font = [UIFont boldSystemFontOfSize:17];
		lblAddress1.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblAddress1 setText:@"Address1"];
		}
		else {
			[lblAddress1 setText:@"First Name"];
		}

		lblAddress1.numberOfLines =0;
		[aCell addSubview:lblAddress1];
		
		UILabel *lblAddress1_value  = [[[UILabel alloc] init]autorelease];
		[lblAddress1_value setFrame:CGRectMake(190,10, 200,24.0f)];		
		[lblAddress1_value setBackgroundColor:[UIColor clearColor]];
		lblAddress1_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblAddress1_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblAddress1_value setText:@"Liften Road"];
		}
		else 
		{
			if ([self.ID isEqualToString:@"6"]) {
				[lblAddress1_value setText:@"Lauren"];
			}
			else if ([self.ID isEqualToString:@"7"]) {
				[lblAddress1_value setText:@"Jake"];
			}
			else if ([self.ID isEqualToString:@"8"]) {
				[lblAddress1_value setText:@"Cindy"];
			}

		}

		lblAddress1_value.numberOfLines =0;
		[aCell addSubview:lblAddress1_value];
	}
	else if (indexPath.row == 2)
	{		
		UILabel *lblAddress2  = [[[UILabel alloc] init]autorelease];
		[lblAddress2 setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblAddress2 setBackgroundColor:[UIColor clearColor]];
		lblAddress2.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblAddress2.font = [UIFont boldSystemFontOfSize:17];
		lblAddress2.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblAddress2 setText:@"Address2"];
		}
		else {
			[lblAddress2 setText:@"Last Name"];
		}

		lblAddress2.numberOfLines =0;
		[aCell addSubview:lblAddress2];
		
		UILabel *lblAddress2_value  = [[[UILabel alloc] init]autorelease];
		[lblAddress2_value setFrame:CGRectMake(190,10, 200,24.0f)];		
		[lblAddress2_value setBackgroundColor:[UIColor clearColor]];
		lblAddress2_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblAddress2_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblAddress2_value setText:@"N/A"];
		}
		else {
			//[lblAddress2_value setText:@"Kelley"];
			if ([self.ID isEqualToString:@"6"]) {
				[lblAddress2_value setText:@"Mckeown"];
			}
			else if ([self.ID isEqualToString:@"7"]) {
				[lblAddress2_value setText:@"Kelly"];
			}
			else if ([self.ID isEqualToString:@"8"]) {
				[lblAddress2_value setText:@"Wittstock"];
			}
		}

		
		lblAddress2_value.numberOfLines =0;
		[aCell addSubview:lblAddress2_value];
	}
	else if (indexPath.row == 3)
	{		
		UILabel *lblCity  = [[[UILabel alloc] init]autorelease];
		[lblCity setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblCity setBackgroundColor:[UIColor clearColor]];
		lblCity.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblCity.font = [UIFont boldSystemFontOfSize:17];
		lblCity.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblCity setText:@"City"];
		}
		else {
			[lblCity setText:@"Address Line 1"];
		}

		lblCity.numberOfLines =0;
		[aCell addSubview:lblCity];
		
		UILabel *lblCity_value  = [[[UILabel alloc] init]autorelease];
		[lblCity_value setFrame:CGRectMake(190,10, 117,24.0f)];		
		[lblCity_value setBackgroundColor:[UIColor clearColor]];
		lblCity_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblCity_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblCity_value setText:@"Fulham"];
		}
		else {
			//[lblCity_value setText:@"67 gowland road"];
			if ([self.ID isEqualToString:@"6"]) {
				[lblCity_value setText:@"67 gowland road"];
			}
			else if ([self.ID isEqualToString:@"7"]) {
				[lblCity_value setText:@"new road"];
			}
			else if ([self.ID isEqualToString:@"8"]) {
				[lblCity_value setText:@"abc"];
			}
			
		}

		lblCity_value.numberOfLines =0;
		[aCell addSubview:lblCity_value];
	}
	else if (indexPath.row == 4)
	{		
		UILabel *lblCountry = [[[UILabel alloc] init]autorelease];
		[lblCountry setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblCountry setBackgroundColor:[UIColor clearColor]];
		lblCountry.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblCountry.font = [UIFont boldSystemFontOfSize:17];
		lblCountry.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblCountry setText:@"Country"];
		}
		else {
			[lblCountry setText:@"Address Line 1"];
		}

		lblCountry.numberOfLines =0;
		[aCell addSubview:lblCountry];
		
		UILabel *lblCountry_value  = [[[UILabel alloc] init]autorelease];
		[lblCountry_value setFrame:CGRectMake(190,10, 128,24.0f)];		
		[lblCountry_value setBackgroundColor:[UIColor clearColor]];
		lblCountry_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblCountry_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
				
		if (self.Mode == @"PROPERTY") {
			[lblCountry_value setText:@"London"];
		}
		else {
			//[lblCountry_value setText:@"N/A"];
			if ([self.ID isEqualToString:@"6"]) {
				[lblCountry_value setText:@"N/A"];
			}
			else if ([self.ID isEqualToString:@"7"]) {
				[lblCountry_value setText:@"N/A"];
			}
			else if ([self.ID isEqualToString:@"8"]) {
				[lblCountry_value setText:@"N/A"];
			}
		}

		lblCountry_value.numberOfLines =0;
		[aCell addSubview:lblCountry_value];
	}
	else if (indexPath.row == 5)
	{		
		UILabel *lblPC = [[[UILabel alloc] init]autorelease];
		[lblPC setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblPC setBackgroundColor:[UIColor clearColor]];
		lblPC.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblPC.font = [UIFont boldSystemFontOfSize:17];
		lblPC.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		
		if (self.Mode == @"PROPERTY") {
			[lblPC setText:@"PostCode"];
		}
		else {
			[lblPC setText:@"City"];
		}

		lblPC.numberOfLines =0;
		[aCell addSubview:lblPC];
		
		UILabel *lblPC_value  = [[[UILabel alloc] init]autorelease];
		[lblPC_value setFrame:CGRectMake(190,10, 128,24.0f)];		
		[lblPC_value setBackgroundColor:[UIColor clearColor]];
		lblPC_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblPC_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblPC_value setText:@"SW6 1UW"];
		}
		else {
			//[lblPC_value setText:@"Chelsea"];
			if ([self.ID isEqualToString:@"6"]) {
				[lblPC_value setText:@"Chelsea"];
			}
			else if ([self.ID isEqualToString:@"7"]) {
				[lblPC_value setText:@"N/A"];
			}
			else if ([self.ID isEqualToString:@"8"]) {
				[lblPC_value setText:@"gh"];
			}
		}

		lblPC_value.numberOfLines =0;
		[aCell addSubview:lblPC_value];
	}
	else if (indexPath.row == 6)
	{		
		UILabel *lblNotes = [[[UILabel alloc] init]autorelease];
		[lblNotes setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblNotes setBackgroundColor:[UIColor clearColor]];
		lblNotes.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblNotes.font = [UIFont boldSystemFontOfSize:17];
		lblNotes.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblNotes setText:@"Notes"];
		}
		else {
			[lblNotes setText:@"Country"];
		}

		lblNotes.numberOfLines =0;
		[aCell addSubview:lblNotes];
		
		UILabel *lblNotes_value  = [[[UILabel alloc] init]autorelease];
		[lblNotes_value setFrame:CGRectMake(190,10, 128,24.0f)];		
		[lblNotes_value setBackgroundColor:[UIColor clearColor]];
		lblNotes_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblNotes_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblNotes_value setText:@"N/A"];
		}
		else {
			[lblNotes_value setText:@"London"];
		}

		lblNotes_value.numberOfLines =0;
		[aCell addSubview:lblNotes_value];
	}
	else if (indexPath.row == 7)
	{		
		UILabel *lblFinishedType = [[[UILabel alloc] init]autorelease];
		[lblFinishedType setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblFinishedType setBackgroundColor:[UIColor clearColor]];
		lblFinishedType.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblFinishedType.font = [UIFont boldSystemFontOfSize:17];
		lblFinishedType.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblFinishedType setText:@"Furnished Type"];
		}
		else {
			[lblFinishedType setText:@"Postcode"];
		}

		lblFinishedType.numberOfLines =0;
		[aCell addSubview:lblFinishedType];
		
		UILabel *lblFinishedType_value  = [[[UILabel alloc] init]autorelease];
		[lblFinishedType_value setFrame:CGRectMake(190,10, 128,24.0f)];		
		[lblFinishedType_value setBackgroundColor:[UIColor clearColor]];
		lblFinishedType_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblFinishedType_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblFinishedType_value setText:@"CheckIn"];
		}
		else {
			//[lblFinishedType_value setText:@"SW10 8BU"];
			if ([self.ID isEqualToString:@"6"]) {
				[lblFinishedType_value setText:@"SW10 8BU"];
			}
			else if ([self.ID isEqualToString:@"7"]) {
				[lblFinishedType_value setText:@"SW13 9RU"];
			}
			else if ([self.ID isEqualToString:@"8"]) {
				[lblFinishedType_value setText:@"SW13 9RU"];
			}
		}

		lblFinishedType_value.numberOfLines =0;
		[aCell addSubview:lblFinishedType_value];
	}
	else if (indexPath.row == 8)
	{		
		UILabel *lblNoOfBedRooms = [[[UILabel alloc] init]autorelease];
		[lblNoOfBedRooms setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblNoOfBedRooms setBackgroundColor:[UIColor clearColor]];
		lblNoOfBedRooms.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblNoOfBedRooms.font = [UIFont boldSystemFontOfSize:17];
		lblNoOfBedRooms.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblNoOfBedRooms setText:@"No. of Bedrooms"];
		}
		else {
			[lblNoOfBedRooms setText:@"Home Tel No."];
		}

		lblNoOfBedRooms.numberOfLines =0;
		[aCell addSubview:lblNoOfBedRooms];
		
		UILabel *lblNoOfBedRooms_value  = [[[UILabel alloc] init]autorelease];
		[lblNoOfBedRooms_value setFrame:CGRectMake(190,10, 128,24.0f)];		
		[lblNoOfBedRooms_value setBackgroundColor:[UIColor clearColor]];
		lblNoOfBedRooms_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblNoOfBedRooms_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblNoOfBedRooms_value setText:@"4"];
		}
		else {
			//[lblNoOfBedRooms_value setText:@"0784 621 5223"];
			
			if ([self.ID isEqualToString:@"6"]) {
				[lblNoOfBedRooms_value setText:@"0784 621 5223"];
			}
			else if ([self.ID isEqualToString:@"7"]) {
				[lblNoOfBedRooms_value setText:@"2884 321 5903"];
			}
			else if ([self.ID isEqualToString:@"8"]) {
				[lblNoOfBedRooms_value setText:@"1864 721 8803"];
			}
		}

		lblNoOfBedRooms_value.numberOfLines =0;
		[aCell addSubview:lblNoOfBedRooms_value];
	}
	else if (indexPath.row == 9)
	{		
		UILabel *lblNoOfBath = [[[UILabel alloc] init]autorelease];
		[lblNoOfBath setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblNoOfBath setBackgroundColor:[UIColor clearColor]];
		lblNoOfBath.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblNoOfBath.font = [UIFont boldSystemFontOfSize:17];
		lblNoOfBath.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblNoOfBath setText:@"No. of Bathrooms"];
		}
		else {
			[lblNoOfBath setText:@"Mobile No."];
		}

		lblNoOfBath.numberOfLines =0;
		[aCell addSubview:lblNoOfBath];
		
		UILabel *lblNoOfBath_value  = [[[UILabel alloc] init]autorelease];
		[lblNoOfBath_value setFrame:CGRectMake(190,10, 128,24.0f)];		
		[lblNoOfBath_value setBackgroundColor:[UIColor clearColor]];
		lblNoOfBath_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblNoOfBath_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblNoOfBath_value setText:@"4"];
		}
		else {
			//[lblNoOfBath_value setText:@"N/A"];
			if ([self.ID isEqualToString:@"6"]) {
				[lblNoOfBath_value setText:@"N/A"];
			}
			else if ([self.ID isEqualToString:@"7"]) {
				[lblNoOfBath_value setText:@"N/A"];
			}
			else if ([self.ID isEqualToString:@"8"]) {
				[lblNoOfBath_value setText:@"N/A"];
			}
		}

		lblNoOfBath_value.numberOfLines =0;
		[aCell addSubview:lblNoOfBath_value];
	}
	else if (indexPath.row == 10)
	{		
		UILabel *lblNoOfRec = [[[UILabel alloc] init]autorelease];
		[lblNoOfRec setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblNoOfRec setBackgroundColor:[UIColor clearColor]];
		lblNoOfRec.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblNoOfRec.font = [UIFont boldSystemFontOfSize:17];
		lblNoOfRec.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblNoOfRec setText:@"No. of Reception"];
		}
		else {
			[lblNoOfRec setText:@"Company Name"];
		}

		lblNoOfRec.numberOfLines =0;
		[aCell addSubview:lblNoOfRec];
		
		UILabel *lblNoOfRec_value  = [[[UILabel alloc] init]autorelease];
		[lblNoOfRec_value setFrame:CGRectMake(190,10, 128,24.0f)];		
		[lblNoOfRec_value setBackgroundColor:[UIColor clearColor]];
		lblNoOfRec_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblNoOfRec_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		if (self.Mode == @"PROPERTY") {
			[lblNoOfRec_value setText:@"3"];
		}
		else {
			//[lblNoOfRec_value setText:@"JK Property"];
			if ([self.ID isEqualToString:@"6"]) {
				[lblNoOfRec_value setText:@"JK Property"];
			}
			else if ([self.ID isEqualToString:@"7"]) {
				[lblNoOfRec_value setText:@"A"];
			}
			else if ([self.ID isEqualToString:@"8"]) {
				[lblNoOfRec_value setText:@"Property"];
			}
		}

		lblNoOfRec_value.numberOfLines =0;
		[aCell addSubview:lblNoOfRec_value];
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

