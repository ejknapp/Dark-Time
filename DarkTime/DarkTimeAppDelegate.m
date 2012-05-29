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
#import "DCIWelcomeViewController.h"
#import "DCDarkClockViewController_iPad.h"
#import "DCDarkClockViewController_iPhone.h"

@interface DarkTimeAppDelegate()

@property (nonatomic, strong) DCClockState *clockState;
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
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[DCDarkClockViewController_iPhone alloc] 
                               initWithNibName:@"DCDarkClockViewController_iPhone" 
                               bundle:nil];
    } else {
        self.viewController = [[DCDarkClockViewController_iPad alloc] 
                               initWithNibName:@"DCDarkClockViewController_iPad" 
                               bundle:nil];
    }
    
    self.clockState = [[DCClockState alloc] init];
    self.viewController.clockState = self.clockState;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];    
    [[UIApplication sharedApplication] setIdleTimerDisabled:self.clockState.suspendSleep];

    UIScreen *screen = [UIScreen mainScreen];    
    screen.wantsSoftwareDimming = NO;

    self.window.rootViewController = self.viewController;
    
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
    
    
    [UIScreen mainScreen].brightness = [[NSUserDefaults standardUserDefaults]
                                        floatForKey:@"savedSystemBrightness"];
    
    [self.clockState saveClockState];

    
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

    [[NSUserDefaults standardUserDefaults] setFloat:[[UIScreen mainScreen] brightness]
                                             forKey:@"savedSystemBrightness"];
    
    [UIScreen mainScreen].brightness = [[NSUserDefaults standardUserDefaults]
                                        floatForKey:@"clockBrightnessLevel"];

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
        
        
        [UIScreen mainScreen].brightness = 0.6;
        [[NSUserDefaults standardUserDefaults] setFloat:[[UIScreen mainScreen] brightness]
                                                 forKey:@"clockBrightnessLevel"];

        [self.clockState saveClockState];
        
        DCIWelcomeViewController *welcomeController = [[DCIWelcomeViewController alloc] 
                                                       initWithNibName:@"DCIWelcomeViewController"
                                                       bundle:nil];
        welcomeController.mainController = self.viewController;
        
        UINavigationController *navigationController = [[UINavigationController alloc] 
                                                        initWithRootViewController:welcomeController];
        
        navigationController.navigationBar.barStyle = UIBarStyleBlack;
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                       target:welcomeController 
                                       action:@selector(doneButtonTapped)];
        
        
        welcomeController.navigationItem.leftBarButtonItem = doneButton;
        
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [self.viewController presentViewController:navigationController animated:YES completion:^{}];
        
        [defaults setBool:YES forKey:@"firstTimeFlag"];
        [defaults setObject:appVersion forKey:@"DarkTime_version"];
        
    }
}



@end
