//
//  selectDescDetails.m
//  Natolli
//
//  Created by Nidhi Sharma on 13/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "selectDescDetails.h"


@implementation selectDescDetails
@synthesize pv_Quantity, pv_Shape, pv_Shade, pv_material, pv_make;
@synthesize arrQuantity, arrShape, arrShade, arrmaterial, arrmake, Mode, lblTitle;
@synthesize SelectedQuantity, SelectedShape, SelectedShade, SelectedMaterial, SelectedmakeModel;
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
				[CCommon AddItemDescription2:txtValue.text ShapeSize:@" " ShadeColor:@" " Material:@" " MakeModel:@" " AdditionalInfo:@" " ParentID:@"0"];
			}
			
			self.SelectedQuantity =self.txtValue.text;
			
		}
		
		if ([self.SelectedQuantity length] != 0) {
			sharedInstance.mstrSelectedQuantity = self.SelectedQuantity;
		}

	}
	else if (self.Mode == @"SHAPE") 
	{
		if ([txtValue.text length] !=0)
		{
			BOOL isItemTypeExists = FALSE;
			int selectedId = [arrShape count] ;
			for (int i =0; i < [arrShape count]; i++)
			{
				NSString *itemType = [arrShape objectAtIndex:i];
				
				if ([[itemType uppercaseString] compare:[txtValue.text uppercaseString]] == NSOrderedSame)
				{
					isItemTypeExists = TRUE;
					selectedId = i;
				}
			}
			
			if (!isItemTypeExists) 
			{
				[CCommon AddItemDescription2:@" " ShapeSize:txtValue.text ShadeColor:@" " Material:@" " MakeModel:@" " AdditionalInfo:@" " ParentID:@"0"];
			}
			
			self.SelectedShape=self.txtValue.text;
			
		}
		
		if ([self.SelectedShape length] != 0) {
			sharedInstance.mstrSelectedShape = self.SelectedShape;
		}
	}
	else if (self.Mode == @"SHADE") 
	{
		if ([txtValue.text length] !=0)
		{
			BOOL isItemTypeExists = FALSE;
			int selectedId = [arrShade count] ;
			for (int i =0; i < [arrShade count]; i++)
			{
				NSString *itemType = [arrShade objectAtIndex:i];
				
				if ([[itemType uppercaseString] compare:[txtValue.text uppercaseString]] == NSOrderedSame)
				{
					isItemTypeExists = TRUE;
					selectedId = i;
				}
			}
			
			if (!isItemTypeExists) 
			{
				[CCommon AddItemDescription2:@" " ShapeSize:@" " ShadeColor:txtValue.text Material:@" " MakeModel:@" " AdditionalInfo:@" " ParentID:@"0"];
			}
			
			self.SelectedShade=self.txtValue.text;
			
		}
		
		if ([self.SelectedShade length] != 0) {
			sharedInstance.mstrSelectedShade = self.SelectedShade;
		}
		
	}
	else if (self.Mode == @"MATERIAL") 
	{
		if ([txtValue.text length] !=0)
		{
			BOOL isItemTypeExists = FALSE;
			int selectedId = [arrmaterial count] ;
			for (int i =0; i < [arrmaterial count]; i++)
			{
				NSString *itemType = [arrmaterial objectAtIndex:i];
				
				if ([[itemType uppercaseString] compare:[txtValue.text uppercaseString]] == NSOrderedSame)
				{
					isItemTypeExists = TRUE;
					selectedId = i;
				}
			}
			
			if (!isItemTypeExists) 
			{
				[CCommon AddItemDescription2:@" " ShapeSize:@" " ShadeColor:@" " Material:txtValue.text MakeModel:@" " AdditionalInfo:@" " ParentID:@"0"];
			}
			
			self.SelectedMaterial=self.txtValue.text;
			
		}
		
		if ([self.SelectedMaterial length] != 0) {
			sharedInstance.mstrSelectedMaterial = self.SelectedMaterial;
		}

	}
	else if (self.Mode == @"MAKE") 
	{
		if ([txtValue.text length] !=0)
		{
			BOOL isItemTypeExists = FALSE;
			int selectedId = [arrmake count] ;
			for (int i =0; i < [arrmake count]; i++)
			{
				NSString *itemType = [arrmake objectAtIndex:i];
				
				if ([[itemType uppercaseString] compare:[txtValue.text uppercaseString]] == NSOrderedSame)
				{
					isItemTypeExists = TRUE;
					selectedId = i;
				}
			}
			
			if (!isItemTypeExists) 
			{
				[CCommon AddItemDescription2:@" " ShapeSize:@" " ShadeColor:@" " Material:@" " MakeModel:txtValue.text AdditionalInfo:@" " ParentID:@"0"];
			}
			
			self.SelectedmakeModel=self.txtValue.text;
			
		}
		
		if ([self.SelectedmakeModel length] != 0) {
			sharedInstance.mstrSelectedmakeModel = self.SelectedmakeModel;
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
	
	pv_Shape = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
	pv_Shape.delegate = self;
	pv_Shape.showsSelectionIndicator = YES;
	[self.view addSubview:pv_Shape];
	
	pv_Shade = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
	pv_Shade.delegate = self;
	pv_Shade.showsSelectionIndicator = YES;
	[self.view addSubview:pv_Shade];

	pv_material =[[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
	pv_material.delegate = self;
	pv_material.showsSelectionIndicator = YES;
	[self.view addSubview:pv_material];
	
	pv_make = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
	pv_make.delegate = self;
	pv_make.showsSelectionIndicator = YES;
	[self.view addSubview:pv_make];
	
	arrQuantity = [[NSMutableArray alloc] init];
	arrQuantity = [CCommon Get_Quantity_Description];
	
	arrShape = [[NSMutableArray alloc] init];
	arrShape = [CCommon Get_Shape];
	
	arrShade = [[NSMutableArray alloc] init];
	arrShade = [CCommon Get_Shade];
	
	arrmaterial = [[NSMutableArray alloc] init];
	arrmaterial = [CCommon Get_Material];
	
	arrmake = [[NSMutableArray alloc] init];
	arrmake = [CCommon Get_MakeModel];
	
	if (self.Mode == @"QUANTITY") 
	{
		pv_Quantity.hidden = NO;
		pv_Shape.hidden = YES;
		pv_Shade.hidden = YES;
		pv_material.hidden = YES;
		pv_make.hidden = YES;
		
		[lblTitle setText:@"Add Quantity"];
		
		for (int i =0 ;i < [arrQuantity count]; i++) {
			
			if ([[[CCommon objCCommon] mstrSelectedQuantity] isEqualToString:[arrQuantity objectAtIndex:i]]) 
			{
				[pv_Quantity selectRow:i inComponent:0 animated:NO];
			}
		}
		
		self.title = @"Add Quantity";
	}
	else if (self.Mode == @"SHAPE") 
	{
		pv_Quantity.hidden = YES;
		pv_Shape.hidden = NO;
		pv_Shade.hidden = YES;
		pv_material.hidden = YES;
		pv_make.hidden = YES;
		
		[lblTitle setText:@"Add Shape/Size"];
		
		for (int i =0 ;i < [arrShape count]; i++) {
			
			if ([[[CCommon objCCommon] mstrSelectedShape] isEqualToString:[arrShape objectAtIndex:i]]) 
			{
				[pv_Shape selectRow:i inComponent:0 animated:NO];
			}
		}

		self.title = @"Add Shape/Size";
	}
	else if (self.Mode == @"SHADE") 
	{
		pv_Quantity.hidden = YES;
		pv_Shape.hidden = YES;
		pv_Shade.hidden = NO;
		pv_material.hidden = YES;
		pv_make.hidden = YES;
		
		[lblTitle setText:@"Add Shade Color"];
		
		for (int i =0 ;i < [arrShade count]; i++) {
			
			if ([[[CCommon objCCommon] mstrSelectedShade] isEqualToString:[arrShade objectAtIndex:i]]) 
			{
				[pv_Shade selectRow:i inComponent:0 animated:NO];
			}
		}
		
		self.title = @"Add Shade Color";
	}
	else if (self.Mode == @"MATERIAL") 
	{
		pv_Quantity.hidden = YES;
		pv_Shape.hidden = YES;
		pv_Shade.hidden = YES;
		pv_material.hidden = NO;
		pv_make.hidden = YES;

		[lblTitle setText:@"Add Material"];
		
		for (int i =0 ;i < [arrmaterial count]; i++) {
			
			if ([[[CCommon objCCommon] mstrSelectedMaterial] isEqualToString:[arrmaterial objectAtIndex:i]]) 
			{
				[pv_material selectRow:i inComponent:0 animated:NO];
			}
		}

		self.title = @"Add Material";
	}
	else if (self.Mode == @"MAKE") 
	{
		pv_Quantity.hidden = YES;
		pv_Shape.hidden = YES;
		pv_Shade.hidden = YES;
		pv_material.hidden = YES;
		pv_make.hidden = NO;
		
		[lblTitle setText:@"Add Make/Model"];
		
		for (int i =0 ;i < [arrmake count]; i++) {
			
			if ([[[CCommon objCCommon] mstrSelectedmakeModel] isEqualToString:[arrmake objectAtIndex:i]]) 
			{
				[pv_make selectRow:i inComponent:0 animated:NO];
			}
		}

		self.title = @"Add Make/Model";
	}
	
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
	
	if (pickerView == pv_Quantity)
	{
		self.SelectedQuantity = [arrQuantity objectAtIndex:row];
		txtValue.text = [arrQuantity objectAtIndex:row];
	}
	else if (pickerView == pv_Shape)
	{
		self.SelectedShape = [arrShape objectAtIndex:row];
		txtValue.text = [arrShape objectAtIndex:row];
	}
	else if (pickerView == pv_Shade)
	{
		self.SelectedShade = [arrShade objectAtIndex:row];
		txtValue.text = [arrShade objectAtIndex:row];
	}
	else if (pickerView == pv_material)
	{
		self.SelectedMaterial = [arrmaterial objectAtIndex:row];
		txtValue.text = [arrmaterial objectAtIndex:row];
	}
	else 
	{
		self.SelectedmakeModel = [arrmake objectAtIndex:row];
		txtValue.text = [arrmake objectAtIndex:row];
	}
}


// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	
	if (pickerView == pv_Quantity)
	{
		if ([arrQuantity count] == 0)
		{
			return 1;
		}
		else {
			return [arrQuantity count];
		}
	}
	else if (pickerView == pv_Shape)
	{
		if ([arrShape count] == 0)
		{
			return 1;
		}
		else {
			return [arrShape count];
		}
	}
	else if (pickerView == pv_Shade)
	{
		if ([arrShade count] == 0)
		{
			return 1;
		}
		else {
			return [arrShade count];
		}
	}
	else if (pickerView == pv_material)
	{
		if ([arrmaterial count] == 0)
		{
			return 1;
		}
		else {
			return [arrmaterial count];
		}
	}
	else {
		if ([arrmake count] == 0)
		{
			return 1;
		}
		else {
			return [arrmake count];
		}
	}
	
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	
	return 1;
	
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	/*if (pickerView == pv_Item)
		return [arrItem objectAtIndex:row];
	else {
		if ([arrType count] == 0)
		{
			return @"No record found";
		}
		else {
			return [arrType objectAtIndex:row];
		}
	}*/
	
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
	else if (pickerView == pv_Shape)
	{
		if ([arrShape count] == 0)
		{
			return @"No record found";
		}
		else {
			return [arrShape objectAtIndex:row];
		}
	}
	else if (pickerView == pv_Shade)
	{
		if ([arrShade count] == 0)
		{
			return @"No record found";
		}
		else {
			return [arrShade objectAtIndex:row];
		}
	}
	else if (pickerView == pv_material)
	{
		if ([arrmaterial count] == 0)
		{
			return @"No record found";
		}
		else {
			return [arrmaterial objectAtIndex:row];
		}
	}
	else {
		if ([arrmake count] == 0)
		{
			return @"No record found";
		}
		else {
			return [arrmake objectAtIndex:row];
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
