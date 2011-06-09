//
//  Items.m
//  Natolli
//
//  Created by Nidhi Sharma on 12/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Items.h"
#import "ViewTableViewController.h"
#import "AddDescription.h"
#import "SelectItem.h"
#import "AddCondition.h"

@implementation Items
@synthesize btnImage, imageName, txtVw, aTableView, lblSelectedItem, lblSelectedType;
@synthesize Mode, SelectedTitle, SelectedItem, SelectedType, SelectedID;;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if (section == 0) {
		return 2;
	}
	else {
		return 1;
	}

}

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

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
								   reuseIdentifier:CellIdentifier] autorelease]; 
	
	if (indexPath.section == 0)
	{
		if (indexPath.row == 0)
		{
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
								   reuseIdentifier:CellIdentifier] autorelease]; 
	
			UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 12.0f, 200.0f, 20.0f)];
			//label.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			//label.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
			[label setText:@"Select Item"];

			label.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			label.font = [UIFont boldSystemFontOfSize:17];
			label.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			
	
			[cell addSubview:label];
			[label release];
			
			if ([[[[CCommon objCCommon]mstrSelectedItem] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] != 0)
			{
				
				lblSelectedItem = [[UILabel alloc] initWithFrame:CGRectMake(180.0f, 12.0f, 100.0f, 20.0f)];
				lblSelectedItem.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
				lblSelectedItem.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
				[lblSelectedItem setText:[[CCommon objCCommon] mstrSelectedItem]];
				
				[cell addSubview:lblSelectedItem];
				cell.accessoryType = UITableViewCellAccessoryNone;
			}
			else {
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			}
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
		}//END - if (row == 0)
		if (indexPath.row == 1)
		{
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
										   reuseIdentifier:CellIdentifier] autorelease]; 

			UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 12.0f, 200.0f, 20.0f)];
			//label.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			//label.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
			label.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
			label.font = [UIFont boldSystemFontOfSize:17];
			label.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
			
			
			[label setText:@"Select Type"];
			[cell addSubview:label];
			[label release];
			
			if ([[[[CCommon objCCommon]mstrSelectedType] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] != 0)
			{
				lblSelectedType = [[UILabel alloc] initWithFrame:CGRectMake(180.0f, 12.0f, 100.0f, 20.0f)];
				lblSelectedType.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
				lblSelectedType.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
				
				if ([[[CCommon objCCommon]IsItemSelected] isEqualToString:@"YES"]) {
					
					sharedInstance.mstrSelectedType = @"";
				}
				
				[lblSelectedType setText:[[CCommon objCCommon] mstrSelectedType]];
				
				[cell addSubview:lblSelectedType];
				//[lblSelectedType release];
				cell.accessoryType = UITableViewCellAccessoryNone;
			}
			else {
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			}
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			//
		}//END - if (row == 0)
		
		
	}//END - if (section ==0)
	else if (indexPath.section == 1){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
									   reuseIdentifier:CellIdentifier] autorelease]; 
		
		UIButton *btnAddNewFloor = [UIButton buttonWithType:UIButtonTypeContactAdd];
		btnAddNewFloor.titleLabel.text = @"Foo Bar";								
		[btnAddNewFloor setFrame:CGRectMake(-20.0f, 8.0f, 80.0f, 30.0f)];
		//[btnAddNewFloor addTarget:self action:@selector(AddNewItem:) forControlEvents:UIControlEventTouchUpInside];
		[cell.contentView addSubview:btnAddNewFloor];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 12.0f, 200.0f, 20.0f)];
		label.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		label.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		[label setText:@"Add Description"];
		[cell addSubview:label];
		[label release];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	else if (indexPath.section == 2){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
									   reuseIdentifier:CellIdentifier] autorelease]; 
		
		UIButton *btnAddNewFloor = [UIButton buttonWithType:UIButtonTypeContactAdd];
		btnAddNewFloor.titleLabel.text = @"Foo Bar";								
		[btnAddNewFloor setFrame:CGRectMake(-20.0f, 8.0f, 80.0f, 30.0f)];
		//[btnAddNewFloor addTarget:self action:@selector(AddNewItem:) forControlEvents:UIControlEventTouchUpInside];
		[cell.contentView addSubview:btnAddNewFloor];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 12.0f, 200.0f, 20.0f)];
		label.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		label.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		[label setText:@"Add Condition"];
		[cell addSubview:label];
		[label release];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}

    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	  [txtVw resignFirstResponder];


	if (indexPath.section == 0)
	{
		SelectItem *objLevel_1 = [[SelectItem alloc] initWithNibName:@"SelectItem" bundle:nil];
		if (indexPath.row == 0)
		{
			objLevel_1.Mode = @"SELECTITEM";
		}
		else {
			objLevel_1.Mode = @"SELECTTYPE";
		}
		[self.navigationController pushViewController:objLevel_1 animated:YES];
		[objLevel_1 release];
	}
	if (indexPath.section == 1)
	{
		AddDescription *objLevel_1 = [[AddDescription alloc] initWithNibName:@"AddDescription" bundle:nil];
		[self.navigationController pushViewController:objLevel_1 animated:YES];
		[objLevel_1 release];
	}
	if (indexPath.section == 2)
	{
		
		AddCondition *objLevel_1 = [[AddCondition alloc] initWithNibName:@"AddCondition" bundle:nil];
		[self.navigationController pushViewController:objLevel_1 animated:YES];
		[objLevel_1 release];
	}
	

}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
	
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


-(void)AddImage:(id)sender
{
	ViewTableViewController *objLevel_1 = [[ViewTableViewController alloc] initWithNibName:@"ViewTableViewController" bundle:nil];
	objLevel_1.Mode = @"ITEM";
	[self.navigationController pushViewController:objLevel_1 animated:YES];
	[objLevel_1 release];
	
}

- (void)viewWillAppear:(BOOL)animated {
	
	if (self.Mode == @"UPDATE") 
		[CCommon setLastAdded_ItemID:self.SelectedID];

	
	[self.aTableView reloadData];
	
    [super viewWillAppear:animated];
}

- (void)UpdateItemDetails:(id)sender
{	
	NSString *lstrValue = txtVw.text;
	NSString *lstrItem =  @"";
	NSString *lstrType =  @"";
	
	if ([ lblSelectedItem.text length] != 0)
	{
		lstrItem = lblSelectedItem.text;
	}

	if ([ lblSelectedType.text length] != 0)
	{
		lstrType = lblSelectedType.text;
	}
	
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
		[txtVw resignFirstResponder];
		[CCommon UpdateItemDetails:lstrValue strItem:lstrItem strType:lstrType];
		
	}
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    self.title = @"Items";
	self.imageName = @" ";
	
	sharedInstance =[CCommon objCCommon];	
	//sharedInstance.mstrSelected
	
	if (self.Mode == @"UPDATE") 
		[CCommon setLastAdded_ItemID:self.SelectedID];
	
	sharedInstance.mstrSelectedItemID = self.SelectedID;
	sharedInstance.mstrSelectedItem=  self.SelectedItem;
	sharedInstance.mstrSelectedType=  self.SelectedType;
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(UpdateItemDetails:)];
	
	UIPicker = [[UIImagePickerController alloc] init];
	UIPicker.allowsImageEditing = NO;
	UIPicker.delegate = self;	
	
	btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
	[btnImage setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];	
	
	[btnImage setFrame:CGRectMake(11, 8, 64, 63)];
	[btnImage addTarget:self action:@selector(AddImage:) forControlEvents:UIControlEventTouchUpInside];

	[btnImage setBackgroundImage:[UIImage imageNamed:@"add_image.png"] forState:UIControlStateNormal];

	[self.view addSubview:btnImage];

	NSString *value = txtVw.text;
	
	txtVw = [[UITextView alloc]initWithFrame:CGRectMake(83.0f, 8.0f, 225.0f, 63.0f)];
	txtVw.layer.borderWidth = 1.0f;
	txtVw.delegate = self;
	txtVw.layer.cornerRadius = 5;
	txtVw.layer.borderWidth = 1;
	txtVw.layer.borderColor = [[UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0] CGColor];
	txtVw.font = [UIFont boldSystemFontOfSize:17];
	txtVw.textColor = [UIColor colorWithRed:0.12 green:0.27 blue:0.34 alpha:1.0]; 
	//txtVw.text = @"Floor Name";
	
	if ([value length] == 0)
	{
		if (self.Mode == @"UPDATE")
			txtVw.text = self.SelectedTitle;
		else
			txtVw.text = @"Item Name";
	}
	else 
		txtVw.text = value;
	
	
	[self.view addSubview:txtVw];
	
		
	aTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 70, 312, 260) style:UITableViewStyleGrouped]; 
	aTableView.dataSource = self; 
	aTableView.delegate = self; 
	[aTableView setBackgroundColor:[UIColor clearColor]];
	//aTableView.style = UITableViewStyleGrouped;
	
	UIButton *btnAddNewFloor = [UIButton buttonWithType:UIButtonTypeContactAdd];
	btnAddNewFloor.titleLabel.text = @"Foo Bar";								
	[btnAddNewFloor setFrame:CGRectMake(0.0, 210, 80.0f, 30.0f)];
	//[btnAddNewFloor addTarget:self action:@selector(AddNewFloor:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:aTableView];
	//[self.view addSubview:btnAddNewFloor];
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	if (textView == txtVw) {
		if ([txtVw.text isEqualToString:@"Item Name"]) {
			txtVw.text = @"";
		}
	}

	return TRUE;
}


- (void)dealloc {
    [super dealloc];
}


@end
