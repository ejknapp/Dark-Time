//
//  DarkTimeAppDelegate.h
//  DarkTime
//
//  Created by Eric Knapp on 9/20/11.
//  Copyright 2011 Eric Knapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCDarkClockViewController;
@class DCClockState;

@interface DarkTimeAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DCDarkClockViewController *viewController;

@property (nonatomic, retain) DCClockState *clockState;

@end
