//
//  AddDescription.h
//  Natolli
//
//  Created by Nidhi Sharma on 13/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddDescription : UITableViewController<UIPickerViewDelegate, UITextViewDelegate> {

	UITextView *txtVw;
	CCommon *sharedInstance;
}

@property(nonatomic, retain)UITextView *txtVw;

@end
