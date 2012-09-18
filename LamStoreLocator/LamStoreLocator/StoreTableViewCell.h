//
//  StoreTableViewCell.h
//  LamStoreLocator
//
//  Created by benjamin payen on 12/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface StoreTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet PFImageView *pictoImageView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *phoneLabel;
@property (nonatomic, strong) IBOutlet UILabel *adressLabel1;
@property (nonatomic, strong) IBOutlet UILabel *adressLabel2;

@end
