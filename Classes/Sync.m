//
//  Sync.m
//  Natolli
//
//  Created by Nidhi Sharma on 01/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Sync.h"
#import "CustomCell.h"

@implementation Sync
@synthesize loader, arrBrandTitle,arrBrandTitleFromLocalDB_ForSync, arrBrandTitleFromServerDB_ForSync;

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
	//[theRootViewController createToolbarItems:@"SYNC"];
	[theRootViewController createNewToolbarItems:@"SYNC"];
	
	[super viewWillAppear:animated];
}

- (IBAction)aButtonClicked:(id)sender
{
	exit(0);
}

- (IBAction)SyncData:(id)sender 
{
	UIImage *backgroundImage = [UIImage imageNamed:@"alert_bg.png"];
	UIImage *ActionBtnImage = [UIImage imageNamed:@"btn_close.png"];
	alert = [[CustomCell alloc] initWithImage:backgroundImage text:NSLocalizedString(@"Pending inventory files synchronised.", nil) ActionBtnImg:ActionBtnImage];
	[alert show];
}

- (void) handleBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{	
	loader.hidden = true;
	
	arrBrandTitle = [[NSMutableArray alloc] init];
	arrBrandTitleFromLocalDB_ForSync = [[NSMutableArray alloc] init];
	arrBrandTitleFromServerDB_ForSync = [[NSMutableArray alloc] init];

	sharedInstance =[GlobalSingleton sharedInstance];

	arrBrandTitleFromLocalDB_ForSync = [CCommon GetBrandsFromLocalDBForSync];
	arrBrandTitle = [CCommon GetAllBrandsFromLocalDb];
	
	//self.navigationItem.hidesBackButton = YES;
	//self.navigationController.navigationBarHidden = NO;
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(aButtonClicked:)];

	self.title = @"Sync Inventories";
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

- (void)GetBrandsFromServerDb {
	
	NSError* error;
	if ([NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://iphone.5sol.com/Service.asmx"] encoding:NSASCIIStringEncoding error:&error] != NULL)
	{
		NSURL *url = [NSURL URLWithString:
					  @"http://iphone.5sol.com/Service.asmx/GetBrands"];
		
		NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
		
		[req addValue:@"application/x-www-form-urlencoded"
		forHTTPHeaderField:@"Content-Type"];
		[req addValue:@"5" forHTTPHeaderField:@"Content-Length"];
		[req setHTTPMethod:@"POST"];
		//[activityIndicator startAnimating];
		
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

- (void)UpdateLocalDb {
	
	NSError* error;
	if ([NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://iphone.5sol.com/Service.asmx"] encoding:NSASCIIStringEncoding error:&error] != NULL)
	{
		NSURL *url = [NSURL URLWithString:
					  @"http://iphone.5sol.com/Service.asmx/GetBrands"];
		
		NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
		
		[req addValue:@"application/x-www-form-urlencoded"
		forHTTPHeaderField:@"Content-Type"];
		[req addValue:@"5" forHTTPHeaderField:@"Content-Length"];
		[req setHTTPMethod:@"POST"];

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

//Function used to Sync. local data with Online database, on button click. 
-(void)SyncDetails:(id)sender
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;  
	
	loader.hidden = false;
	loader.hidesWhenStopped = TRUE;
	[loader startAnimating];
	NSError* error;
	
	if ([NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://iphone.5sol.com/Service.asmx"] encoding:NSASCIIStringEncoding error:&error] != NULL)
	{ 
		NSString *strTitle = [arrBrandTitleFromLocalDB_ForSync componentsJoinedByString: @","];
	
		if ([arrBrandTitleFromLocalDB_ForSync count] >0)
		{
			NSString *postString = @"title=";
			postString  =[postString stringByAppendingString:strTitle];

			NSLog(@"MY @", postString);
			
			NSURL *url = [NSURL URLWithString:
						  @"http://iphone.5sol.com/Service.asmx/AddBrand"];
			
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
			if (conn) 
			{
				webData = [[NSMutableData data] retain];
			}			
		}
		else
		{
			[self UpdateLocalDb];
		}

		/*UIAlertView *baseAlert = [[UIAlertView alloc] 
								  initWithTitle:@"" message:@"Data has been synchronized successfully."
								  delegate:self cancelButtonTitle:nil
								  otherButtonTitles:@"OK",nil];
		[baseAlert show];
		[baseAlert release];
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO; */
	}
	else 
	{ 
		UIAlertView *baseAlert = [[UIAlertView alloc] 
								  initWithTitle:@"Alert" message:@"Unable to connect to Internet. Please try again later." 
								  delegate:self cancelButtonTitle:@"Ok"
								  otherButtonTitles:nil];
		//[baseAlert show];	
		[baseAlert release];
	}	
}

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response
{
	[webData setLength: 0];
}

-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data
{
	[webData appendData:data];
} 

-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error
{
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
  attributes:(NSDictionary *) attributeDict
{
	if( [elementName isEqualToString:@"Message"] || [elementName isEqualToString:@"Title"] || [elementName isEqualToString:@"IsLastElement"])
	{
		if (!soapResults)
		{
			soapResults = [[NSMutableString alloc] init];
		}
		elementFound = TRUE;
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
	if ([elementName isEqualToString:@"Message"])
	{
		if ([soapResults compare:@"Error"] == NSOrderedSame)
		{
			UIAlertView *alertView = [[UIAlertView alloc]
								  initWithTitle:nil
								  message:@"Error occured. Please try again."
								  delegate:self
								  cancelButtonTitle:@"OK"
								  otherButtonTitles:nil];
			[alertView show];
			[alertView release];
		}
		else
		{
			elementFound = FALSE;
			[soapResults setString:@""];
			[CCommon MarkBrandsAsSync];
			//[self UpdateLocalDb];
			
			[self performSelector:@selector(UpdateLocalDb) withObject:NULL afterDelay:[arrBrandTitleFromLocalDB_ForSync count]];
		}
		
	}
	if ([elementName isEqualToString:@"Title"])
	{
		NSString *value = [[NSString alloc] init];
		value = @"";
		value = [value stringByAppendingString:soapResults];
		
		//[arrBrandTitle addObject:value];
		//if ([arrBrandTitle indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) 
		//{
		if([arrBrandTitle containsObject:value])
		{
			NSLog(@"Success");
		}
		else {
			[arrBrandTitleFromServerDB_ForSync addObject:value];
		}

		elementFound = FALSE;
		[soapResults setString:@""];

	}
	if ([elementName isEqualToString:@"IsLastElement"])
	{
		NSString *value = [[NSString alloc] init];
		value = @"";
		value = [value stringByAppendingString:soapResults];

		if ([value compare:@"YES"] == NSOrderedSame)
		{
			/*NSArray *copy = [arrBrandTitle copy];
			NSInteger index = [copy count] - 1;
			for (id object in [copy reverseObjectEnumerator]) 
			{
				if ([arrBrandTitle indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) 
				{
					//NSLog(@"MyNumber is, %d",[[arrBrandTitle objectAtIndex:index]intValue]);
					[arrBrandTitle removeObjectAtIndex:index];
					
					if ([arrBrandTitle containsObject:object])
					{
						NSLog(@"Value: %d", index);
						//[arrBrandTitle removeObjectAtIndex:index-1];
					}
				}
				index--;				
			}
			[copy release];*/
			
			[CCommon AddBrandsFromServerToLocalDB:arrBrandTitleFromServerDB_ForSync];
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Data has been synchronized successfully."
									  delegate:self cancelButtonTitle:nil
									  otherButtonTitles:@"OK",nil];
			[baseAlert show];
			[baseAlert release];
			
			[UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
			
			elementFound = FALSE;
			[soapResults setString:@""];
		}
	}
	
	elementFound = FALSE;
	[soapResults setString:@""];
}

@end
