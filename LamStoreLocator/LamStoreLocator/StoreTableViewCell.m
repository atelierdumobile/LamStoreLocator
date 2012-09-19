//
//  StoreTableViewCell.m
//  LamStoreLocator
//
//  Created by benjamin payen on 12/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import "StoreTableViewCell.h"


@implementation StoreTableViewCell

@synthesize pictoImageView = _pictoImageView;
@synthesize nameLabel = _nameLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize adressLabel1 = _adressLabel1;
@synthesize adressLabel2 = _adressLabel2;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		self.imageView.frame = CGRectMake(4, 4, 94, 67);
	} else {
		self.imageView.frame = CGRectMake(10, 10, 141, 100);
	}
}

@end
