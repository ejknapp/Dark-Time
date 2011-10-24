//
//  DarkTimeAppDelegate.m
//  DarkTime
//
//  Created by Eric Knapp on 9/20/11.
//  Copyright 2011 Dovetail Computing, Inc.. All rights reserved.
//

#import "DarkTimeAppDelegate.h"
#import "DCDarkClockViewController.h"
#import "DCClockState.h"
#import "DCDarkClockViewController.h"

@interface DarkTimeAppDelegate()

@property (nonatomic, assign) CGFloat savedScreenBrightness;
@property (nonatomic, assign) BOOL savedScreenWantsSoftwareDimming;

-(void)firstTime;


@end

@implementation DarkTimeAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize clockState = _clockState;
@synthesize savedScreenBrightness = _savedScreenBrightness;
@synthesize savedScreenWantsSoftwareDimming = _savedScreenWantsSoftwareDimming;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.clockState = [[DCClockState alloc] init];
    self.viewController.clockState = self.clockState;
        
    UIScreen *screen = [UIScreen mainScreen];    
    screen.wantsSoftwareDimming = NO;

    self.window.rootViewController = self.viewController;
    
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
     Sent when the application is about to move from active to inactive state. This can occur 
     for certain types of temporary interruptions (such as an incoming phone call or SMS message) 
     or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. 
     Games should use this method to pause the game.
     */
    
    
    [[NSUserDefaults standardUserDefaults] setFloat:self.clockState.clockBrightnessLevel 
                                             forKey:@"clockBrightnessLevel"];
    
    NSLog(@"applicationWillResignActive before %f", [UIScreen mainScreen].brightness);
    
    [UIScreen mainScreen].brightness = [[NSUserDefaults standardUserDefaults]
                                        floatForKey:@"savedSystemBrightness"];
    
    [self.clockState saveClockState];

    NSLog(@"applicationWillResignActive after %f", [UIScreen mainScreen].brightness);
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store 
     enough application state information to restore your application to its current state in 
     case it is terminated later. 
     If your application supports background execution, this method is called instead of 
     applicationWillTerminate: when the user quits.
     */
    

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo 
     many of the changes made on entering the background.
     */
    

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. 
     If the application was previously in the background, optionally refresh the user interface.
     */
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];    
    [[UIApplication sharedApplication] setIdleTimerDisabled:self.clockState.suspendSleep];
    
    [self.clockState loadClockState];

    NSLog(@"applicationDidBecomeActive before %f", [UIScreen mainScreen].brightness);
    [[NSUserDefaults standardUserDefaults] setFloat:[[UIScreen mainScreen] brightness]
                                             forKey:@"savedSystemBrightness"];
    
    [UIScreen mainScreen].brightness = [[NSUserDefaults standardUserDefaults]
                                        floatForKey:@"clockBrightnessLevel"];
    NSLog(@"applicationDidBecomeActive after %f", [UIScreen mainScreen].brightness);

    [self.viewController updateClockDisplayColorWithBrightness:[UIScreen mainScreen].brightness];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    

}


-(void)firstTime
{
    DCClockState *clockState = self.clockState;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL firstTimeFlag = [defaults boolForKey:@"firstTimeFlag"];
    NSString *defaultsVersion = [defaults stringForKey:@"DarkTime_version"];
    NSString *appVersion = clockState.version;
    
    if (!firstTimeFlag || ![defaultsVersion isEqualToString:appVersion]) {
        
        NSLog(@"firstTime before %f", [UIScreen mainScreen].brightness);
        
        [UIScreen mainScreen].brightness = 0.6;
        [[NSUserDefaults standardUserDefaults] setFloat:[[UIScreen mainScreen] brightness]
                                                 forKey:@"clockBrightnessLevel"];
        
        NSLog(@"firstTime after %f", [UIScreen mainScreen].brightness);
        
        [self.clockState saveClockState];
        
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"Be Careful!" 
                              message:@"Dark Time prevents your device from going to sleep. It should not be used for long periods of time without being plugged in to a power source." 
                              delegate:self 
                              cancelButtonTitle:@"OK, I'll be Careful" 
                              otherButtonTitles:nil, nil];
        
        [alert show];
        
        [defaults setBool:YES forKey:@"firstTimeFlag"];
        [defaults setObject:appVersion forKey:@"DarkTime_version"];
    }
}



@end
