//
//  StoreViewController.m
//  LamStoreLocator
//
//  Created by benjamin payen on 13/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import "StoreViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <Parse/Parse.h>


@interface StoreViewController ()

@end

@implementation StoreViewController
@synthesize nameLabel = _nameLabel;
@synthesize addressLabel1 = _addressLabel1;
@synthesize addressLabel2 = _addressLabel2;
@synthesize pictoImageView = _pictoImageView;
@synthesize mapButton = _mapButton;
@synthesize callButton = _callButton;
@synthesize store = _store;


#pragma mark - Init

- (id)init
{
	if (self) {
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
			self = [super initWithNibName:@"StoreViewController_iPhone" bundle:nil];
		}
		else {
			self = [super initWithNibName:@"StoreViewController_iPad" bundle:nil];
		}
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	self.nameLabel.text = [self.store valueForKey:kNameKey];
	self.addressLabel1.text = [self.store valueForKey:kAddLine1Key];
	self.addressLabel2.text = [self.store valueForKey:kAddLine2Key];
	PFFile *picto = [self.store valueForKey:kPictoKey];
	[self.pictoImageView setImageWithURL:[NSURL URLWithString:[picto url]] placeholderImage:[UIImage imageNamed:kPlaceholderFileName]];
}

- (void)viewDidUnload
{
	[self setNameLabel:nil];
	[self setAddressLabel1:nil];
	[self setAddressLabel2:nil];
	[self setPictoImageView:nil];
	[self setMapButton:nil];
	[self setCallButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Store Localization

- (IBAction)showOnMap
{
	NSString *mapsURLScheme = @"";
	if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
		mapsURLScheme = @"http://maps.apple.com/maps";
	}
	else {
		mapsURLScheme = @"http://maps.google.com/maps";
	}
	
	NSURL *myURL = [NSURL URLWithString:[[NSString stringWithFormat:@"%@?q=%@ %@, %@", mapsURLScheme, [self.store valueForKey:kAddLine1Key], [self.store valueForKey:kAddLine2Key], [self.store valueForKey:@"countryName"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[[UIApplication sharedApplication] openURL:myURL];
}


#pragma mark - Store phone

- (IBAction)callTheStore
{
	NSString *phoneNumber = [@"telprompt:" stringByAppendingString:[[self.store valueForKey:kPhoneKey] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
@end
