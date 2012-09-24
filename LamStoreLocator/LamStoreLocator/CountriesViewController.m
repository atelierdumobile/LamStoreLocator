//
//  CountriesViewController.m
//  LamStoreLocator
//
//  Created by benjamin payen on 11/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import "CountriesViewController.h"
#import "CitiesViewController.h"
#import "StoresNearbyViewController.h"

#import <Parse/Parse.h>


@interface CountriesViewController ()

@property (nonatomic, strong) NSArray *stores;
@property (nonatomic, strong) NSArray *countries;

@end

@implementation CountriesViewController

@synthesize countriesTableView = _countriesTableView;
@synthesize stores = _stores;
@synthesize countries = _countries;
@synthesize refreshControl = _refreshControl;


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
	[self downloadData];
	return self;
}


#pragma mark - View Life Cycle

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.refreshControl = [[UIRefreshControl alloc] init];
	
	NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//	[attributes setObject:[UIColor blueColor] forKey:NSBackgroundColorAttributeName];
//	[attributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
	NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"Chargement des données en cours" attributes:attributes];
	self.refreshControl.attributedTitle = title;
	
	[self.refreshControl addTarget:self action:@selector(downloadData) forControlEvents:UIControlEventValueChanged];
	[self.countriesTableView addSubview:self.refreshControl];
}

- (void)viewDidUnload
{
	[self setCountriesTableView:nil];
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Data downloading

- (void)downloadData
{
	PFQuery *query = [PFQuery queryWithClassName:kClassName];
	[query setCachePolicy:kCachePolicy];
	
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		
		if (!error) {
			// The find succeeded.
			NSLog(@"Successfully retrieved %d stores.", objects.count);
			
			self.stores = [NSArray arrayWithArray:objects];
			self.countries = [self.stores valueForKeyPath:[NSString stringWithFormat:@"@distinctUnionOfObjects.%@", kCountryKey]];
			
			for (NSArray *store in self.stores) {
				NSString *countryCode = [store valueForKey:kCountryKey];
				[store setValue:[self countryNameWithCode:countryCode] forKey:@"countryName"];
			}
			
			//Debug
			[self.stores writeToFile:@"/plist/initialData.plist" atomically:YES];
			
			[self.countriesTableView reloadData];
		}
		else {
			// Log details of the failure
			NSLog(@"Error: %@ %@", error, [error userInfo]);
		}

		[self.refreshControl endRefreshing];
	}];
}


#pragma mark - Data management

- (NSString *)countryNameWithCode:(NSString *)countryCode
{
	NSLocale *myLocale = [NSLocale currentLocale];
	NSString *loalisedCountryName = [myLocale displayNameForKey:NSLocaleCountryCode value:countryCode];
	return loalisedCountryName;
}


#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0) {
		return 1;
	}
	else {
		return [self.countries count];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"cellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	
	if (indexPath.section == 0) {
		cell.textLabel.text = NSLocalizedString(@"Stores nearby", @"Stores Nearby");
	}
	else {
		NSString *countryCode = [self.countries objectAtIndex:indexPath.row];
		cell.textLabel.text = [self countryNameWithCode:countryCode];
	}
	return cell;
}


#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.section == 0) {
		StoresNearbyViewController *storesNearbyViewController = [[StoresNearbyViewController alloc] init];
		[storesNearbyViewController setTitle:NSLocalizedString(@"Stores nearby", @"Stores Nearby")];
		[self.navigationController pushViewController:storesNearbyViewController animated:YES];
	}
	else {
		CitiesViewController *citiesViewController = [[CitiesViewController alloc] init];
		
		NSString *predicateString = [NSString stringWithFormat:@"%@ like \"%@\"", kCountryKey, [self.countries objectAtIndex:indexPath.row]];
		NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
		NSArray *filteredArray = [NSArray arrayWithArray:[self.stores filteredArrayUsingPredicate:predicate]];
		[citiesViewController setStores:filteredArray];
	
		[citiesViewController setTitle:[self countryNameWithCode:[self.countries objectAtIndex:indexPath.row]]];
		[self.navigationController pushViewController:citiesViewController animated:YES];
	}
}


@end
