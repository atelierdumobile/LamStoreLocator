//
//  StoreViewController.h
//  LamStoreLocator
//
//  Created by benjamin payen on 13/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StoreViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel1;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *pictoImageView;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (strong, nonatomic) NSArray *store;

- (IBAction)showOnMap;
- (IBAction)callTheStore;

@end
