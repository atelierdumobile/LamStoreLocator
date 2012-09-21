//
//  StoresNearbyViewController.h
//  LamStoreLocator
//
//  Created by benjamin on 19/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface StoresNearbyViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, MKAnnotation>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;



@end
