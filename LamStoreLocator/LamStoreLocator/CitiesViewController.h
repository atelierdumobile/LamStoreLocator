//
//  CitiesViewController.h
//  LamStoreLocator
//
//  Created by benjamin on 21/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitiesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *citiesTableView;
@property (nonatomic, strong) NSArray *stores;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@end
