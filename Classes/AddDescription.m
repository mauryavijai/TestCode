//
//  AddDescription.m
//  Natolli
//
//  Created by Nidhi Sharma on 13/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddDescription.h"
#import "selectDescDetails.h"

@implementation AddDescription
@synthesize txtVw;

#pragma mark -
#pragma mark View lifecycle

- (void)UpdateDetails:(id)sender
{	
	[txtVw resignFirstResponder];
	
	NSString *strQuantity = [[CCommon objCCommon]mstrSelectedQuantity];
	NSString *strShape = [[CCommon objCCommon]mstrSelectedShape];
	
	NSString *strShade = [[CCommon objCCommon]mstrSelectedShade];
	NSString *strMaterial = [[CCommon objCCommon]mstrSelectedMaterial];
	
	NSString *strMakeModel = [[CCommon objCCommon]mstrSelectedmakeModel];
	NSString *strInfo = txtVw.text;
	
	if ([strQuantity length] == 0) {
		strQuantity = @" ";
	}
	if ([strShape length] == 0) {
		strShape = @" ";
	}
	if ([strShade length] == 0) {
		strShade = @" ";
	}
	if ([strMaterial length] == 0) {
		strMaterial = @" ";
	}
	if ([strMakeModel length] == 0) {
		strMakeModel = @" ";
	}
	if ([strInfo length] == 0) {
		strInfo = @" ";
	}
	
	
	[CCommon UpdateItemDescription:strQuantity ShapeSize:strShape ShadeColor:strShade Material:strMaterial MakeModel:strMakeModel AdditionalInfo:strInfo];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	sharedInstance =[CCommon objCCommon];
	NSMutableArray *arrValues  = [[NSMutableArray alloc] init];
	arrValues =  [CCommon GetDescriptionDetails];
	
	if ([arrValues count] > 5 )
	{
		sharedInstance.mstrSelectedQuantity = [arrValues objectAtIndex:0];
		sharedInstance.mstrSelectedShape = [arrValues objectAtIndex:1];
		sharedInstance.mstrSelectedShade = [arrValues objectAtIndex:2];
		sharedInstance.mstrSelectedMaterial = [arrValues objectAtIndex:3];
		sharedInstance.mstrSelectedmakeModel = [arrValues objectAtIndex:4];
		sharedInstance.mstrSelectedInfo = [arrValues objectAtIndex:5];
	}
	
	self.title = @"Add Description";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(UpdateDetails:)];

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
    return 6;
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
	if (indexPath.row == 5) {
		return 200;
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
	if (indexPath.row != 5){
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
		[lblQuantity_value setText:[[CCommon objCCommon]mstrSelectedQuantity]];
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
		[lblShape setText:@"Shape/Size"];
		lblShape.numberOfLines =0;
		[aCell addSubview:lblShape];
		
		
		
		UILabel *lblShape_value  = [[UILabel alloc] init];
		[lblShape_value setFrame:CGRectMake(160,10, 200,24.0f)];		
		[lblShape_value setBackgroundColor:[UIColor clearColor]];
		lblShape_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblShape_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		[lblShape_value setText:[[CCommon objCCommon]mstrSelectedShape]];

		lblShape_value.numberOfLines =0;
		[aCell addSubview:lblShape_value];
	}
	else if (indexPath.row == 2)
	{		
		UILabel *lblShadeColor  = [[[UILabel alloc] init]autorelease];
		[lblShadeColor setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblShadeColor setBackgroundColor:[UIColor clearColor]];
		lblShadeColor.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblShadeColor.font = [UIFont boldSystemFontOfSize:17];
		lblShadeColor.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblShadeColor setText:@"Shade color"];
		lblShadeColor.numberOfLines =0;
		[aCell addSubview:lblShadeColor];
		
		UILabel *lblShadeColor_value  =  [[UILabel alloc] init];
		[lblShadeColor_value setFrame:CGRectMake(160,10, 200,24.0f)];		
		[lblShadeColor_value setBackgroundColor:[UIColor clearColor]];
		lblShadeColor_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblShadeColor_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
	
		[lblShadeColor_value setText:[[CCommon objCCommon]mstrSelectedShade]];
		
		lblShadeColor_value.numberOfLines =0;
		[aCell addSubview:lblShadeColor_value];
	}
	else if (indexPath.row == 3)
	{		
		UILabel *lblMaterial  = [[[UILabel alloc] init]autorelease];
		[lblMaterial setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblMaterial setBackgroundColor:[UIColor clearColor]];
		lblMaterial.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblMaterial.font = [UIFont boldSystemFontOfSize:17];
		lblMaterial.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblMaterial setText:@"Material"];
		lblMaterial.numberOfLines =0;
		[aCell addSubview:lblMaterial];
		
		UILabel *lblMaterial_value  =  [[UILabel alloc] init];
		[lblMaterial_value setFrame:CGRectMake(160,10, 200,24.0f)];		
		[lblMaterial_value setBackgroundColor:[UIColor clearColor]];
		lblMaterial_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblMaterial_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 

		[lblMaterial_value setText:[[CCommon objCCommon]mstrSelectedMaterial]];
		lblMaterial_value.numberOfLines =0;
		[aCell addSubview:lblMaterial_value];
	}
	else if (indexPath.row == 4)
	{		
		UILabel *lblMake= [[[UILabel alloc] init]autorelease];
		[lblMake setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblMake setBackgroundColor:[UIColor clearColor]];
		lblMake.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblMake.font = [UIFont boldSystemFontOfSize:17];
		lblMake.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblMake setText:@"Make/Model"];
		lblMake.numberOfLines =0;
		[aCell addSubview:lblMake];
		
		UILabel *lblMake_value  =  [[UILabel alloc] init];
		[lblMake_value setFrame:CGRectMake(160,10, 128,24.0f)];		
		[lblMake_value setBackgroundColor:[UIColor clearColor]];
		lblMake_value.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblMake_value.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		[lblMake_value setText:[[CCommon objCCommon]mstrSelectedmakeModel]];
		
		lblMake_value.numberOfLines =0;
		[aCell addSubview:lblMake_value];
	}
	else if (indexPath.row == 5)
	{	
		UILabel *lblNotes = [[[UILabel alloc] init]autorelease];
		[lblNotes setFrame:CGRectMake(18,10, 200,24.0f)];		
		[lblNotes setBackgroundColor:[UIColor clearColor]];
		lblNotes.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblNotes.font = [UIFont boldSystemFontOfSize:17];
		lblNotes.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
		[lblNotes setText:@"Additional Info"];
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
		[aCell addSubview:txtVw];
		txtVw.text = [[CCommon objCCommon]mstrSelectedInfo]; 

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
	
	if (indexPath.row != 5)
	{
	
	selectDescDetails *objLevel_1 = [[selectDescDetails alloc] initWithNibName:@"selectDescDetails" bundle:nil];
	
	if (indexPath.row == 0)
	{
		objLevel_1.Mode = @"QUANTITY";
	}
	else if (indexPath.row == 1)
	{
		objLevel_1.Mode = @"SHAPE";
	}
	else if (indexPath.row == 2)
	{
		objLevel_1.Mode = @"SHADE";
	}
	else if (indexPath.row == 3)
	{
		objLevel_1.Mode = @"MATERIAL";
	}
	else
	{
		objLevel_1.Mode = @"MAKE";
	}
	
	
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


- (void)dealloc {
    [super dealloc];
}


@end

