//
//  CountriesViewController.h
//  LamStoreLocator
//
//  Created by benjamin payen on 11/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountriesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *countriesTableView;

@end
