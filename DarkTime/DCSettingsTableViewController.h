//
//  DCSettingsTableViewController.h
//  DarkTime
//
//  Created by Eric Knapp on 9/23/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCClockState;

@interface DCSettingsTableViewController : UITableViewController

@property (nonatomic, retain) DCClockState *clockState;

-(void)updateFontCellDisplay;

@end
