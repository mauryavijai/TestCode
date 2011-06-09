//
//  MapViewController.h
//  MapApp
//
//  Created by Mithin on 21/06/09.
//  Copyright 2009 Techtinium Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	
	NSString *mTitle;
	NSString *mSubTitle;
}

@end

@interface MapViewController : UIViewController<MKMapViewDelegate> {
	IBOutlet UITextField *addressField;
	IBOutlet UIButton *goButton;
	IBOutlet MKMapView *mapView;
	
	AddressAnnotation *addAnnotation;
	
	NSString *address;
}

- (IBAction) showAddress;

-(CLLocationCoordinate2D) addressLocation;


@property(copy, readwrite)NSString *address;

@end
