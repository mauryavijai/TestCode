//
//  CCommon.h
//  Natolli
//
//  Created by Nidhi Sharma on 27/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalSingleton.h"

@interface CCommon : NSObject {
	
	
	NSString *mstrSelectedSDate;
	NSString *mstrSelectedStartTime;
	NSString *mstrSelectedEndDate;
	NSString *mstrSelectedEndTime;
	NSString *mstrSelectedInType;
	NSString *mstrSelectedInStatus;
	NSString *mstrNotes;
	NSString *mstrSelectedInspectionID;
	
	NSString *mstrSelectedItem;
	NSString *mstrSelectedItemID;
	NSString *mstrSelectedType;
	NSString *mstrSelectedTypeID;
	
	NSString *IsItemSelected;
	
	NSString *mstrSelectedQuantity;
	NSString *mstrSelectedShape;
	NSString *mstrSelectedShade;
	NSString *mstrSelectedMaterial;
	NSString *mstrSelectedmakeModel;
	NSString *mstrSelectedInfo;
	
	NSString *mstrSelectedQuantity_Condition;
	NSString *mstrSelectedCondition;
	NSString *mstrFurtherNotes;
	NSString *mstrTenant;
	NSString *mstrLandlord;
	NSString *mstrFairUsage;
	NSString *mstrCleaningReq;
	NSString *mstrMaintenanceReq;

}
+ (CCommon *)objCCommon;


@property(nonatomic,retain)NSString *mstrMaintenanceReq;
@property(nonatomic,retain)NSString *mstrCleaningReq;
@property(nonatomic,retain)NSString *mstrFairUsage;
@property(nonatomic,retain)NSString *mstrLandlord;
@property(nonatomic,retain)NSString *mstrTenant;
@property(nonatomic,retain)NSString *mstrFurtherNotes;
@property(nonatomic,retain)NSString *mstrSelectedCondition;
@property(nonatomic,retain)NSString *mstrSelectedSDate;
@property(nonatomic,retain)NSString *mstrSelectedStartTime;
@property(nonatomic,retain)NSString *mstrSelectedEndDate;
@property(nonatomic,retain)NSString *mstrSelectedEndTime;
@property(nonatomic,retain)NSString *mstrSelectedInType;
@property(nonatomic,retain)NSString *mstrSelectedInStatus;
@property(nonatomic,retain)NSString *mstrNotes;
@property(nonatomic,retain)NSString *mstrSelectedInspectionID;
@property(nonatomic,retain)NSString *mstrSelectedItemID;
@property(nonatomic,retain)NSString *mstrSelectedTypeID;

@property(nonatomic,retain)NSString *mstrSelectedItem;
@property(nonatomic,retain)NSString *mstrSelectedType;
@property(nonatomic,retain)NSString *IsItemSelected;

@property(nonatomic,retain)NSString *mstrSelectedQuantity;
@property(nonatomic,retain)NSString *mstrSelectedShape;
@property(nonatomic,retain)NSString *mstrSelectedShade;
@property(nonatomic,retain)NSString *mstrSelectedMaterial;
@property(nonatomic,retain)NSString *mstrSelectedmakeModel;
@property(nonatomic,retain)NSString *mstrSelectedInfo;
@property(nonatomic,retain)NSString *mstrSelectedQuantity_Condition;

+ (NSString *) GetItemNotes;
+ (NSString *) LastAdded_ItemID;
+ (NSString *) LastAdded_RoomID;
+ (NSString *) LastAdded_FloorID;
+ (NSString *) LastAdded_PropertyID;

+ (NSString *) LastAdded_FloorImageID;
+ (NSString *) LastAdded_RoomImageID;
+ (NSString *) LastAdded_DescriptionID;
+ (NSString *) LastAdded_ConditionID;


+ (NSString *) AddItemType:(NSString *)value;
+ (NSString *) GetItemTypeIDByTitle:(NSString *)text;
+ (NSString *) GetItemTypeTitleByID:(NSString *)text;

+ (void) MarkBrandsAsSync;
+ (void) AddRoomToLocaldb:(NSString *)text;
+ (void) AddItemsToLocaldb:(NSString *)text;
+ (void) AddFloorToLocaldb:(NSString *)text;
+ (void) AddNewBrandToLocaldb:(NSString *)text;
+ (void) AddPropertyTitleToLocaldb:(NSString *)text;
+ (void) DeleteDescription_Level_3:(NSString *) _itemTypeID;
+ (void) setLastAdded_ItemID:(NSString*)newLastAdded_ItemID;
+ (void) setLastAdded_RoomID:(NSString*)newLastAdded_RoomID;
+ (void) setLastAdded_FloorID:(NSString*)newLastAdded_FloorID;
+ (void) setLastAdded_DescriptionID:(NSString*)newLastAdded_DescriptionID;

+ (void) setLastAdded_RoomImageID:(NSString*)newLastAdded_RoomImageID;
+ (void) setLastAdded_ConditionID:(NSString*)newLastAdded_ConditionID;

+ (void) setLastAdded_FloorImageID:(NSString*)newLastAdded_FloorID;
+ (void) AddBrandsFromServerToLocalDB:(NSMutableArray *)BrandTitle;
+ (void) setLastAdded_PropertyID:(NSString*)newLastAdded_PropertyID;
+ (void) UpdateFloorDetails:(NSString *)_title  _notes:(NSString *)_notes _image:(NSString *)_image;
+ (void) UpdateItem:(NSString *)_itemName  _itemTypeID:(NSString *)_itemTypeID;
+ (void) AddItemDetailsToLocaldb:(NSString *)_description  _condition:(NSString *)_condition  _notes:(NSString *)_notes;
+ (void) UpdateRoomDetails:(NSString *)_title  _details:(NSString *)_details _location:(NSString *)_location  _description:(NSString *)_description;
+ (void) UpdateInspectionDetails:(NSString *)_StartDate  StartTime:(NSString *)_StartTime 
					   EndDate:(NSString *)_EndDate EndTime:(NSString *)_EndTime
					   InventoryType:(NSString *)_InventoryType
			   InventoryStatus:(NSString *)_InventoryStatus  Notes:(NSString *)_Notes;


+(void) AddItemTypeToLocalDB:(NSString *)strTitle strFeatureID:(NSString *)strFeatureID;

+ (NSMutableArray *) GetItemIDs;
+ (NSMutableArray *) GetItemNames;
+ (NSMutableArray *) GetFloorNotes;
+ (NSMutableArray *) GetRoomTitles;
+ (NSMutableArray *) GetItemTypeIDs;
+ (NSMutableArray *) GetRoomDetails;
+ (NSMutableArray *) GetFloorTitles;
+ (NSMutableArray *) GetRoomTitleIDs;
+ (NSMutableArray *) GetRoomLocation;
+ (NSMutableArray *) GetFloorTitleIDs;
+ (NSMutableArray *) GetFloorImages;
+ (NSMutableArray *) GetConditionIds;
+ (NSMutableArray *) GetDescriptionIds;
+ (NSMutableArray *) GetConditionTitles;
+ (NSMutableArray *) GetRoomDescription;
+ (NSMutableArray *) GetDescriptionTitles;
+ (NSMutableArray *) GetAllBrandsFromLocalDb;
+ (NSMutableArray *) GetBrandsFromLocalDBForSync;
+ (NSMutableArray *) GetItemTypes:(NSString *)value;
+ (NSMutableArray *) GetBrandsByName:(NSString *)value;
+ (NSMutableArray *) GetRoomTitlesBasedOnFloorTitle:(NSString *)text;
+ (NSMutableArray *) Get_Level0_Details;
+ (NSMutableArray *) Get_StartDate;
+ (NSMutableArray *) Get_InventoryType;
+ (NSMutableArray *) Get_EndTime;
+ (NSMutableArray *) Get_EndDate;
+ (NSMutableArray *) Get_StartTime;
+ (NSMutableArray *) GetFloorImageTitle;
+(void) AddFloorImages:(NSString *)text;
+ (NSMutableArray *) GetRoomImageTitle;
+(void) AddRoomImages:(NSString *)text;
+ (NSMutableArray *) Get_InspectionStatus;
+(void)DeleteRoom_Level_2:(NSString *) _itemTypeID;
+(void)DeleteFloor_Level_1:(NSString *) _itemTypeID;
+ (NSMutableArray *) Get_Items;
+ (NSMutableArray *) Get_Types;
+ (NSMutableArray *) Get_ItemsID;

+(void) AddItemDetails;
+(void)UpdateItemDetails:(NSString *)strtitle strItem:(NSString *)strItem 
				 strType:(NSString *)strType;

+ (NSMutableArray *) Get_itemTypes;
+ (NSMutableArray *) Get_Items_level3;
+ (NSMutableArray *) Get_ItemIDs;
+ (NSMutableArray *) Get_ItemTitles;
+(void)Deleteitem:(NSString *) _itemID;

+ (NSMutableArray *) Get_MakeModel;
+ (NSMutableArray *) Get_Material;
+ (NSMutableArray *) Get_Shade;
+ (NSMutableArray *) Get_Shape;
+ (NSMutableArray *) Get_Quantity_Description;

+(void) AddItemDescription :(NSString *)strQuantity ShapeSize:(NSString *) strShapeSize
				 ShadeColor:(NSString *)strShadeColor Material:(NSString *)strMaterial
				  MakeModel:(NSString *)strMakeModel 
				AdditionalInfo:(NSString *)strAdditionalInfo ParentID:(NSString *)strParentID;

+(void)UpdateItemDescription:(NSString *)strQuantity ShapeSize:(NSString *) strShapeSize
				  ShadeColor:(NSString *)strShadeColor Material:(NSString *)strMaterial
				   MakeModel:(NSString *)strMakeModel AdditionalInfo:(NSString *)strAdditionalInfo;

+ (NSMutableArray *) GetDescriptionDetails;

+(void) AddItemDescription2 :(NSString *)strQuantity ShapeSize:(NSString *) strShapeSize
				  ShadeColor:(NSString *)strShadeColor Material:(NSString *)strMaterial
				   MakeModel:(NSString *)strMakeModel AdditionalInfo:(NSString *)strAdditionalInfo
					ParentID:(NSString *)strParentID;

+ (NSMutableArray *) Get_Quantity_Condition;

+(void) AddItemConditions :(NSString *)strMaintenanceRequired CleaningRequired:(NSString *) strCleaningRequired
				 FairUsage:(NSString *)strFairUsage Landlord:(NSString *)strLandlord
					Tenant:(NSString *)strTenant FurtherNotes:(NSString *)strFurtherNotes
				 Condition:(NSString *)strCondition  Quantity:(NSString *)strQuantity
				  ParentID:(NSString *)strParentID;

+(void) AddItemConditions2 :(NSString *)strMaintenanceRequired CleaningRequired:(NSString *) strCleaningRequired
				 FairUsage:(NSString *)strFairUsage Landlord:(NSString *)strLandlord
					Tenant:(NSString *)strTenant FurtherNotes:(NSString *)strFurtherNotes
				 Condition:(NSString *)strCondition  Quantity:(NSString *)strQuantity
				  ParentID:(NSString *)strParentID;

+(NSMutableArray *)GetConditionsByName:(NSString *)value;

+(void)UpdateItemCondition:(NSString *)strMaintenanceReq CleaningReq:(NSString *)strCleaningReq
FairUsage:(NSString *)strFairUsage Landlord:(NSString *)strLandlord
Tenant:(NSString *)strTenant FurtherNotes:(NSString *)strFurtherNotes
Condition:(NSString *)strCondition Quantity:(NSString *)strQuantity
ParentID:(NSString *)strParentID;

+ (NSMutableArray *) GetConditionDetails;

+(NSMutableArray *)GetFloorsByName:(NSString *)value;

+(NSMutableArray *)GetRoomsByName:(NSString *)value; //added by Vijai on 8th june 2011

@end
