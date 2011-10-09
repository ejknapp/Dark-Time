//
//  DCSettingsViewController.h
//  DarkTime
//
//  Created by Eric Knapp on 9/23/11.
//  Copyright 2011 Eric Knapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCClockState;
@class DCSettingsTableViewController;
@class DCInfoViewController;
@class DCDarkClockViewController;

@interface DCSettingsViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) DCClockState *clockState;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController;
@property (nonatomic, strong) DCSettingsTableViewController *settingsTableViewController;
@property (nonatomic, strong) DCInfoViewController *infoController;

@property (nonatomic, weak) DCDarkClockViewController *clockViewController;

-(DCSettingsTableViewController *)createTableViewController;
-(void)updateFontCellDisplay;

-(void)displayInfoPage;

@end
