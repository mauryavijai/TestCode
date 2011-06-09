//
//  Level0.m
//  Natolli
//
//  Created by Nidhi Sharma on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Level0.h"
#import "selectStartDate.h"
#import "DetailView.h"
#import "Level1.h"
#import "AddDetails.h"

@implementation Level0
@synthesize lblStartDate_value, lblStartTime_value, strStartDate, strStartTime;
@synthesize lblEndDate_value, lblEndTime_value, strEndDate, strEndTime, strInType, lblInventoryType_value;
@synthesize strInStatus, lblInsStatus_value, txtVw;
#pragma mark -
#pragma mark View lifecycle

- (void)aButtonClicked:(id)sender {
	
	[CCommon UpdateInspectionDetails:[[CCommon objCCommon]mstrSelectedSDate] StartTime:[[CCommon objCCommon]mstrSelectedStartTime] EndDate:[[CCommon objCCommon]mstrSelectedEndDate] EndTime:[[CCommon objCCommon]mstrSelectedEndTime] InventoryType:[[CCommon objCCommon]mstrSelectedInType] InventoryStatus:[[CCommon objCCommon]mstrSelectedInStatus] Notes:[[CCommon objCCommon]mstrNotes]];

	 /*Level1 *objLevel1 = [[Level1 alloc] initWithNibName:@"Level1" bundle:nil];
	 [self.navigationController pushViewController:objLevel1 animated:YES];
	 [objLevel1 release];*/
	
	AddDetails *objAddDetails = [[AddDetails alloc] initWithNibName:@"AddDetails" bundle:nil];
	[self.navigationController pushViewController:objAddDetails animated:YES];
	[objAddDetails release];
}

- (void)viewDidLoad {
    [super viewDidLoad];

	sharedInstance =[CCommon objCCommon];	
	
	
	NSMutableArray *arrValues = [[NSMutableArray alloc] init];
	arrValues = [CCommon Get_Level0_Details];
	
	if ([arrValues count] > 6) {
		
		
		sharedInstance.mstrSelectedSDate = [arrValues objectAtIndex:0];
		sharedInstance.mstrSelectedStartTime = [arrValues objectAtIndex:1];
		
		sharedInstance.mstrSelectedEndDate = [arrValues objectAtIndex:2];
		sharedInstance.mstrSelectedEndTime = [arrValues objectAtIndex:3];
		
		sharedInstance.mstrSelectedInType = [arrValues objectAtIndex:4];
		sharedInstance.mstrSelectedInStatus = [arrValues objectAtIndex:5];
		
		sharedInstance.mstrNotes = [arrValues objectAtIndex:6];
	}
	
	self.title = @"Upcoming Inspections";
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.46 
																		green:0.70
																		 blue:0.08
																		alpha:1.0f];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(aButtonClicked:)];
	
	
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
	
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 11;
}


-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 6;
    return 1.0;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 80.0;
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
	if (indexPath.row == 10) {
		 return 220;
	}
	else
		return 45;
}




// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	//if (aCell == nil)
	//{
		// Make the Display Picker and Create New Contact rows look like buttons	
		aCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
		aCell.selectionStyle = UITableViewCellSelectionStyleNone;
		if (indexPath.row != 10){
			aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		else {
			aCell.accessoryType = UITableViewCellAccessoryNone;
		}

		if (indexPath.row == 0)
		{		
			UILabel *lblStartDate  = [[[UILabel alloc] init] autorelease];
			[lblStartDate setFrame:CGRectMake(18,10, 200,24.0f)];		
			[lblStartDate setBackgroundColor:[UIColor clearColor]];
			lblStartDate.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblStartDate.font = [UIFont boldSystemFontOfSize:17];
			lblStartDate.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			[lblStartDate setText:@"Start Date"];
			lblStartDate.numberOfLines =0;
			[aCell addSubview:lblStartDate];


			//lblStartDate_value  = [[[UILabel alloc] init]autorelease];
			lblStartDate_value  = [[UILabel alloc] init];
			[lblStartDate_value setFrame:CGRectMake(160,10, 200,24.0f)];		
			[lblStartDate_value setBackgroundColor:[UIColor clearColor]];
			lblStartDate_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblStartDate_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
	
			/*UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:[[CCommon objCCommon]mstrSelectedSDate]
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];*/
			
			//[lblStartDate_value setText:strStartDate];
			
			[lblStartDate_value setText:[[CCommon objCCommon]mstrSelectedSDate]];
			
			lblStartDate_value.numberOfLines =0;
			[aCell addSubview:lblStartDate_value];
		}
		else if (indexPath.row == 1)
		{		
			UILabel *lblStartTime  = [[[UILabel alloc] init]autorelease];
			[lblStartTime setFrame:CGRectMake(18,10, 200,24.0f)];		
			[lblStartTime setBackgroundColor:[UIColor clearColor]];
			lblStartTime.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblStartTime.font = [UIFont boldSystemFontOfSize:17];
			lblStartTime.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			[lblStartTime setText:@"Start Time"];
			lblStartTime.numberOfLines =0;
			[aCell addSubview:lblStartTime];
			
			lblStartTime_value  = [[[UILabel alloc] init]autorelease];
			[lblStartTime_value setFrame:CGRectMake(160,10, 200,24.0f)];		
			[lblStartTime_value setBackgroundColor:[UIColor clearColor]];
			lblStartTime_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblStartTime_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 

			//[lblStartTime_value setText:strStartTime];
			[lblStartTime_value setText:[[CCommon objCCommon]mstrSelectedStartTime]];
			

			lblStartTime_value.numberOfLines =0;
			[aCell addSubview:lblStartTime_value];
		}
		else if (indexPath.row == 2)
		{		
			UILabel *lblEndDate  = [[[UILabel alloc] init]autorelease];
			[lblEndDate setFrame:CGRectMake(18,10, 200,24.0f)];		
			[lblEndDate setBackgroundColor:[UIColor clearColor]];
			lblEndDate.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblEndDate.font = [UIFont boldSystemFontOfSize:17];
			lblEndDate.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			[lblEndDate setText:@"End Date"];
			lblEndDate.numberOfLines =0;
			[aCell addSubview:lblEndDate];
		
			lblEndDate_value  = [[[UILabel alloc] init]autorelease];
			[lblEndDate_value setFrame:CGRectMake(160,10, 200,24.0f)];		
			[lblEndDate_value setBackgroundColor:[UIColor clearColor]];
			lblEndDate_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblEndDate_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
			//[lblEndDate_value setText:@"25/03/2011"];
			//[lblEndDate_value setText:strEndDate];
			
			[lblEndDate_value setText:[[CCommon objCCommon]mstrSelectedEndDate]];

			lblEndDate_value.numberOfLines =0;
			[aCell addSubview:lblEndDate_value];
		}
		else if (indexPath.row == 3)
		{		
			UILabel *lblEndTime  = [[[UILabel alloc] init]autorelease];
			[lblEndTime setFrame:CGRectMake(18,10, 200,24.0f)];		
			[lblEndTime setBackgroundColor:[UIColor clearColor]];
			lblEndTime.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblEndTime.font = [UIFont boldSystemFontOfSize:17];
			lblEndTime.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			[lblEndTime setText:@"End Time"];
			lblEndTime.numberOfLines =0;
			[aCell addSubview:lblEndTime];
			
			lblEndTime_value  = [[[UILabel alloc] init]autorelease];
			[lblEndTime_value setFrame:CGRectMake(160,10, 200,24.0f)];		
			[lblEndTime_value setBackgroundColor:[UIColor clearColor]];
			lblEndTime_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblEndTime_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
			//[lblEndTime_value setText:@"04:05:55"];
			//[lblEndTime_value setText:strEndTime];
			[lblEndTime_value setText:[[CCommon objCCommon]mstrSelectedEndTime]];
			lblEndTime_value.numberOfLines =0;
			[aCell addSubview:lblEndTime_value];
		}
		else if (indexPath.row == 4)
		{		
			UILabel *lblInventoryType = [[[UILabel alloc] init]autorelease];
			[lblInventoryType setFrame:CGRectMake(18,10, 200,24.0f)];		
			[lblInventoryType setBackgroundColor:[UIColor clearColor]];
			lblInventoryType.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblInventoryType.font = [UIFont boldSystemFontOfSize:17];
			lblInventoryType.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			[lblInventoryType setText:@"Inventory Type"];
			lblInventoryType.numberOfLines =0;
			[aCell addSubview:lblInventoryType];
		
			lblInventoryType_value  = [[[UILabel alloc] init]autorelease];
			[lblInventoryType_value setFrame:CGRectMake(160,10, 128,24.0f)];		
			[lblInventoryType_value setBackgroundColor:[UIColor clearColor]];
			lblInventoryType_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblInventoryType_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
			//[lblInventoryType_value setText:@"check in"];
			//[lblInventoryType_value setText:strInType];
			[lblInventoryType_value setText:[[CCommon objCCommon]mstrSelectedInType]];

			lblInventoryType_value.numberOfLines =0;
			[aCell addSubview:lblInventoryType_value];
		}
		else if (indexPath.row == 5)
		{		
			UILabel *lblProperty = [[[UILabel alloc] init]autorelease];
			[lblProperty setFrame:CGRectMake(18,10, 200,24.0f)];		
			[lblProperty setBackgroundColor:[UIColor clearColor]];
			lblProperty.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblProperty.font = [UIFont boldSystemFontOfSize:17];
			lblProperty.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			[lblProperty setText:@"Property"];
			lblProperty.numberOfLines =0;
			[aCell addSubview:lblProperty];
		
			UILabel *lblProperty_value  = [[[UILabel alloc] init]autorelease];
			[lblProperty_value setFrame:CGRectMake(160,10, 200,24.0f)];		
			[lblProperty_value setBackgroundColor:[UIColor clearColor]];
			lblProperty_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblProperty_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
			[lblProperty_value setText:@"11, Liften Road"];
			lblProperty_value.numberOfLines =0;
			[aCell addSubview:lblProperty_value];
		}
		else if (indexPath.row == 6)
		{		
			UILabel *lblClerk = [[[UILabel alloc] init]autorelease];
			[lblClerk setFrame:CGRectMake(18,10, 200,24.0f)];		
			[lblClerk setBackgroundColor:[UIColor clearColor]];
			lblClerk.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblClerk.font = [UIFont boldSystemFontOfSize:17];
			lblClerk.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			[lblClerk setText:@"Clerk"];
			lblClerk.numberOfLines =0;
			[aCell addSubview:lblClerk];
		
			UILabel *lblClerk_value  = [[[UILabel alloc] init]autorelease];
			[lblClerk_value setFrame:CGRectMake(160,10, 200,24.0f)];		
			[lblClerk_value setBackgroundColor:[UIColor clearColor]];
			lblClerk_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblClerk_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
			[lblClerk_value setText:@"Lauren Mckeown"];
			lblClerk_value.numberOfLines =0;
			[aCell addSubview:lblClerk_value];
		}
		else if (indexPath.row == 7)
		{		
			UILabel *lblLandlord = [[[UILabel alloc] init]autorelease];
			[lblLandlord setFrame:CGRectMake(18,10, 200,24.0f)];		
			[lblLandlord setBackgroundColor:[UIColor clearColor]];
			lblLandlord.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblLandlord.font = [UIFont boldSystemFontOfSize:17];
			lblLandlord.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			[lblLandlord setText:@"Landlord"];
			lblLandlord.numberOfLines =0;
			[aCell addSubview:lblLandlord];
		
			UILabel *lblLandlord_value  = [[[UILabel alloc] init]autorelease];
			[lblLandlord_value setFrame:CGRectMake(160,10, 200,24.0f)];		
			[lblLandlord_value setBackgroundColor:[UIColor clearColor]];
			lblLandlord_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblLandlord_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
			[lblLandlord_value setText:@"Jake Kelley"];
			lblLandlord_value.numberOfLines =0;
			[aCell addSubview:lblLandlord_value];
		}
		else if (indexPath.row == 8)
		{		
			/*UILabel *lblTenant = [[UILabel alloc] init];
			[lblTenant setFrame:CGRectMake(18,10, 200,24.0f)];		
			[lblTenant setBackgroundColor:[UIColor clearColor]];
			lblTenant.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblTenant.font = [UIFont boldSystemFontOfSize:17];
			lblTenant.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			[lblTenant setText:@"Tenant"];
			lblTenant.numberOfLines =0;
			[aCell addSubview:lblTenant];
		
			UILabel *lblTenant_value  = [[UILabel alloc] init];
			[lblTenant_value setFrame:CGRectMake(160,10, 200,24.0f)];		
			[lblTenant_value setBackgroundColor:[UIColor clearColor]];
			lblTenant_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblTenant_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
			[lblTenant_value setText:@"N/A"];
			lblTenant_value.numberOfLines =0;
			[aCell addSubview:lblTenant_value];*/
			
			
			UILabel *lblEstateAgent = [[[UILabel alloc] init]autorelease];
			[lblEstateAgent setFrame:CGRectMake(18,10, 200,24.0f)];		
			[lblEstateAgent setBackgroundColor:[UIColor clearColor]];
			lblEstateAgent.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblEstateAgent.font = [UIFont boldSystemFontOfSize:17];
			lblEstateAgent.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			[lblEstateAgent setText:@"Estate Agent"];
			lblEstateAgent.numberOfLines =0;
			[aCell addSubview:lblEstateAgent];
			
			UILabel *lblEstateAgent_value  = [[[UILabel alloc] init]autorelease];
			[lblEstateAgent_value setFrame:CGRectMake(160,10, 200,24.0f)];		
			[lblEstateAgent_value setBackgroundColor:[UIColor clearColor]];
			lblEstateAgent_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblEstateAgent_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
			[lblEstateAgent_value setText:@"Cindy Wittstock"];
			lblEstateAgent_value.numberOfLines =0;
			[aCell addSubview:lblEstateAgent_value];

		}
		else if (indexPath.row == 9)
		{		
			
			UILabel *lblInsStatus =[[[UILabel alloc] init]autorelease];
			[lblInsStatus setFrame:CGRectMake(18,10, 200,24.0f)];		
			[lblInsStatus setBackgroundColor:[UIColor clearColor]];
			lblInsStatus.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblInsStatus.font = [UIFont boldSystemFontOfSize:17];
			lblInsStatus.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			[lblInsStatus setText:@"Inspection Status"];
			lblInsStatus.numberOfLines =0;
			[aCell addSubview:lblInsStatus];
			
			lblInsStatus_value  = [[[UILabel alloc] init]autorelease];
			[lblInsStatus_value setFrame:CGRectMake(168,10, 200,24.0f)];		
			[lblInsStatus_value setBackgroundColor:[UIColor clearColor]];
			lblInsStatus_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblInsStatus_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
			//[lblInsStatus_value setText:@"Pending"];
			[lblInsStatus_value setText:[[CCommon objCCommon]mstrSelectedInStatus]];

			lblInsStatus_value.numberOfLines =0;
			[aCell addSubview:lblInsStatus_value];
		}
		else if (indexPath.row == 10)
		{	
			UILabel *lblNotes = [[[UILabel alloc] init]autorelease];
			[lblNotes setFrame:CGRectMake(18,10, 200,24.0f)];		
			[lblNotes setBackgroundColor:[UIColor clearColor]];
			lblNotes.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblNotes.font = [UIFont boldSystemFontOfSize:17];
			lblNotes.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			[lblNotes setText:@"Notes"];
			lblNotes.numberOfLines =0;
			[aCell addSubview:lblNotes];

			txtVw = [[UITextView alloc]initWithFrame:CGRectMake(18.0f, 35.0f, 282.0f, 135.0f)];
			txtVw.layer.borderWidth = 1.0f;
			txtVw.font = [UIFont fontWithName:@"Arial" size: 14.0];
			txtVw.delegate = self;
			txtVw.layer.cornerRadius = 5;
			txtVw.layer.borderWidth = 1;
			txtVw.layer.borderColor = [[UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0] CGColor];
			[txtVw setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
			txtVw.textColor = [UIColor colorWithRed:0.47 green:0.47 blue:0.47 alpha:1.0];
			txtVw.text = [[CCommon objCCommon]mstrNotes]; 
			
			//[txtVw setBackgroundColor:[UIColor redColor]];
			[aCell addSubview:txtVw];
			
			UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
			[btnSave setFrame:CGRectMake(18, 176,141 , 40)];
			//[btnSave setTitle:@"Save" forState:UIControlStateNormal];
			//[btnSave setFont:[UIFont boldSystemFontOfSize:20]];
			[btnSave setBackgroundImage:[[UIImage imageNamed:@"btn_save.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
			[btnSave addTarget:self action:@selector(aButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
			[aCell addSubview:btnSave];
		}
		/*else if (indexPath.row == 11)
		{		
			UILabel *lblNotes = [[[UILabel alloc] init]autorelease];
			[lblNotes setFrame:CGRectMake(18,10, 200,24.0f)];		
			[lblNotes setBackgroundColor:[UIColor clearColor]];
			lblNotes.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			lblNotes.font = [UIFont boldSystemFontOfSize:17];
			lblNotes.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			[lblNotes setText:@"Notes"];
			lblNotes.numberOfLines =0;
			[aCell addSubview:lblNotes];
			
			
			UITextView *txtVwNotes = [[UITextView alloc]initWithFrame:CGRectMake(18.0f, 35.0f, 285.0f, 135.0f)];
			txtVwNotes.layer.borderWidth = 1.0f;
			txtVwNotes.font = [UIFont fontWithName:@"Arial" size: 14.0];
			[aCell addSubview:txtVwNotes];
		}*/
		
	//}
		
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

	
	if (indexPath.row == 0)
	{
		selectStartDate *objselectStartDate = [[selectStartDate alloc] initWithNibName:@"selectStartDate" bundle:nil];
		objselectStartDate.Mode = @"DATE";		

		NSString *value =  lblStartTime_value.text;
		if([value length] != 0)
		{
			objselectStartDate.SelectedStartTime = value;
		}
		
		NSString *value1 =  lblStartDate_value.text;
		if([value1 length] != 0)
		{
			objselectStartDate.SelectedSDate = value1;
		}
		
		NSString *value2 =  lblEndTime_value.text;
		if([value2 length] != 0)
		{
			objselectStartDate.SelectedEndTime = value2;
		}
		
		NSString *value3 =  lblEndDate_value.text;
		if([value3 length] != 0)
		{
			objselectStartDate.SelectedEndDate = value3;
		}
		
		NSString *value4 =  lblInventoryType_value.text;
		if([value4 length] != 0)
		{
			objselectStartDate.SelectedInType = value4;
		}
		NSString *value5 =  lblInsStatus_value.text;
		if([value5 length] != 0)
		{
			objselectStartDate.SelectedInStatus = value5;
		}
		
		[self.navigationController pushViewController:objselectStartDate animated:YES];
		[objselectStartDate release];
	}
	else if (indexPath.row == 1)
	{
		selectStartDate *objselectStartDate = [[selectStartDate alloc] initWithNibName:@"selectStartDate" bundle:nil];
		objselectStartDate.Mode = @"TIME";	
		NSString *value =  lblStartTime_value.text;
		if([value length] != 0)
		{
			objselectStartDate.SelectedStartTime = value;
		}
		
		NSString *value1 =  lblStartDate_value.text;
		if([value1 length] != 0)
		{
			objselectStartDate.SelectedSDate = value1;
		}
		NSString *value2 =  lblEndTime_value.text;
		if([value2 length] != 0)
		{
			objselectStartDate.SelectedEndTime = value2;
		}
		
		NSString *value3 =  lblEndDate_value.text;
		if([value3 length] != 0)
		{
			objselectStartDate.SelectedEndDate = value3;
		}
		
		NSString *value4 =  lblInventoryType_value.text;
		if([value4 length] != 0)
		{
			objselectStartDate.SelectedInType = value4;
		}
		NSString *value5 =  lblInsStatus_value.text;
		if([value5 length] != 0)
		{
			objselectStartDate.SelectedInStatus = value5;
		}

		[self.navigationController pushViewController:objselectStartDate animated:YES];
		[objselectStartDate release];	
	}
	else if (indexPath.row == 2)
	{
		selectStartDate *objselectStartDate = [[selectStartDate alloc] initWithNibName:@"selectStartDate" bundle:nil];
		objselectStartDate.Mode = @"ENDDATE";		
		NSString *value =  lblStartTime_value.text;
		if([value length] != 0)
		{
			objselectStartDate.SelectedStartTime = value;
		}
		
		NSString *value1 =  lblStartDate_value.text;
		if([value1 length] != 0)
		{
			objselectStartDate.SelectedSDate = value1;
		}
		NSString *value2 =  lblEndTime_value.text;
		if([value2 length] != 0)
		{
			objselectStartDate.SelectedEndTime = value2;
		}
		
		NSString *value3 =  lblEndDate_value.text;
		if([value3 length] != 0)
		{
			objselectStartDate.SelectedEndDate = value3;
		}	
		
		NSString *value4 =  lblInventoryType_value.text;
		if([value4 length] != 0)
		{
			objselectStartDate.SelectedInType = value4;
		}
		NSString *value5 =  lblInsStatus_value.text;
		if([value5 length] != 0)
		{
			objselectStartDate.SelectedInStatus = value5;
		}
		
		[self.navigationController pushViewController:objselectStartDate animated:YES];
		[objselectStartDate release];	
	}
	else if (indexPath.row == 3)
	{
		selectStartDate *objselectStartDate = [[selectStartDate alloc] initWithNibName:@"selectStartDate" bundle:nil];
		objselectStartDate.Mode = @"ENDTIME";		
		NSString *value =  lblStartTime_value.text;
		if([value length] != 0)
		{
			objselectStartDate.SelectedStartTime = value;
		}
		
		NSString *value1 =  lblStartDate_value.text;
		if([value1 length] != 0)
		{
			objselectStartDate.SelectedSDate = value1;
		}
		NSString *value2 =  lblEndTime_value.text;
		if([value2 length] != 0)
		{
			objselectStartDate.SelectedEndTime = value2;
		}
		
		NSString *value3 =  lblEndDate_value.text;
		if([value3 length] != 0)
		{
			objselectStartDate.SelectedEndDate = value3;
		}
		NSString *value4 =  lblInventoryType_value.text;
		if([value4 length] != 0)
		{
			objselectStartDate.SelectedInType = value4;
		}
		NSString *value5 =  lblInsStatus_value.text;
		if([value5 length] != 0)
		{
			objselectStartDate.SelectedInStatus = value5;
		}
		
		[self.navigationController pushViewController:objselectStartDate animated:YES];
		[objselectStartDate release];	
	}
	else if (indexPath.row == 4)
	{
		selectStartDate *objselectStartDate = [[selectStartDate alloc] initWithNibName:@"selectStartDate" bundle:nil];
		objselectStartDate.Mode = @"INTY";		
		NSString *value =  lblStartTime_value.text;
		if([value length] != 0)
		{
			objselectStartDate.SelectedStartTime = value;
		}
		
		NSString *value1 =  lblStartDate_value.text;
		if([value1 length] != 0)
		{
			objselectStartDate.SelectedSDate = value1;
		}
		NSString *value2 =  lblEndTime_value.text;
		if([value2 length] != 0)
		{
			objselectStartDate.SelectedEndTime = value2;
		}
		
		NSString *value3 =  lblEndDate_value.text;
		if([value3 length] != 0)
		{
			objselectStartDate.SelectedEndDate = value3;
		}
		NSString *value4 =  lblInventoryType_value.text;
		if([value4 length] != 0)
		{
			objselectStartDate.SelectedInType = value4;
		}
		NSString *value5 =  lblInsStatus_value.text;
		if([value5 length] != 0)
		{
			objselectStartDate.SelectedInStatus = value5;
		}
		
		[self.navigationController pushViewController:objselectStartDate animated:YES];
		[objselectStartDate release];
	}
	else if (indexPath.row == 5)
	{
		DetailView *objDetailView = [[DetailView alloc] initWithNibName:@"DetailView" bundle:nil];
		objDetailView.Mode = @"PROPERTY";
		[self.navigationController pushViewController:objDetailView animated:YES];
		[objDetailView release];
	}
	else if (indexPath.row == 6)
	{
		DetailView *objDetailView = [[DetailView alloc] initWithNibName:@"DetailView" bundle:nil];
		objDetailView.Mode = @"CLERK";
		objDetailView.ID = [@"" stringByAppendingFormat:@"%d", indexPath.row];
		[self.navigationController pushViewController:objDetailView animated:YES];
		[objDetailView release];
	}
	else if (indexPath.row == 7)
	{
		DetailView *objDetailView = [[DetailView alloc] initWithNibName:@"DetailView" bundle:nil];
		objDetailView.Mode = @"LANDLORD";
		objDetailView.ID = [@"" stringByAppendingFormat:@"%d", indexPath.row];
		[self.navigationController pushViewController:objDetailView animated:YES];
		[objDetailView release];
	}
	else if (indexPath.row == 8)
	{
		DetailView *objDetailView = [[DetailView alloc] initWithNibName:@"DetailView" bundle:nil];
		objDetailView.Mode = @"EA";
		objDetailView.ID = [@"" stringByAppendingFormat:@"%d", indexPath.row];
		[self.navigationController pushViewController:objDetailView animated:YES];
		[objDetailView release];
	}
	else if (indexPath.row == 9)
	{
		selectStartDate *objselectStartDate = [[selectStartDate alloc] initWithNibName:@"selectStartDate" bundle:nil];
		objselectStartDate.Mode = @"INSTATUS";		
		NSString *value =  lblStartTime_value.text;
		if([value length] != 0)
		{
			objselectStartDate.SelectedStartTime = value;
		}
		
		
		
		NSString *value2 =  lblEndTime_value.text;
		//NSString *value2 =  @"Nidhi Sharma";
		if([value2 length] != 0)
		{
			objselectStartDate.SelectedEndTime = value2;
		}
		
		NSString *value3 =  lblEndDate_value.text;
		if([value3 length] != 0)
		{
			objselectStartDate.SelectedEndDate = value3;
		}
		NSString *value4 =  lblInventoryType_value.text;
		if([value4 length] != 0)
		{
			objselectStartDate.SelectedInType = value4;
		}
		NSString *value5 =  lblInsStatus_value.text;
		if([value5 length] != 0)
		{
			objselectStartDate.SelectedInStatus = value5;
		}
		
		NSString *value1 =  lblStartDate_value.text;
		if([value1 length] != 0)
		{
			objselectStartDate.SelectedSDate = value1;
		}
		
		[self.navigationController pushViewController:objselectStartDate animated:YES];
		[objselectStartDate release];
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


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
	sharedInstance.mstrNotes = txtVw.text;
	
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
		
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

- (void)dealloc {
    [super dealloc];
}


@end

