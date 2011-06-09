//
//  AddFloor.h
//  Natolli
//
//  Created by Nidhi Sharma on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddFloor : UITableViewController<UITextFieldDelegate> {

	BOOL IsDoneClicked;
	UITextField *tf;
	NSMutableArray *arrRoom;
	NSString *Mode;
	NSString *SelectedFloor;
}
@property (nonatomic, retain)UITextField *tf;
@property(copy, readwrite)NSMutableArray *arrRoom;
@property(copy, readwrite)NSString *Mode;
@property(copy, readwrite)NSString *SelectedFloor;

@end
