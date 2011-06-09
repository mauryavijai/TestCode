//
//  Login.m
//  Natolli
//
//  Created by Nidhi Sharma on 30/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Login.h"
#import "RootViewController.h"
#import "untitled.h"

@implementation Login
@synthesize txtUserName, txtPwd, scrollview;
@synthesize mstrUserName, mstrPassword;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void) viewWillAppear:(BOOL)animated {
	
	RootViewController *theRootViewController =[[self.navigationController viewControllers] objectAtIndex:0];
	//[theRootViewController createToolbarItems:@"HIDE"];
	[theRootViewController createNewToolbarItems:@"HIDE"];
	
	
	[self.navigationController setNavigationBarHidden:YES animated:NO];
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
	
	[self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
	
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
	//scrollview.frame = CGRectMake(-50, -100, 0, 0);

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
	return YES;
}

- (void)GetValuesFromInfoList
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:@"MySettings.plist"];
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:myPathDocs])
	{
		NSString *myPathInfo = [[NSBundle mainBundle] pathForResource:@"MySettings" ofType:@"plist"];
		NSFileManager *fileManager = [NSFileManager defaultManager];
		[fileManager copyItemAtPath:myPathInfo toPath:myPathDocs error:NULL];
	}		
	
	//Load from File
	NSMutableArray *array = [[[NSMutableArray alloc] initWithContentsOfFile:myPathDocs] autorelease];
	
	if ([ array count] >1) {
		NSString *userName = [array objectAtIndex:0];
		NSString *pwd = [array objectAtIndex:1];
		
		if ([pwd length] != 0)
		{
			txtPwd.text = pwd;
			mstrPassword = pwd;
		}
		if ([userName length] != 0)
		{
			txtUserName.text = userName;
			mstrUserName = userName;
		}
	}	
	
	//[array release];
}

-(IBAction)checkOnOffState:(id)sender{
	
    UISegmentedControl* tempSeg=(UISegmentedControl *)sender;
    if(tempSeg.selectedSegmentIndex==0){
        [tempSeg setImage:[UIImage imageNamed:@"onSelected.png"] forSegmentAtIndex:0];
        [tempSeg setImage:[UIImage imageNamed:@"off.png"] forSegmentAtIndex:1];
		
		//[tempSeg setImage:[UIImage imageNamed:@"btn_sync.png"] forSegmentAtIndex:0];
        //[tempSeg setImage:[UIImage imageNamed:@"btn_sync_over.png"] forSegmentAtIndex:1];
    }
    else{
        [tempSeg setImage:[UIImage imageNamed:@"on.png"] forSegmentAtIndex:0];
        [tempSeg setImage:[UIImage imageNamed:@"offSelected.png"] forSegmentAtIndex:1];
		
		//[tempSeg setImage:[UIImage imageNamed:@"btn_pending.png"] forSegmentAtIndex:0];
        //[tempSeg setImage:[UIImage imageNamed:@"btn_pending_over.png"] forSegmentAtIndex:1];
    }   
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	sharedInstance =[GlobalSingleton sharedInstance];
	
	[self GetValuesFromInfoList];
	
	self.scrollview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
	//self.scrollview.backgroundColor = [UIColor redColor];

	// Standard ON/OFF
	switchView = [[UICustomSwitch alloc] initWithFrame:CGRectZero];
	switchView.center = CGPointMake(68.0f, 280.0f);
	switchView.on = YES;
	[self.scrollview addSubview:switchView];
	[switchView release];
	
	/*UISegmentedControl* switchView1=[[UISegmentedControl alloc] initWithItems:[[[NSMutableArray alloc] initWithObjects:@"On",@"Off",nil] autorelease]];
    [switchView1 setFrame:CGRectMake(50,50,100,28)];
	//switchView1.center = CGPointMake(40.0f, 280.0f);
	//switchView1.center = CGPointMake(27.0f, 97.0f);
    switchView1.selectedSegmentIndex=0;
    switchView1.segmentedControlStyle=UISegmentedControlStyleBar;
    [switchView1 setImage:[UIImage imageNamed:@"onSelected.png"] forSegmentAtIndex:0];
    [switchView1 setImage:[UIImage imageNamed:@"off.png"] forSegmentAtIndex:1];
	
	// [switchView1 setImage:[UIImage imageNamed:@"btn_sync.png"] forSegmentAtIndex:0];
    // [switchView1 setImage:[UIImage imageNamed:@"btn_sync_over.png"] forSegmentAtIndex:1];

    [switchView1 addTarget:self action:@selector(checkOnOffState:) forControlEvents:UIControlEventValueChanged];
	[self.scrollview  addSubview:switchView1];
   // self.navigationItem.titleView=switchView1;*/

	txtPwd.textColor = [UIColor colorWithRed:0.2 
									   green:0.2
										blue:0.2
									   alpha:1.0f];
	
	UIImageView * myView = [[ UIImageView  alloc] initWithImage :[UIImage  imageNamed : @"10x10.png" ]];
	[txtPwd  setLeftView :myView];
	[txtPwd  setLeftViewMode: UITextFieldViewModeAlways];
	
	txtUserName.textColor = [UIColor colorWithRed:0.2
									   green:0.2
										blue:0.2
									   alpha:1.0f];	
	
	UIImageView * myView_UN = [[ UIImageView  alloc] initWithImage :[UIImage  imageNamed : @"10x10.png" ]];
	[txtUserName  setLeftView :myView_UN];
	[txtUserName  setLeftViewMode: UITextFieldViewModeAlways];
}



/*// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
   // return (interfaceOrientation == UIInterfaceOrientationPortrait);
	//return YES;
	//scrollview.frame = CGRectMake(0, 0, SCROLLVIEW_CONTENT_WIDTH, SCROLLVIEW_CONTENT_HEIGHT);
	//return(interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
	return YES;
}*/



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

- (IBAction)CheckUserAuthentication:(id)sender
{

	[txtPwd resignFirstResponder];
	[txtUserName resignFirstResponder];
	sharedInstance.LastPageOpened = @"HIDE";
	NSString *lstrUserName = txtUserName.text;
	NSString *lstrPwd = txtPwd.text;
	
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = YES; 
	
	//MapViewController *obj = [[MapViewController alloc] initWithNibName:@"MapView" bundle:nil];
	//[self.navigationController pushViewController:obj animated:YES];
	untitled *objDashboard = [[untitled alloc] initWithNibName:@"untitled" bundle:nil];	
	[self.navigationController pushViewController:objDashboard animated:YES];
	[objDashboard release];

	/*if ([lstrUserName length] == 0)
	{
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@""
							  message:@"Please enter Username"
							  delegate:self
							  cancelButtonTitle:@"OK"
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
		
	}
	else if ([lstrPwd length] == 0)
	{
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:@""
							  message:@"Please enter Password"
							  delegate:self
							  cancelButtonTitle:@"OK"
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
		
	}
	else 
	{
		if ([mstrUserName length] != 0 && [mstrPassword length] != 0)
		{
			if ([mstrUserName compare:txtUserName.text] == NSOrderedSame && [mstrPassword compare:txtPwd.text] == NSOrderedSame)
			{
				[UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
	
				untitled *objDashboard = [[untitled alloc] initWithNibName:@"untitled" bundle:nil];	
				[self.navigationController pushViewController:objDashboard animated:YES];
				[objDashboard release];
				
			
			}
			else {
				[UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
				UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Invalid Username/Password. Please try again." 
									  delegate:self cancelButtonTitle:@"Ok"
									  otherButtonTitles:nil];
				[baseAlert show];	
				[baseAlert release];
			}
		}
		else 
		{
			NSError *error;
			if ([NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://iphone.5sol.com/Service.asmx"] encoding:NSASCIIStringEncoding error:&error] != NULL)
			{
				
				NSString *postString =[@"" stringByAppendingString:@"ClientName="];
				postString =[postString stringByAppendingString:lstrUserName];
				postString =[postString stringByAppendingString:@"&Pwd="];
				postString =[postString stringByAppendingString:lstrPwd];
			
				NSURL *url = [NSURL URLWithString:
						  @"http://iphone.5sol.com/Service.asmx/AuthenticateUser"];
				
				NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
				NSString *msgLength =
				[NSString stringWithFormat:@"%d", [postString length]];
			
				[req addValue:@"application/x-www-form-urlencoded"
				forHTTPHeaderField:@"Content-Type"];
				[req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
				[req setHTTPMethod:@"POST"];
				[req setHTTPBody: [postString
							   dataUsingEncoding:NSUTF8StringEncoding]];
			
				conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
				if (conn) {
					webData = [[NSMutableData data] retain];
				}
			}
			else 
			{ 
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"Alert" message:@"Unable to connect to Internet. Please try again later." 
										  delegate:self cancelButtonTitle:@"Ok"
										  otherButtonTitles:nil];
				[baseAlert show];	
				[baseAlert release];		
			}
			
		}
	}// END -  "if" statement */

}// END - CheckUserAuthentication

-(void) connection:(NSURLConnection *) connection 
didReceiveResponse:(NSURLResponse *) response {
	[webData setLength: 0];
}

-(void) connection:(NSURLConnection *) connection 
	didReceiveData:(NSData *) data {
	[webData appendData:data];
}

-(void) connection:(NSURLConnection *) connection 
  didFailWithError:(NSError *) error {
	NSLog(@"error code=%d domain=%@",error.code,error.domain);
	NSLog(@"Error : %@", [error localizedDescription]);
	[webData release];
    [connection release];
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
	NSLog(@"DONE. Received Bytes: %d", [webData length]);
	NSString *theXML = [[NSString alloc]
						initWithBytes: [webData mutableBytes]
						length:[webData length]
						encoding:NSUTF8StringEncoding];
			
	//---shows the XML---
	[theXML release];
		
	if (xmlParser)
	{
		[xmlParser release];
	}
	xmlParser = [[NSXMLParser alloc] initWithData: webData];
	[xmlParser setDelegate: self];
	[xmlParser setShouldResolveExternalEntities:YES];
	[xmlParser parse];
	
	[connection release];
	[webData release];
}

//---when the start of an element is found---
-(void) parser:(NSXMLParser *) parser
didStartElement:(NSString *) elementName
  namespaceURI:(NSString *) namespaceURI
 qualifiedName:(NSString *) qName
	attributes:(NSDictionary *) attributeDict {
	//NSLog(soapResults);
	if( [elementName isEqualToString:@"IsUserAuthenticated"])
	{
		if (!soapResults)
		{
			soapResults = [[NSMutableString alloc] init];
		}
		elementFound = YES;
	}
	
}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
{
	if (elementFound)
	{
		[soapResults appendString: string];
	}
}

//---when the end of element is found---
-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
{
	//NSLog(soapResults);
	
	if ([elementName isEqualToString:@"IsUserAuthenticated"])
	{
		//---displays the country---
		//NSLog(soapResults);
		
		if ([soapResults compare:@"True"] == NSOrderedSame )
		{
			if (switchView.on) 
			{
				NSMutableArray *array = [[NSMutableArray alloc]init];
				
				[array addObject:[NSString stringWithFormat:@"%@", txtUserName.text]];
				[array addObject:[NSString stringWithFormat:@"%@", txtPwd.text]];
				[array addObject:@""];
				
				NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
				NSString *documentsDirectory = [paths objectAtIndex:0];
				NSString *dataFilePath = [documentsDirectory stringByAppendingPathComponent:@"MySettings.plist"];
				
				[array writeToFile:dataFilePath atomically:YES];
				[array release];
				
			}	
			
			/*Dashboard *objDashboard = [[Dashboard alloc] initWithNibName:@"Dashboard" bundle:nil];	
			[self.navigationController pushViewController:objDashboard animated:YES];
			[objDashboard release];
			
			Dash *objDashboard = [[Dash alloc] initWithNibName:@"Dash" bundle:nil];	
			[self.navigationController pushViewController:objDashboard animated:YES];
			[objDashboard release];	*/
			
			untitled *objDashboard = [[untitled alloc] initWithNibName:@"untitled" bundle:nil];	
			[self.navigationController pushViewController:objDashboard animated:YES];
			[objDashboard release];
			
		}
		else {		
			UIAlertView *alert = [[UIAlertView alloc]
								  initWithTitle:nil
								  message:@"Invalid Username/Password. Please try again."
								  delegate:self
								  cancelButtonTitle:@"OK"
								  otherButtonTitles:nil];
			[alert show];
			[alert release];	
		}
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
	}
	
	[soapResults setString:@""];
	elementFound = NO;
}

- (void)dealloc {
    [super dealloc];
	[txtPwd release];
	[txtUserName release];
	[mstrPassword release];
	[mstrUserName release];
	[scrollview release];
	[activeField release];

	if(webData != NULL)
		[webData release];
	
	if (soapResults != NULL)
		[soapResults release];
	
	if (conn != NULL)
		[conn release];	
	
	if (xmlParser != NULL)
		[xmlParser release];		
}


@end
