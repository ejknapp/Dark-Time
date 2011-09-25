//
//  DCClockState.h
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/2/11.
//  Copyright 2011 Dovetail Computing, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DCClockState : NSObject

@property (nonatomic, retain) UIColor *displayBackgroundColor;
@property (nonatomic, retain) UIColor *timeTextColor;
@property (nonatomic, retain) UIColor *savedColorForClock;
@property (nonatomic, retain) NSCalendar *calendar;
@property (nonatomic, assign) CGFloat clockBrightnessLevel;

@property (nonatomic, retain) NSDateFormatter *formatter;
@property (nonatomic, retain) NSDate *previousNow;
@property (nonatomic, assign) BOOL displaySeconds;
@property (nonatomic, assign) BOOL savedDisplaySeconds;
@property (nonatomic, assign) BOOL displayAmPm;
@property (nonatomic, assign) BOOL savedDisplayAmPm;
@property (nonatomic, assign) BOOL suspendSleep;
@property (nonatomic, retain) UIFont *currentFont;
@property (nonatomic, retain) NSString *currentFontName;
@property (nonatomic, assign) NSUInteger currentFontIndex;
@property (nonatomic, retain) NSArray *fontChoices;
@property (nonatomic, assign, getter = isFontEditorDisplayed) BOOL fontEditorDisplayed;
@property (nonatomic, assign) CGPoint startingDragLocation;
@property (nonatomic, assign, getter = isInfoPageViewDisplayed) BOOL infoPageViewDisplayed;
@property (nonatomic, assign) NSString *version;
@property (nonatomic, assign) NSInteger displayLabelY;
@property (nonatomic, assign) CGPoint displayCenter;

@property (nonatomic, retain) NSArray *fontNames;

-(void)loadClockState;
-(void)saveClockState;

-(NSString *)currentTimeString;
-(NSString *)currentSecondsString;
-(NSString *)currentAmPmString;

-(void)changeFontWithFontIndex:(NSInteger)index viewWidth:(CGFloat)width;
-(void)changeFontWithName:(NSString *)fontName;

@end
