//
//  Level0.h
//  Natolli
//
//  Created by Nidhi Sharma on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Level0 : UITableViewController<UITextViewDelegate> {

	UILabel *lblStartDate_value;
	UILabel *lblStartTime_value;
	UILabel *lblEndDate_value;
	UILabel *lblEndTime_value;
	UILabel *lblInventoryType_value;
	UILabel *lblInsStatus_value;
	UITextView *txtVw;
	
	NSString *strStartDate;
	NSString *strStartTime;
	NSString *strEndDate;
	NSString *strEndTime;
	NSString *strInType;
	NSString *strInStatus;
	
	CCommon *sharedInstance;
	


	
}
@property (nonatomic, retain)UILabel *lblStartDate_value;
@property (nonatomic, retain)UILabel *lblStartTime_value;
@property (nonatomic, retain)UILabel *lblEndDate_value;
@property (nonatomic, retain)UILabel *lblEndTime_value;
@property (nonatomic, retain)UILabel *lblInventoryType_value;
@property (nonatomic, retain)UILabel *lblInsStatus_value;
@property (nonatomic, retain)UITextView *txtVw;

@property(copy, readwrite)NSString *strStartDate;
@property(copy, readwrite)NSString *strStartTime;
@property(copy, readwrite)NSString *strEndDate;
@property(copy, readwrite)NSString *strEndTime;
@property(copy, readwrite)NSString *strInType;
@property(copy, readwrite)NSString *strInStatus;

@end
