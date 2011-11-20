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


@interface DCDarkClockViewController : UIViewController <UIGestureRecognizerDelegate> 

@property (nonatomic, strong) DCClockState *clockState;
@property (nonatomic, strong) NSTimer *appTimer;

@property (nonatomic, strong) DCInfoViewController *infoController;
@property (nonatomic, strong) NSCalendar *calendar;

@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *ampmLabel;
@property (nonatomic, strong) IBOutlet UILabel *secondsLabel;
@property (nonatomic, strong) IBOutlet UIButton *clockSettingsButton;

@property (nonatomic, strong) IBOutlet UILabel *timeLabelHoursPortrait;
@property (nonatomic, strong) IBOutlet UILabel *timeLabelMinutesPortrait;

@property (nonatomic, strong) IBOutlet UILabel *ampmLabelPortrait;
@property (nonatomic, strong) IBOutlet UILabel *secondsLabelPortrait;
@property (nonatomic, strong) IBOutlet UIButton *clockSettingsButtonPortrait;

@property (nonatomic, strong) IBOutlet UIView *landscapeView;
@property (nonatomic, strong) IBOutlet UIView *portraitView;

@property (nonatomic, assign) NSUInteger savedSeconds;
@property (nonatomic, assign) CGFloat brightnessLevel;

@property (nonatomic, strong) DCSettingsTableViewController *settingsEditor;

@property (nonatomic, strong) UISwipeGestureRecognizer *brightnessSwipeRight;
@property (nonatomic, strong) UISwipeGestureRecognizer *brightnessSwipeLeft;
@property (nonatomic, assign) UIModalPresentationStyle modalStyle;
@property (nonatomic, strong) NSString *settingsViewNib;


-(void)changeDisplayBrightnessWithBrightness:(CGFloat)brightness;
-(void)updateClock;
-(void)updateDisplayFontWithFontSize:(NSInteger)fontSize;
-(void)updateDisplayFont;
-(void)updateClockDisplayColorWithBrightness:(CGFloat)brightness;
-(void)switchToOrientationView:(UIInterfaceOrientation)interfaceOrientation;



@end
