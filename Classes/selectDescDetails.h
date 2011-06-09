//
//  selectDescDetails.h
//  Natolli
//
//  Created by Nidhi Sharma on 13/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface selectDescDetails : UIViewController<UIPickerViewDelegate, UITextFieldDelegate> {

	UIPickerView *pv_Quantity;
	UIPickerView *pv_Shape;
	UIPickerView *pv_Shade;
	UIPickerView *pv_material;
	UIPickerView *pv_make;
	
	NSMutableArray *arrQuantity;
	NSMutableArray *arrShape;
	NSMutableArray *arrShade;
	NSMutableArray *arrmaterial;
	NSMutableArray *arrmake;
	
	NSString *Mode;
	NSString *SelectedQuantity;
	NSString *SelectedShape;
	NSString *SelectedShade;
	NSString *SelectedMaterial;
	NSString *SelectedmakeModel;
	
	CCommon *sharedInstance;
	
	IBOutlet UILabel *lblTitle;
	IBOutlet UITextField *txtValue;
}

@property (nonatomic, retain)UIPickerView *pv_Quantity;
@property (nonatomic, retain)UIPickerView *pv_Shape;
@property (nonatomic, retain)UIPickerView *pv_Shade;
@property (nonatomic, retain)UIPickerView *pv_material;
@property (nonatomic, retain)UIPickerView *pv_make;
@property (nonatomic, retain)UILabel *lblTitle;
@property (nonatomic, retain)UITextField *txtValue;

@property(copy, readwrite)NSMutableArray *arrQuantity;
@property(copy, readwrite)NSMutableArray *arrShape;
@property(copy, readwrite)NSMutableArray *arrShade;
@property(copy, readwrite)NSMutableArray *arrmaterial;
@property(copy, readwrite)NSMutableArray *arrmake;

@property(copy, readwrite)NSString *SelectedQuantity;
@property(copy, readwrite)NSString *SelectedShape;
@property(copy, readwrite)NSString *SelectedShade;
@property(copy, readwrite)NSString *SelectedMaterial;
@property(copy, readwrite)NSString *SelectedmakeModel;



@property(copy, readwrite)NSString *Mode;
@end
