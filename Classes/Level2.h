//
//  Level2.h
//  Natolli
//
//  Created by Nidhi Sharma on 09/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Level2 : UITableViewController {

	NSMutableArray *arrRoom;
	NSMutableArray *arrRoomID;
	NSMutableArray *arrRoomNotes;
	//NSMutableArray *arrRoomImages;
	NSMutableArray *arrRoomLocations;
}
@property(copy, readwrite)NSMutableArray *arrRoom;
@property(copy, readwrite)NSMutableArray *arrRoomID;
@property(copy, readwrite)NSMutableArray *arrRoomNotes;
//@property(copy, readwrite)NSMutableArray *arrRoomImages;
@property(copy, readwrite)NSMutableArray *arrRoomLocations;
@end
