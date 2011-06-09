//
//  Items.h
//  Natolli
//
//  Created by Nidhi Sharma on 12/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Items : UIViewController<UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate> {

	UIImagePickerController *UIPicker;
	UIButton *btnImage;
	UITextView *txtVw;

	NSString *imageName;
	CCommon *sharedInstance;
	
	UITableView * aTableView;
	UILabel *lblSelectedType;
	UILabel *lblSelectedItem;
	
	NSString *Mode;
	NSString *SelectedTitle;
	NSString *SelectedItem;
	NSString *SelectedType;
	NSString *SelectedID;
	
}


@property (copy, readwrite)NSString *Mode;
@property (copy, readwrite)NSString *SelectedID;
@property (copy, readwrite)NSString *SelectedTitle;
@property (copy, readwrite)NSString *SelectedItem;
@property (copy, readwrite)NSString *SelectedType;
//@property (copy, readwrite)NSString *SelectedID;

@property (nonatomic, retain)UIButton *btnImage;
@property (copy, readwrite)NSString *imageName;
@property (nonatomic, retain)UITextView *txtVw;
@property (nonatomic, retain)UITableView * aTableView;
@property (nonatomic, retain)UILabel *lblSelectedType;
@property (nonatomic, retain)UILabel *lblSelectedItem;
@end
