//
//  CountriesViewController.m
//  LamStoreLocator
//
//  Created by benjamin payen on 11/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import "CountriesViewController.h"
#import "StoresViewController.h"

#import <Parse/Parse.h>

@interface CountriesViewController ()

@property (nonatomic, strong) NSArray *stores;
@property (nonatomic, strong) NSArray *countries;

@end

@implementation CountriesViewController

@synthesize countriesTableView = _countriesTableView;
@synthesize stores = _stores;
@synthesize countries = _countries;


#pragma mark - Init

- (id)init
{
	if (self) {
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
			self = [self initWithNibName:@"CountriesViewController_iPhone" bundle:nil];
		}
		else {
			self = [self initWithNibName:@"CountriesViewController_iPad" bundle:nil];
		}
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	PFQuery *query = [PFQuery queryWithClassName:@"Stores"];
	[query setCachePolicy:kPFCachePolicyCacheThenNetwork];
	
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		if (!error) {
			// The find succeeded.
			NSLog(@"Successfully retrieved %d stores.", objects.count);
			
			self.stores = [NSArray arrayWithArray:objects];
			self.countries = [self.stores valueForKeyPath:@"@distinctUnionOfObjects.Country"];
			[self.countriesTableView reloadData];
			
		} else {
			// Log details of the failure
			NSLog(@"Error: %@ %@", error, [error userInfo]);
		}
	}];
	return self;
}


#pragma mark - View Life Cycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
	[self setCountriesTableView:nil];
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
		return YES;
	}
}


#pragma mark - UITableViewDataSource methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
	return [self.countries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"countriesCellIdentifier";
	
	UITableViewCell *countryCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (countryCell == nil) {
		countryCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	
	
	NSString *countryCode = [self.countries objectAtIndex:indexPath.row];
	countryCell.textLabel.text = [self countryNameWithCode:countryCode];
	
	return countryCell;
}

- (NSString *)countryNameWithCode:(NSString *)countryCode
{
	NSLocale *myLocale = [NSLocale currentLocale];
	NSString *loalisedCountryName = [myLocale displayNameForKey:NSLocaleCountryCode value:countryCode];
	return loalisedCountryName;
}


#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	StoresViewController *storesViewController = [[StoresViewController alloc] init];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Country like %@", [self.countries objectAtIndex:indexPath.row]];
	NSArray *filteredArray = [self.stores filteredArrayUsingPredicate:predicate];
	
	NSString *countryCode = [self.countries objectAtIndex:indexPath.row];
	for (NSArray *store in filteredArray) {
		[store setValue:[self countryNameWithCode:countryCode] forKey:@"Country"];
	}
	
	[storesViewController setStores:filteredArray];
	[self.navigationController pushViewController:storesViewController animated:YES];
}


@end
