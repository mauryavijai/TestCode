//
//  CompletedList.h
//  Natolli
//
//  Created by Nidhi Sharma on 01/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h> // For .layer 
#import "GlobalSingleton.h"

@interface CompletedList : UITableViewController {
GlobalSingleton *sharedInstance;
}

@end
