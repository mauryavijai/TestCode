//
//  selectConditionDetails.h
//  Natolli
//
//  Created by Nidhi Sharma on 15/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface selectConditionDetails : UIViewController <UIPickerViewDelegate, UITextFieldDelegate> {
	
	UIPickerView *pv_Quantity;

	NSMutableArray *arrQuantity;

	NSString *Mode;
	NSString *SelectedQuantity;

	CCommon *sharedInstance;
	
	IBOutlet UILabel *lblTitle;
	IBOutlet UITextField *txtValue;
}

@property (nonatomic, retain)UIPickerView *pv_Quantity;
@property (nonatomic, retain)UILabel *lblTitle;
@property (nonatomic, retain)UITextField *txtValue;
@property(copy, readwrite)NSMutableArray *arrQuantity;
@property(copy, readwrite)NSString *SelectedQuantity;
@property(copy, readwrite)NSString *Mode;

@end