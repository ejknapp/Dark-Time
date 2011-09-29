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


@interface DCDarkClockViewController : UIViewController <UIGestureRecognizerDelegate> 

@property (nonatomic, retain) DCClockState *clockState;
@property (nonatomic, retain) NSTimer *appTimer;

@property (nonatomic, retain) DCInfoViewController *infoController;
@property (nonatomic, retain) NSCalendar *calendar;

@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *ampmLabel;
@property (nonatomic, retain) IBOutlet UILabel *secondsLabel;
@property (nonatomic, retain) IBOutlet UIButton *clockSettingsButton;


@property (nonatomic, assign) NSUInteger savedSeconds;
@property (nonatomic, assign) CGFloat brightnessLevel;

@property (nonatomic, retain) DCSettingsViewController *fontEditor;

@property (nonatomic, retain) UISwipeGestureRecognizer *brightnessSwipeRight;
@property (nonatomic, retain) UISwipeGestureRecognizer *brightnessSwipeLeft;
@property (nonatomic, assign) UIModalPresentationStyle modalStyle;
@property (nonatomic, retain) NSString *settingsViewNib;


-(void)changeDisplayBrightnessWithBrightness:(CGFloat)brightness;
-(void)updateClock;
-(void)updateDisplayFontWithFontSize:(NSInteger)fontSize;
-(void)updateDisplayFont;


@end
