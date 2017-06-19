//
//  DCFontSelectTableViewController.h
//  DarkTime
//
//  Created by Eric Knapp on 9/24/11.
//  Copyright 2011 Dovetail Computing, Inc.. All rights reserved.
//

@import UIKit;

@class DCClockState;
@class DCDarkClockViewController;


@interface DCFontSelectTableViewController : UITableViewController

@property (nonatomic, strong) DCClockState *clockState;
@property (nonatomic, strong) UITableViewCell *currentCheckedCell;
@property (nonatomic, weak) DCDarkClockViewController *clockViewController;


@end
