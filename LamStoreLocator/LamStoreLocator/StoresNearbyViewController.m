//
//  StoresNearbyViewController.m
//  LamStoreLocator
//
//  Created by benjamin on 19/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import "StoresNearbyViewController.h"
#import <Parse/Parse.h>
#import "StoreAnnotation.h"
#import "StorePinAnnotationView.h"
#import "StoreViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface StoresNearbyViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray *storesNearByArray;

@end


@implementation StoresNearbyViewController
@synthesize mapView = _mapView;

@synthesize locationManager = _locationManager;
@synthesize storesNearByArray = _storesNearByArray;

#pragma mark - Init

- (id)init
{
	if (self) {
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
			self = [self initWithNibName:@"StoresNearbyViewController_iPhone" bundle:nil];
		}
		else {
			self = [self initWithNibName:@"StoresNearbyViewController_iPad" bundle:nil];
		}
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.locationManager = [[CLLocationManager alloc] init];
		self.locationManager.delegate = self;
		self.locationManager.distanceFilter = kCLDistanceFilterNone;
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		[self.locationManager startUpdatingLocation];
		
		self.mapView = [[MKMapView alloc] init];
		// affichage de la position de l’utilisateur
		self.mapView.showsUserLocation = YES;
		// on change le type d’affichage pour mettre carte + satellite
		self.mapView.mapType = MKMapTypeHybrid;
    }
    return self;
}


#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
	[self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - CLLocationManagerDelegate method

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
	PFQuery *query = [PFQuery queryWithClassName:kClassName];
	[query whereKey:kGeolocKey nearGeoPoint:userGeoPoint withinKilometers:kMaximumDistanceInKm];
	query.limit = kMaxStoresNearbyToReturn;
	self.storesNearByArray = [query findObjects];
	[self addAnnotations];
}

- (void)addAnnotations
{
	for (NSArray *store in self.storesNearByArray) {
		CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([(PFGeoPoint *)[store valueForKey:kGeolocKey] latitude], [(PFGeoPoint *)[store valueForKey:kGeolocKey] longitude]);
		StoreAnnotation *storeAnnotation = [[StoreAnnotation alloc] initWithCoordinate:coordinate];
		[storeAnnotation setTitle:[store valueForKey:kNameKey]];
		[storeAnnotation setSubtitle:[store valueForKey:kAddLine1Key]];
		[storeAnnotation setStore:store];
//		PFFile *pictoFile = [store valueForKey:kPictoKey];
//		[storeAnnotation.imageURL:[pictoFile url]];
		
		[self.mapView addAnnotation:storeAnnotation];
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
    static NSString *identifier = @"Annotation";
    if ([annotation isKindOfClass:[StoreAnnotation class]]) {
		
        StorePinAnnotationView *annotationView = (StorePinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[StorePinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
		
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
		
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		[imageView setImage:[UIImage imageNamed:@"placeholder.png"]];
		annotationView.autoresizesSubviews = YES;
		[annotationView setLeftCalloutAccessoryView:imageView];

		[annotationView setImage:[UIImage imageNamed:@"bottle.png"]];
				
		UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton setTitle:annotation.title forState:UIControlStateNormal];
        [annotationView setRightCalloutAccessoryView:rightButton];
		
		NSArray *store = [(StoreAnnotation *)annotation store];
		[annotationView setStore:store];
		
        return annotationView;
    }
	else {
		NSLog(@"NIL Value");
		return nil;
	}
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	
    if ([(UIButton*)control buttonType] == UIButtonTypeDetailDisclosure){
        // Do your thing when the detailDisclosureButton is touched
		StoreViewController *storeViewController = [[StoreViewController alloc] init];
		[storeViewController setStore:[view valueForKey:@"store"]];
        [[self navigationController] pushViewController:storeViewController animated:YES];
    }
}


#pragma mark - MKMapView delegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *) userLocation
{
	// on zoome
	MKCoordinateSpan span = {0.01, 0.01};
	[mapView setRegion:MKCoordinateRegionMake(mapView.userLocation.location.coordinate, span) animated:YES];
}

@end
