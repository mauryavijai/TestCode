//
//  Login.h
//  Natolli
//
//  Created by Nidhi Sharma on 30/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#define SCROLLVIEW_CONTENT_HEIGHT 460
#define SCROLLVIEW_CONTENT_WIDTH  320

#import <UIKit/UIKit.h>
#import "UICustomSwitch.h"
#import "GlobalSingleton.h"
#import "MapViewController.h"

@interface Login : UIViewController<NSXMLParserDelegate> {

	IBOutlet UITextField *txtUserName;
	IBOutlet UITextField *txtPwd;
	IBOutlet UIScrollView *scrollview;
	
	BOOL keyboardVisible;
	CGPoint offset;
	UITextField *activeField;
	
	UICustomSwitch *switchView;
	
	GlobalSingleton *sharedInstance;
	
	NSString *mstrUserName;
	NSString *mstrPassword;
	
	//---web service access---
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSURLConnection *conn;
	
	//---xml parsing---
    NSXMLParser *xmlParser;
    BOOL elementFound; 

}
@property(nonatomic, retain)UITextField *txtUserName;
@property(nonatomic, retain)UITextField *txtPwd;
@property(copy, readwrite)NSString *mstrUserName;
@property(copy, readwrite)NSString *mstrPassword;

@property(nonatomic,retain) IBOutlet UIScrollView *scrollview;
- (IBAction)CheckUserAuthentication:(id)sender;

@end
