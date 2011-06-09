//
//  untitled.m
//  Natolli
//
//  Created by Nidhi Sharma on 18/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "untitled.h"
#import "Login.h"
#import "PendingList.h"
#import "CompletedList.h"
#import "Sync.h"
#import "List.h"


@implementation untitled

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	theRootViewController =[[self.navigationController viewControllers] objectAtIndex:0];
	[theRootViewController createNewToolbarItems:@"DASHBOARD"];

}


- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
	theRootViewController =[[self.navigationController viewControllers] objectAtIndex:0];
	[theRootViewController createNewToolbarItems:@"DASHBOARD"];
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction)aButtonClicked:(id)sender {
	Login *aLogin = [[Login alloc] initWithNibName:@"Login" bundle:nil];
	[self.navigationController pushViewController:aLogin animated:NO];
	[aLogin release];
	[[UIApplication sharedApplication] terminateWithSuccess];
		
}

- (void)loadView {
	[super loadView];
	
	self.title = @"Dashboard";
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.46 
																		green:0.70
																		 blue:0.08
																		alpha:1.0f];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(aButtonClicked:)];
	

	self.navigationItem.hidesBackButton = YES;
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
	//self.scrollview.backgroundColor = [UIColor redColor];
	
	
}

- (IBAction)UpComingBooking:(id)sender
{
	[theRootViewController createNewToolbarItems:@"NEW"];
	/*Level_0 *aAddNewInventory = [[Level_0 alloc] initWithNibName:@"Level_0" bundle:nil];
	[self.navigationController pushViewController:aAddNewInventory animated:YES];
	[aAddNewInventory release];*/
	
	List *aAddNewInventory = [[List alloc] initWithNibName:@"List" bundle:nil];
	[self.navigationController pushViewController:aAddNewInventory animated:YES];
	[aAddNewInventory release];
}

- (IBAction)IncompleteBooking:(id)sender
{
	[theRootViewController createNewToolbarItems:@"PENDING"];
	PendingList *aPending = [[PendingList alloc] initWithNibName:@"PendingList" bundle:nil];
	[self.navigationController pushViewController:aPending animated:YES];
	
}

- (IBAction)CompleteBooking:(id)sender
{
	[theRootViewController createNewToolbarItems:@"COMPLETED"];
	CompletedList *aCompleted = [[CompletedList alloc] initWithNibName:@"CompletedList" bundle:nil];
	[self.navigationController pushViewController:aCompleted animated:YES];
}

- (IBAction)Synchronise:(id)sender
{
	[theRootViewController createNewToolbarItems:@"SYNC"];
	Sync *aSync = [[Sync alloc] initWithNibName:@"Sync" bundle:nil];
	[self.navigationController pushViewController:aSync animated:YES];
}


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


@end
