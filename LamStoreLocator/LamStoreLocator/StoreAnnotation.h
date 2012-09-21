//
//  StoreAnnotation.h
//  LamStoreLocator
//
//  Created by benjamin on 19/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface StoreAnnotation : NSObject <MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *subtitle;
@property(nonatomic, strong) NSString *imageURL;
@property(nonatomic, strong) NSArray *store;

-(id)initWithCoordinate:(CLLocationCoordinate2D)theCoordinate;


@end
