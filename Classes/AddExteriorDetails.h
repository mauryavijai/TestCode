//
//  AddExteriorDetails.h
//  Natolli
//
//  Created by Nidhi Sharma on 08/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddExteriorDetails: UIViewController <UIImagePickerControllerDelegate,
UITableViewDelegate, UITableViewDataSource,
UITextViewDelegate, UINavigationControllerDelegate, UITextViewDelegate> {
	
	UIImagePickerController *UIPicker;
	UIButton *btnImage;
	UIButton *selectedButton;
	UITextView *txtVw;
	UITextView *txtVwNotes;
	NSString *imageName;
	
	NSString *Mode;
	NSString *SelectedFloorTitle;
	NSString *SelectedFloorNotes;
	NSString *SelectedFloorID;
	NSString *SelectedFloorImage;
	
	NSMutableArray *arrItemTitle;
	NSMutableArray *arrItemID;
	NSMutableArray *arrItem;
	NSMutableArray *arrType;
	
	UITableView * aTableView;
	
	NSString *strDeleteditemID;
	
	IBOutlet UIScrollView *scrollview;
	
	
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollview;

@property (nonatomic, retain)UITableView * aTableView;
@property (nonatomic, retain)UIButton *btnImage;
@property (nonatomic, retain)UIButton *selectedButton;

@property (nonatomic, retain)UITextView *txtVw;
@property (nonatomic, retain)UITextView *txtVwNotes;
@property (copy, readwrite)NSString *imageName;

@property(copy, readwrite)NSString *Mode;
@property(copy, readwrite)NSString *SelectedFloorTitle;
@property(copy, readwrite)NSString *SelectedFloorNotes;
@property(copy, readwrite)NSString *SelectedFloorID;
@property(copy, readwrite)NSString *SelectedFloorImage;
@property(copy, readwrite)NSMutableArray *arrItemTitle;
@property(copy, readwrite)NSMutableArray *arrItemID;
@property(copy, readwrite)NSMutableArray *arrItem;
@property(copy, readwrite)NSMutableArray *arrType;

@property(copy, readwrite)NSString *strDeleteditemID;


@end