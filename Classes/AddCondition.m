//
//  AddCondition.m
//  Natolli
//
//  Created by Nidhi Sharma on 15/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddCondition.h"
#import "selectConditionDetails.h"

@implementation AddCondition
@synthesize txtVw, arrValue, view_otherOption_list, txt;

#pragma mark -
#pragma mark View lifecycle


- (void)UpdateDetails:(id)sender
{	
	[txtVw resignFirstResponder];
	[txt resignFirstResponder];
	
	NSString *strMaintenanceReq = [[CCommon objCCommon]mstrMaintenanceReq];
	NSString *strCleaningReq = [[CCommon objCCommon]mstrCleaningReq];
	
	NSString *strFairUsage = [[CCommon objCCommon]mstrFairUsage];
	NSString *strLandlord = [[CCommon objCCommon]mstrLandlord];
	
	NSString *strTenant = [[CCommon objCCommon]mstrTenant];
	NSString *strFurtherNotes = txtVw.text;
	
	//NSString *strCondition = [[CCommon objCCommon]mstrSelectedCondition];
	NSString *strCondition = txt.text;
	NSString *strQuantity = [[CCommon objCCommon]mstrSelectedQuantity_Condition];
	
	if ([strMaintenanceReq length] == 0) {
		strMaintenanceReq = @" ";
	}
	if ([strCleaningReq length] == 0) {
		strCleaningReq = @" ";
	}
	if ([strFairUsage length] == 0) {
		strFairUsage = @" ";
	}
	if ([strLandlord length] == 0) {
		strLandlord = @" ";
	}
	if ([strTenant length] == 0) {
		strTenant = @" ";
	}
	if ([strFurtherNotes length] == 0) {
		strFurtherNotes = @" ";
	}
	if ([strCondition length] == 0) {
		strCondition = @" ";
	}
	if ([strQuantity length] == 0) {
		strQuantity = @" ";
	}
	
	if	([txt.text length] != 0)
	{
	
	BOOL isItemTypeExists = FALSE;
	int selectedId = [arrValue count] ;
	for (int i =0; i < [arrValue count]; i++)
	{
		NSString *itemType = [arrValue objectAtIndex:i];
		
		if ([[itemType uppercaseString] compare:[txt.text uppercaseString]] == NSOrderedSame)
		{
			isItemTypeExists = TRUE;
			selectedId = i;
		}
	}
	
	if (!isItemTypeExists) 
	{
		[CCommon AddItemConditions2:@"" CleaningRequired:@" " FairUsage:@" " Landlord:@" " Tenant:@" " FurtherNotes:@" " Condition:txt.text Quantity:@" " ParentID:@"'' "];
	}
	
	}
	[CCommon UpdateItemCondition:strMaintenanceReq CleaningReq:strCleaningReq FairUsage:strFairUsage Landlord:strLandlord Tenant:strTenant FurtherNotes:strFurtherNotes Condition:strCondition Quantity:strQuantity ParentID:@"0"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	sharedInstance =[CCommon objCCommon];
	
	NSMutableArray *arrVal = [[NSMutableArray alloc] init];
	arrVal = [CCommon GetConditionDetails];
	
	if ([arrVal count] > 6 )
	{
		sharedInstance.mstrMaintenanceReq = [arrVal objectAtIndex:0];
		sharedInstance.mstrCleaningReq = [arrVal objectAtIndex:1];
		sharedInstance.mstrFairUsage = [arrVal objectAtIndex:2];
		sharedInstance.mstrLandlord = [arrVal objectAtIndex:3];
		sharedInstance.mstrTenant = [arrVal objectAtIndex:4];
		sharedInstance.mstrFurtherNotes = [arrVal objectAtIndex:5];
		
		sharedInstance.mstrSelectedCondition = [arrVal objectAtIndex:6];
		sharedInstance.mstrSelectedQuantity_Condition = [arrVal objectAtIndex:7];

	}
	
	
	self.title = @"Add Conditions";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(UpdateDetails:)];
	
	

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 9;
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
	if (indexPath.row == 2) {
		return 200;
	}
	else if (indexPath.row == 1) {
		return 80.0f;
	}
	else
		return 45;
}

- (void) switchChanged:(id)sender {
    UISwitch* switchControl = sender;
	
	 int row = switchControl.tag;
	
	if (row == 1)
	{
		if (switchControl.on) {
			sharedInstance.mstrLandlord = @"YES";
		}
		else {
			sharedInstance.mstrLandlord = @"NO";
		}

	}
	if (row == 2)
	{
		if (switchControl.on) {
			sharedInstance.mstrTenant = @"YES";
		}
		else {
			sharedInstance.mstrTenant = @"NO";
		}
		
	}
	if (row == 3)
	{
		if (switchControl.on) {
			sharedInstance.mstrFairUsage = @"YES";
		}
		else {
			sharedInstance.mstrFairUsage = @"NO";
		}
		
	}
	if (row == 4)
	{
		if (switchControl.on) {
			sharedInstance.mstrCleaningReq = @"YES";
		}
		else {
			sharedInstance.mstrCleaningReq = @"NO";
		}
		
	}
	if (row == 5)
	{
		if (switchControl.on) {
			sharedInstance.mstrMaintenanceReq = @"YES";
		}
		else {
			sharedInstance.mstrMaintenanceReq = @"NO";
		}
		
	}
	 
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
	if (indexPath.row == 0){
		aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	else {
		aCell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	if (indexPath.row == 0)
	{		
		UILabel *lblQuantity  = [[[UILabel alloc] init] autorelease];
		[lblQuantity setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblQuantity setBackgroundColor:[UIColor clearColor]];
		lblQuantity.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblQuantity.font = [UIFont boldSystemFontOfSize:17];
		lblQuantity.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblQuantity setText:@"Quantity"];
		lblQuantity.numberOfLines =0;
		[aCell addSubview:lblQuantity];
		
		//lblStartDate_value  = [[[UILabel alloc] init]autorelease];
		UILabel *lblQuantity_value  = [[UILabel alloc] init];
		[lblQuantity_value setFrame:CGRectMake(160,10, 200,24.0f)];		
		[lblQuantity_value setBackgroundColor:[UIColor clearColor]];
		lblQuantity_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblQuantity_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		[lblQuantity_value setText:[[CCommon objCCommon]mstrSelectedQuantity_Condition]];
		///[lblQuantity_value setText:@"sss"];
		lblQuantity_value.numberOfLines =0;
		[aCell addSubview:lblQuantity_value];
	}
	else if (indexPath.row == 1)
	{		
		UILabel *lblShape  = [[[UILabel alloc] init]autorelease];
		[lblShape setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblShape setBackgroundColor:[UIColor clearColor]];
		lblShape.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblShape.font = [UIFont boldSystemFontOfSize:17];
		lblShape.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblShape setText:@"Condition"];
		lblShape.numberOfLines =0;
		[aCell addSubview:lblShape];
		
		NSString *value = txt.text;
		txt = [[UITextField alloc] initWithFrame:CGRectMake(17.0f, 40.0f, 280.0f, 30.0f)];
		txt.font = [UIFont fontWithName:@"Arial" size: 14.0];
		txt.delegate = self;
		txt.borderStyle = UITextBorderStyleBezel;
		[txt addTarget:self action:@selector(AutoComplete:) forControlEvents:UIControlEventEditingChanged];
		
		
		if ([value length] == 0)
		{
			//if (self.Mode == @"UPDATE")
			//	txt.text = self.SelectedRoomDetails;
			//else
				txt.text = [[CCommon objCCommon]mstrSelectedCondition];
		}
		else 
			txt.text = value;
		
		[aCell addSubview:txt];
		aCell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	else if (indexPath.row == 2)
	{
		UILabel *lblNotes = [[[UILabel alloc] init]autorelease];
		[lblNotes setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblNotes setBackgroundColor:[UIColor clearColor]];
		lblNotes.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblNotes.font = [UIFont boldSystemFontOfSize:17];
		lblNotes.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblNotes setText:@"Further notes"];
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
		txtVw.text = [[CCommon objCCommon]mstrFurtherNotes];
		
		[aCell addSubview:txtVw];

		}
	else if (indexPath.row == 3)
	{		
		UILabel *lblShadeColor  = [[[UILabel alloc] init]autorelease];
		[lblShadeColor setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblShadeColor setBackgroundColor:[UIColor clearColor]];
		lblShadeColor.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblShadeColor.font = [UIFont boldSystemFontOfSize:17];
		lblShadeColor.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblShadeColor setText:@"Liability:"];
		lblShadeColor.numberOfLines =0;
		[aCell addSubview:lblShadeColor];
	
	}
	else if (indexPath.row == 4)
	{		
		UILabel *lblShadeColor  = [[[UILabel alloc] init]autorelease];
		[lblShadeColor setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblShadeColor setBackgroundColor:[UIColor clearColor]];
		lblShadeColor.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblShadeColor.font = [UIFont boldSystemFontOfSize:17];
		lblShadeColor.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblShadeColor setText:@"Landlord"];
		lblShadeColor.numberOfLines =0;
		[aCell addSubview:lblShadeColor];
		
		UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
		aCell.accessoryView = switchView;
		
		if ([[CCommon objCCommon]mstrLandlord] == @"YES") {
			[switchView setOn:YES animated:NO];
		}
		else {
			[switchView setOn:NO animated:NO];
		}

		
		
		[switchView setTag:1];
		
		[switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
		[switchView release];
	}
	else if (indexPath.row == 5)
	{	
		UILabel *lblShadeColor  = [[[UILabel alloc] init]autorelease];
		[lblShadeColor setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblShadeColor setBackgroundColor:[UIColor clearColor]];
		lblShadeColor.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblShadeColor.font = [UIFont boldSystemFontOfSize:17];
		lblShadeColor.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblShadeColor setText:@"Tenant"];
		lblShadeColor.numberOfLines =0;
		[aCell addSubview:lblShadeColor];
		
		UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
		aCell.accessoryView = switchView;
		//[switchView setOn:NO animated:NO];
		
		if ([[CCommon objCCommon]mstrTenant] == @"YES") {
			[switchView setOn:YES animated:NO];
		}
		else {
			[switchView setOn:NO animated:NO];
		}
		
		[switchView setTag:2];
		[switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
		[switchView release];
		
		
	}
	else if (indexPath.row == 6)
	{	
		UILabel *lblShadeColor  = [[[UILabel alloc] init]autorelease];
		[lblShadeColor setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblShadeColor setBackgroundColor:[UIColor clearColor]];
		lblShadeColor.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblShadeColor.font = [UIFont boldSystemFontOfSize:17];
		lblShadeColor.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblShadeColor setText:@"Fair usage"];
		lblShadeColor.numberOfLines =0;
		[aCell addSubview:lblShadeColor];
		
		UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
		aCell.accessoryView = switchView;
		
		if ([[CCommon objCCommon]mstrFairUsage] == @"YES") {
			[switchView setOn:YES animated:NO];
		}
		else {
			[switchView setOn:NO animated:NO];
		}
		
	//	[switchView setOn:NO animated:NO];
		[switchView setTag:3];
		[switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
		[switchView release];
		
		
	}
	else if (indexPath.row == 7)
	{	
		UILabel *lblShadeColor  = [[[UILabel alloc] init]autorelease];
		[lblShadeColor setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblShadeColor setBackgroundColor:[UIColor clearColor]];
		lblShadeColor.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblShadeColor.font = [UIFont boldSystemFontOfSize:17];
		lblShadeColor.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblShadeColor setText:@"Cleaning required"];
		lblShadeColor.numberOfLines =0;
		[aCell addSubview:lblShadeColor];
		
		UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
		aCell.accessoryView = switchView;
	//	[switchView setOn:NO animated:NO];
		
		if ([[CCommon objCCommon]mstrCleaningReq] == @"YES") {
			[switchView setOn:YES animated:NO];
		}
		else {
			[switchView setOn:NO animated:NO];
		}
		
		[switchView setTag:4];
		[switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
		[switchView release];
	
	}
	else if (indexPath.row == 8)
	{	
		UILabel *lblShadeColor  = [[[UILabel alloc] init]autorelease];
		[lblShadeColor setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblShadeColor setBackgroundColor:[UIColor clearColor]];
		lblShadeColor.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblShadeColor.font = [UIFont boldSystemFontOfSize:17];
		lblShadeColor.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblShadeColor setText:@"Maintenance required"];
		lblShadeColor.numberOfLines =0;
		[aCell addSubview:lblShadeColor];
		
		UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
		aCell.accessoryView = switchView;
		//[switchView setOn:NO animated:NO];
		
		if ([[CCommon objCCommon]mstrMaintenanceReq] == @"YES") {
			[switchView setOn:YES animated:NO];
		}
		else {
			[switchView setOn:NO animated:NO];
		}
		
		[switchView setTag:5];
		[switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
		[switchView release];	
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
    if (indexPath.row == 0)
	{
		
		selectConditionDetails *objLevel_1 = [[selectConditionDetails alloc] initWithNibName:@"selectConditionDetails" bundle:nil];

		objLevel_1.Mode = @"QUANTITY";

		[self.navigationController pushViewController:objLevel_1 animated:YES];
		[objLevel_1 release];
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



-(void)Set
{
	BOOL ColorAdded =  TRUE;
	
	if (IsBrandSelected == YES)
	{
		view_otherOption_list.hidden = TRUE;
		
		IsBrandSelected = NO;
	}
	else {
		
		view_otherOption_list.hidden = TRUE;	
		
		CGFloat yposition = (CGFloat)0;
		CGSize ConstraintSize;
		ConstraintSize.width = 250.0f;
		ConstraintSize.height = MAXFLOAT;
		
		view_otherOption_list = [[UIView alloc]initWithFrame:CGRectMake(28, 192, 280, 100)];
		[view_otherOption_list setBackgroundColor:[UIColor clearColor]];
		view_otherOption_list.hidden = FALSE;
		
		view_otherOption_list.layer.borderColor = [UIColor colorWithRed:0.59 green:0.81 blue:0.55 alpha:1.0f].CGColor;
		view_otherOption_list.layer.borderWidth = 1.0f;
		view_otherOption_list.layer.cornerRadius = 8;
		
		for (int i = 0; i < [arrValue count]; i++)
		{
			CGSize stringsize = [[arrValue objectAtIndex:i] sizeWithFont:[UIFont fontWithName:@"Arial" size:16.0] constrainedToSize: ConstraintSize lineBreakMode:UILineBreakModeWordWrap];
			
			UIButton *btnWeight = [UIButton buttonWithType:UIButtonTypeCustom];
			
			if (ColorAdded)
			{
				[btnWeight setBackgroundColor:[UIColor whiteColor]];
				ColorAdded = FALSE;
			}
			else {
				[btnWeight setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0f]];
				ColorAdded = TRUE;
			}
			[btnWeight setTitleColor:[UIColor colorWithRed:0.50
													 green:0.72
													  blue:0.14
													 alpha:1.0f] forState:UIControlStateHighlighted];
			
			[btnWeight setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0f] forState:UIControlStateNormal];
			[btnWeight setTag:i];
			[btnWeight setFrame:CGRectMake(0,yposition, 280,stringsize.height+10)];	
			[btnWeight setTitle:[arrValue objectAtIndex:i] forState:UIControlStateNormal];
			[btnWeight addTarget:self action:@selector(SetValue:) forControlEvents:UIControlEventTouchUpInside];
			//[btnWeight setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"no-reps-2.png"]]];
			[view_otherOption_list addSubview:btnWeight];
			yposition = yposition + stringsize.height+10;
		}
		view_otherOption_list.frame = CGRectMake(18, 121, 280, yposition);
		
		[self.view addSubview:view_otherOption_list];
		[view_otherOption_list release];
		
	}
}



-(void)SetValue:(id)sender
{	
	IsBrandSelected = YES;
	txt.text = [sender currentTitle];
	
	view_otherOption_list.hidden = TRUE;
}

-(void)AutoComplete:(id)sender
{
	NSString *value = txt.text;
	
	if ([value length]!= 0)
	{
		view_otherOption_list.hidden = FALSE;
		arrValue = [[NSMutableArray alloc] init];
		arrValue = [CCommon GetConditionsByName:value];
		
		[self Set];
	}
	else {
		view_otherOption_list.hidden = TRUE;
	}	
}


-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField {
	//activeField = textField;
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	view_otherOption_list.hidden = TRUE;
	return YES;
}

- (void)dealloc {
    [super dealloc];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
	//sharedInstance.mstrNotes = txtVw.text;
	
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



@end

