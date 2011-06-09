//
//  Level2_Details.h
//  Natolli
//
//  Created by Nidhi Sharma on 09/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//



#import <UIKit/UIKit.h>


@interface Level2_Details : UIViewController <UIImagePickerControllerDelegate,
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
    //added by Vijai on 8th June 2011
    NSMutableArray *arrRoomList;
	
	UIView *view_otherOption_list;
	
	BOOL IsRoomSelected;
//end of Vijai Code
	
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

//added by Vijai on 8th June 2011
@property(copy, readwrite)NSMutableArray *arrRoomList;


@property(nonatomic,retain)UIView *view_otherOption_list;

-(void) ShowRoomList;
//end of Vijai Code


@end