//
//  MainView.h
//  ViewTable
//
//  Created by Chakra on 05/04/10.
//  Copyright 2010 Chakra Interactive Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainView : UITableViewCell {
	IBOutlet UILabel *cellText;
	IBOutlet UIImageView *productImg;
	
	UIButton *btnImage;
	
}

- (void)LabelText:(NSString *)_text;
- (void)ProductImage:(NSString *)_text;

@property (nonatomic, retain)UIButton *btnImage;
@end
