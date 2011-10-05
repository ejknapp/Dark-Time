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

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet DCDarkClockViewController *viewController;

@property (nonatomic, strong) DCClockState *clockState;

@end
