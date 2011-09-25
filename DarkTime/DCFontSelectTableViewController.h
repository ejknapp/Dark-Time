//
//  DCFontSelectTableViewController.h
//  DarkTime
//
//  Created by Eric Knapp on 9/24/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCClockState;

@interface DCFontSelectTableViewController : UITableViewController

@property (nonatomic, retain) DCClockState *clockState;
@property (nonatomic, retain) UITableViewCell *currentCheckedCell;


@end
