//
//  StoresViewController.h
//  LamStoreLocator
//
//  Created by benjamin payen on 12/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoresViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *storesTableView;
@property (nonatomic, strong) NSArray *stores;

@end
