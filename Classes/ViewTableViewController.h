//
//  ViewTableViewController.h
//  ViewTable
//
//  Created by Chakraon 05/04/10.
//  Copyright Chakra Interactive Pvt Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"

@interface ViewTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tableView;
	NSMutableArray *arryList;
	NSMutableArray *imagesList;
	IBOutlet MainView *tableCell;
	
	UIImagePickerController *UIPicker;
	
	NSString *Mode;
}

@property(copy, readwrite)NSString *Mode;

@end

