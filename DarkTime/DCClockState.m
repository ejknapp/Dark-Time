//
//  DCClockState.m
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/2/11.
//  Copyright 2011 Dovetail Computing, Inc. All rights reserved.
//

#import "DCClockState.h"
#import "DCClockConstants.h"

@interface DCClockState ()

-(void)createFontsArray;
- (NSString *)applicationDocumentsDirectory;

@end


@implementation DCClockState

@synthesize displayBackgroundColor = _displayBackgroundColor;
@synthesize timeTextColor = _timeTextColor;
@synthesize savedColorForClock = _savedColorForClock;
@synthesize calendar = _calendar;
@synthesize clockBrightnessLevel = _clockBrightnessLevel;

@synthesize formatter = _formatter;
@synthesize previousNow = _previousNow;
@synthesize displaySeconds = _displaySeconds;
@synthesize savedDisplaySeconds = _savedDisplaySeconds;
@synthesize displayAmPm = _displayAmPm;
@synthesize savedDisplayAmPm = _savedDisplayAmPm;
@synthesize suspendSleep = _suspendSleep;
@synthesize screenWantsSoftwareDimming = _screenWantsSoftwareDimming;
@synthesize currentFont =_currentFont;
@synthesize currentFontName = _currentFontName;
@synthesize currentFontIndex = _currentFontIndex;
@synthesize fontChoices = _fontChoices;
@synthesize fontEditorDisplayed = _fontEditorDisplayed;
@synthesize startingDragLocation = _startingDragLocation;
@synthesize infoPageViewDisplayed = _infoPageViewDisplayed;
@synthesize version = _version;
@synthesize displayLabelY = _displayLabelY;
@synthesize displayCenter = _displayCenter;

@synthesize fontNames = _fontNames;
@synthesize currentOrientation = _currentOrientation;

@synthesize fontSizeLandscape = _fontSizeLandscape;
@synthesize fontSizePortrait = _fontSizePortrait;


-(id)init
{
    
    self = [super init];
    
    if (self) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setTimeStyle:NSDateFormatterShortStyle];
        
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        _clockBrightnessLevel = 0.6;
        
        _displayAmPm = YES;
        _displaySeconds = YES;
        _suspendSleep = YES;
        _fontEditorDisplayed = NO;
        _infoPageViewDisplayed = NO;
        
        [self createFontsArray];
        
        _version = @"1.0.1";
        
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

-(void)changeFontWithFontIndex:(NSInteger)index viewWidth:(CGFloat)width
{

    self.currentFontIndex = index;
    CGFloat fontSize;
    
    self.currentFontName = [self.fontNames objectAtIndex:self.currentFontIndex];
    
    if (UIInterfaceOrientationIsPortrait(self.currentOrientation)) {
        fontSize = self.fontSizePortrait;
    } else {
        fontSize = self.fontSizeLandscape;
    }
    self.currentFont = [UIFont fontWithName:self.currentFontName size:fontSize];
    
}

-(void)createFontsArray 
{

    NSString *fontFilePath = [[NSBundle mainBundle] pathForResource:@"fontNames" ofType:@"plist"];
    self.fontNames = [[NSArray alloc] initWithContentsOfFile:fontFilePath];

    self.currentFontIndex = DCInitialFontIndex;
    [self changeFontWithFontIndex:self.currentFontIndex viewWidth:480];
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
    
    timeString = [[NSString alloc] initWithFormat:@"%d:%02d", displayHour, minute];
    
    return timeString;
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
    
    hourString = [[NSString alloc] initWithFormat:@"%d", displayHour];
    
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
    
    NSInteger fontIndex = [userDefaults integerForKey:@"currentFontIndex"];
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
        
    if (fontIndex >= 0) {
        [self changeFontWithFontIndex:fontIndex viewWidth:screenRect.size.height];
    } else {
        [self changeFontWithFontIndex:8 viewWidth:screenRect.size.height];
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
    
    [userDefaults setInteger:self.currentFontIndex forKey:@"currentFontIndex"];
    
    [userDefaults setBool:self.displayAmPm forKey:@"displayAmPm"];
    
    [userDefaults setBool:self.displaySeconds forKey:@"displaySeconds"];
    
    [userDefaults setBool:self.suspendSleep forKey:@"suspendSleep"];

}


@end







