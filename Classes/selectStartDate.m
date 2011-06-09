//
//  selectStartDate.m
//  Natolli
//
//  Created by Nidhi Sharma on 22/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "selectStartDate.h"

@implementation selectStartDate
@synthesize SelectedSDate, SelectedStartTime, Mode, SelectedEndTime, SelectedEndDate, SelectedInType;
@synthesize arrInvTypes, pv_InventoryTypes, SelectedInStatus, pv_InventoryStatus, arrInvStatus;
@synthesize lblTitle;

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
	/*	Level0 *objLevel0 = [[Level0 alloc] initWithNibName:@"Level0" bundle:nil];
		objLevel0.strStartDate = self.SelectedSDate;
		objLevel0.strStartTime = self.SelectedStartTime;
		objLevel0.strEndDate = self.SelectedEndDate;
		objLevel0.strEndTime = self.SelectedEndTime;
		objLevel0.strInType = self.SelectedInType;	*/
	
		sharedInstance.mstrSelectedSDate = self.SelectedSDate;
		sharedInstance.mstrSelectedStartTime = self.SelectedStartTime;
		sharedInstance.mstrSelectedEndDate = self.SelectedEndDate;
		sharedInstance.mstrSelectedEndTime = self.SelectedEndTime;
		sharedInstance.mstrSelectedInType =self.SelectedInType;
		sharedInstance.mstrSelectedInStatus =self.SelectedInStatus;
	
	    [self.navigationController popViewControllerAnimated:YES];

		//[self.navigationController pushViewController:objLevel0 animated:NO];
		//[objLevel0 release];
}

- (void)changeDateInLabel:(id)sender{
	//Use NSDateFormatter to write out the date in a friendly format
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;

	if (self.Mode == @"DATE") {
		
		[df setDateFormat:@"dd/MM/yyyy"];

		NSString *value =   [NSString stringWithFormat:@"%@",
							 [df stringFromDate:datePicker.date]];

		if ([value length] != 0) {
			self.SelectedSDate =value;
			self.SelectedEndDate = value;
		}
	}
	else if (self.Mode == @"TIME")  {
		//[df setDateFormat:@"HH:MM:SS"];
		[df setDateFormat:@"h:mm a"];
		
		NSString *value =   [NSString stringWithFormat:@"%@",
							 [df stringFromDate:datePicker.date]];
		
		if ([value length] != 0) {
			self.SelectedStartTime = value;
		}
	}
	else if (self.Mode == @"ENDTIME")  {
		//[df setDateFormat:@"HH:MM:SS"];
		[df setDateFormat:@"h:mm a"];
		
		NSString *value =   [NSString stringWithFormat:@"%@",
							 [df stringFromDate:datePicker.date]];
		
		if ([value length] != 0) {
			self.SelectedEndTime = value;
		}
	}
	else if (self.Mode == @"ENDDATE") {
		
		[df setDateFormat:@"dd/MM/yyyy"];
		
		NSString *value =   [NSString stringWithFormat:@"%@",
							 [df stringFromDate:datePicker.date]];
		
		if ([value length] != 0) {
			self.SelectedEndDate =value;
		}	
	}

	[df release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	sharedInstance =[CCommon objCCommon];
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
		self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.46 
																		green:0.70
																		 blue:0.08
																		alpha:1.0f];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(aButtonClicked:)];
	self.navigationItem.hidesBackButton = YES;
	
	// Initialization code
	datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,50, 325, 250)];
	
	pv_InventoryTypes = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 70, 320, 200)];
	pv_InventoryTypes.delegate = self;
	pv_InventoryTypes.showsSelectionIndicator = YES;
	[self.view addSubview:pv_InventoryTypes];
	
	pv_InventoryStatus = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 70, 320, 200)];
	pv_InventoryStatus.delegate = self;
	pv_InventoryStatus.showsSelectionIndicator = YES;
	[self.view addSubview:pv_InventoryStatus];
	
	if (self.Mode == @"DATE" || self.Mode == @"ENDDATE") {
		datePicker.datePickerMode = UIDatePickerModeDate;
	}
	else {
		datePicker.datePickerMode = UIDatePickerModeTime;
	}
	
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	
	arrInvTypes = [[NSMutableArray alloc] init];
	[arrInvTypes addObject:@"Check In"];
	[arrInvTypes addObject:@"Inventory Make"];
	[arrInvTypes addObject:@"Check Out"];
	[arrInvTypes addObject:@"Inventory Check In"];
	[arrInvTypes addObject:@"MidTerm Inspection"];
	
	arrInvStatus = [[NSMutableArray alloc] init];
	[arrInvStatus addObject:@"Pending"];
	//[arrInvStatus addObject:@"Send To Typist"];
	[arrInvStatus addObject:@"Complete and Hold"];
	[arrInvStatus addObject:@"Complete and send"];
	[arrInvStatus addObject:@"Proofing"];
	[arrInvStatus addObject:@"Complete"];
	[arrInvStatus addObject:@"Locked"];
	
	
	if (self.Mode == @"DATE")
	{
		self.title = @"Start date";
		lblTitle.text = @"Select start date";
		
		if ([[[[CCommon objCCommon]mstrSelectedSDate] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] != 0)
		{
			[df setDateFormat:@"dd/MM/yyyy"];
			NSDate* d = [df dateFromString:[[CCommon objCCommon]mstrSelectedSDate]];
			[datePicker setDate:d];
		}
	}
	else if (self.Mode == @"ENDDATE")
	{
		self.title = @"End date";
		lblTitle.text = @"Select end date";
		
		if ([[[[CCommon objCCommon]mstrSelectedEndDate] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] != 0)
		{
			[df setDateFormat:@"dd/MM/yyyy"];
			NSDate* d = [df dateFromString:[[CCommon objCCommon]mstrSelectedEndDate]];
			[datePicker setDate:d];
		}
	}
	else if (self.Mode == @"TIME")
	{
		self.title = @"Start time";
		lblTitle.text = @"Select start time";
		
		if ([[[[CCommon objCCommon]mstrSelectedStartTime] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] != 0)
		{
			//[df setDateFormat:@"HH:MM:SS"];
			[df setDateFormat:@"h:mm a"];
			NSDate* d = [df dateFromString:[[CCommon objCCommon]mstrSelectedStartTime]];
			[datePicker setDate:d];
		}
	}
	else if (self.Mode == @"ENDTIME") 
	{
		self.title = @"End time";
		lblTitle.text = @"Select end time";
		
		if ([[[[CCommon objCCommon]mstrSelectedEndTime] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] != 0)
		{
			//[df setDateFormat:@"HH:MM:SS"];
			[df setDateFormat:@"h:mm a"];
			NSDate* d = [df dateFromString:[[CCommon objCCommon]mstrSelectedEndTime]];
			[datePicker setDate:d];
		}
	}
	else if (self.Mode == @"INTY") 
	{
		for (int i =0 ;i < [arrInvTypes count]; i++) {
			

			if ([[[CCommon objCCommon] mstrSelectedInType] isEqualToString:[arrInvTypes objectAtIndex:i]]) 
			{
				[pv_InventoryTypes selectRow:i inComponent:0 animated:NO];
			}
			
		}
		
		self.title = @"Inventory type";
		lblTitle.text = @"Select inventory type";
	}
	else 
	{
		for (int i =0 ;i < [arrInvStatus count]; i++) {
			
			if ([[[CCommon objCCommon] mstrSelectedInStatus] isEqualToString: [arrInvStatus objectAtIndex:i]]) 
			{
				[pv_InventoryStatus selectRow:i inComponent:0 animated:NO];
			}
			
		}
		
		self.title = @"Inspection status";
		lblTitle.text = @"Select inspection status";
	}

	//datePicker.date = [NSDate date];
	
	//NSLog(@"AAA   %@", [NSDate date]);
	//NSLog(@"BBB   %@",d);
	
	[datePicker addTarget:self
	               action:@selector(changeDateInLabel:)
	     forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:datePicker];
	[datePicker release];

	if (self.Mode == @"INTY")
	{
		datePicker.hidden = YES;
		pv_InventoryStatus.hidden = YES;
		pv_InventoryTypes.hidden = NO;
		
	}
	else if (self.Mode == @"INSTATUS") {
		
		datePicker.hidden = YES;
		pv_InventoryTypes.hidden = YES;
		pv_InventoryStatus.hidden = NO;
	}
	else {
		datePicker.hidden = NO;
		pv_InventoryTypes.hidden = YES;
		pv_InventoryStatus.hidden = YES;
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
	
	if (pickerView == pv_InventoryTypes)
		SelectedInType = [arrInvTypes objectAtIndex:row];
	else {
		SelectedInStatus = [arrInvStatus objectAtIndex:row];
	}
}


// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	
	if (pickerView == pv_InventoryTypes)
		return [arrInvTypes count];
	else {
		return [arrInvStatus count];
	}

}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	
	return 1;
	
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

	if (pickerView == pv_InventoryTypes)
		return [arrInvTypes objectAtIndex:row];
	else {
		return [arrInvStatus objectAtIndex:row];
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


@end
