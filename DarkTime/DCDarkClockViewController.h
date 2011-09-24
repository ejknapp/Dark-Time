//
//  DCDarkClockViewController.h
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/1/11.
//  Copyright 2011 Dovetail Computing, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DCClockState;
@class DCNewClockEditorViewController;

@interface DCDarkClockViewController : UIViewController <UIGestureRecognizerDelegate, UIScrollViewDelegate> 

@property (nonatomic, retain) DCClockState *clockState;
@property (nonatomic, retain) NSTimer *appTimer;

@property (nonatomic, retain) NSCalendar *calendar;

@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *ampmLabel;
@property (nonatomic, retain) IBOutlet UILabel *secondsLabel;
@property (nonatomic, retain) UIPanGestureRecognizer *brightnessPanRecognizer;
@property (nonatomic, retain) UITapGestureRecognizer *brightnessTapRecognizer;
@property (nonatomic, assign) NSUInteger savedSeconds;
@property (nonatomic, assign) CGFloat brightnessLevel;

@property (nonatomic, retain) IBOutlet UIButton *clockSettingsButton;
@property (nonatomic, retain) UIButton *editorModeDoneButton;

@property (nonatomic, retain) DCNewClockEditorViewController *fontEditor;

@property (nonatomic, assign) CGPoint startingOrigin;

-(void)changeDisplayBrightnessWithBrightness:(CGFloat)brightness;
-(void)updateClock;

@end
