//
//  AddNewInventory.h
//  Natolli
//
//  Created by Nidhi Sharma on 01/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#define SCROLLVIEW_CONTENT_HEIGHT 460
#define SCROLLVIEW_CONTENT_WIDTH  320

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h> // For .layer 
#import "GlobalSingleton.h"
@interface AddNewInventory : UIViewController<UIScrollViewDelegate, UIPickerViewDelegate> {

	IBOutlet UIScrollView *scrollview;
	IBOutlet UITextField *txtPropertyName;
	IBOutlet UITextField *txtAddress;
	IBOutlet UITextField *txtCity;
	IBOutlet UITextField *txtCountry;
	IBOutlet UITextField *txtNoOfBeds;
	IBOutlet UITextField *txtNoOfBaths;
	
	BOOL keyboardVisible;
	CGPoint offset;
	UITextField *activeField;
	
	GlobalSingleton *sharedInstance;
	
	UIPickerView *myPickerView;
	
	NSMutableArray *arrAppliances;
	
	NSString *SelectedAppliance;
	
	//---web service access---
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSURLConnection *conn;
	
	//---xml parsing---
    NSXMLParser *xmlParser;
    BOOL elementFound; 
	
	UIView *view_otherOption_list;
	UIView *view_otherOption;
	UIButton *btnAction2;
	
	BOOL IsBrandSelected;
	CCommon *objCCommon;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollview;
@property(nonatomic,retain) IBOutlet UITextField *txtPropertyName;
@property(nonatomic,retain) IBOutlet UITextField *txtAddress;
@property(nonatomic,retain) IBOutlet UITextField *txtCity;
@property(nonatomic,retain) IBOutlet UITextField *txtCountry;
@property(nonatomic,retain) IBOutlet UITextField *txtNoOfBeds;
@property(nonatomic,retain) IBOutlet UITextField *txtNoOfBaths;
@property (nonatomic, retain)UIPickerView *myPickerView;
@property(copy, readwrite)NSMutableArray *arrAppliances;
@property(copy, readwrite)NSString *SelectedAppliance;
@property(nonatomic,retain)UIView *view_otherOption_list;
@property(nonatomic,retain)UIView *view_otherOption;
@property(nonatomic,retain)UIButton *btnAction2;
- (IBAction)AddNewAppliance:(id)sender;
- (IBAction)AutoComplete:(id)sender;

@end
