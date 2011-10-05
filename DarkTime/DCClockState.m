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

-(id)init
{
    
    self = [super init];
    
    if (self) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setTimeStyle:NSDateFormatterShortStyle];
        
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        _clockBrightnessLevel = 1.0;
        
        _displayAmPm = YES;
        _displaySeconds = YES;
        _suspendSleep = YES;
        _fontEditorDisplayed = NO;
        _infoPageViewDisplayed = NO;
        
        [self createFontsArray];
        
        _version = @"b7";
        
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
    
    self.currentFontName = [self.fontNames objectAtIndex:self.currentFontIndex];
    UIFont *newFont = [UIFont fontWithName:self.currentFontName size:500];

    CGFloat realFontSize;
    [@"8:88" sizeWithFont:newFont 
               minFontSize:24  
            actualFontSize:&realFontSize 
                  forWidth:width 
             lineBreakMode:UILineBreakModeWordWrap];
    
    self.currentFont = [newFont fontWithSize:realFontSize];
    
}

-(void)changeFontWithName:(NSString *)fontName
{
    
//    self.currentFont = [UIFont fontWithName:fontName size:500];
//    self.currentFontName = fontName;
//    self.displayLabelY = (375 - self.currentFont.ascender - 107) / 2;
}

-(void)createFontsArray 
{

    self.fontNames = [[NSArray alloc] initWithObjects:
                               @"Cochin-Bold",
                               @"Baskerville-Bold",
                               @"Palatino-Bold",
                               @"Verdana-Bold",
                               @"MarkerFelt-Wide",
                               @"Courier-Bold",
                               @"AmericanTypewriter-Bold",
                               @"Helvetica-Bold",
                               @"Futura-CondensedExtraBold",
                               @"TimesNewRomanPS-BoldMT",
                               @"TrebuchetMS-Bold",
                               @"SnellRoundhand-Bold",
                               nil];
    
    self.currentFontIndex = 8;
    [self changeFontWithFontIndex:self.currentFontIndex viewWidth:480];
}


-(NSString *)currentTimeString
{
    
    NSDate* now = [NSDate date];
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
    
//    return @"12:58";
//    return @"1:11";
    return timeString;

}

-(NSString *)currentSecondsString
{
    
    NSDate* now = [NSDate date];
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
    NSDate* now = [[NSDate alloc] init];
    
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
    
    CGFloat brightness = [userDefaults floatForKey:@"clockBrightnessLevel"];
    
    if (brightness) {
        if (brightness >= 0.1) {
            self.clockBrightnessLevel = brightness;
        } else {
            self.clockBrightnessLevel = 1.0;
        }
    } else {
        self.clockBrightnessLevel = 1.0;
    }
        
    
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
    
    [userDefaults setFloat:self.clockBrightnessLevel forKey:@"clockBrightnessLevel"];
    
    [userDefaults setBool:self.displayAmPm forKey:@"displayAmPm"];
    
    [userDefaults setBool:self.displaySeconds forKey:@"displaySeconds"];
    
    [userDefaults setBool:self.suspendSleep forKey:@"suspendSleep"];
    
}



@end
