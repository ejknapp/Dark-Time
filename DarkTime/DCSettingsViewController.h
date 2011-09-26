//
//  DCSettingsViewController.h
//  DarkTime
//
//  Created by Eric Knapp on 9/23/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCClockState;
@class DCSettingsTableViewController;

@interface DCSettingsViewController : UIViewController 

@property (nonatomic, retain) DCClockState *clockState;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) DCSettingsTableViewController *settingsTableViewController;

-(DCSettingsTableViewController *)createTableViewController;
-(void)updateFontCellDisplay;

@end
