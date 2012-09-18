//
//  AppDelegate.h
//  LamStoreLocator
//
//  Created by benjamin payen on 11/09/12.
//  Copyright (c) 2012 L'atelier du mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class CountriesViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CountriesViewController *viewController;

@end
