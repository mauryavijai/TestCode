//
//  RootViewController.h
//  Natolli
//
//  Created by Nidhi Sharma on 30/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TransparentToolbar.h"
#import "GlobalSingleton.h"
@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
	TransparentToolbar	*toolbar;
	UIImageView *bottomimgVw;
	GlobalSingleton *sharedInstance;
	
	NSString *SelectedTab;
	NSString *SelectedTabID;
}

- (void)createToolbarItems:(NSString*)selectedButton;
- (void)createNewToolbarItems:(NSString*)selectedButton;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property(copy, readwrite)NSString *SelectedTab;
@property(copy, readwrite)NSString *SelectedTabID;
@end
