//
//  SelectItem.m
//  Natolli
//
//  Created by Nidhi Sharma on 12/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectItem.h"


@implementation SelectItem

@synthesize  Mode,SelectedItem, SelectedType;
@synthesize arrType, pv_Item, pv_Type, arrItem, arrItemID, arrTypeID, SelectedItemID, SelectedTypeID;
@synthesize txtVw, lblHeading;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

- (void)aButtonClicked:(id)sender
{

	
	if (self.Mode == @"SELECTITEM") 
	{
		if ([self.SelectedItem length] != 0) {
			sharedInstance.mstrSelectedItem =self.SelectedItem;
			sharedInstance.mstrSelectedItemID =self.SelectedItemID;
			sharedInstance.IsItemSelected = @"YES";
		}
		
	}
	else 
	{

		if ([txtVw.text length] !=0)
		{
			
			NSString *ID;
			if ([sharedInstance.mstrSelectedItemID length] != 0 ) {
				ID = sharedInstance.mstrSelectedItemID;
			}
			else {
				ID = @"0";
			}

			BOOL isItemTypeExists = FALSE;
			
			int selectedId = [arrType count] ;
			
			for (int i =0; i < [arrType count]; i++)
			{
				NSString *itemType = [arrType objectAtIndex:i];

				if ([[itemType uppercaseString] compare:[txtVw.text uppercaseString]] == NSOrderedSame)
				{
					isItemTypeExists = TRUE;
					selectedId = i;
				}
			}
			
			if (!isItemTypeExists) 
			{
				[CCommon AddItemTypeToLocalDB:txtVw.text strFeatureID:ID];
			}

			self.SelectedType =self.txtVw.text;
			
		}
		
		if ([self.SelectedType length] != 0) {
			sharedInstance.mstrSelectedType =self.SelectedType;
			sharedInstance.mstrSelectedTypeID =self.SelectedTypeID;
			sharedInstance.IsItemSelected = @"NO";
		}
	}
	[self.navigationController popViewControllerAnimated:YES];
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	sharedInstance =[CCommon objCCommon];
	
	//self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.46 
																		green:0.70
																		 blue:0.08
																		alpha:1.0f];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(aButtonClicked:)];
	self.navigationItem.hidesBackButton = YES;

	pv_Item = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 70, 320, 200)];
	pv_Item.delegate = self;
	pv_Item.showsSelectionIndicator = YES;
	[self.view addSubview:pv_Item];
	
	pv_Type = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
	pv_Type.delegate = self;
	pv_Type.showsSelectionIndicator = YES;
	[self.view addSubview:pv_Type];
	
	arrItem = [[NSMutableArray alloc] init];
	arrItem = [CCommon Get_Items];
	
	arrItemID = [[NSMutableArray alloc] init];
	arrItemID = [CCommon Get_ItemsID];
	
	arrType = [[NSMutableArray alloc] init];
	arrType = [CCommon Get_Types];

	if (self.Mode == @"SELECTITEM") 
	{
		txtVw.hidden = TRUE;
		lblHeading.hidden = TRUE;
		
		for (int i =0 ;i < [arrItem count]; i++) {

			if ([[[CCommon objCCommon] mstrSelectedItem] isEqualToString:[arrItem objectAtIndex:i]]) 
			{
				[pv_Item selectRow:i inComponent:0 animated:NO];
			}
			
		}
		
		self.title = @"Select Item";
		//lblTitle.text = @"Select inventory type";
	}
	else 
	{
		txtVw.hidden = NO;
		lblHeading.hidden = NO;
		
		txtVw.text = [[CCommon objCCommon] mstrSelectedType];
		
		for (int i =0 ;i < [arrType count]; i++) {
			
			if ([[[CCommon objCCommon] mstrSelectedType] isEqualToString: [arrType objectAtIndex:i]]) 
			{
				[pv_Type selectRow:i inComponent:0 animated:NO];
			}
			
		}
		
		self.title = @"Select Type";
		//lblTitle.text = @"Select inspection status";
	}
	
	
	if (self.Mode == @"SELECTITEM")
	{
		pv_Item.hidden = NO;
		pv_Type.hidden = YES;
		
	}
	else {
		pv_Item.hidden = YES;
		pv_Type.hidden = NO;
	}
	
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


- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
	
	if (pickerView == pv_Item)
	{
		self.SelectedItem = [arrItem objectAtIndex:row];
		self.SelectedItemID = [arrItemID objectAtIndex:row];
	}
	else {
		if ([arrType count] == 0)
		{
		}
		else {
			self.SelectedType = [arrType objectAtIndex:row];
			self.SelectedTypeID	= [arrTypeID objectAtIndex:row];
			
			txtVw.text = [arrType objectAtIndex:row];
		}
	}
}


// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	
	if (pickerView == pv_Item)
		return [arrItem count];
	else {
		if ([arrType count] == 0)
		{
			return 1;
		}
		else {
			return [arrType count];
		}

	}
	
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	
	return 1;
	
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	if (pickerView == pv_Item)
		return [arrItem objectAtIndex:row];
	else {
		if ([arrType count] == 0)
		{
			return @"No record found";
		}
		else {
			return [arrType objectAtIndex:row];
		}
	}
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	int sectionWidth = 300;
	
	return sectionWidth;
}


- (void)dealloc {
    [super dealloc];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

@end
