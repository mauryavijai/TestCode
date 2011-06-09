//
//  CompletedList.m
//  Natolli
//
//  Created by Nidhi Sharma on 01/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CompletedList.h"


@implementation CompletedList


#pragma mark -
#pragma mark View lifecycle

- (IBAction)aButtonClicked:(id)sender {
	exit(0);
}

- (void) handleBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	sharedInstance =[GlobalSingleton sharedInstance];
	
	//self.navigationItem.hidesBackButton = YES;
	//self.navigationController.navigationBarHidden = NO;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(aButtonClicked:)];
	
	
	self.title = @"Completed Inventories";
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.46 
																		green:0.70
																		 blue:0.08
																		alpha:1.0f];
	/*Right bar button - START
	
	UIImage *buttonImage = [UIImage imageNamed:@"btn_logout.png"];
	
	UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[aButton setImage:buttonImage forState:UIControlStateNormal];
	
	aButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
	
	UIBarButtonItem *aBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aButton];
	
	[aButton addTarget:self action:@selector(aButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	[buttonImage release];

	self.navigationItem.rightBarButtonItem = aBarButtonItem;*/
	
	/*Right bar button - END*/
	
	/*left bar button - START
	
	UIImage *leftBtnImage = [UIImage imageNamed:@"btn_back.png"];
	
	UIButton *aLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[aLeftButton setImage:leftBtnImage forState:UIControlStateNormal];
	
	aLeftButton.frame = CGRectMake(100.0, 0.0, leftBtnImage.size.width, leftBtnImage.size.height);
	
	UIBarButtonItem *aLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aLeftButton];
	
	[aLeftButton addTarget:self action:@selector(handleBack:) forControlEvents:UIControlEventTouchUpInside];
	
	[leftBtnImage release];
	
	self.navigationItem.leftBarButtonItem = aLeftBarButtonItem;*/
	
	/*left bar button - END*/
	
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated 
{
	RootViewController *theRootViewController =[[self.navigationController viewControllers] objectAtIndex:0];
//	[theRootViewController createToolbarItems:@"COMPLETED"];
	[theRootViewController createNewToolbarItems:@"COMPLETED"];
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
    return 3.0;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 3.0;
	//return 17.0;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
	return [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
	return [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
}


- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
	return 78.0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	static NSString *CellIdentifier = @"Cell"; 
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; 
	if (cell == nil) 
	{ 
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(50,150, 320, 79) 
									   reuseIdentifier:CellIdentifier] autorelease]; 
		
		//cell.selectionStyle = UITableViewCellSelectionStyleGray;
		
	   cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg_hover.png"]] autorelease];
		
		NSString *strHeading =@"";
		NSString *strSubHeading = @"";
		//NSString *imageName = @""; 
		NSString *imageName = @"cell_bg.png"; 
		
		if (indexPath.row == 0) {
			strHeading =@"Lorem ipsum dolor sit";
			strSubHeading =@"Southhall / 29th Oct 2010, 9:10am";
			//imageName = @"1.png";
		}
		if (indexPath.row == 1) {
			strHeading =@"Onsectetuer adipiscing";
			strSubHeading =@"Deven / 27th Oct 2010, 01:10pm";
			//imageName = @"2.png";
		}
		if (indexPath.row == 2) {
			strHeading =@"Ed daim nonummy";
			strSubHeading =@"Deven / 26th Oct 2010, 07:10pm";
			//imageName = @"1.png";
		}
		if (indexPath.row == 3) {
			strHeading =@"Euismod tincidunt ut laoreet";
			strSubHeading =@"yorkshire / 25th Oct 2010, 5:30pm";
			//imageName = @"2.png";
		}
		if (indexPath.row == 4) {
			strHeading =@"Dolore magna aliquam";
			strSubHeading =@"Deven / 24th Oct 2010, 07:10pm";
			//imageName = @"1.png";
		}
		if (indexPath.row == 5) {
			strHeading =@"Ullamcorper suscipit lobortis";
			strSubHeading =@"Southhall / 23th Oct 2010, 9:10am";
			//imageName = @"2.png";
		}
		
		UIImage *rowBackground;
		///NSString *imageName = @"table_view_cell.png"; 
		//NSString *imageName = @"cell_bg.png"; 

		rowBackground = [UIImage imageNamed:imageName]; 
		
		UILabel *lblheading = [[UILabel alloc] initWithFrame:CGRectMake(11,10, 270, 30)];
		lblheading.backgroundColor	= [UIColor clearColor];
		lblheading.textColor = [UIColor colorWithRed:0.50 green:0.72 blue:0.14 alpha:1.0]; 
		lblheading.font = [UIFont fontWithName:@"Arial-BoldMT" size:23.0f]; 
		lblheading.text =strHeading;
		
		UILabel *lblSubHeading = [[UILabel alloc] initWithFrame:CGRectMake(11,33, 270, 30)];
		lblSubHeading.backgroundColor	= [UIColor clearColor];
		lblSubHeading.textColor = [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:1.0]; 
		lblSubHeading.font = [UIFont fontWithName:@"Arial-BoldMT" size:16.0f]; 
		lblSubHeading.text =strSubHeading;
		
		UIImageView *normalBackground = [[[UIImageView alloc] init] autorelease];
		normalBackground.image = rowBackground; 
		[normalBackground insertSubview:lblheading atIndex:0]; 
		[normalBackground insertSubview:lblSubHeading atIndex:1]; 
		cell.backgroundView = normalBackground; 
		[lblheading release];
	} 
	return cell;
	
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	// Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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


- (void)dealloc {
    [super dealloc];
}


@end

