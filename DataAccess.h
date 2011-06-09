//
//  DataAccess.h
//  Natolli
//
//  Created by Nidhi Sharma on 25/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataAccess : NSObject {

}

+(DataAccess *)objDataAccess;
+ (void) copyDatabaseIfNeeded;
+ (NSString *) getDBPath;
@end
