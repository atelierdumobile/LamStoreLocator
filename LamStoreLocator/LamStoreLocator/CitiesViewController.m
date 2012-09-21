//
//  StoresByCityViewController.m
//  LamStoreLocator
//
//  Created by benjamin on 21/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import "CitiesViewController.h"
#import "StoresByCityViewController.h"

@interface CitiesViewController ()

@property (nonatomic, strong) NSArray *cities;

@end

@implementation CitiesViewController


#pragma mark - Init

- (id)init
{
	if (self) {
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
			self = [self initWithNibName:@"CitiesViewController_iPhone" bundle:nil];
		}
		else {
			self = [self initWithNibName:@"CitiesViewController_iPad" bundle:nil];
		}
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.cities = [self.stores valueForKeyPath:[NSString stringWithFormat:@"@distinctUnionOfObjects.%@", kCityKey]];
}

- (void)viewDidUnload
{
	[self setCitiesTableView:nil];
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"cellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	
	cell.textLabel.text = [self.cities objectAtIndex:indexPath.row];

	return cell;
}


#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	StoresByCityViewController *storesByCityViewController = [[StoresByCityViewController alloc] init];
		
	NSString *predicateString = [NSString stringWithFormat:@"%@ like \"%@\"", kCityKey, [self.cities objectAtIndex:indexPath.row]];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	NSArray *filteredArray = [NSArray arrayWithArray:[self.stores filteredArrayUsingPredicate:predicate]];
	[storesByCityViewController setStores:filteredArray];
		
	[storesByCityViewController setTitle:[self.cities objectAtIndex:indexPath.row]];
	[self.navigationController pushViewController:storesByCityViewController animated:YES];
}


@end
