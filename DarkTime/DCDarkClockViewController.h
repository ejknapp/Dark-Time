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

@property (nonatomic, strong) DCClockState *clockState;
@property (nonatomic, strong) NSTimer *appTimer;

@property (nonatomic, strong) DCInfoViewController *infoController;
@property (nonatomic, strong) NSCalendar *calendar;

@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *ampmLabel;
@property (nonatomic, strong) IBOutlet UILabel *secondsLabel;
@property (nonatomic, strong) IBOutlet UIButton *clockSettingsButton;


@property (nonatomic, assign) NSUInteger savedSeconds;
@property (nonatomic, assign) CGFloat brightnessLevel;

@property (nonatomic, strong) DCSettingsViewController *fontEditor;

@property (nonatomic, strong) UISwipeGestureRecognizer *brightnessSwipeRight;
@property (nonatomic, strong) UISwipeGestureRecognizer *brightnessSwipeLeft;
@property (nonatomic, assign) UIModalPresentationStyle modalStyle;
@property (nonatomic, strong) NSString *settingsViewNib;


-(void)changeDisplayBrightnessWithBrightness:(CGFloat)brightness;
-(void)updateClock;
-(void)updateDisplayFontWithFontSize:(NSInteger)fontSize;
-(void)updateDisplayFont;


@end
