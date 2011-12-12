//
//  DCClockState.h
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/2/11.
//  Copyright 2011 Dovetail Computing, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DCClockState : NSObject

@property (nonatomic, strong) UIColor *displayBackgroundColor;
@property (nonatomic, strong) UIColor *timeTextColor;
@property (nonatomic, strong) UIColor *savedColorForClock;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, assign) CGFloat clockBrightnessLevel;

@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSDate *previousNow;
@property (nonatomic, assign) BOOL displaySeconds;
@property (nonatomic, assign) BOOL savedDisplaySeconds;
@property (nonatomic, assign) BOOL displayAmPm;
@property (nonatomic, assign) BOOL savedDisplayAmPm;
@property (nonatomic, assign) BOOL suspendSleep;
@property (nonatomic, assign) BOOL screenWantsSoftwareDimming;
@property (nonatomic, strong) UIFont *currentFont;
@property (nonatomic, strong) NSString *currentFontName;
@property (nonatomic, assign) NSUInteger currentFontIndex;
@property (nonatomic, strong) NSArray *fontChoices;
@property (nonatomic, assign, getter = isFontEditorDisplayed) BOOL fontEditorDisplayed;
@property (nonatomic, assign) CGPoint startingDragLocation;
@property (nonatomic, assign, getter = isInfoPageViewDisplayed) BOOL infoPageViewDisplayed;
@property (nonatomic, weak) NSString *version;
@property (nonatomic, assign) NSInteger displayLabelY;
@property (nonatomic, assign) CGPoint displayCenter;

@property (nonatomic, strong) NSArray *fontNames;
@property (assign, nonatomic) UIInterfaceOrientation currentOrientation;

@property (nonatomic, assign) NSUInteger fontSizeLandscape;
@property (nonatomic, assign) NSUInteger fontSizePortrait;


-(void)loadClockState;
-(void)saveClockState;

-(NSString *)currentTimeString;
-(NSString *)currentHourString;
-(NSString *)currentMinutesString;
-(NSString *)currentSecondsString;
-(NSString *)currentAmPmString;

-(void)changeFontWithFontIndex:(NSInteger)index viewWidth:(CGFloat)width;


@end
