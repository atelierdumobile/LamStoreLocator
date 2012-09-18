//
//  StoresViewController.m
//  LamStoreLocator
//
//  Created by benjamin payen on 12/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import "StoresViewController.h"
#import "StoreTableViewCell.h"
#import "StoreViewController.h"

#import <Parse/Parse.h>

@interface StoresViewController ()
@end

@implementation StoresViewController

@synthesize storesTableView = _storesTableView;


#pragma mark - Init

- (id) init
{
	if (self) {
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
			self = [self initWithNibName:@"StoresViewController_iPhone" bundle:nil];
		}
		else {
			self = [self initWithNibName:@"StoresViewController_iPad" bundle:nil];
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
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		[self.storesTableView registerNib:[UINib nibWithNibName:@"StoreTableViewCell_iPhone" bundle:nil] forCellReuseIdentifier:@"MyIdentifier"];
	} else {
		[self.storesTableView registerNib:[UINib nibWithNibName:@"StoreTableViewCell_iPad" bundle:nil] forCellReuseIdentifier:@"MyIdentifier"];
	}

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
	[self setStoresTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - UITableViewDataSource methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		return 75;
	} else {
		return 100;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.stores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"MyIdentifier";
	
	StoreTableViewCell *cell = (StoreTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	cell.nameLabel.text = [[self.stores objectAtIndex:indexPath.row] valueForKeyPath:@"name"];
	cell.phoneLabel.text = [[self.stores objectAtIndex:indexPath.row] valueForKeyPath:@"phone"];
	cell.adressLabel1.text = [[self.stores objectAtIndex:indexPath.row] valueForKeyPath:@"addLine1"];
	cell.adressLabel2.text = [[self.stores objectAtIndex:indexPath.row] valueForKeyPath:@"addLine2"];
	
	PFFile *pictoFile = [[self.stores objectAtIndex:indexPath.row] valueForKey:@"picto"];
	if (nil == cell.pictoImageView) {
		cell.pictoImageView = [[PFImageView alloc] init];
	}
	[cell.pictoImageView setFile:pictoFile];
	[cell.pictoImageView loadInBackground];
	
	return cell;
}


#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	StoreViewController *storeViewController = [[StoreViewController alloc] init];
	[storeViewController setStore:[self.stores objectAtIndex:indexPath.row]];
	[self.navigationController pushViewController:storeViewController animated:YES];
}


@end
