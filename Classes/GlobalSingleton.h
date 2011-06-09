//
//  GlobalSingleton.h
//  Untitled
//

#import <Foundation/Foundation.h>


@interface GlobalSingleton : NSObject {

	NSString *LastPageOpened;
}

@property(copy,readwrite)NSString *LastPageOpened;

+(GlobalSingleton *)sharedInstance;

@end
