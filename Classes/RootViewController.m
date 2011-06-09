//
//  RootViewController.m
//  Natolli
//
//  Created by Nidhi Sharma on 30/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "Login.h"
#import "AddNewInventory.h"
#import "Sync.h"
#import "PendingList.h"
#import "CompletedList.h"
#import "CustomCell.h"
#import "New.h"
#import "untitled.h"
#import "List.h"


@interface RootViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end


@implementation RootViewController

@synthesize fetchedResultsController=fetchedResultsController_, managedObjectContext=managedObjectContext_;
@synthesize SelectedTab, SelectedTabID;

#pragma mark -
#pragma mark View lifecycle


- (void)createNewToolbarItems:(NSString*)selectedButton
{	
	if(selectedButton == @"HIDE")
	{
		bottomimgVw.hidden = TRUE;
		toolbar.hidden = TRUE;
	}
	else
	{
		bottomimgVw.hidden = FALSE;
		toolbar.hidden = FALSE;
		
		//flex item used to separate the left groups items and right grouped items
		UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																				  target:nil
																				  action:nil];
		
		UIImage *butimg_Dash;
		UIImage *butimg_New;
		UIImage *butimg_Pending;
		UIImage *butimg_Completed;
		UIImage *butimg_Sync;
		
		if(selectedButton == @"DASHBOARD")
		{
			butimg_Dash = [UIImage imageNamed:@"btn_dashboard_over.png"];
			self.SelectedTab = @"DASHBOARD";
		}
		else 
		{
			butimg_Dash = [UIImage imageNamed:@"btn_dashboard.png"];
			self.SelectedTab = @"";
		}
		
		if(selectedButton == @"NEW")
		{
			butimg_New = [UIImage imageNamed:@"btn_upcoming_over.png"];
			self.SelectedTab = @"NEW";
		}
		else
		{
			butimg_New = [UIImage imageNamed:@"btn_upcoming.png"];
			//self.SelectedTab = @"";
		}
		
		if(selectedButton == @"PENDING")
		{
			butimg_Pending = [UIImage imageNamed:@"btn_incomplete_over.png"];
			self.SelectedTab = @"PENDING";
		}
		else 
		{
			butimg_Pending = [UIImage imageNamed:@"btn_incomplete.png"];
			//self.SelectedTab = @"";
		}
		
		if(selectedButton == @"COMPLETED")
		{
			butimg_Completed = [UIImage imageNamed:@"btn_completed_over.png"];
			self.SelectedTab = @"COMPLETED";
		}
		else 
		{
			butimg_Completed = [UIImage imageNamed:@"btn_completed.png"];
			//self.SelectedTab = @"";
		}	
		
		if(selectedButton == @"SYNC")
		{
			butimg_Sync = [UIImage imageNamed:@"btn_sync_over.png"];
			self.SelectedTab = @"SYNC";
		}
		else 
		{
			butimg_Sync = [UIImage imageNamed:@"btn_sync.png"];
			//self.SelectedTab = @"";
		}
		
		UIButton *btn_Dash = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn_Dash setImage:butimg_Dash forState:UIControlStateNormal];	
		btn_Dash.frame = CGRectMake(0,10, butimg_Dash.size.width, butimg_Dash.size.height);
		[btn_Dash addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];	
		btn_Dash.tag = 0;
		UIBarButtonItem *index =[[UIBarButtonItem alloc] initWithCustomView:btn_Dash];
		
		UIButton *btn_New = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn_New setImage:butimg_New forState:UIControlStateNormal];	
		btn_New.frame = CGRectMake(0,0, butimg_New.size.width, butimg_New.size.height);
		[btn_New addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];	
		btn_New.tag = 1;
		UIBarButtonItem *new =[[UIBarButtonItem alloc] initWithCustomView:btn_New];
		
		UIButton *btn_Pending = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn_Pending setImage:butimg_Pending forState:UIControlStateNormal];	
		btn_Pending.frame = CGRectMake(0,0, butimg_Pending.size.width, butimg_Pending.size.height);
		[btn_Pending addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];	
		btn_Pending.tag = 2;
		UIBarButtonItem *routines =[[UIBarButtonItem alloc] initWithCustomView:btn_Pending];
		
		UIButton *btn_Completed	= [UIButton buttonWithType:UIButtonTypeCustom];
		[btn_Completed setImage:butimg_Completed forState:UIControlStateNormal];	
		btn_Completed.frame = CGRectMake(0,0, butimg_Completed.size.width, butimg_Completed.size.height);
		[btn_Completed addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];	
		btn_Completed.tag = 3;
		UIBarButtonItem *logs =[[UIBarButtonItem alloc] initWithCustomView:btn_Completed];
		
		UIButton *btn_sync = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn_sync setImage:butimg_Sync forState:UIControlStateNormal];	
		btn_sync.frame = CGRectMake(0,0, butimg_Sync.size.width, butimg_Sync.size.height);
		[btn_sync addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];	
		btn_sync.tag = 4;
		UIBarButtonItem *tmore =[[UIBarButtonItem alloc] initWithCustomView:btn_sync];
		
		NSArray *items = [NSArray arrayWithObjects: flexItem,index,flexItem,new,flexItem,routines,flexItem,logs, flexItem,tmore,flexItem, nil];
		
		[toolbar setItems:items animated:NO];
		
		[index release];
		[new release];
		[routines release];
		[logs release];
		[tmore release];
		[flexItem release];
		
	}//end else
	
}//end of Function - createToolbarItems:(NSString*)selectedButton


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 1)
	{
		if ([self.SelectedTabID compare:@"0"] == NSOrderedSame) {
			self.SelectedTab = @"DASHBOARD";
		}
		else if ([self.SelectedTabID compare:@"1"] == NSOrderedSame) {
			self.SelectedTab = @"NEW";
		}
		else if ([self.SelectedTabID compare:@"2"] == NSOrderedSame) {
			self.SelectedTab = @"PENDING";
		}
		else if ([self.SelectedTabID compare:@"3"] == NSOrderedSame) {
			self.SelectedTab = @"COMPLETED";
		}
		else if ([self.SelectedTabID compare:@"4"] == NSOrderedSame) {
			self.SelectedTab = @"SYNC";
		}
		
		if ([self.SelectedTab compare:@"DASHBOARD"] == NSOrderedSame) 
		{
			/*[self createToolbarItems:@"DASHBOARD"];
			Dashboard *aAddNewInventory = [[Dashboard alloc] initWithNibName:@"Dashboard" bundle:nil];
			[self.navigationController pushViewController:aAddNewInventory animated:YES];
			[UIView commitAnimations];	*/
			
			[self createNewToolbarItems:@"DASHBOARD"];
			untitled *aAddNewInventory = [[untitled alloc] initWithNibName:@"untitled" bundle:nil];
			[self.navigationController pushViewController:aAddNewInventory animated:YES];
			[UIView commitAnimations];	
		}
		else if ([self.SelectedTab compare:@"NEW"] == NSOrderedSame) 
		{
			/*//[self createToolbarItems:@"NEW"];
			[self createNewToolbarItems:@"NEW"];
			
			Level_0 *aAddNewInventory = [[Level_0 alloc] initWithNibName:@"Level_0" bundle:nil];
			//aAddNewInventory.Mode = @"BACK";
			[self.navigationController pushViewController:aAddNewInventory animated:YES];*/
			
			
			[self createNewToolbarItems:@"NEW"];
			/*Level_0 *aAddNewInventory = [[Level_0 alloc] initWithNibName:@"Level_0" bundle:nil];
			 [self.navigationController pushViewController:aAddNewInventory animated:YES];
			 [aAddNewInventory release];*/
			
			List *aAddNewInventory = [[List alloc] initWithNibName:@"List" bundle:nil];
			[self.navigationController pushViewController:aAddNewInventory animated:YES];
			[aAddNewInventory release];

		}
		else if ([self.SelectedTab compare:@"PENDING"] == NSOrderedSame) 
		{
			//[self createToolbarItems:@"PENDING"];
			[self createNewToolbarItems:@"PENDING"];
			PendingList *aPending = [[PendingList alloc] initWithNibName:@"PendingList" bundle:nil];
			[self.navigationController pushViewController:aPending animated:YES];
		}
		else if ([self.SelectedTab compare:@"COMPLETED"] == NSOrderedSame) 
		{
			//[self createToolbarItems:@"COMPLETED"];
			[self createNewToolbarItems:@"COMPLETED"];
			CompletedList *aCompleted = [[CompletedList alloc] initWithNibName:@"CompletedList" bundle:nil];
			[self.navigationController pushViewController:aCompleted animated:YES];
		}
		else if ([self.SelectedTab compare:@"SYNC"] == NSOrderedSame) 
		{
			//[self createToolbarItems:@"SYNC"];
			[self createNewToolbarItems:@"SYNC"];
			Sync *aSync = [[Sync alloc] initWithNibName:@"Sync" bundle:nil];
			[self.navigationController pushViewController:aSync animated:YES];
		}
		else if([self.SelectedTab compare:@"ACCOUNT"] == NSOrderedSame)
		{
			//[self createToolbarItems:@"ACCOUNT"];
			[self createNewToolbarItems:@"ACCOUNT"];
			PendingList *Aaccount = [[PendingList alloc] initWithNibName:@"PendingList" bundle:nil];
			[self.navigationController pushViewController:Aaccount animated:YES];
		}
	}
}

-(void)confirm:(id)sender
{
	NSLog(@"tag: %d SelectedTag: %@",[sender tag], self.SelectedTab);
	
	if(([sender tag] == 0 && self.SelectedTab == @"DASHBOARD") || ([sender tag] == 1 && self.SelectedTab == @"NEW")
	   || ([sender tag] == 2 && self.SelectedTab == @"PENDING") || ([sender tag] == 3 && self.SelectedTab == @"COMPLETED")
	   || ([sender tag] == 4 && self.SelectedTab == @"SYNC"))
	{

	}
	else
	{
		UIAlertView *baseAlert = [[UIAlertView alloc] 
								  initWithTitle:@"" message:@"Are you sure you want to navigate away from this page"
								  delegate:self cancelButtonTitle:@"No"
								  otherButtonTitles:@"Yes", nil
								  ];
		[baseAlert show];		
	
		[baseAlert release];
	
		self.SelectedTabID  = [@"" stringByAppendingFormat:@"%d", [sender tag]];
	}
}

- (void)createToolbarItems:(NSString*)selectedButton
{	
	if(selectedButton == @"HIDE")
	{
		bottomimgVw.hidden = TRUE;
		toolbar.hidden = TRUE;
	}
	else
	{
		bottomimgVw.hidden = FALSE;
		toolbar.hidden = FALSE;
	
		//flex item used to separate the left groups items and right grouped items
		UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
															 target:nil
															 action:nil];
	
		UIImage *butimg_Dash;
		UIImage *butimg_New;
		UIImage *butimg_Pending;
		UIImage *butimg_Completed;
		UIImage *butimg_Sync;
	
		if(selectedButton == @"DASHBOARD")
		{
			butimg_Dash = [UIImage imageNamed:@"btn_dash_over.png"];
			SelectedTab = @"DASHBOARD";
		}
		else 
			butimg_Dash = [UIImage imageNamed:@"btn_dash.png"];
	
		if(selectedButton == @"NEW")
			butimg_New = [UIImage imageNamed:@"btn_new_over.png"];
		else 
			butimg_New = [UIImage imageNamed:@"btn_new.png"];
	
		if(selectedButton == @"PENDING")
			butimg_Pending = [UIImage imageNamed:@"btn_pending_over.png"];
		else 
			butimg_Pending = [UIImage imageNamed:@"btn_pending.png"];
	
		if(selectedButton == @"COMPLETED")
			butimg_Completed = [UIImage imageNamed:@"btn_completed_over.png"];
		else 
			butimg_Completed = [UIImage imageNamed:@"btn_completed.png"];
	
		if(selectedButton == @"SYNC")
			butimg_Sync = [UIImage imageNamed:@"btn_sync_over.png"];
		else 
			butimg_Sync = [UIImage imageNamed:@"btn_sync.png"];

		UIButton *btn_Dash = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn_Dash setImage:butimg_Dash forState:UIControlStateNormal];	
		btn_Dash.frame = CGRectMake(0,10, butimg_Dash.size.width, butimg_Dash.size.height);
		[btn_Dash addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];	
		btn_Dash.tag = 0;
		UIBarButtonItem *index =[[UIBarButtonItem alloc] initWithCustomView:btn_Dash];
	
		UIButton *btn_New = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn_New setImage:butimg_New forState:UIControlStateNormal];	
		btn_New.frame = CGRectMake(0,0, butimg_New.size.width, butimg_New.size.height);
		[btn_New addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];	
		btn_New.tag = 1;
		UIBarButtonItem *new =[[UIBarButtonItem alloc] initWithCustomView:btn_New];
	
		UIButton *btn_Pending = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn_Pending setImage:butimg_Pending forState:UIControlStateNormal];	
		btn_Pending.frame = CGRectMake(0,0, butimg_Pending.size.width, butimg_Pending.size.height);
		[btn_Pending addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];	
		btn_Pending.tag = 2;
		UIBarButtonItem *routines =[[UIBarButtonItem alloc] initWithCustomView:btn_Pending];
	
		UIButton *btn_Completed	= [UIButton buttonWithType:UIButtonTypeCustom];
		[btn_Completed setImage:butimg_Completed forState:UIControlStateNormal];	
		btn_Completed.frame = CGRectMake(0,0, butimg_Completed.size.width, butimg_Completed.size.height);
		[btn_Completed addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];	
		btn_Completed.tag = 3;
		UIBarButtonItem *logs =[[UIBarButtonItem alloc] initWithCustomView:btn_Completed];
	
		UIButton *btn_sync = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn_sync setImage:butimg_Sync forState:UIControlStateNormal];	
		btn_sync.frame = CGRectMake(0,0, butimg_Sync.size.width, butimg_Sync.size.height);
		[btn_sync addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];	
		btn_sync.tag = 4;
		UIBarButtonItem *tmore =[[UIBarButtonItem alloc] initWithCustomView:btn_sync];
			
		NSArray *items = [NSArray arrayWithObjects: flexItem,index,flexItem,new,flexItem,routines,flexItem,logs, flexItem,tmore,flexItem, nil];
	
		[toolbar setItems:items animated:NO];
	
		[index release];
		[new release];
		[routines release];
		[logs release];
		[tmore release];
		[flexItem release];
		
	}//end else
	
}//end of Function - createToolbarItems:(NSString*)selectedButton





- (void)Hide
{
	bottomimgVw.hidden = TRUE;
}

- (void)viewDidLoad {
	
	sharedInstance =[GlobalSingleton sharedInstance];
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"natolli_logo.png"]];

    [super viewDidLoad];

	//Initialize toolbar
	toolbar = [[TransparentToolbar alloc] init];
	[toolbar sizeToFit];
	
	//Caclulate the height of the toolbar
	CGFloat toolbarHeight = [toolbar frame].size.height;
	//Get the bounds of the parent view
	CGRect rootViewBounds = self.parentViewController.view.bounds;
	//Get the height of the parent view.
	CGFloat rootViewHeight = CGRectGetHeight(rootViewBounds);
	//Get the width of the parent view,
	CGFloat rootViewWidth = CGRectGetWidth(rootViewBounds);
	//Create a rectangle for the toolbar
	CGRect rectArea = CGRectMake(0, rootViewHeight - toolbarHeight-4, rootViewWidth, toolbarHeight);
	//Reposition and resize the receiver
	[toolbar setFrame:rectArea];
	
	UIImage *bottomimg = [UIImage imageNamed:@"toolbar.png"];
	bottomimgVw = [[UIImageView alloc] initWithImage:bottomimg ];

	CGRect rectAreabottom = CGRectMake(0, 432, 320, 48);
	[bottomimgVw setFrame:rectAreabottom];
	
	[self.navigationController.view addSubview:bottomimgVw];
	
	self.navigationController.navigationBarHidden = YES;
	
	Login *objLogin = [[Login alloc] initWithNibName:@"Login" bundle:nil];
	[self.navigationController pushViewController:objLogin animated:NO];
	[objLogin release];

	[self.navigationController.view addSubview:toolbar];
}


// Implement viewWillAppear: to do additional setup before the view is presented.
- (void)viewWillAppear:(BOOL)animated {
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
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[managedObject valueForKey:@"timeStamp"] description];
}


#pragma mark -
#pragma mark Add a new object

- (void)insertNewObject {
    
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
//	return [[self.fetchedResultsController sections] ];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here -- for example, create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     NSManagedObject *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}


#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController_ != nil) {
        return fetchedResultsController_;
    }
    
    /*
     Set up the fetched results controller.
    */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    NSError *error = nil;
    if (![fetchedResultsController_ performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController_;
}    


#pragma mark -
#pragma mark Fetched results controller delegate


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */


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


- (void)dealloc {
    [fetchedResultsController_ release];
    [managedObjectContext_ release];
	[SelectedTab release];
	[SelectedTabID release];
	
    [super dealloc];
}


@end

