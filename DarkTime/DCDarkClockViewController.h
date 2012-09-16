//
//  DCDarkClockViewController.h
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/1/11.
//  Copyright 2011 Dovetail Computing, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DCClockState;
@class DCSettingsViewController;
@class DCInfoViewController;
@class DCSettingsTableViewController;
@class DCIDashedDividerView;


@interface DCDarkClockViewController : UIViewController <UIGestureRecognizerDelegate> 

@property (nonatomic, weak) IBOutlet UIView *landscapeView;
@property (nonatomic, weak) IBOutlet UIView *portraitView;
@property (nonatomic, weak) IBOutlet DCIDashedDividerView *dottedLine;


@property (nonatomic, strong) DCClockState *clockState;
@property (nonatomic, strong) NSTimer *appTimer;

@property (nonatomic, strong) DCInfoViewController *infoController;
@property (nonatomic, strong) NSCalendar *calendar;

@property (nonatomic, weak) IBOutlet UILabel *timeLabelHoursPortrait;
@property (nonatomic, weak) IBOutlet UILabel *timeLabelMinutesPortrait;

@property (nonatomic, assign) NSUInteger savedSeconds;
@property (nonatomic, assign) CGFloat brightnessLevel;

@property (nonatomic, strong) DCSettingsTableViewController *settingsEditor;

@property (nonatomic, strong) UISwipeGestureRecognizer *brightnessSwipeRight;
@property (nonatomic, strong) UISwipeGestureRecognizer *brightnessSwipeUp;
@property (nonatomic, strong) UISwipeGestureRecognizer *brightnessSwipeLeft;
@property (nonatomic, strong) UISwipeGestureRecognizer *brightnessSwipeDown;

@property (nonatomic, assign) UIModalPresentationStyle modalStyle;
@property (nonatomic, strong) NSString *settingsViewNib;

-(void)changeDisplayBrightnessWithBrightness:(CGFloat)brightness;
-(void)updateClock;
-(void)updateDisplayFontWithFontSize:(NSInteger)fontSize;
-(void)updateDisplayFont;
-(void)updateClockDisplayColorWithBrightness:(CGFloat)brightness;
-(void)switchToOrientationView:(UIInterfaceOrientation)interfaceOrientation;
- (void)adjustHourMinuteLabelsForScreenHeight;
-(void)adjustDashedLiveViewForScreenHeight;


@end
