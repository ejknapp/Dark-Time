//
//  DarkTimeAppDelegate.m
//  DarkTime
//
//  Created by Eric Knapp on 9/20/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DarkTimeAppDelegate.h"
#import "DCDarkClockViewController.h"
#import "DCClockState.h"

@interface DarkTimeAppDelegate()

-(void)firstTime;

@end

@implementation DarkTimeAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize clockState = _clockState;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DCClockState *state = [[DCClockState alloc] init];
    self.clockState = state;
    self.viewController.clockState = self.clockState;
    [self.clockState loadClockState];
    [state release];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];    
    [[UIApplication sharedApplication] setIdleTimerDisabled:self.clockState.suspendSleep];


    [self.window addSubview:self.viewController.view];
    [self.window makeKeyAndVisible];
    
    [self firstTime];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    
    [self.clockState saveClockState];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
    [self.clockState saveClockState];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];    
    [[UIApplication sharedApplication] setIdleTimerDisabled:self.clockState.suspendSleep];
    
    [self.clockState loadClockState];

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];    
    [[UIApplication sharedApplication] setIdleTimerDisabled:self.clockState.suspendSleep];
    
    [self.clockState loadClockState];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    [self.clockState saveClockState];

}

-(void)firstTime
{
    DCClockState *clockState = self.clockState;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL firstTimeFlag = [defaults boolForKey:@"firstTimeFlag"];
    NSString *defaultsVersion = [defaults stringForKey:@"DarkTime_version"];
    NSString *appVersion = clockState.version;
    
    if (!firstTimeFlag || ![defaultsVersion isEqualToString:appVersion]) {
        
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"Be Careful!" 
                              message:@"Dark Time prevents your device from going to sleep. It should not be used for long periods of time without being plugged in to a power source." 
                              delegate:self 
                              cancelButtonTitle:@"OK, I'll be Careful" 
                              otherButtonTitles:nil, nil];
        
        [alert show];
        
        [alert release];
        
        [defaults setBool:YES forKey:@"firstTimeFlag"];
        [defaults setObject:appVersion forKey:@"DarkTime_version"];
    }
}


- (void)dealloc
{
    [_clockState release];
    [_viewController release];
    
    [_window release];
    [super dealloc];
}

@end
