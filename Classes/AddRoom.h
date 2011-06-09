//
//  AddRoom.h
//  Natolli
//
//  Created by Nidhi Sharma on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddRoom : UITableViewController<UITextFieldDelegate, UITextViewDelegate> {
	
	BOOL IsDoneClicked;
	UITextField *tf;
	UITextView *txtViewDesc;
	
}
@property (nonatomic, retain)UITextField *tf;
@property (nonatomic, retain)UITextView *txtViewDesc;
@end
