//
//  selectStartDate.h
//  Natolli
//
//  Created by Nidhi Sharma on 22/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Level0.h"


@interface selectStartDate : UIViewController<UIPickerViewDelegate> {

	UIDatePicker *datePicker;
	NSMutableArray *arrInvTypes;
	NSMutableArray *arrInvStatus;
	UIPickerView *pv_InventoryTypes;
	UIPickerView *pv_InventoryStatus;
	IBOutlet UILabel *lblTitle;
	
	NSString *SelectedSDate;
	NSString *SelectedStartTime;
	
	NSString *SelectedEndDate;
	NSString *SelectedEndTime;
	
	NSString *SelectedInType;
	NSString *SelectedInStatus;
	
	NSString *Mode;
	
	CCommon *sharedInstance;
	
}
@property(copy, readwrite)NSString *SelectedStartTime;
@property(copy, readwrite)NSString *SelectedSDate;
@property(copy, readwrite)NSString *SelectedEndDate;
@property(copy, readwrite)NSString *SelectedEndTime;
@property(copy, readwrite)NSString *SelectedInType;
@property(copy, readwrite)NSString *SelectedInStatus;
@property(copy, readwrite)NSString *Mode;

@property(copy, readwrite)NSMutableArray *arrInvTypes;
@property(copy, readwrite)NSMutableArray *arrInvStatus;
@property (nonatomic, retain)UIPickerView *pv_InventoryTypes;
@property (nonatomic, retain)UIPickerView *pv_InventoryStatus;
@property (nonatomic, retain)UILabel *lblTitle;
@end
