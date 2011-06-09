//
//  Level1_Details.h
//  Natolli
//
//  Created by Nidhi Sharma on 06/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Level1_Details : UIViewController<UIImagePickerControllerDelegate,
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
	NSString *strDeleteditemID;
	
	IBOutlet UIScrollView *scrollview;
	
	NSMutableArray *arrRoom;
	NSMutableArray *arrRoomID;
	NSMutableArray *arrRoomNotes;
	NSMutableArray *arrRoomLocations;
	UITableView * aTableView;
	
		bool IsValuSaved;
	
	NSMutableArray *arrFloorList;
	
	UIView *view_otherOption_list;
	
	BOOL IsFloorSelected;
	UITextField *txtFloor;

}
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
@property(copy, readwrite)NSString *strDeleteditemID;

@property(nonatomic,retain) IBOutlet UIScrollView *scrollview;

@property(copy, readwrite)NSMutableArray *arrRoom;
@property(copy, readwrite)NSMutableArray *arrRoomID;
@property(copy, readwrite)NSMutableArray *arrRoomNotes;
@property(copy, readwrite)NSMutableArray *arrRoomLocations;
@property(copy, readwrite)NSMutableArray *arrFloorList;

@property(nonatomic, retain)UITextField *txtFloor;
@property(nonatomic,retain)UIView *view_otherOption_list;

//added by Vijai 

-(void)ShowFloorList;
@end
