//
//  StoresByCityViewController.m
//  LamStoreLocator
//
//  Created by benjamin payen on 12/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import "StoresByCityViewController.h"
#import "StoresByCityTableViewCell.h"
#import "StoreViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import <Parse/Parse.h>


@interface StoresByCityViewController ()
@end

@implementation StoresByCityViewController

@synthesize storesByCityTableView = _storesByCityTableView;


#pragma mark - Init

- (id) init
{
	if (self) {
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
			self = [self initWithNibName:@"StoresByCityViewController_iPhone" bundle:nil];
		}
		else {
			self = [self initWithNibName:@"StoresByCityViewController_iPad" bundle:nil];
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
		[self.storesByCityTableView registerNib:[UINib nibWithNibName:@"StoresByCityTableViewCell_iPhone" bundle:nil] forCellReuseIdentifier:@"storesCellIdentifier"];
	}
	else {
		[self.storesByCityTableView registerNib:[UINib nibWithNibName:@"StoresByCityTableViewCell_iPad" bundle:nil] forCellReuseIdentifier:@"storesCellIdentifier"];
	}

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
	[self setStoresByCityTableView:nil];
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
		return 120;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.stores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"storesCellIdentifier";
	
	StoresByCityTableViewCell *cell = (StoresByCityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	cell.nameLabel.text = [[self.stores objectAtIndex:indexPath.row] valueForKeyPath:kNameKey];
	cell.phoneLabel.text = [[self.stores objectAtIndex:indexPath.row] valueForKeyPath:kPhoneKey];
	cell.adressLabel1.text = [[self.stores objectAtIndex:indexPath.row] valueForKeyPath:kAddLine1Key];
	cell.adressLabel2.text = [[self.stores objectAtIndex:indexPath.row] valueForKeyPath:kAddLine2Key];
		
	PFFile *pictoFile = [[self.stores objectAtIndex:indexPath.row] valueForKey:kPictoKey];
    [cell.imageView setImageWithURL:[NSURL URLWithString:[pictoFile url]] placeholderImage:[UIImage imageNamed:kPlaceholderCellFileName]];
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
