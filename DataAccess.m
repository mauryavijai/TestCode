//
//  DataAccess.m
//  Natolli
//
//  Created by Nidhi Sharma on 25/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataAccess.h"


@implementation DataAccess

+(DataAccess *)objDataAccess
{
	static DataAccess *myInstance = nil;
	
	if(myInstance == nil)
	{
		myInstance = [[[self class] alloc] init];
	}
	
	return myInstance;
}

//Funxtion used to get database path.
+ (NSString *) getDBPath 
{	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"Natolli.sql"];	
	return databasePath;		
}//end of - getDBPath


//Function used to copy database file to device.
+ (void) copyDatabaseIfNeeded {
	
	NSString *dbPath = [self getDBPath];
	
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
	
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:dbPath];
	
	// If the database already exists then return without doing anything
	if(success) return;
	
	// If not then proceed to copy the database from the application to the users filesystem
	
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Natolli.sql"];
	
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:dbPath error:nil];
	
	[fileManager release];
	
}//end of - copyDatabaseIfNeeded

@end
