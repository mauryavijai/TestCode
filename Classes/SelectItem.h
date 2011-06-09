//
//  SelectItem.h
//  Natolli
//
//  Created by Nidhi Sharma on 12/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Level0.h"


@interface SelectItem : UIViewController<UIPickerViewDelegate, UITextFieldDelegate> {


	NSMutableArray *arrItem;
	NSMutableArray *arrType;
	NSMutableArray *arrItemID;
	NSMutableArray *arrTypeID;
	
	UIPickerView *pv_Item;
	UIPickerView *pv_Type;
	//IBOutlet UILabel *lblTitle;
	
	
	NSString *SelectedItem;
	NSString *SelectedType;
	
	NSString *SelectedItemID;
	NSString *SelectedTypeID;
	
	NSString *Mode;
	
	CCommon *sharedInstance;
	
	IBOutlet UITextField *txtVw;
	IBOutlet UILabel *lblHeading;
	
}

@property(copy, readwrite)NSString *SelectedItem;
@property(copy, readwrite)NSString *SelectedType;

@property(copy, readwrite)NSString *SelectedItemID;
@property(copy, readwrite)NSString *SelectedTypeID;

@property(copy, readwrite)NSString *Mode;

@property(copy, readwrite)NSMutableArray *arrItem;
@property(copy, readwrite)NSMutableArray *arrItemID;
@property(copy, readwrite)NSMutableArray *arrType;
@property(copy, readwrite)NSMutableArray *arrTypeID;
@property (nonatomic, retain)UIPickerView *pv_Item;
@property (nonatomic, retain)UIPickerView *pv_Type;


@property (nonatomic, retain)UITextField *txtVw;
@property (nonatomic, retain)UILabel *lblHeading;
//@property (nonatomic, retain)UILabel *lblTitle;
@end