//
//  New.h
//  Natolli
//
//  Created by Nidhi Sharma on 09/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface New : UITableViewController<UITextFieldDelegate> {

	BOOL IsDoneClicked;
	UITextField *tf;
	NSMutableArray *arrFloor;
	NSMutableArray *arrFloorID;

	NSString *Mode;
	NSString *SelectedFloor;
	
}
@property (nonatomic, retain)UITextField *tf;
@property(copy, readwrite)NSMutableArray *arrFloor;
@property(copy, readwrite)NSMutableArray *arrFloorID;
@property(copy, readwrite)NSString *Mode;
@property(copy, readwrite)NSString *SelectedFloor;
@end
