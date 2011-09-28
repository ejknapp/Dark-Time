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
@class DCInfoViewController;

@interface DCSettingsViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain) DCClockState *clockState;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) DCSettingsTableViewController *settingsTableViewController;
@property (nonatomic, retain) DCInfoViewController *infoController;

-(DCSettingsTableViewController *)createTableViewController;
-(void)updateFontCellDisplay;

-(void)dismissInfoPage;
-(void)displayInfoPage;

@end
