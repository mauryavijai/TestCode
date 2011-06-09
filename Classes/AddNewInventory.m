//
//  AddNewInventory.m
//  Natolli
//
//  Created by Nidhi Sharma on 01/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AddNewInventory.h"


@implementation AddNewInventory
@synthesize scrollview,txtPropertyName, txtAddress, txtCity, txtCountry, txtNoOfBeds, txtNoOfBaths;
@synthesize myPickerView, arrAppliances, SelectedAppliance, view_otherOption_list, view_otherOption;
@synthesize btnAction2;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


-(void)ShowBrandList
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
		
		view_otherOption_list = [[UIView alloc]initWithFrame:CGRectMake(8, 62, 250, 100)];
		[view_otherOption_list setBackgroundColor:[UIColor clearColor]];
		view_otherOption_list.hidden = FALSE;
		
		view_otherOption_list.layer.borderColor = [UIColor colorWithRed:0.59 green:0.81 blue:0.55 alpha:1.0f].CGColor;
		view_otherOption_list.layer.borderWidth = 1.0f;
		view_otherOption_list.layer.cornerRadius = 8;
		
		for (int i = 0; i < [arrAppliances count]; i++)
		{
			CGSize stringsize = [[arrAppliances objectAtIndex:i] sizeWithFont:[UIFont fontWithName:@"Arial" size:16.0] constrainedToSize: ConstraintSize lineBreakMode:UILineBreakModeWordWrap];
			
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
			[btnWeight setFrame:CGRectMake(0,yposition, 250,stringsize.height+10)];	
			[btnWeight setTitle:[arrAppliances objectAtIndex:i] forState:UIControlStateNormal];
			[btnWeight addTarget:self action:@selector(SetSelectedBrand:) forControlEvents:UIControlEventTouchUpInside];
			//[btnWeight setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"no-reps-2.png"]]];
			[view_otherOption_list addSubview:btnWeight];
			yposition = yposition + stringsize.height+10;
		}
		view_otherOption_list.frame = CGRectMake(8, 63, 250, yposition);
		
		[self.scrollview addSubview:view_otherOption_list];
		[view_otherOption_list release];
		
	}
}




- (void) viewWillAppear:(BOOL)animated {
	
	RootViewController *theRootViewController =[[self.navigationController viewControllers] objectAtIndex:0];
	[theRootViewController createToolbarItems:@"NEW"];
	
	[super viewWillAppear:animated];
	NSLog(@"Registering for keyboard events");
	
	// Register for the events
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector (keyboardDidShow:)
	 name: UIKeyboardDidShowNotification
	 object:nil];
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector (keyboardDidHide:)
	 name: UIKeyboardDidHideNotification
	 object:nil];
	
	
	// Setup content size
	scrollview.contentSize = CGSizeMake(SCROLLVIEW_CONTENT_WIDTH,
										SCROLLVIEW_CONTENT_HEIGHT);
	
	//Initially the keyboard is hidden
	keyboardVisible = NO;
}

-(void) viewWillDisappear:(BOOL)animated {
	NSLog (@"Unregister for keyboard events");
	[[NSNotificationCenter defaultCenter]
	 removeObserver:self];
}

-(void) keyboardDidShow: (NSNotification *)notif {
	NSLog(@"Keyboard is visible");
	// If keyboard is visible, return
	if (keyboardVisible) {
		NSLog(@"Keyboard is already visible. Ignore notification.");
		return;
	}
	
	//switchView.center = CGPointMake(144.0, 278.0-60);
	
	// Get the size of the keyboard.
	NSDictionary* info = [notif userInfo];
	NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
	CGSize keyboardSize = [aValue CGRectValue].size;
	
	// Save the current location so we can restore
	// when keyboard is dismissed
	offset = scrollview.contentOffset;
	
	// Resize the scroll view to make room for the keyboard
	CGRect viewFrame = scrollview.frame;
	viewFrame.size.height -= keyboardSize.height;
	scrollview.frame = viewFrame;
	
	CGRect textFieldRect = [activeField frame];
	textFieldRect.origin.y += 75;
	[scrollview scrollRectToVisible:textFieldRect animated:YES];
	
	NSLog(@"ao fim");
	// Keyboard is now visible
	keyboardVisible = YES;
	
}

-(void) keyboardDidHide: (NSNotification *)notif {
	// Is the keyboard already shown
	if (!keyboardVisible) {
		NSLog(@"Keyboard is already hidden. Ignore notification.");
		return;
	}
	
	//switchView.center = CGPointMake(144.0f, 278.0f);
	// Reset the frame scroll view to its original value
	scrollview.frame = CGRectMake(0, 0, SCROLLVIEW_CONTENT_WIDTH, SCROLLVIEW_CONTENT_HEIGHT);
	
	// Reset the scrollview to previous location
	scrollview.contentOffset = offset;
	
	// Keyboard is no longer visible
	keyboardVisible = NO;
	
}

-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField {
	activeField = textField;
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	view_otherOption_list.hidden = TRUE;
	return YES;
}


- (IBAction)aButtonClicked:(id)sender {
	exit(0);
}

- (void) handleBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	txtPropertyName.textColor = [UIColor colorWithRed:0.50
											green:0.72
											 blue:0.14
											alpha:1.0f];
	
	arrAppliances = [[NSMutableArray alloc] init];
	
	sharedInstance =[GlobalSingleton sharedInstance];

	self.navigationItem.hidesBackButton = YES;
	self.navigationController.navigationBarHidden = NO;
	self.title = @"New Inventories";
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.46 
																		green:0.70
																		 blue:0.08
	/*Right bar button - START*/
																		alpha:1.0f];
	UIImage *buttonImage = [UIImage imageNamed:@"btn_logout.png"];
	
	UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[aButton setImage:buttonImage forState:UIControlStateNormal];
	
	aButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
	
	UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aButton];
	
	[aButton addTarget:self action:@selector(aButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	[buttonImage release];
	
	self.navigationItem.rightBarButtonItem = aBarButtonItem;
	
	/*Right bar button - END*/
	
	/*left bar button - START*/
	
	UIImage *leftBtnImage = [UIImage imageNamed:@"btn_back.png"];
	
	UIButton *aLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[aLeftButton setImage:leftBtnImage forState:UIControlStateNormal];
	
	aLeftButton.frame = CGRectMake(100.0, 0.0, leftBtnImage.size.width, leftBtnImage.size.height);
	
	UIBarButtonItem *aLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aLeftButton];
	
	[aLeftButton addTarget:self action:@selector(handleBack:) forControlEvents:UIControlEventTouchUpInside];
	
	[leftBtnImage release];
	
	self.navigationItem.leftBarButtonItem = aLeftBarButtonItem;
	
	/*left bar button - END*/

    [super viewDidLoad];
	
	
	txtAddress.textColor = [UIColor colorWithRed:0.71 
									   green:0.71
										blue:0.71
									   alpha:1.0f];
	
	txtCountry.textColor = [UIColor colorWithRed:0.71 
									   green:0.71
										blue:0.71
									   alpha:1.0f];
	
	txtCity.textColor = [UIColor colorWithRed:0.71 
									   green:0.71
										blue:0.71
									   alpha:1.0f];
	
	txtNoOfBaths.textColor = [UIColor colorWithRed:0.71 
									   green:0.71
										blue:0.71
									   alpha:1.0f];
	
	myPickerView= [[UIPickerView alloc] initWithFrame:CGRectMake(0, 90, 320, 200)];
	myPickerView.delegate = self;
	myPickerView.showsSelectionIndicator = YES;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
	
	SelectedAppliance =[self.arrAppliances objectAtIndex:row];
	
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [arrAppliances count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	
	return 1;
	
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
   	
	return [arrAppliances objectAtIndex:row];
	
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	int sectionWidth = 300;
	
	return sectionWidth;
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

-(void)SetSelectedBrand:(id)sender
{
	IsBrandSelected = YES;
	txtPropertyName.text = [sender currentTitle];
}

-(void)AutoComplete:(id)sender
{
	NSString *value = txtPropertyName.text;
	
	if ([value length]!= 0)
	{
		view_otherOption_list.hidden = FALSE;
		arrAppliances = [[NSMutableArray alloc] init];
		arrAppliances = [CCommon GetBrandsByName:value];
		[self ShowBrandList];
	}
	else {
		view_otherOption_list.hidden = TRUE;
	}	
}

-(void)AddNewAppliance:(id)sender
{
	[txtPropertyName resignFirstResponder];
	BOOL BrandAlreadyExists = FALSE;
	
	if ([txtPropertyName.text length] == 0)
	{
		UIAlertView *baseAlert = [[UIAlertView alloc] 
								  initWithTitle:@"" message:@"Please enter brand"
								  delegate:self cancelButtonTitle:@"Ok"
								  otherButtonTitles:nil];
		[baseAlert show];	
		[baseAlert release];
	}
	else {
		int selectedId = [arrAppliances count] ;
		 
		for (int i =0; i < [arrAppliances count]; i++)
		{
			NSString *Brand = [arrAppliances objectAtIndex:i];
			if ([[Brand uppercaseString] compare:[txtPropertyName.text uppercaseString]] == NSOrderedSame) {
				BrandAlreadyExists = TRUE;
				selectedId = i;
			}
			
		}
		
		if (!BrandAlreadyExists) {
			
			[CCommon AddNewBrandToLocaldb:txtPropertyName.text];
			[arrAppliances addObject:txtPropertyName.text];
			//[myPickerView reloadData];
			[myPickerView reloadComponent:0];
			txtPropertyName.text =@"";
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"New brand added"
									  delegate:self cancelButtonTitle:@"Ok"
									  otherButtonTitles:nil];
			[baseAlert show];	
			[baseAlert release];
			
			[myPickerView selectRow:selectedId inComponent:0 animated:YES];
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Brand  already exists"
									  delegate:self cancelButtonTitle:@"Ok"
									  otherButtonTitles:nil];
			[baseAlert show];	
			[baseAlert release];
			
			[myPickerView selectRow:selectedId inComponent:0 animated:YES];
			
		}
	}

}

- (void)dealloc {
    [super dealloc];
}


@end
