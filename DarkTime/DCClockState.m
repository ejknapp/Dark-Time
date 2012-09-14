//
//  DCClockState.m
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/2/11.
//  Copyright 2011 Dovetail Computing, Inc. All rights reserved.
//

#import "DCClockState.h"
#import "DCClockConstants.h"
#import "DCIFontManager.h"

@interface DCClockState ()

@property (nonatomic, strong) UIColor *displayBackgroundColor;
@property (nonatomic, strong) UIColor *timeTextColor;
@property (nonatomic, strong) UIColor *savedColorForClock;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSDate *previousNow;
@property (nonatomic, assign) BOOL savedDisplaySeconds;
@property (nonatomic, assign) BOOL savedDisplayAmPm;
@property (nonatomic, assign) BOOL screenWantsSoftwareDimming;
@property (nonatomic, strong) NSArray *fontChoices;
@property (nonatomic, assign) CGPoint startingDragLocation;
@property (nonatomic, assign) NSInteger displayLabelY;
@property (nonatomic, assign) CGPoint displayCenter;
@property (nonatomic, strong) NSArray *fontNames;



-(void)createFontsArray;
- (NSString *)applicationDocumentsDirectory;

@end


@implementation DCClockState


-(id)init
{
    
    self = [super init];
    
    if (self) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setTimeStyle:NSDateFormatterShortStyle];
        
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        _clockBrightnessLevel = 0.6;
        _currentOrientation = UIInterfaceOrientationPortrait;
        
        _displayAmPm = YES;
        _displaySeconds = YES;
        _suspendSleep = YES;
        _fontEditorDisplayed = NO;
        _infoPageViewDisplayed = NO;
        
        [self createFontsArray];
        
        _version = @"1.1";
        
        [self addObserver:self 
               forKeyPath:@"suspendSleep" 
                  options:NSKeyValueObservingOptionNew
                  context:NULL];

        
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"suspendSleep"]) {
        [[UIApplication sharedApplication] setIdleTimerDisabled:self.suspendSleep];
    }
}

-(void)changeFontWithFontIndex:(NSInteger)index
{

    self.fontManager.currentFontIndex = index;
    CGFloat fontSize;

    if (UIInterfaceOrientationIsPortrait(self.currentOrientation)) {
        fontSize = self.fontSizePortrait;
    } else {
        fontSize = self.fontSizeLandscape;
    }
        
    self.fontManager.currentFont = [UIFont fontWithName:[self.fontManager fontNameAtIndex:self.fontManager.currentFontIndex] 
                                                   size:fontSize];
    
}

-(void)createFontsArray 
{
    self.fontManager = [[DCIFontManager alloc] init];
    self.fontManager.clockState = self;
    [self.fontManager loadFontDictionaries];

    self.fontManager.currentFontIndex = DCInitialFontIndex;
    [self changeFontWithFontIndex:DCInitialFontIndex];
    
}

- (NSString *)applicationDocumentsDirectory
{
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
     return basePath;
 }


-(NSString *)currentTimeString
{
    
    NSDate *now = [NSDate date];
    NSString *timeString;
    
    int hour = [[self.calendar components:NSHourCalendarUnit fromDate:now] hour];
    int minute = [[self.calendar components:NSMinuteCalendarUnit fromDate:now] minute];
    
    int displayHour = hour;
    
    
    if (hour > 12) {
        displayHour -= 12;
    }
    
    if (displayHour == 0) {
        displayHour = 12;
    }
    
    if (self.clockDisplayType == DCIClockDisplayType24Hour) {
        timeString = [NSString stringWithFormat:@"%02d:%02d", hour, minute];
    } else {
        timeString = [[NSString alloc] initWithFormat:@"%d:%02d", displayHour, minute];
    }
    
    return timeString;
//    return @"20:58";
}

-(NSString *)currentHourString
{
    NSDate *now = [NSDate date];
    NSString *hourString;
    
    int hour = [[self.calendar components:NSHourCalendarUnit fromDate:now] hour];

    int displayHour = hour;
    
    if (hour > 12) {
        displayHour -= 12;
    }
    
    if (displayHour == 0) {
        displayHour = 12;
    }
    
    if (self.clockDisplayType == DCIClockDisplayType24Hour) {
        hourString = [NSString stringWithFormat:@"%02d", hour];
    } else {
        hourString = [[NSString alloc] initWithFormat:@"%d", displayHour];
    }
    
    return hourString;
    
}

-(NSString *)currentMinutesString
{
    NSDate *now = [NSDate date];
    NSString *minutesString;

    int minute = [[self.calendar components:NSMinuteCalendarUnit fromDate:now] minute];

    minutesString = [[NSString alloc] initWithFormat:@"%02d", minute];
    
    return minutesString;

}

-(NSString *)currentSecondsString
{
    
    NSDate *now = [NSDate date];
    int second = [[self.calendar components:NSSecondCalendarUnit fromDate:now] second];
    
    NSString *secondsString;
    
    
    if (self.displaySeconds) {
        secondsString = [NSString stringWithFormat:@"%02d", second];
    } else {
        secondsString = [NSString stringWithFormat:@"%@", kNoSeconds];
    }
    
    return secondsString;

}

-(NSString *)currentAmPmString
{
    NSDate *now = [[NSDate alloc] init];
    
    int hour = [[self.calendar components:NSHourCalendarUnit fromDate:now] hour];
    
    if (self.displayAmPm) {
        if (hour < 12) {
            return kAmDisplay;
        } else {
            return kPmDisplay;
        }
    } else {
        return kAmPmNoDisplay;
    }
    
}


#pragma mark - User Settings methods

- (void)loadClockState
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
    [UIScreen mainScreen].wantsSoftwareDimming = self.screenWantsSoftwareDimming;
    
    NSInteger displayType = [userDefaults integerForKey:@"clockDisplayType"];
    
    if (displayType) {
        self.clockDisplayType = DCIClockDisplayType24Hour;
    } else {
        self.clockDisplayType = DCIClockDisplayType12Hour;
    }
    
    NSInteger fontIndex = [userDefaults integerForKey:@"currentFontIndex"];
            
    if (fontIndex >= 0) {
        [self changeFontWithFontIndex:fontIndex];
    } else {
        [self changeFontWithFontIndex:8];
    }
    
    BOOL ampm = [userDefaults boolForKey:@"displayAmPm"];
    
    if (ampm) {
        self.displayAmPm = YES;
    } else {
        self.displayAmPm = NO;
    }

    BOOL seconds = [userDefaults boolForKey:@"displaySeconds"];
    
    if (seconds) {
        self.displaySeconds = YES;
    } else {
        self.displaySeconds = NO;
    }

    BOOL sleep = [userDefaults boolForKey:@"suspendSleep"];
    
    if (sleep) {
        self.suspendSleep = YES;
    } else {
        self.suspendSleep = NO;
    }
}

- (void) saveClockState
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setInteger:self.clockDisplayType forKey:@"clockDisplayType"];

    [userDefaults setInteger:self.fontManager.currentFontIndex forKey:@"currentFontIndex"];
    
    [userDefaults setBool:self.displayAmPm forKey:@"displayAmPm"];
    
    [userDefaults setBool:self.displaySeconds forKey:@"displaySeconds"];
    
    [userDefaults setBool:self.suspendSleep forKey:@"suspendSleep"];

}


@end







