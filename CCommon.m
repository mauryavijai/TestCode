//
//  CCommon.m
//  Natolli
//
//  Created by Nidhi Sharma on 27/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CCommon.h"

static NSString* MyClassLastAdded_FloorID = nil;
static NSString* MyClassLastAdded_PropertyID = nil;
static NSString* MyClassLastAdded_RoomID = nil;
static NSString* MyClassLastAdded_ItemID = nil;
static NSString* MyClassLastAdded_FloorImageID = nil;
static NSString* MyClassLastAdded_RoomImageID = nil;
static NSString* MyClassLastAdded_DescriptionID = nil;
static NSString* MyClassLastAdded_ConditionID = nil;



@implementation CCommon
@synthesize mstrSelectedSDate, mstrSelectedStartTime, mstrSelectedEndDate, mstrSelectedEndTime, mstrSelectedInType;
@synthesize mstrSelectedInStatus, mstrNotes, mstrSelectedInspectionID, mstrSelectedItem, mstrSelectedType;
@synthesize mstrSelectedItemID, mstrSelectedTypeID, IsItemSelected;
@synthesize mstrSelectedQuantity, mstrSelectedShape, mstrSelectedShade, mstrSelectedMaterial, mstrSelectedmakeModel, mstrSelectedInfo;
@synthesize mstrSelectedQuantity_Condition;
@synthesize mstrMaintenanceReq, mstrCleaningReq, mstrFairUsage, mstrLandlord, mstrTenant, mstrFurtherNotes,mstrSelectedCondition;


+ (NSString*)LastAdded_ConditionID {
    return MyClassLastAdded_ConditionID;
}

+ (NSString*)LastAdded_ItemID {
    return MyClassLastAdded_ItemID;
}

+ (NSString*)LastAdded_FloorID {
    return MyClassLastAdded_FloorID;
}
+ (NSString*)LastAdded_PropertyID {
    return MyClassLastAdded_PropertyID;
}
+ (NSString*)LastAdded_RoomID {
    return MyClassLastAdded_RoomID;
}
+ (NSString*)LastAdded_DescriptionID {
    return MyClassLastAdded_DescriptionID;
}

+ (NSString*)LastAdded_FloorImageID {
    return MyClassLastAdded_FloorImageID;
}

+ (NSString*)LastAdded_RoomImageID {
    return MyClassLastAdded_RoomImageID;
}


+ (void)setLastAdded_ConditionID:(NSString*)newLastAdded_ConditionID
{
    if(MyClassLastAdded_ConditionID != newLastAdded_ConditionID)
	{
        [MyClassLastAdded_ConditionID release];
        MyClassLastAdded_ConditionID = [newLastAdded_ConditionID retain];
    }
}


+ (void)setLastAdded_DescriptionID:(NSString*)newLastAdded_DescriptionID
{
    if(MyClassLastAdded_DescriptionID != newLastAdded_DescriptionID)
	{
        [MyClassLastAdded_DescriptionID release];
        MyClassLastAdded_DescriptionID = [newLastAdded_DescriptionID retain];
    }
}

+ (void)setLastAdded_RoomImageID:(NSString*)newLastAdded_RoomImageID
{
    if(MyClassLastAdded_RoomImageID != newLastAdded_RoomImageID)
	{
        [MyClassLastAdded_RoomImageID release];
        MyClassLastAdded_RoomImageID = [newLastAdded_RoomImageID retain];
    }
}

//Last added Floor ID
+ (void)setLastAdded_FloorID:(NSString*)newLastAdded_FloorID
{
    if(MyClassLastAdded_FloorID != newLastAdded_FloorID)
	{
        [MyClassLastAdded_FloorID release];
        MyClassLastAdded_FloorID = [newLastAdded_FloorID retain];
    }
}
//Last added property ID
+ (void)setLastAdded_PropertyID:(NSString*)newLastAdded_PropertyID
{
    if(MyClassLastAdded_PropertyID != newLastAdded_PropertyID)
	{
        [MyClassLastAdded_PropertyID release];
        MyClassLastAdded_PropertyID = [newLastAdded_PropertyID retain];
    }
}



//Last added Room ID
+ (void)setLastAdded_RoomID:(NSString*)newLastAdded_RoomID
{
    if(MyClassLastAdded_RoomID != newLastAdded_RoomID)
	{
        [MyClassLastAdded_RoomID release];
        MyClassLastAdded_RoomID = [newLastAdded_RoomID retain];
    }
}

//Last added item ID
+ (void)setLastAdded_ItemID:(NSString*)newLastAdded_ItemID
{
    if(MyClassLastAdded_ItemID != newLastAdded_ItemID)
	{
        [MyClassLastAdded_ItemID release];
        MyClassLastAdded_ItemID = [newLastAdded_ItemID retain];
    }
}
/**/
//Last added property ID
+ (void)setLastAdded_FloorImageID:(NSString*)newLastAdded_FloorImageID
{
    if(MyClassLastAdded_FloorImageID != newLastAdded_FloorImageID)
	{
        [MyClassLastAdded_FloorImageID release];
        MyClassLastAdded_FloorImageID = [newLastAdded_FloorImageID retain];
    }
}


+(CCommon *)objCCommon
{
	static CCommon *myInstance = nil;
	
	if(myInstance == nil)
	{
		myInstance = [[[self class] alloc] init];
	}
	
	return myInstance;
}

//Function used to get Brands name from local database.
+ (NSMutableArray *) GetBrandsFromLocalDBForSync
{	
	NSMutableArray *arrBrand = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;

	[DataAccess copyDatabaseIfNeeded];

	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT title FROM tblBrands WHERE IsSync = 0";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column PropertyName
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arrBrand addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arrBrand;
}//end of - GetBrandsFromLocalDB


+(void)MarkBrandsAsSync
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"UPDATE tblBrands SET IsSync = 1";
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
				/*//if(sqlite3_step(compiledStatement) == SQLITE_DONE) 
				//{		
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Data has been synchronized successfully."
										  delegate:self cancelButtonTitle:nil
										  otherButtonTitles:@"OK",nil];
				[baseAlert show];
				[baseAlert release];
				
				//[self.navigationController popViewControllerAnimated:YES];
				//}*/
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
}// END OF MarkBrandsAsSync



+(void) AddBrandsFromServerToLocalDB:(NSMutableArray *)arrBrandTitle
{
	
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		
		for (int i = 0; i < [arrBrandTitle count]; i++)
		{
			NSString *strQuery;
	
			strQuery = @"INSERT INTO tblBrands(title, IsSync)VALUES('";
			strQuery = [strQuery stringByAppendingString:[arrBrandTitle objectAtIndex:i]];
			strQuery = [strQuery stringByAppendingString:@"',"];
			strQuery = [strQuery stringByAppendingString:@"1"];
			strQuery = [strQuery stringByAppendingString:@")"];
		
			const char *sqlStatement = [strQuery UTF8String];
		
			sqlite3_stmt *compiledStatement;
			if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
			{
				if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
				{
					UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
					[baseAlert show];
					[baseAlert release];
				}
				/*else
				 {
				//if(sqlite3_step(compiledStatement) == SQLITE_DONE) 
				 //{		
				 UIAlertView *baseAlert = [[UIAlertView alloc] 
				 initWithTitle:@"" message:@"Details has been added successfully!"
				 delegate:self cancelButtonTitle:@"OK"
				 otherButtonTitles:nil];
				 [baseAlert show];
				 [baseAlert release];
				 //}
				 }*/
			}
			
				// Release the compiled statement from memory
				sqlite3_finalize(compiledStatement);	
		}
		/*else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}*/

		}
		sqlite3_close(database);
	
}//end - AddBrandsFromServerToLocalDB

+(NSMutableArray *)GetAllBrandsFromLocalDb 
{
	NSMutableArray *arrBrands = [[NSMutableArray alloc]init];
	// Setup the database object
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		strQuery = @"SELECT Title FROM TblBrands";		
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{				
				NSString *lstrTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arrBrands addObject:lstrTitle];
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);		
	}
	sqlite3_close(database);
	
	return arrBrands;
}//end - GetAllBrandsFromLocalDb

+(NSMutableArray *)GetBrandsByName:(NSString *)value
{ 
	NSMutableArray *arrBrands = [[NSMutableArray alloc]init];
	// Setup the database object
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{	
		//strQuery = @"SELECT Title FROM TblBrands";
		
		strQuery = @"SELECT Title FROM TblBrands WHERE Title LIKE '";	
		strQuery =[strQuery stringByAppendingString:value];
		strQuery =[strQuery stringByAppendingString:@"%' ORDER BY Title ASC"];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{				
				NSString *lstrTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arrBrands addObject:lstrTitle];
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);		
	}
	sqlite3_close(database);

	return arrBrands;
}//end - GetBrandsByName

+(NSMutableArray *)GetItemTypes:(NSString *)value
{ 
	NSMutableArray *arrItemTypes = [[NSMutableArray alloc]init];
	// Setup the database object
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		strQuery = @"SELECT ItemName FROM TblLevel_3_ItemType WHERE ItemName LIKE '";	
		strQuery =[strQuery stringByAppendingString:value];
		strQuery =[strQuery stringByAppendingString:@"%' ORDER BY ItemName ASC"];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{				
				NSString *lstrTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arrItemTypes addObject:lstrTitle];
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);		
	}
	sqlite3_close(database);
	
	return arrItemTypes;
}//end - GetItemTypes



+(void) AddNewBrandToLocaldb:(NSString *)text
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"INSERT INTO tblBrands(title, IsSync)VALUES('";
		strQuery = [strQuery stringByAppendingString:text];
		strQuery = [strQuery stringByAppendingString:@"',"];
		strQuery = [strQuery stringByAppendingString:@"0"];
		strQuery = [strQuery stringByAppendingString:@")"];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
				/*//if(sqlite3_step(compiledStatement) == SQLITE_DONE) 
				 //{		
				 UIAlertView *baseAlert = [[UIAlertView alloc] 
				 initWithTitle:@"" message:@"Details has been added successfully!"
				 delegate:self cancelButtonTitle:@"OK"
				 otherButtonTitles:nil];
				 [baseAlert show];
				 [baseAlert release];
				 //}*/
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}

		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
}//end - AddNewBrandToLocaldb


//Function used to get InspectionDetailsID from local database.
+ (NSMutableArray *) GetInspectionDetailsID
{	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT InspectionDetailsID FROM tblInspectionDetails";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column PropertyName
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetInspectionDetailsID

//Function used to get ParentID from local database.
+ (NSMutableArray *) GetParentID
{	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT ParentID FROM tblInspectionDetails";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column PropertyName
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetParentID

//Function used to get Room Titles from local database.
/*+ (NSMutableArray *) GetRoomTitles{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{	
		//str = @"SELECT Title FROM tblInspectionDetails WHERE ParentID = (SELECT InspectionDetailsID FROM tblInspectionDetails WHERE Title = '";
		//str = [str stringByAppendingString:text];
		//str = [str stringByAppendingString:@"')"];
		
		str = @"SELECT Title FROM tblInspectionDetails WHERE ParentID =";
		str = [str stringByAppendingString:[CCommon LastAdded_FloorID]];
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column PropertyName
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];

				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetRoomTitles*/

//Function used to get Room Titles based on floor titles from local database.
+ (NSMutableArray *) GetRoomTitlesBasedOnFloorTitle:(NSString *) value {	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{	
		str = @"SELECT Title FROM tblInspectionDetails WHERE ParentID = (SELECT InspectionDetailsID FROM tblInspectionDetails WHERE Title = '";
		str = [str stringByAppendingString:value];
		str = [str stringByAppendingString:@"')"];
		
		//str = @"SELECT Title FROM tblInspectionDetails WHERE ParentID =";
		//str = [str stringByAppendingString:[CCommon LastAdded_FloorID]];
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column PropertyName
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetRoomTitlesBasedOnFloorTitle

//Function used to get Floor Titles from local database.
+ (NSMutableArray *) GetFloorTitles{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT Title FROM tblLevel_1 WHERE ParentID =";
		str = [str stringByAppendingString:[[CCommon objCCommon]mstrSelectedInspectionID]];
	//	str = [str stringByAppendingString:[CCommon LastAdded_PropertyID]];
		//str = [str stringByAppendingString:@"1"];
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column PropertyName
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
				
				//[Title release];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetFloorTitles

//Function used to get Floor notes from local database.
+ (NSMutableArray *) GetFloorNotes{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT Notes FROM tblLevel_1 WHERE ParentID =";
		str = [str stringByAppendingString:[[CCommon objCCommon]mstrSelectedInspectionID]];
		//	str = [str stringByAppendingString:[CCommon LastAdded_PropertyID]];
	//	str = [str stringByAppendingString:@"1"];
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column PropertyName
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
				
				//[Title release];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetFloorNotes

//Function used to get Floor Title ID's from local database.
+ (NSMutableArray *) GetFloorTitleIDs{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT ID FROM tblLevel_1  WHERE ParentID =";
		str = [str stringByAppendingString:[[CCommon objCCommon]mstrSelectedInspectionID]];
		//str = [str stringByAppendingString:[CCommon LastAdded_PropertyID]];
		//str = [str stringByAppendingString:@"1"];
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column PropertyName
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetFloorTitleIDs

//Function used to get Floor images from local database.
+ (NSMutableArray *) GetFloorImages{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT image FROM tblLevel_1  WHERE ParentID =";
		str = [str stringByAppendingString:[[CCommon objCCommon]mstrSelectedInspectionID]];

		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column image
				NSString *image = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:image];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetFloorImages

//Function used to get Description from local database.
+ (NSMutableArray *) GetDescription
{	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT Description FROM tblInspectionDetails";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column PropertyName
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetDescription


+(void) AddPropertyTitleToLocaldb:(NSString *)text
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"INSERT INTO tblInspectionDetails(title)VALUES('";
		strQuery = [strQuery stringByAppendingString:text];
		strQuery = [strQuery stringByAppendingString:@"')"];

		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	NSString *strQuery1;
	sqlite3 *database1;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest1 = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest1 UTF8String], &database1) == SQLITE_OK)	
	{
		strQuery1 = @"SELECT InspectionDetailsID FROM tblInspectionDetails ORDER BY 1 DESC LIMIT 1";
		
		const char *sqlStatement1 = [strQuery1 UTF8String];
		
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database1, sqlStatement1, -1, &compiledStatement1, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{		
				//Column InspectionDetailsID
				[CCommon setLastAdded_PropertyID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1,0)]];	
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement1);		
	}
	sqlite3_close(database1);
	
}//end - AddPropertyTitleToLocaldb

+(void) AddFloorToLocaldb:(NSString *)text
{
	NSString *strQuery;
	sqlite3 *database;

	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];

	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"INSERT INTO tblLevel_1(title, ParentID, Notes, image)VALUES('";
		strQuery = [strQuery stringByAppendingString:text];
		strQuery = [strQuery stringByAppendingString:@"', "];
		strQuery = [strQuery stringByAppendingString:[[CCommon objCCommon]mstrSelectedInspectionID]];
		strQuery = [strQuery stringByAppendingString:@",'Notes','add_image.png')"];

		const char *sqlStatement = [strQuery UTF8String];

		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	NSString *strQuery1;
	sqlite3 *database1;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest1 = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest1 UTF8String], &database1) == SQLITE_OK)	
	{
		strQuery1 = @"SELECT ID FROM tblLevel_1 ORDER BY 1 DESC LIMIT 1";
		
		const char *sqlStatement1 = [strQuery1 UTF8String];
		
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database1, sqlStatement1, -1, &compiledStatement1, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{		
				//Column InspectionDetailsID
				[CCommon setLastAdded_FloorID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1,0)]];	
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement1);		
	}
	sqlite3_close(database1);
	
}//end - AddFloorToLocaldb


+(void) AddRoomToLocaldb:(NSString *)text
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"INSERT INTO tblLevel_2(title, ParentID, Details, Location, Description)VALUES('";
		strQuery = [strQuery stringByAppendingString:text];
		strQuery = [strQuery stringByAppendingString:@"',"];
		strQuery = [strQuery stringByAppendingString:[CCommon LastAdded_FloorID]];
		strQuery = [strQuery stringByAppendingString:@", ' ', ' ', 'Notes')"];
		
		NSLog(@"Query: %@", strQuery);
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	NSString *strQuery1;
	sqlite3 *database1;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest1 = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest1 UTF8String], &database1) == SQLITE_OK)	
	{
		strQuery1 = @"SELECT ID FROM tblLevel_2 ORDER BY 1 DESC LIMIT 1";
		
		const char *sqlStatement1 = [strQuery1 UTF8String];
		
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database1, sqlStatement1, -1, &compiledStatement1, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{		
				[CCommon setLastAdded_RoomID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1,0)]];	
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement1);		
	}
	sqlite3_close(database1);
	
}//end - AddFloorToLocaldb

+(NSString *)AddItemType:(NSString *)value
{
	NSString *strQuery;
	sqlite3 *database;
	NSString *ItemTypeID;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"INSERT INTO TblLevel_3_ItemType(ItemName)VALUES('";
		strQuery = [strQuery stringByAppendingString:value];
		strQuery = [strQuery stringByAppendingString:@"')"];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	NSString *strQuery1;
	sqlite3 *database1;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest1 = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest1 UTF8String], &database1) == SQLITE_OK)	
	{
		strQuery1 = @"SELECT ID FROM TblLevel_3_ItemType ORDER BY 1 DESC LIMIT 1";
		
		const char *sqlStatement1 = [strQuery1 UTF8String];
		
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database1, sqlStatement1, -1, &compiledStatement1, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{		
				ItemTypeID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1,0)];
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement1);		
	}
	sqlite3_close(database1);
	
	return ItemTypeID;
	
}

+(void) AddItemsToLocaldb:(NSString *)text
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"INSERT INTO tblLevel_3(ItemName, ParentID, ItemTypeID)VALUES('";
		strQuery = [strQuery stringByAppendingString:text];
		strQuery = [strQuery stringByAppendingString:@"', "];
		strQuery = [strQuery stringByAppendingString:[CCommon LastAdded_RoomID]];
		strQuery = [strQuery stringByAppendingString:@", 0)"];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	NSString *strQuery1;
	sqlite3 *database1;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest1 = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest1 UTF8String], &database1) == SQLITE_OK)	
	{
		strQuery1 = @"SELECT ID FROM tblLevel_3 ORDER BY 1 DESC LIMIT 1";
		
		const char *sqlStatement1 = [strQuery1 UTF8String];
		
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database1, sqlStatement1, -1, &compiledStatement1, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{		
				[CCommon setLastAdded_ItemID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1,0)]];	
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement1);		
	}
	sqlite3_close(database1);
	
}//end - AddItemsToLocaldb



+(void)UpdateFloorDetails:(NSString *)_title  _notes:(NSString *)_notes _image:(NSString *)_image
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"UPDATE tblLevel_1 SET Title ='";
		strQuery = [strQuery stringByAppendingString:_title];
		strQuery = [strQuery stringByAppendingString:@"', Notes = '"];
		strQuery = [strQuery stringByAppendingString:_notes];
		strQuery = [strQuery stringByAppendingString:@"', image = '"];
		strQuery = [strQuery stringByAppendingString:_image];
		strQuery = [strQuery stringByAppendingString:@"' WHERE id =  "];
		strQuery = [strQuery stringByAppendingString:[CCommon LastAdded_FloorID]];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
				/*if(sqlite3_step(compiledStatement) == SQLITE_DONE) 
				 {		
				 UIAlertView *baseAlert = [[UIAlertView alloc] 
				 initWithTitle:@"" message:@"Data has been synchronized successfully."
				 delegate:self cancelButtonTitle:nil
				 otherButtonTitles:@"OK",nil];
				 [baseAlert show];
				 [baseAlert release];
				 
				 //[self.navigationController popViewControllerAnimated:YES];
				 }*/
				
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Detail(s) has been saved successfully"
										  delegate:self cancelButtonTitle:nil
										  otherButtonTitles:@"OK",nil];
				//[baseAlert show];
				[baseAlert release];
				
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
}// END OF UpdateFloorDetails

+(void)UpdateRoomDetails:(NSString *)_title  _details:(NSString *)_details _location:(NSString *)_location  _description:(NSString *)_description
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"UPDATE tblLevel_2 SET Title ='";
		strQuery = [strQuery stringByAppendingString:_title];
		strQuery = [strQuery stringByAppendingString:@"', Details = '"];
		strQuery = [strQuery stringByAppendingString:_details];
		strQuery = [strQuery stringByAppendingString:@"', location = '"];
		strQuery = [strQuery stringByAppendingString:_location];
		strQuery = [strQuery stringByAppendingString:@"', description = '"];
		strQuery = [strQuery stringByAppendingString:_description];
		strQuery = [strQuery stringByAppendingString:@"' WHERE id =  "];
		strQuery = [strQuery stringByAppendingString:[CCommon LastAdded_RoomID]];
		
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
				/*if(sqlite3_step(compiledStatement) == SQLITE_DONE) 
				{		
					UIAlertView *baseAlert = [[UIAlertView alloc] 
											  initWithTitle:@"" message:@"Data has been synchronized successfully."
											  delegate:self cancelButtonTitle:nil
											  otherButtonTitles:@"OK",nil];
					[baseAlert show];
					[baseAlert release];
					
					//[self.navigationController popViewControllerAnimated:YES];
				}*/
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Detail(s) has been saved successfully"
										  delegate:self cancelButtonTitle:nil
										  otherButtonTitles:@"OK",nil];
				//[baseAlert show];
				[baseAlert release];
				
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
}// END OF UpdateRoomDetails

//Function used to get room Title from local database.
+ (NSMutableArray *) GetRoomTitles{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT title FROM tblLevel_2  WHERE ParentID =";
		str = [str stringByAppendingString:[CCommon LastAdded_FloorID]];
		//str	= [str stringByAppendingString:[[CCommon objCCommon]mstrSelectedInspectionID]];

		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetRoomTitles

+ (NSString *) GetItemTypeIDByTitle:(NSString *)text
{
	NSString *ID;
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT id FROM TblLevel_3_ItemType  WHERE ItemName ='";
		str = [str stringByAppendingString:text];
		str = [str stringByAppendingString:@"'"];
			   
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return ID;
}

+ (NSString *) GetItemTypeTitleByID:(NSString *)text
{
	NSString *strItemName =@"";
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT ItemName FROM TblLevel_3_ItemType  WHERE id ='";
		str = [str stringByAppendingString:text];
		str = [str stringByAppendingString:@"'"];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				strItemName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return strItemName;
}

//Function used to get room Title ids from local database.
+ (NSMutableArray *) GetRoomTitleIDs{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT id FROM tblLevel_2  WHERE ParentID =";
		str = [str stringByAppendingString:[CCommon LastAdded_FloorID]];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetRoomTitleIDs

//Function used to get room  details from local database.
+ (NSMutableArray *) GetRoomDetails{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT details FROM tblLevel_2  WHERE ParentID =";
		str = [str stringByAppendingString:[CCommon LastAdded_FloorID]];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetRoomDetails

//Function used to get room Description from local database.
+ (NSMutableArray *) GetRoomDescription{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT Description FROM tblLevel_2  WHERE ParentID =";
		str = [str stringByAppendingString:[CCommon LastAdded_FloorID]];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetRoomDescription

//Function used to get room location from local database.
+ (NSMutableArray *) GetRoomLocation{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT location FROM tblLevel_2  WHERE ParentID =";
		str = [str stringByAppendingString:[CCommon LastAdded_FloorID]];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetRoomLocation

+(void)UpdateItem:(NSString *)_itemName  _itemTypeID:(NSString *)_itemTypeID
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"UPDATE tblLevel_3 SET itemName ='";
		strQuery = [strQuery stringByAppendingString:_itemName];
		strQuery = [strQuery stringByAppendingString:@"', itemTypeID = '"];
		strQuery = [strQuery stringByAppendingString:_itemTypeID];
		strQuery = [strQuery stringByAppendingString:@"' WHERE id =  "];
		strQuery = [strQuery stringByAppendingString:[CCommon LastAdded_ItemID]];
		
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
				//if(sqlite3_step(compiledStatement) == SQLITE_DONE) 
				//{		
					UIAlertView *baseAlert = [[UIAlertView alloc] 
											  initWithTitle:@"" message:@"Detail(s) has been saved successfully"
											  delegate:self cancelButtonTitle:nil
											  otherButtonTitles:@"OK",nil];
					//[baseAlert show];
					[baseAlert release];
					
					//[self.navigationController popViewControllerAnimated:YES];
				//}
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
}

+(void)UpdateItemNameAndType:(NSString *)_itemName  _itemType:(NSString *)_itemType _location:(NSString *)_location  _description:(NSString *)_description
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
	/*	strQuery = @"UPDATE tblLevel_2 SET Title ='";
		strQuery = [strQuery stringByAppendingString:_title];
		strQuery = [strQuery stringByAppendingString:@"', Details = '"];
		strQuery = [strQuery stringByAppendingString:_details];
		strQuery = [strQuery stringByAppendingString:@"', location = '"];
		strQuery = [strQuery stringByAppendingString:_location];
		strQuery = [strQuery stringByAppendingString:@"', description = '"];
		strQuery = [strQuery stringByAppendingString:_description];
		strQuery = [strQuery stringByAppendingString:@"' WHERE id =  "];
		strQuery = [strQuery stringByAppendingString:[CCommon LastAdded_RoomID]];
		*/
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
				if(sqlite3_step(compiledStatement) == SQLITE_DONE) 
				{		
					UIAlertView *baseAlert = [[UIAlertView alloc] 
											  initWithTitle:@"" message:@"Data has been synchronized successfully."
											  delegate:self cancelButtonTitle:nil
											  otherButtonTitles:@"OK",nil];
					//[baseAlert show];
					[baseAlert release];
					
					//[self.navigationController popViewControllerAnimated:YES];
				}
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
}// END OF UpdateItemNameAndType


//Function used to get item ids from local database.
+ (NSMutableArray *) GetItemIDs{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT ID FROM tblLevel_3  WHERE ParentID =";
		str = [str stringByAppendingString:[CCommon LastAdded_RoomID]];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetItemIDs

//Function used to get item ids from local database.
+ (NSMutableArray *) GetItemNames{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT itemName FROM tblLevel_3  WHERE ParentID =";
		str = [str stringByAppendingString:[CCommon LastAdded_RoomID]];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetItemIDs

//Function used to get item Notes from local database.
+ (NSString *) GetItemNotes{	
	
	//NSMutableArray *arr = [[NSMutableArray alloc]init];
	NSString *strValue =@"";
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	/*UIAlertView *baseAlert = [[UIAlertView alloc] 
							  initWithTitle:@"" message:[CCommon LastAdded_ItemID]
							  delegate:self cancelButtonTitle:@"OK"
							  otherButtonTitles:nil];
	[baseAlert show];
	[baseAlert release];*/
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT Notes FROM TblLevel_3_Details WHERE Notes <>'' AND ParentID =";
		str = [str stringByAppendingString:[CCommon LastAdded_ItemID]];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				strValue = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return strValue;
}//end of - GetItemNotes

//Function used to get item ids from local database.
+ (NSMutableArray *) GetItemTypeIDs{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;

	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT itemTypeID FROM tblLevel_3  WHERE ParentID =";
		str = [str stringByAppendingString:[CCommon LastAdded_RoomID]];
		//str = [str stringByAppendingString:@" AND itemTypeID IS NOT NULL"];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
	
	return arr;
	
}//end of - GetItemIDs


+(void) AddItemDetailsToLocaldb:(NSString *)_description _condition:(NSString *)_condition _notes:(NSString *)_notes
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"INSERT INTO tblLevel_3_Details(Description, Condition, Notes, ParentID)VALUES('";
		strQuery = [strQuery stringByAppendingString:_description];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:_condition];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:_notes];
		strQuery = [strQuery stringByAppendingString:@"', "];
		strQuery = [strQuery stringByAppendingString:[CCommon LastAdded_ItemID]];
		strQuery = [strQuery stringByAppendingString:@")"];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
}//end - AddItemsDetailsToLocaldb


//Function used to get room  details from local database.
+ (NSMutableArray *) GetDescriptionTitles{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT Description FROM tblLevel_3_details  WHERE Condition = '' AND Notes ='' AND Description <> '' AND ParentID =";
		str = [str stringByAppendingString:[CCommon LastAdded_ItemID]];
		str = [str stringByAppendingString:@" ORDER BY ID DESC"];

		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetDescriptionTitles

//Function used to get room  details from local database.
+ (NSMutableArray *) GetConditionTitles{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT Condition FROM tblLevel_3_details  WHERE Description = '' AND Notes ='' AND Condition <> '' AND ParentID =";
		str = [str stringByAppendingString:[CCommon LastAdded_ItemID]];
		str = [str stringByAppendingString:@" ORDER BY ID DESC"];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetConditionTitles

//Function used to get room  details from local database.
+ (NSMutableArray *) GetDescriptionIds{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT ID FROM tblLevel_3_details  WHERE Condition = '' AND Notes ='' AND Description <> ''  AND ParentID =";
		str = [str stringByAppendingString:[CCommon LastAdded_ItemID]];
		str = [str stringByAppendingString:@" ORDER BY 1 DESC"];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetDescriptionIds

//Function used to get room  details from local database.
+ (NSMutableArray *) GetConditionIds{	
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	NSString *str;
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		str = @"SELECT ID FROM tblLevel_3_details  WHERE Description = '' AND Notes ='' AND Condition <> '' AND ParentID =";
		str = [str stringByAppendingString:[CCommon LastAdded_ItemID]];
		str = [str stringByAppendingString:@" ORDER BY 1 DESC"];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				NSString *Title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:Title];
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetConditionIds

+(void)DeleteDescription_Level_3:(NSString *) _itemTypeID
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"DELETE FROM tblLevel_3_Details WHERE id =  ";
		strQuery = [strQuery stringByAppendingString:_itemTypeID];

		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
				//if(sqlite3_step(compiledStatement) == SQLITE_DONE) 
				//{		
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Detail(s) has been saved successfully"
										  delegate:self cancelButtonTitle:nil
										  otherButtonTitles:@"OK",nil];
				//[baseAlert show];
				[baseAlert release];
				
				//[self.navigationController popViewControllerAnimated:YES];
				//}
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
}


+(void)DeleteRoom_Level_2:(NSString *) _itemTypeID
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"DELETE FROM tblLevel_2 WHERE id =  ";
		strQuery = [strQuery stringByAppendingString:_itemTypeID];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
				//if(sqlite3_step(compiledStatement) == SQLITE_DONE) 
				//{		
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Detail(s) has been saved successfully"
										  delegate:self cancelButtonTitle:nil
										  otherButtonTitles:@"OK",nil];
				//[baseAlert show];
				[baseAlert release];
				
				//[self.navigationController popViewControllerAnimated:YES];
				//}
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	
	
	/*Nidhi*/
	
	NSString *strQuery2;
	sqlite3 *database2;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest2 = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest2 UTF8String], &database2) == SQLITE_OK)	
	{
		strQuery2 = @"DELETE FROM tblItemDetails WHERE ParentID  =  ";
		strQuery2 = [strQuery2 stringByAppendingString:_itemTypeID];
		
		const char *sqlStatement2 = [strQuery2 UTF8String];
		
		
		sqlite3_stmt *compiledStatement2;
		if(sqlite3_prepare_v2(database2, sqlStatement2, -1, &compiledStatement2, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement2) == SQLITE_ROW) 
			{		
				//Column floor imageid
				//[CCommon setLastAdded_FloorImageID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement2,0)]];	
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement2);		
	}
	sqlite3_close(database2);
}


+(void)DeleteFloor_Level_1:(NSString *) _itemTypeID
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"DELETE FROM tblLevel_1 WHERE id =  ";
		strQuery = [strQuery stringByAppendingString:_itemTypeID];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
				//if(sqlite3_step(compiledStatement) == SQLITE_DONE) 
				//{		
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Detail(s) has been saved successfully"
										  delegate:self cancelButtonTitle:nil
										  otherButtonTitles:@"OK",nil];
				//[baseAlert show];
				[baseAlert release];
				
				//[self.navigationController popViewControllerAnimated:YES];
				//}
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	
	/*Nidhi*/
	
	NSString *strQuery2;
	sqlite3 *database2;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest2 = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest2 UTF8String], &database2) == SQLITE_OK)	
	{
		strQuery2 = @"DELETE FROM tblItemDetails WHERE ParentID IN (SELECT ID FROM tblLevel_2 WHERE ParentID =  ";
		strQuery2 = [strQuery2 stringByAppendingString:_itemTypeID];
		strQuery2 = [strQuery2 stringByAppendingString:@")"];
		
		const char *sqlStatement2 = [strQuery2 UTF8String];
			
		
		sqlite3_stmt *compiledStatement2;
		if(sqlite3_prepare_v2(database2, sqlStatement2, -1, &compiledStatement2, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement2) == SQLITE_ROW) 
			{		
				//Column floor imageid
				//[CCommon setLastAdded_FloorImageID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement2,0)]];	
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement2);		
	}
	sqlite3_close(database2);
	
	/*Nidhi*/
	
	
	NSString *strQuery1;
	sqlite3 *database1;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest1 = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest1 UTF8String], &database1) == SQLITE_OK)	
	{
		strQuery1 = @"DELETE FROM tblLevel_2 WHERE ParentID =  ";
		strQuery1 = [strQuery1 stringByAppendingString:_itemTypeID];
		
		const char *sqlStatement1 = [strQuery1 UTF8String];
		
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database1, sqlStatement1, -1, &compiledStatement1, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{		
				//Column floor imageid
				[CCommon setLastAdded_FloorImageID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1,0)]];	
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement1);		
	}
	sqlite3_close(database1);
	
	
}

+(void)UpdateInspectionDetails:(NSString *)_StartDate  StartTime:(NSString *)_StartTime 
					   EndDate:(NSString *)_EndDate EndTime:(NSString *)_EndTime
					   InventoryType:(NSString *)_InventoryType
					   InventoryStatus:(NSString *)_InventoryStatus  Notes:(NSString *)_Notes
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"UPDATE tblLevel_0 SET StartDate ='";
		strQuery = [strQuery stringByAppendingString:_StartDate];
		strQuery = [strQuery stringByAppendingString:@"', StartTime = '"];
		strQuery = [strQuery stringByAppendingString:_StartTime];
		strQuery = [strQuery stringByAppendingString:@"', EndDate = '"];
		strQuery = [strQuery stringByAppendingString:_EndDate];
		strQuery = [strQuery stringByAppendingString:@"', EndTime = '"];
		strQuery = [strQuery stringByAppendingString:_EndTime];
		strQuery = [strQuery stringByAppendingString:@"', InventoryType = '"];
		strQuery = [strQuery stringByAppendingString:_InventoryType];
		strQuery = [strQuery stringByAppendingString:@"', InspectionStatus = '"];
		strQuery = [strQuery stringByAppendingString:_InventoryStatus];
		strQuery = [strQuery stringByAppendingString:@"', Notes = '"];
		strQuery = [strQuery stringByAppendingString:_Notes];
		
		strQuery = [strQuery stringByAppendingString:@"' WHERE id =  "];
		strQuery = [strQuery stringByAppendingString:[[CCommon objCCommon]mstrSelectedInspectionID]];
		
		
		const char *sqlStatement = [strQuery UTF8String];
		
		/*UIAlertView *baseAlert = [[UIAlertView alloc] 
								  initWithTitle:@"Query" message:strQuery
								  delegate:self cancelButtonTitle:@"OK"
								  otherButtonTitles:nil];
		[baseAlert show];
		[baseAlert release];*/
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
				/*if(sqlite3_step(compiledStatement) == SQLITE_DONE) 
				 {		
				 UIAlertView *baseAlert = [[UIAlertView alloc] 
				 initWithTitle:@"" message:@"Data has been synchronized successfully."
				 delegate:self cancelButtonTitle:nil
				 otherButtonTitles:@"OK",nil];
				 [baseAlert show];
				 [baseAlert release];
				 
				 //[self.navigationController popViewControllerAnimated:YES];
				 }*/
				
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Detail(s) has been saved successfully"
										  delegate:self cancelButtonTitle:nil
										  otherButtonTitles:@"OK",nil];
				//[baseAlert show];
				[baseAlert release];
				
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
}// END OF UpdateInspectionDetails

//Function used to get Description from local database.
+ (NSMutableArray *) Get_Level0_Details
{	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT StartDate, StartTime, EndDate, EndTime, InventoryType, InspectionStatus, Notes FROM TblLevel_0 WHERE id = ";
		str = [str stringByAppendingString:[[CCommon objCCommon]mstrSelectedInspectionID]];

		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column PropertyName
				NSString *StartDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:StartDate];
				
				NSString *StartTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)];
				[arr addObject:StartTime];
				
				NSString *EndDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)];
				[arr addObject:EndDate];
				
				NSString *EndTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)];
				[arr addObject:EndTime];
				
				NSString *InventoryType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,4)];
				[arr addObject:InventoryType];

				NSString *InspectionStatus = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,5)];
				[arr addObject:InspectionStatus];
				
				NSString *Notes = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,6)];
				[arr addObject:Notes];


			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}//end of - GetDescription

//Function used to get InventoryType from local database.
+ (NSMutableArray *) Get_InventoryType
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT InventoryType FROM TblLevel_0";

		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column InventoryType
				NSString *StartDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:StartDate];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}

//Function used to get startdate from local database.
+ (NSMutableArray *) Get_StartDate
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT StartDate FROM TblLevel_0";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column StartDate
				NSString *StartDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:StartDate];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}

//Function used to get InspectionStatus from local database.
+ (NSMutableArray *) Get_InspectionStatus
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT InspectionStatus FROM TblLevel_0";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column StartDate
				NSString *StartDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:StartDate];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}


//Function used to get starttime from local database.
+ (NSMutableArray *) Get_StartTime
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT StartTime FROM TblLevel_0";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column StartTime
				NSString *StartTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:StartTime];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}

//Function used to get EndDate from local database.
+ (NSMutableArray *) Get_EndDate
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT EndDate FROM TblLevel_0";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column EndDate
				NSString *EndDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:EndDate];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}

//Function used to get EndTime from local database.
+ (NSMutableArray *) Get_EndTime
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT EndTime FROM TblLevel_0";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column EndTime
				NSString *EndTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:EndTime];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}


+(void) AddFloorImages:(NSString *)text
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"INSERT INTO tblFloorImages(title, ParentID)VALUES('";
		strQuery = [strQuery stringByAppendingString:text];
		strQuery = [strQuery stringByAppendingString:@"', "];
		strQuery = [strQuery stringByAppendingString:[CCommon LastAdded_FloorID]];
		strQuery = [strQuery stringByAppendingString:@")"];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	NSString *strQuery1;
	sqlite3 *database1;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest1 = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest1 UTF8String], &database1) == SQLITE_OK)	
	{
		strQuery1 = @"SELECT ID FROM tblFloorImages ORDER BY 1 DESC LIMIT 1";
		
		const char *sqlStatement1 = [strQuery1 UTF8String];
		
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database1, sqlStatement1, -1, &compiledStatement1, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{		
				//Column floor imageid
				[CCommon setLastAdded_FloorImageID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1,0)]];	
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement1);		
	}
	sqlite3_close(database1);
	
}//end - AddFloorToLocaldb


+(void) AddRoomImages:(NSString *)text
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"INSERT INTO tblRoomImages(title, ParentID)VALUES('";
		strQuery = [strQuery stringByAppendingString:text];
		strQuery = [strQuery stringByAppendingString:@"', "];
		strQuery = [strQuery stringByAppendingString:[CCommon LastAdded_RoomID]];
		strQuery = [strQuery stringByAppendingString:@")"];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	NSString *strQuery1;
	sqlite3 *database1;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest1 = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest1 UTF8String], &database1) == SQLITE_OK)	
	{
		strQuery1 = @"SELECT ID FROM tblRoomImages ORDER BY 1 DESC LIMIT 1";
		
		const char *sqlStatement1 = [strQuery1 UTF8String];
		
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database1, sqlStatement1, -1, &compiledStatement1, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{		
				//Column floor imageid
				[CCommon setLastAdded_RoomImageID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1,0)]];	
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement1);		
	}
	sqlite3_close(database1);
	
}//end - AddFloorToLocaldb


//Function used to get starttime from local database.
+ (NSMutableArray *) GetFloorImageTitle
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT title FROM tblFloorImages";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column title
				NSString *title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:title];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}


+ (NSMutableArray *) GetRoomImageTitle
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT title FROM tblRoomImages";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column title
				NSString *title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:title];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}


//Function used to get InventoryType from local database.
+ (NSMutableArray *) Get_Items
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT FeatureName FROM tblInspectionFeature ORDER BY FeatureName ASC";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column FeatureName
				NSString *FeatureName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:FeatureName];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}


+ (NSMutableArray *) Get_ItemsID
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT FeatureID FROM tblInspectionFeature ORDER BY FeatureName ASC";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column FeatureName
				NSString *FeatureName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:FeatureName];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}


//Function used to get InventoryType from local database.
+ (NSMutableArray *) Get_Types
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT SubFeatureName FROM tblInspectionSubFeature WHERE FeatureID = ";
		
		if ([[[CCommon objCCommon]mstrSelectedItemID] length] != 0)
		{
			str = [str stringByAppendingString:[[CCommon objCCommon]mstrSelectedItemID]];
		}
		else {
			str = [str stringByAppendingString:@"0"];
		}

		
		str = [str stringByAppendingString:@" ORDER BY 1 ASC"];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column SubFeatureName
				NSString *SubFeatureName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:SubFeatureName];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}


+(void) AddItemTypeToLocalDB:(NSString *)strTitle strFeatureID:(NSString *)strFeatureID
{
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];

	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
			NSString *strQuery;
			
			strQuery = @"INSERT INTO tblInspectionSubFeature(SubFeatureName, FeatureID)VALUES('";
			strQuery = [strQuery stringByAppendingString:strTitle];
			strQuery = [strQuery stringByAppendingString:@"',"];
			strQuery = [strQuery stringByAppendingString:strFeatureID];
			strQuery = [strQuery stringByAppendingString:@")"];
			
			const char *sqlStatement = [strQuery UTF8String];
			
			sqlite3_stmt *compiledStatement;
			if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
			{
				if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
				{
					UIAlertView *baseAlert = [[UIAlertView alloc] 
											  initWithTitle:@"" message:@"Error occured. Please try again later"
											  delegate:self cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
					[baseAlert show];
					[baseAlert release];
				}
			}
			
			// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	

	}
	sqlite3_close(database);
	
}//end - AddBrandsFromServerToLocalDB


+(void) AddItemDetails
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"INSERT INTO tblItemDetails(title,Item, Type, ParentID)VALUES('Item Name',' ',' ', ";
		strQuery = [strQuery stringByAppendingString:[CCommon LastAdded_RoomID]];
		strQuery = [strQuery stringByAppendingString:@")"];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	NSString *strQuery1;
	sqlite3 *database1;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest1 = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest1 UTF8String], &database1) == SQLITE_OK)	
	{
		strQuery1 = @"SELECT ID FROM tblItemDetails ORDER BY 1 DESC LIMIT 1";
		
		const char *sqlStatement1 = [strQuery1 UTF8String];
		
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database1, sqlStatement1, -1, &compiledStatement1, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{		
				[CCommon setLastAdded_ItemID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1,0)]];	
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement1);		
	}
	sqlite3_close(database1);
	
}//end - 

+(void)UpdateItemDetails:(NSString *)strtitle strItem:(NSString *)strItem strType:(NSString *)strType
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"UPDATE tblItemDetails SET Title ='";
		strQuery = [strQuery stringByAppendingString:strtitle];
		strQuery = [strQuery stringByAppendingString:@"', Item = '"];
		strQuery = [strQuery stringByAppendingString:strItem];
		strQuery = [strQuery stringByAppendingString:@"', Type = '"];
		strQuery = [strQuery stringByAppendingString:strType];
		strQuery = [strQuery stringByAppendingString:@"' WHERE id =  "];
		strQuery = [strQuery stringByAppendingString:[CCommon LastAdded_ItemID]];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Detail(s) has been saved successfully"
										  delegate:self cancelButtonTitle:nil
										  otherButtonTitles:@"OK",nil];
				//[baseAlert show];
				[baseAlert release];
				
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
}// END OF UpdateRoomDetails



+ (NSMutableArray *) Get_ItemTitles
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT title FROM tblItemDetails WHERE ParentID = ";
		str = [str stringByAppendingString:[CCommon LastAdded_RoomID]];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column title
				NSString *title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:title];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}


+ (NSMutableArray *) Get_ItemIDs
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT ID FROM tblItemDetails WHERE ParentID = ";
		str = [str stringByAppendingString:[CCommon LastAdded_RoomID]];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column ID
				NSString *ID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:ID];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}

+ (NSMutableArray *) Get_Items_level3
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT item FROM tblItemDetails WHERE ParentID = ";
		str = [str stringByAppendingString:[CCommon LastAdded_RoomID]];

		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column item
				NSString *item = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:item];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}

+ (NSMutableArray *) Get_itemTypes
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT Type FROM tblItemDetails WHERE ParentID = ";
		str = [str stringByAppendingString:[CCommon LastAdded_RoomID]];

		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column Types
				NSString *Types = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:Types];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}


+(void)Deleteitem:(NSString *) _itemID
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"DELETE FROM tblItemDetails WHERE id =  ";
		strQuery = [strQuery stringByAppendingString:_itemID];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				//[baseAlert show];
				[baseAlert release];
			}
			else
			{	
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Detail(s) has been saved successfully"
										  delegate:self cancelButtonTitle:nil
										  otherButtonTitles:@"OK",nil];
				//[baseAlert show];
				[baseAlert release];
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			//[baseAlert show];
			[baseAlert release];
		}
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
}



+ (NSMutableArray *) Get_Quantity_Description
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT Quantity FROM tblDescription GROUP BY Quantity";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column FeatureName
				NSString *FeatureName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:FeatureName];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}

+ (NSMutableArray *) Get_Quantity_Condition
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT Quantity FROM tblConditions GROUP BY Quantity";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column FeatureName
				NSString *FeatureName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:FeatureName];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}

+ (NSMutableArray *) Get_Shape
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT ShapeSize FROM tblDescription GROUP BY ShapeSize";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column FeatureName
				NSString *FeatureName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:FeatureName];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}

+ (NSMutableArray *) Get_Shade
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT ShadeColor FROM tblDescription GROUP BY ShadeColor";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column FeatureName
				NSString *FeatureName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:FeatureName];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}

+ (NSMutableArray *) Get_Material
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT Material FROM tblDescription GROUP BY Material";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column FeatureName
				NSString *FeatureName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:FeatureName];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}

+ (NSMutableArray *) Get_MakeModel
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT MakeModel FROM tblDescription GROUP BY MakeModel";
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				//Column FeatureName
				NSString *FeatureName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				[arr addObject:FeatureName];	
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
}

+(void) AddItemDescription2 :(NSString *)strQuantity ShapeSize:(NSString *) strShapeSize
				 ShadeColor:(NSString *)strShadeColor Material:(NSString *)strMaterial
				  MakeModel:(NSString *)strMakeModel AdditionalInfo:(NSString *)strAdditionalInfo
				   ParentID:(NSString *)strParentID
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"INSERT INTO tblDescription(Quantity, ShapeSize, ShadeColor, Material, MakeModel, AdditionalInfo, ParentID) VALUES('";
		
		strQuery = [strQuery stringByAppendingString:strQuantity];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strShapeSize];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strShadeColor];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strMaterial];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strMakeModel];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strAdditionalInfo];
		strQuery = [strQuery stringByAppendingString:@"', "];
		strQuery = [strQuery stringByAppendingString:strParentID];
		strQuery = [strQuery stringByAppendingString:@")"];
		
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
}


+(void) AddItemDescription :(NSString *)strQuantity ShapeSize:(NSString *) strShapeSize
				 ShadeColor:(NSString *)strShadeColor Material:(NSString *)strMaterial
				  MakeModel:(NSString *)strMakeModel AdditionalInfo:(NSString *)strAdditionalInfo
				ParentID:(NSString *)strParentID

{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"INSERT INTO tblDescription(Quantity, ShapeSize, ShadeColor, Material, MakeModel, AdditionalInfo, ParentID) VALUES('";
		
		strQuery = [strQuery stringByAppendingString:strQuantity];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strShapeSize];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strShadeColor];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strMaterial];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strMakeModel];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strAdditionalInfo];
		strQuery = [strQuery stringByAppendingString:@"', "];
		strQuery = [strQuery stringByAppendingString:strParentID];
		strQuery = [strQuery stringByAppendingString:@")"];


		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	NSString *strQuery1;
	sqlite3 *database1;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest1 = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest1 UTF8String], &database1) == SQLITE_OK)	
	{
		strQuery1 = @"SELECT ID FROM tblDescription ORDER BY 1 DESC LIMIT 1";
		
		const char *sqlStatement1 = [strQuery1 UTF8String];
		
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database1, sqlStatement1, -1, &compiledStatement1, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{		
				[CCommon setLastAdded_DescriptionID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1,0)]];	
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement1);		
	}
	sqlite3_close(database1);
	
}//end -


+(void)UpdateItemDescription:(NSString *)strQuantity ShapeSize:(NSString *) strShapeSize
							ShadeColor:(NSString *)strShadeColor Material:(NSString *)strMaterial
							MakeModel:(NSString *)strMakeModel AdditionalInfo:(NSString *)strAdditionalInfo
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"UPDATE tblDescription SET Quantity ='";
		strQuery = [strQuery stringByAppendingString:strQuantity];
		strQuery = [strQuery stringByAppendingString:@"', ShapeSize = '"];
		strQuery = [strQuery stringByAppendingString:strShapeSize];
		strQuery = [strQuery stringByAppendingString:@"', ShadeColor = '"];
		strQuery = [strQuery stringByAppendingString:strShadeColor];
		strQuery = [strQuery stringByAppendingString:@"', Material = '"];
		strQuery = [strQuery stringByAppendingString:strMaterial];
		strQuery = [strQuery stringByAppendingString:@"', MakeModel = '"];
		strQuery = [strQuery stringByAppendingString:strMakeModel];
		strQuery = [strQuery stringByAppendingString:@"', Additionalinfo = '"];
		strQuery = [strQuery stringByAppendingString:strAdditionalInfo];
		
		strQuery = [strQuery stringByAppendingString:@"' WHERE id =  "];
		strQuery = [strQuery stringByAppendingString:[CCommon LastAdded_DescriptionID]];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Detail(s) has been saved successfully"
										  delegate:self cancelButtonTitle:nil
										  otherButtonTitles:@"OK",nil];
				//[baseAlert show];
				[baseAlert release];
				
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
}// END OF 


+ (NSMutableArray *) GetDescriptionDetails
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT Quantity, ShapeSize, ShadeColor, Material, MakeModel, Additionalinfo FROM tblDescription WHERE ParentID = ";
		str = [str stringByAppendingString:[CCommon LastAdded_ItemID]];
		
		const char *sqlStatement = [str UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				NSString *Quantity = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
			//	mstrSelectedQuantity = Quantity;
				[arr addObject:Quantity];
				
				NSString *ShapeSize = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)];
				//mstrSelectedShape = ShapeSize;
				[arr addObject:ShapeSize];
				
				NSString *ShadeColor = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)];
				//mstrSelectedShade  = ShadeColor;
				[arr addObject:ShadeColor];
				
				NSString *Material = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)];
				//mstrSelectedMaterial  = Material;
				[arr addObject:Material];
				
				NSString *MakeModel = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,4)];
				//mstrSelectedmakeModel  = MakeModel;
				[arr addObject:MakeModel];
				
				NSString *Additionalinfo = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,5)];
				//mstrSelectedInfo  = Additionalinfo;
				[arr addObject:Additionalinfo];

			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;

}

+(void) AddItemConditions :(NSString *)strMaintenanceRequired CleaningRequired:(NSString *) strCleaningRequired
				 FairUsage:(NSString *)strFairUsage Landlord:(NSString *)strLandlord
				  Tenant:(NSString *)strTenant FurtherNotes:(NSString *)strFurtherNotes
				  Condition:(NSString *)strCondition  Quantity:(NSString *)strQuantity
					ParentID:(NSString *)strParentID

{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"INSERT INTO tblConditions(MaintenanceRequired, CleaningRequired, FairUsage, Landlord, Tenant, FurtherNotes,Condition,Quantity, ParentID) VALUES('";
		
		strQuery = [strQuery stringByAppendingString:strMaintenanceRequired];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strCleaningRequired];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strFairUsage];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strLandlord];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strTenant];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strFurtherNotes];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strCondition];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strQuantity];
		strQuery = [strQuery stringByAppendingString:@"', "];
		strQuery = [strQuery stringByAppendingString:strParentID];
		strQuery = [strQuery stringByAppendingString:@")"];
		
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	
	NSString *strQuery1;
	sqlite3 *database1;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest1 = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest1 UTF8String], &database1) == SQLITE_OK)	
	{
		strQuery1 = @"SELECT ID FROM tblConditions ORDER BY 1 DESC LIMIT 1";
		
		const char *sqlStatement1 = [strQuery1 UTF8String];
		
		sqlite3_stmt *compiledStatement1;
		if(sqlite3_prepare_v2(database1, sqlStatement1, -1, &compiledStatement1, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement1) == SQLITE_ROW) 
			{		
				[CCommon setLastAdded_ConditionID:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement1,0)]];	
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement1);		
	}
	sqlite3_close(database1);
	
}//end -


+(void) AddItemConditions2 :(NSString *)strMaintenanceRequired CleaningRequired:(NSString *) strCleaningRequired
				 FairUsage:(NSString *)strFairUsage Landlord:(NSString *)strLandlord
					Tenant:(NSString *)strTenant FurtherNotes:(NSString *)strFurtherNotes
				 Condition:(NSString *)strCondition  Quantity:(NSString *)strQuantity
				  ParentID:(NSString *)strParentID

{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"INSERT INTO tblConditions(MaintenanceRequired, CleaningRequired, FairUsage, Landlord, Tenant, FurtherNotes,Condition,Quantity, ParentID) VALUES('";
		
		strQuery = [strQuery stringByAppendingString:strMaintenanceRequired];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strCleaningRequired];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strFairUsage];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strLandlord];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strTenant];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strFurtherNotes];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strCondition];
		strQuery = [strQuery stringByAppendingString:@"', '"];
		strQuery = [strQuery stringByAppendingString:strQuantity];
		strQuery = [strQuery stringByAppendingString:@"', "];
		strQuery = [strQuery stringByAppendingString:strParentID];
		strQuery = [strQuery stringByAppendingString:@")"];
	
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	
}//end -


+(NSMutableArray *)GetConditionsByName:(NSString *)value
{ 
	
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	// Setup the database object
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		strQuery = @"SELECT Condition FROM tblConditions WHERE Condition LIKE '";	
		strQuery =[strQuery stringByAppendingString:value];
		strQuery =[strQuery stringByAppendingString:@"%' ORDER BY Condition ASC"];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{				
				NSString *lstrTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arr addObject:lstrTitle];
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);		
	}
	sqlite3_close(database);
	
	return arr;
}

+(void)UpdateItemCondition:(NSString *)strMaintenanceReq CleaningReq:(NSString *) strCleaningReq
				  FairUsage:(NSString *)strFairUsage Landlord:(NSString *)strLandlord
				   Tenant:(NSString *)strTenant FurtherNotes:(NSString *)strFurtherNotes
				Condition:(NSString *)strCondition Quantity:(NSString *)strQuantity
				ParentID:(NSString *)strParentID
{
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{
		strQuery = @"UPDATE tblConditions SET MaintenanceRequired ='";
		strQuery = [strQuery stringByAppendingString:strMaintenanceReq];
		strQuery = [strQuery stringByAppendingString:@"', CleaningRequired = '"];
		strQuery = [strQuery stringByAppendingString:strCleaningReq];
		strQuery = [strQuery stringByAppendingString:@"', FairUsage = '"];
		strQuery = [strQuery stringByAppendingString:strFairUsage];
		strQuery = [strQuery stringByAppendingString:@"', Landlord = '"];
		strQuery = [strQuery stringByAppendingString:strLandlord];
		strQuery = [strQuery stringByAppendingString:@"', Tenant = '"];
		strQuery = [strQuery stringByAppendingString:strTenant];
		strQuery = [strQuery stringByAppendingString:@"', FurtherNotes = '"];
		strQuery = [strQuery stringByAppendingString:strFurtherNotes];
		strQuery = [strQuery stringByAppendingString:@"', Condition = '"];
		strQuery = [strQuery stringByAppendingString:strCondition];
		strQuery = [strQuery stringByAppendingString:@"', Quantity = '"];
		strQuery = [strQuery stringByAppendingString:strQuantity];
		//strQuery = [strQuery stringByAppendingString:@"', ID = '"];
		//strQuery = [strQuery stringByAppendingString:strParentID];
		strQuery = [strQuery stringByAppendingString:@"' WHERE id =  "];
		strQuery = [strQuery stringByAppendingString:[CCommon LastAdded_ConditionID]];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		
		UIAlertView *baseAlert = [[UIAlertView alloc] 
								  initWithTitle:@"" message:strQuery
								  delegate:self cancelButtonTitle:@"OK"
								  otherButtonTitles:nil];
	//	[baseAlert show];
		[baseAlert release];
		
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			if(sqlite3_step(compiledStatement) == SQLITE_ERROR) 
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Error occured. Please try again later"
										  delegate:self cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
				[baseAlert show];
				[baseAlert release];
			}
			else
			{
				UIAlertView *baseAlert = [[UIAlertView alloc] 
										  initWithTitle:@"" message:@"Detail(s) has been saved successfully"
										  delegate:self cancelButtonTitle:nil
										  otherButtonTitles:@"OK",nil];
				//[baseAlert show];
				[baseAlert release];
				
			}
		}
		else {
			
			UIAlertView *baseAlert = [[UIAlertView alloc] 
									  initWithTitle:@"" message:@"Error occured. Please try again later"
									  delegate:self cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
			[baseAlert show];
			[baseAlert release];
		}
		
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
}// END OF 


+ (NSMutableArray *) GetConditionDetails
{
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	
	// Setup the database object
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{		
		NSString *str =@"SELECT MaintenanceRequired, CleaningRequired, FairUsage, Landlord, Tenant, FurtherNotes, Condition, Quantity FROM tblDescription WHERE ID = ";
		str = [str stringByAppendingString:[CCommon LastAdded_ConditionID]];
		
		const char *sqlStatement = [str UTF8String];
		
		UIAlertView *baseAlert = [[UIAlertView alloc] 
								  initWithTitle:@"" message:str
								  delegate:self cancelButtonTitle:@"OK"
								  otherButtonTitles:nil];
		[baseAlert show];
		[baseAlert release];
		
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{		
				NSString *Quantity = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				//	mstrSelectedQuantity = Quantity;
				[arr addObject:Quantity];
				
				NSString *ShapeSize = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)];
				//mstrSelectedShape = ShapeSize;
				[arr addObject:ShapeSize];
				
				NSString *ShadeColor = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)];
				//mstrSelectedShade  = ShadeColor;
				[arr addObject:ShadeColor];
				
				NSString *Material = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,3)];
				//mstrSelectedMaterial  = Material;
				[arr addObject:Material];
				
				NSString *MakeModel = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,4)];
				//mstrSelectedmakeModel  = MakeModel;
				[arr addObject:MakeModel];
				
				NSString *Additionalinfo = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,5)];
				//mstrSelectedInfo  = Additionalinfo;
				[arr addObject:Additionalinfo];
				
				
				NSString *Material1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,6)];
				//mstrSelectedMaterial  = Material;
				[arr addObject:Material1];
				
				NSString *MakeModel1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,7)];
				//mstrSelectedmakeModel  = MakeModel;
				[arr addObject:MakeModel1];
				
				NSString *Additionalinfo1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,8)];
				//mstrSelectedInfo  = Additionalinfo;
				[arr addObject:Additionalinfo1];
				
			}	
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);	
	}
	sqlite3_close(database);
	
	return arr;
	
}


+(NSMutableArray *)GetFloorsByName:(NSString *)value
{ 
	NSMutableArray *arrBrands = [[NSMutableArray alloc]init];
	// Setup the database object
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{	
		//strQuery = @"SELECT Title FROM TblBrands";
		
		strQuery = @"SELECT Title FROM tblLevel_1 WHERE Title LIKE '";	
		strQuery =[strQuery stringByAppendingString:value];
		strQuery =[strQuery stringByAppendingString:@"%' ORDER BY Title ASC"];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{				
				NSString *lstrTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arrBrands addObject:lstrTitle];
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);		
	}
	sqlite3_close(database);
	
	return arrBrands;
}//end - GetBrandsByName


//Added by Vijai on 8th June 2011

+(NSMutableArray *)GetRoomsByName:(NSString *)value
{ 
	NSMutableArray *arrRooms = [[NSMutableArray alloc]init];
	// Setup the database object
	NSString *strQuery;
	sqlite3 *database;
	
	[DataAccess copyDatabaseIfNeeded];
	
	NSString *strTest = [DataAccess getDBPath];
	
	// Open the database from the users filessytem
	if(sqlite3_open([strTest UTF8String], &database) == SQLITE_OK)	
	{	
		//strQuery = @"SELECT Title FROM TblBrands";
		
		strQuery = @"SELECT Title FROM tblLevel_2 WHERE Title LIKE '";	
		strQuery =[strQuery stringByAppendingString:value];
		strQuery =[strQuery stringByAppendingString:@"%' ORDER BY Title ASC"];
		
		const char *sqlStatement = [strQuery UTF8String];
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
		{
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
			{				
				NSString *lstrTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
				
				[arrRooms addObject:lstrTitle];
			}
		}
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);		
	}
	sqlite3_close(database);
	
	return arrRooms;
}//end - Get

//end of Vijai code


+ (void)initialize {
	
    if(!MyClassLastAdded_FloorID) {
        MyClassLastAdded_FloorID = @"Default default name";
    }
	
	if(!MyClassLastAdded_PropertyID) {
        MyClassLastAdded_PropertyID = @"Default default name";
    }
	
	/*if(!MyClassLastAdded_RoomID) {
        MyClassLastAdded_RoomID = @"Default default name";
    }*/
	
	if(!MyClassLastAdded_ItemID) {
        MyClassLastAdded_ItemID = @"Default default name";
    }
	
	if(!MyClassLastAdded_FloorImageID) {
        MyClassLastAdded_FloorImageID = @"0";
    }
	
	if(!MyClassLastAdded_RoomImageID) {
        MyClassLastAdded_RoomImageID = @"0";
    }
	
	if(!MyClassLastAdded_ItemID) {
        MyClassLastAdded_ItemID = @"0";
    }
	
	if(!MyClassLastAdded_DescriptionID) {
        MyClassLastAdded_DescriptionID = @"0";
    }
	
	if(!MyClassLastAdded_ConditionID) {
        MyClassLastAdded_ConditionID = @"0";
    }

	
	
}


@end
