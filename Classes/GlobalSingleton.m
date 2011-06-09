//
//  GlobalSingleton.m
//  Untitled
//

#import "GlobalSingleton.h"

@implementation GlobalSingleton
@synthesize LastPageOpened;

+(GlobalSingleton *)sharedInstance
{
	static GlobalSingleton *myInstance = nil;
	
	if(myInstance == nil)
	{
		myInstance = [[[self class] alloc] init];
		
	}
	
	return myInstance;
}

@end
