//
//  StoreAnnotation.m
//  LamStoreLocator
//
//  Created by benjamin on 19/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import "StoreAnnotation.h"

@implementation StoreAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize imageURL = _imageURL;
@synthesize store = _store;

- (id)initWithCoordinate:(CLLocationCoordinate2D)theCoordinate
{
	self.coordinate = theCoordinate;
	return self;
}



@end
