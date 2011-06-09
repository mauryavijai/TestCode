//
//  selectConditionDetails.m
//  Natolli
//
//  Created by Nidhi Sharma on 15/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "selectConditionDetails.h"


@implementation selectConditionDetails

@synthesize pv_Quantity;
@synthesize arrQuantity, Mode, lblTitle;
@synthesize SelectedQuantity;
@synthesize txtValue;

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
	[txtValue resignFirstResponder];
	
	if (self.Mode == @"QUANTITY") 
	{
		if ([txtValue.text length] !=0)
		{
			BOOL isItemTypeExists = FALSE;
			int selectedId = [arrQuantity count] ;
			for (int i =0; i < [arrQuantity count]; i++)
			{
				NSString *itemType = [arrQuantity objectAtIndex:i];
				
				if ([[itemType uppercaseString] compare:[txtValue.text uppercaseString]] == NSOrderedSame)
				{
					isItemTypeExists = TRUE;
					selectedId = i;
				}
			}
			
			if (!isItemTypeExists) 
			{
				//[CCommon AddItemDescription2:txtValue.text ShapeSize:@" " ShadeColor:@" " Material:@" " MakeModel:@" " AdditionalInfo:@" " ParentID:@"0"];
				[CCommon AddItemConditions2:@"NO" CleaningRequired:@"NO" FairUsage:@"NO" Landlord:@"NO" Tenant:@"NO" FurtherNotes:@" " Condition:@" " Quantity:txtValue.text ParentID:@"0"];
				
			
			}
			
			self.SelectedQuantity =self.txtValue.text;
			
		}
		
		if ([self.SelectedQuantity length] != 0) {
			sharedInstance.mstrSelectedQuantity_Condition = self.SelectedQuantity;
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
	
	pv_Quantity = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
	pv_Quantity.delegate = self;
	pv_Quantity.showsSelectionIndicator = YES;
	[self.view addSubview:pv_Quantity];
		
	arrQuantity = [[NSMutableArray alloc] init];
	arrQuantity = [CCommon Get_Quantity_Condition];
	
	
	
	if (self.Mode == @"QUANTITY") 
	{
		pv_Quantity.hidden = NO;
		[lblTitle setText:@"Add Quantity"];
		
		for (int i =0 ;i < [arrQuantity count]; i++) {
			
			if ([[[CCommon objCCommon] mstrSelectedQuantity_Condition] isEqualToString:[arrQuantity objectAtIndex:i]]) 
			{
				[pv_Quantity selectRow:i inComponent:0 animated:NO];
			}
		}
		
		self.title = @"Add Quantity";
	}
	
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
	
	if (pickerView == pv_Quantity)
	{
		self.SelectedQuantity = [arrQuantity objectAtIndex:row];
		txtValue.text = [arrQuantity objectAtIndex:row];
	}
	
}


// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	

		if ([arrQuantity count] == 0)
		{
			return 1;
		}
		else {
			return [arrQuantity count];
		}
	
	
	
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	
	return 1;
	
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

	
	if (pickerView == pv_Quantity)
	{
		if ([arrQuantity count] == 0)
		{
			return @"No record found";
		}
		else {
			return [arrQuantity objectAtIndex:row];
		}
	}
	
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


- (void)dealloc {
    [super dealloc];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

@end
