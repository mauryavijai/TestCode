//
//  Level2_Details.m
//  Natolli
//
//  Created by Nidhi Sharma on 09/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define SCROLLVIEW_CONTENT_HEIGHT 460
#define SCROLLVIEW_CONTENT_WIDTH  320



#import "Level2_Details.h"
#import "ViewTableViewController.h"
#import "Items.h"

@implementation Level2_Details

@synthesize btnImage, selectedButton, txtVw, txtVwNotes, imageName;
@synthesize Mode, SelectedFloorTitle, SelectedFloorNotes, SelectedFloorID, SelectedFloorImage, scrollview;
@synthesize arrItemTitle, arrItemID, arrItem, arrType, aTableView, strDeleteditemID;
@synthesize view_otherOption_list, arrRoomList; //Added by Vijai 0n 8th June 2011


-(void)SetSelectedRoom:(id)sender
{
	[txtVw resignFirstResponder];
	IsRoomSelected = YES;
	txtVw.text = [sender currentTitle];
	
	[self ShowRoomList];
}

-(void)ShowRoomList
{
	BOOL ColorAdded =  TRUE;
	
	if (IsRoomSelected == YES)
	{
		view_otherOption_list.hidden = TRUE;
		
		IsRoomSelected = NO;
	}
	else {
		
		view_otherOption_list.hidden = TRUE;	
		
		CGFloat yposition = (CGFloat)0;
		CGSize ConstraintSize;
		ConstraintSize.width = 250.0f;
		ConstraintSize.height = MAXFLOAT;
		
		view_otherOption_list = [[UIView alloc]initWithFrame:CGRectMake(8, 62, 230, 100)];
		[view_otherOption_list setBackgroundColor:[UIColor clearColor]];
		view_otherOption_list.hidden = FALSE;
		
		view_otherOption_list.layer.borderColor = [UIColor colorWithRed:0.59 green:0.81 blue:0.55 alpha:1.0f].CGColor;
		view_otherOption_list.layer.borderWidth = 1.0f;
		view_otherOption_list.layer.cornerRadius = 8;
		
		for (int i = 0; i < [arrRoomList count]; i++)
		{
			CGSize stringsize = [[arrRoomList objectAtIndex:i] sizeWithFont:[UIFont fontWithName:@"Arial" size:16.0] constrainedToSize: ConstraintSize lineBreakMode:UILineBreakModeWordWrap];
			
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
			[btnWeight setFrame:CGRectMake(0,yposition, 230,stringsize.height+10)];	
			[btnWeight setTitle:[arrRoomList objectAtIndex:i] forState:UIControlStateNormal];
			[btnWeight addTarget:self action:@selector(SetSelectedRoom:) forControlEvents:UIControlEventTouchUpInside];
			//[btnWeight setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"no-reps-2.png"]]];
			[view_otherOption_list addSubview:btnWeight];
			yposition = yposition + stringsize.height+10;
		}
		view_otherOption_list.frame = CGRectMake(80, 72, 230, yposition);
		
		[self.scrollview addSubview:view_otherOption_list];
		[view_otherOption_list release];
		
	}
}

-(void)AutoComplete
{
	NSString *value = txtVw.text;
	
	if ([value length] != 0)
	{
		view_otherOption_list.hidden = FALSE;
		arrRoomList = [[NSMutableArray alloc] init];
		arrRoomList = [CCommon GetRoomsByName:value];
		[self ShowRoomList];
	}
	else {
		view_otherOption_list.hidden = TRUE;
	}	
}

//end of Vijai Code

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 1) //If user pressed OK button
	{
		[CCommon Deleteitem:self.strDeleteditemID];
		
		if (self.Mode == @"UPDATE") 
			[CCommon setLastAdded_RoomID:self.SelectedFloorID];
		
		arrItemTitle =[[NSMutableArray alloc] init];
		arrItemID =[[NSMutableArray alloc] init];
		arrItem =[[NSMutableArray alloc] init];
		arrType =[[NSMutableArray alloc] init];
		
		arrItemTitle = [CCommon Get_ItemTitles];
		arrItemID = [CCommon Get_ItemIDs];
		arrItem = [CCommon Get_Items_level3];
		arrType = [CCommon Get_itemTypes];
		
		[self.aTableView reloadData];	
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	
	if (self.Mode == @"UPDATE") 
		[CCommon setLastAdded_RoomID:self.SelectedFloorID];
	
	arrItemTitle =[[NSMutableArray alloc] init];
	arrItemID =[[NSMutableArray alloc] init];
	arrItem =[[NSMutableArray alloc] init];
	arrType =[[NSMutableArray alloc] init];
	
	arrItemTitle = [CCommon Get_ItemTitles];
	arrItemID = [CCommon Get_ItemIDs];
	arrItem = [CCommon Get_Items_level3];
	arrType = [CCommon Get_itemTypes];
	
	[self.aTableView reloadData];
}

-(void)openCameraRoll {
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		UIPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
		[self presentModalViewController:UIPicker animated:YES];
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Camera is not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	self.imageName = [@"R" stringByAppendingFormat:@"%@.jpeg",[CCommon LastAdded_RoomID]];
	
	NSString *path = [documentsDirectory stringByAppendingPathComponent:self.imageName]; //here use the name with which you want to save the file
	NSData *dataObj = UIImageJPEGRepresentation(image, 1.0);
	[dataObj writeToFile:path atomically:NO]; 
	
	[selectedButton setBackgroundImage:image forState:UIControlStateNormal];
	
	
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

-(void)AddImage:(id)sender
{
	
	ViewTableViewController *objLevel_1 = [[ViewTableViewController alloc] initWithNibName:@"ViewTableViewController" bundle:nil];
	objLevel_1.Mode = @"ROOM";
	[self.navigationController pushViewController:objLevel_1 animated:YES];
	[objLevel_1 release];
	
}

- (void)AddNewItem:(id)sender
{	
	[CCommon AddItemDetails];
	
	[CCommon AddItemDescription:@" " ShapeSize:@" " ShadeColor:@" " Material:@" " MakeModel:@" " AdditionalInfo:@" " ParentID:[CCommon LastAdded_ItemID]];
	
	[CCommon AddItemConditions:@"NO" CleaningRequired:@"NO" FairUsage:@"NO" Landlord:@"NO" Tenant:@"NO" FurtherNotes:@" " Condition:@" " Quantity:@" " ParentID:[CCommon LastAdded_ItemID]];
	
	
	Items *objLevel_1 = [[Items alloc] initWithNibName:@"Items" bundle:nil];
	//objLevel_1.Mode = @"ROOM";
	[self.navigationController pushViewController:objLevel_1 animated:YES];
	[objLevel_1 release];
}

- (void)AddNewFloor:(id)sender
{	
	NSString *lstrValue = txtVw.text;
	
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
		[txtVwNotes resignFirstResponder];
		[CCommon UpdateRoomDetails:lstrValue _details:@" D" _location:@" L" _description:txtVwNotes.text];
	}
	
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	self.title = @"Room Details";
	self.imageName = @" ";
	
	scrollview.contentSize = CGSizeMake(SCROLLVIEW_CONTENT_WIDTH,
										SCROLLVIEW_CONTENT_HEIGHT);
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(AddNewFloor:)];

	UIPicker = [[UIImagePickerController alloc] init];
	UIPicker.allowsImageEditing = NO;
	UIPicker.delegate = self;	
	
	btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
	[btnImage setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];	
	
	[btnImage setFrame:CGRectMake(11, 8, 64, 63)];
	[btnImage addTarget:self action:@selector(AddImage:) forControlEvents:UIControlEventTouchUpInside];

	NSString *strimageName =[@"" stringByAppendingFormat:@"%@",self.SelectedFloorImage];

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [paths objectAtIndex:0];
	NSString *myfile = [documentsPath stringByAppendingPathComponent:strimageName];
	BOOL isfileExists = [[NSFileManager defaultManager] fileExistsAtPath:myfile];
	
	if(isfileExists && [self.SelectedFloorImage length] != 0)
	{
		
		[btnImage setBackgroundImage:[[[UIImage alloc]initWithContentsOfFile:myfile] autorelease] forState:UIControlStateNormal];
	}
	else {
		
		[btnImage setBackgroundImage:[UIImage imageNamed:@"add_image.png"] forState:UIControlStateNormal];
	}

	if (self.Mode == @"UPDATE") 
		[CCommon setLastAdded_RoomID:self.SelectedFloorID];
	
	arrItemTitle =[[NSMutableArray alloc] init];
	arrItemID =[[NSMutableArray alloc] init];
	arrItem =[[NSMutableArray alloc] init];
	arrType =[[NSMutableArray alloc] init];
	
	arrItemTitle = [CCommon Get_ItemTitles];
	arrItemID = [CCommon Get_ItemIDs];
	arrItem = [CCommon Get_Items_level3];
	arrType = [CCommon Get_itemTypes];
	
	
	
	[self.scrollview addSubview:btnImage];
	//add_image.png
	
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
			txtVw.text = self.SelectedFloorTitle;
		else
			txtVw.text = @"Room Name";
	}
	else 
		txtVw.text = value;
	
	
	[self.scrollview addSubview:txtVw];
	
	NSString *value1 = txtVwNotes.text;

	txtVwNotes = [[UITextView alloc]initWithFrame:CGRectMake(12.0f, 80.0f, 297.0f, 75.0f)];
	txtVwNotes.layer.borderWidth = 1.0f;
	txtVwNotes.font = [UIFont fontWithName:@"Arial" size: 17.0];
	txtVwNotes.delegate = self;
	txtVwNotes.layer.cornerRadius = 5;
	txtVwNotes.layer.borderWidth = 1;
	txtVwNotes.layer.borderColor = [[UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0] CGColor];
	txtVwNotes.textColor = [UIColor colorWithRed:0.47 green:0.47 blue:0.47 alpha:1.0];
	//	txtVwNotes.text = @"Notes";
	
	if ([value1 length] == 0)
	{
		if (self.Mode == @"UPDATE")
			txtVwNotes.text = self.SelectedFloorNotes;
		else
			txtVwNotes.text = @"Notes";
	}
	else 
		txtVwNotes.text = value1;
	
	[self.scrollview addSubview:txtVwNotes];
	
	aTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 160, 312, 260) style:UITableViewStyleGrouped]; 
	aTableView.dataSource = self; 
	aTableView.delegate = self; 
	[aTableView setBackgroundColor:[UIColor clearColor]];
	//aTableView.style = UITableViewStyleGrouped;
	
	UIButton *btnAddNewFloor = [UIButton buttonWithType:UIButtonTypeContactAdd];
	btnAddNewFloor.titleLabel.text = @"Foo Bar";								
	[btnAddNewFloor setFrame:CGRectMake(0.0, 210, 80.0f, 30.0f)];
	//[btnAddNewFloor addTarget:self action:@selector(AddNewFloor:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.scrollview addSubview:aTableView];
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


- (void)dealloc {
    [super dealloc];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	//return 1;
	if (section == 1)
	{
		return 1;
	}
	else {
		if ([arrItemID count] !=0) {
			return [arrItemID count];
		}
		else {
			return 1;
		}
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

-(void)DeleteItem:(id)sender
{
	self.strDeleteditemID =[@"" stringByAppendingFormat:@"%d",  [sender tag]];
	
	UIAlertView *baseAlert = [[UIAlertView alloc] 
							  initWithTitle:@"" message:@"Are you sure you want to delete this record" 
							  delegate:self cancelButtonTitle:nil
							  otherButtonTitles:@"Cancel", @"OK", nil];
	
	[baseAlert show];
	[baseAlert release];
	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
								   reuseIdentifier:CellIdentifier] autorelease]; 
	
	if (indexPath.section == 1)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
								   reuseIdentifier:CellIdentifier] autorelease]; 
	
		UIButton *btnAddNewFloor = [UIButton buttonWithType:UIButtonTypeContactAdd];
		btnAddNewFloor.titleLabel.text = @"Foo Bar";								
		[btnAddNewFloor setFrame:CGRectMake(-20.0f, 8.0f, 80.0f, 30.0f)];
		[btnAddNewFloor addTarget:self action:@selector(AddNewItem:) forControlEvents:UIControlEventTouchUpInside];
		[cell.contentView addSubview:btnAddNewFloor];
	
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 12.0f, 200.0f, 20.0f)];
		label.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		label.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		[label setText:@"Add Item"];
		[cell addSubview:label];
		[label release];

		cell.selectionStyle = UITableViewCellSelectionStyleNone;	
	}
	else {
		
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,10, 200, 78) 
									   reuseIdentifier:CellIdentifier] autorelease]; 
		
		UILabel *lblRoomTitle = [[UILabel alloc] initWithFrame:CGRectMake(17.0f, 12.0f, 200.0f, 20.0f)];
		lblRoomTitle.font = [UIFont fontWithName:@"Arial" size:(17.0)];	
		lblRoomTitle.textColor = [UIColor colorWithRed:0.50 green:0.50 blue:0.50 alpha:1.0]; 
		
		
		UIButton *btnDeleteDesc = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		btnDeleteDesc.frame= CGRectMake(235,-18, 100, 78);
		
		[btnDeleteDesc setImage:[UIImage imageNamed:@"btn_delete1.png"] forState:UIControlStateNormal];
		
		if ([arrItemID count] != 0)
		{
			[lblRoomTitle setText:[arrItemTitle objectAtIndex:indexPath.row]];
			//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			btnDeleteDesc.tag = [[arrItemID objectAtIndex:indexPath.row] intValue];
			[btnDeleteDesc addTarget:self action:@selector(DeleteItem:) forControlEvents: UIControlEventTouchUpInside];
			[cell addSubview:btnDeleteDesc];
		}
		else
		{
			[lblRoomTitle setText:@"No item added"];
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
		[btnDeleteDesc release];	
		cell.selectionStyle = UITableViewCellSelectionStyleNone;	
		
		[cell addSubview:lblRoomTitle];
		[lblRoomTitle release];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.section == 1)
	{
		if (indexPath.row == 0)
		{
			[self performSelector:@selector(AddNewItem:)];
		}
	}
	else {
		if ([arrItemID count] != 0)
		{
			Items *objLevel_1 = [[Items alloc] initWithNibName:@"Items" bundle:nil];
			
			if ([arrItemID count] != 0)
			{
				objLevel_1.SelectedID = [arrItemID objectAtIndex:indexPath.row];
				objLevel_1.SelectedTitle = [arrItemTitle objectAtIndex:indexPath.row];
			}
			else
			{
				objLevel_1.SelectedID = @"";
				objLevel_1.SelectedTitle = @"";
			}
			
			if ([arrItem count] != 0)
				objLevel_1.SelectedItem = [arrItem objectAtIndex:indexPath.row];
			else
				objLevel_1.SelectedItem = @"";
			
		
			if ([arrType count] != 0)
				objLevel_1.SelectedType = [arrType objectAtIndex:indexPath.row];
			else
				objLevel_1.SelectedType = @"";
						
			
			objLevel_1.Mode = @"UPDATE";
			[self.navigationController pushViewController:objLevel_1 animated:YES];
			[objLevel_1 release];
			
		}//END - if ([arrFloorID count] != 0)
	}
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
	
    //added by Vijai on 8th June 2011
    if (textView == txtVw)
    { 
        
        [self AutoComplete];
    }
    
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	if (textView == txtVw) {
		if ([txtVw.text isEqualToString:@"Room Name"]) {
			txtVw.text = @"";
		}
	}
	else {
		if ([txtVwNotes.text isEqualToString:@"Notes"]) {
			txtVwNotes.text = @"";
		}
	}
	
	
	return TRUE;
}


@end
