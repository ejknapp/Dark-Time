//
//  DCSettingsTableViewController.h
//  DarkTime
//
//  Created by Eric Knapp on 9/23/11.
//  Copyright 2011 Dovetail Computing, Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCClockState;
@class DCDarkClockViewController;

@interface DCSettingsTableViewController : UITableViewController

@property (nonatomic, strong) DCClockState *clockState;
@property (nonatomic, weak) DCDarkClockViewController *clockViewController;

-(void)updateFontCellDisplay;

@end
