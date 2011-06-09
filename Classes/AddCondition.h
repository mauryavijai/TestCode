//
//  AddCondition.h
//  Natolli
//
//  Created by Nidhi Sharma on 15/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddCondition : UITableViewController<UITextViewDelegate, UITextFieldDelegate> {

	UITextView *txtVw;
	NSMutableArray *arrValue;
	UIView *view_otherOption_list;
	BOOL IsBrandSelected;
	
	UITextField *txt;
	
	CCommon *sharedInstance;
	
}
@property(retain, nonatomic)UITextView *txtVw;
@property(copy, readwrite)NSMutableArray *arrValue;
@property(nonatomic,retain)UIView *view_otherOption_list;
@property(retain, nonatomic)UITextField *txt;
@end
