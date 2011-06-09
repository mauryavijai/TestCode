//
//  ViewTableViewController.m
//  ViewTable
//
//  Created by Chakra on 05/04/10.
//  Copyright Chakra Interactive Pvt Ltd 2010. All rights reserved.
//

#import "ViewTableViewController.h"
#import "MainView.h"
#import "DetailView.h"

@implementation ViewTableViewController
@synthesize Mode;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

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

-(void)reloadTable {
	
	arryList = [[NSMutableArray alloc] init];
	
	if (self.Mode == @"FLOOR") {
		arryList = [CCommon GetFloorImageTitle];
	}
	else {
		arryList = [CCommon GetRoomImageTitle];
	}

	[tableView reloadData];

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES; 
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];

	arryList = [[NSMutableArray alloc] init];
	
	if (self.Mode == @"FLOOR") {
	
		NSString *imageName = [@"F" stringByAppendingFormat:@"%@.jpeg",[CCommon LastAdded_FloorImageID]];

		NSString *path = [documentsDirectory stringByAppendingPathComponent:imageName]; //here use the name with which you want to save the file
		NSData *dataObj = UIImageJPEGRepresentation(image, 1.0);
		[dataObj writeToFile:path atomically:NO]; 

		[[picker parentViewController] dismissModalViewControllerAnimated:YES];
	
		[CCommon AddFloorImages:imageName];

		arryList = [CCommon GetFloorImageTitle];
		
	}
	else {
		
		NSString *imageName = [@"R" stringByAppendingFormat:@"%@.jpeg",[CCommon LastAdded_FloorImageID]];
		
		NSString *path = [documentsDirectory stringByAppendingPathComponent:imageName]; //here use the name with which you want to save the file
		NSData *dataObj = UIImageJPEGRepresentation(image, 1.0);
		[dataObj writeToFile:path atomically:NO]; 
		
		[[picker parentViewController] dismissModalViewControllerAnimated:YES];
		
		[CCommon AddRoomImages:imageName];

		arryList = [CCommon GetRoomImageTitle];
	
	}

	[tableView reloadData];

//	[self performSelector:@selector(reloadTable) withObject:NULL afterDelay:1];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
													message:@"WWW" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
	
	
	//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"ble" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	//[alert show];
	//[alert release];
	
	//arryList = [CCommon GetFloorImageTitle];
	//[tableView reloadData];
}


-(void)AddImage:(id)sender
{

	//selectedButton = (UIButton *)sender;
	[self openCameraRoll];

}

- (void)viewWillAppear:(BOOL)animated {
	
	
	
	[super viewWillAppear:animated];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	UIPicker = [[UIImagePickerController alloc] init];
	UIPicker.allowsImageEditing = NO;
	UIPicker.delegate = self;	
	
	arryList = [[NSMutableArray alloc] init];
	imagesList = [[NSMutableArray alloc] init];
	
	if (self.Mode == @"FLOOR") {
		arryList = [CCommon GetFloorImageTitle];
	}
	else {
		arryList = [CCommon GetRoomImageTitle];
	}

	//self.title = @"Table View";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(AddImage:)];
	

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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(CGFloat)tableView:(UITableView *)tableView widthForRowAtIndexPath:(NSIndexPath *)indexPath
 {	
	 return 150.0;
 }

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    //if(section == 0)
        return 6;
   // return 1.0;
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

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if([arryList count] == 0)
		return 1;
	else {
		return [arryList count];
	}
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	MyIdentifier = @"TableView";
	
	MainView *cell = (MainView *)[tableView dequeueReusableCellWithIdentifier: MyIdentifier];
	if(cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"MainView" owner:self options:nil];
		cell = tableCell;
	}
	
	if([arryList count] == 0)
	{
		//[cell LabelText:@"No image added"];
		[cell ProductImage:@"abc"];
	}
	else {
		//[cell LabelText:[arryList objectAtIndex:indexPath.row]];
		[cell ProductImage:[arryList objectAtIndex:indexPath.row]];
	}

	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//	DetailView *detailController = [[DetailView alloc] initWithNibName:@"DetailView" bundle:nil];
	//[self.navigationController pushViewController:detailController animated:YES];
	//[detailController changeText:[arryList objectAtIndex:indexPath.row]];
}



@end
