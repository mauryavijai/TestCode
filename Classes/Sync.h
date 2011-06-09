//
//  Sync.h
//  Natolli
//
//  Created by Nidhi Sharma on 01/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h> // For .layer 

@interface Sync : UIViewController<NSXMLParserDelegate> {

	UIAlertView *alert;
	GlobalSingleton *sharedInstance;
	
	//---web service access---
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSURLConnection *conn;
	
	//---xml parsing---
    NSXMLParser *xmlParser;
    BOOL elementFound; 
	IBOutlet UIActivityIndicatorView *loader;
	
	NSMutableArray *arrBrandTitle;
	NSMutableArray *arrBrandTitleFromLocalDB_ForSync;
	NSMutableArray *arrBrandTitleFromServerDB_ForSync;
	
	CCommon *objCCommon;
}
@property(nonatomic, retain)UIActivityIndicatorView *loader;
@property(copy, readwrite)NSMutableArray *arrBrandTitle;
@property(copy, readwrite)NSMutableArray *arrBrandTitleFromLocalDB_ForSync;
@property(copy, readwrite)NSMutableArray *arrBrandTitleFromServerDB_ForSync;
- (IBAction)SyncData:(id)sender;
- (IBAction)SyncDetails:(id)sender;
@end
