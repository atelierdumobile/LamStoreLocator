//
//  StoreAnnotationView.m
//  LamStoreLocator
//
//  Created by benjamin on 19/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import "StorePinAnnotationView.h"

@implementation StorePinAnnotationView

@synthesize store = _store;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
	if (self != nil)
	{
//		UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 60)];
//		view.image = [UIImage imageNamed:@"bottle.png"];
//		[self addSubview:view];
	}
	return self;
}

- (void)setAnnotation:(id <MKAnnotation>)annotation {
	[super setAnnotation:annotation];
	// pour updater si besoin l’affichage lors que l’on utilise reuseIdentifier [self setNeedsDisplay];
}

@end
