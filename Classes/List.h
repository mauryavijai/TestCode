//
//  List.h
//  Natolli
//
//  Created by Nidhi Sharma on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface List : UITableViewController {
	
	CCommon *sharedInstance;
	NSMutableArray *arrInventoryType;
	NSMutableArray *arrStartDate;
	NSMutableArray *arrStartTime;
	NSMutableArray *arrEndDate;
	NSMutableArray *arrEndTime;
	NSMutableArray *arrInspectionStatus;
	
}
@property(copy, readwrite)NSMutableArray *arrInventoryType;
@property(copy, readwrite)NSMutableArray *arrStartDate;
@property(copy, readwrite)NSMutableArray *arrStartTime;
@property(copy, readwrite)NSMutableArray *arrEndDate;
@property(copy, readwrite)NSMutableArray *arrEndTime;
@property(copy, readwrite)NSMutableArray *arrInspectionStatus;
@end
