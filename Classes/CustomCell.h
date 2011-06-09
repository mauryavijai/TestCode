//
//  CustomCell.h
//  Natolli
//
//  Created by Nidhi Sharma on 02/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCell : UIAlertView {

	UILabel *alertTextLabel;
	UILabel *alertConfirmationLabel;
	UIImage *backgroundImage;
	UIImage *tickImage;
	UIButton *btnAction;
	UIButton *btnYes;
	UIButton *btnNo;
}

@property(readwrite, retain) UIImage *backgroundImage;
@property(readwrite, retain) NSString *alertText;
@property(readwrite, retain) UIImage *tickImage;
@property(readwrite, retain) UIButton *btnAction;
@property(readwrite, retain) UIButton *btnYes;
@property(readwrite, retain) UIButton *btnNo;

- (id) initWithImage:(UIImage *)backgroundImage text:(NSString *)text ActionBtnImg:(UIImage *)ActionBtnImg;
- (id) initWithConfirmationImage:(UIImage *)backgroundImage text:(NSString *)text YesBtnImg:(UIImage *)YesBtnImg NoBtnImg:(UIImage *)NoBtnImg;

@end