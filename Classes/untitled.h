//
//  untitled.h
//  Natolli
//
//  Created by Nidhi Sharma on 18/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface untitled : UIViewController {

	RootViewController *theRootViewController;
	
}

- (IBAction)UpComingBooking:(id)sender;
- (IBAction)IncompleteBooking:(id)sender;
- (IBAction)CompleteBooking:(id)sender;
- (IBAction)Synchronise:(id)sender;

@end