//
//  StoreViewController.m
//  LamStoreLocator
//
//  Created by benjamin payen on 13/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import "StoreViewController.h"

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
	
	self.nameLabel.text = [self.store valueForKey:@"name"];
	self.addressLabel1.text = [self.store valueForKey:@"addLine1"];
	self.addressLabel2.text = [self.store valueForKey:@"addLine2"];
	[self.pictoImageView setFile:[self.store valueForKey:@"picto" ]];
	[self.pictoImageView loadInBackground];
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
	NSURL *myURL = [NSURL URLWithString:[[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@ %@, %@", [self.store valueForKey:@"addLine1"], [self.store valueForKey:@"addLine2"], [self.store valueForKey:@"CountryName"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[[UIApplication sharedApplication] openURL:myURL];
}


#pragma mark - Store phone

- (IBAction)callTheStore
{
	NSString *phoneNumber = [@"telprompt:" stringByAppendingString:[[self.store valueForKey:@"phone"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
@end
