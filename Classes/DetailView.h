//
//  DetailView.h
//  Natolli
//
//  Created by Nidhi Sharma on 25/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailView : UITableViewController {

	NSString *Mode;
	NSString *ID;
	
}
@property(copy, readwrite)NSString *Mode;
@property(copy, readwrite)NSString *ID;

@end
