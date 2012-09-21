//
//  StoresByCityTableViewCell.h
//  LamStoreLocator
//
//  Created by benjamin payen on 12/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoresByCityTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *pictoImageView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *phoneLabel;
@property (nonatomic, strong) IBOutlet UILabel *adressLabel1;
@property (nonatomic, strong) IBOutlet UILabel *adressLabel2;

@end
