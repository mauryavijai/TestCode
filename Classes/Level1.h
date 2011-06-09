//
//  Level1.h
//  Natolli
//
//  Created by Nidhi Sharma on 04/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Level1 : UITableViewController<UITableViewDataSource> {

	NSMutableArray *arrFloor;
	NSMutableArray *arrFloorID;
	NSMutableArray *arrFloorNotes;
	NSMutableArray *arrFloorImages;
	NSString *strDeleteditemID;
	
	

}
@property(copy, readwrite)NSMutableArray *arrFloor;
@property(copy, readwrite)NSMutableArray *arrFloorID;
@property(copy, readwrite)NSMutableArray *arrFloorNotes;
@property(copy, readwrite)NSMutableArray *arrFloorImages;
@property(copy, readwrite)NSString *strDeleteditemID;


@end
