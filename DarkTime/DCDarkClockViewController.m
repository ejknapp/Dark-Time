//
//  DCDarkClockViewController.m
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/1/11.
//  Copyright 2011 Dovetail Computing, Inc. All rights reserved.
//

#import "DCDarkClockViewController.h"
#import "DCClockState.h"
#import "DCSettingsViewController.h"
#import "DCInfoViewController.h"


@interface DCDarkClockViewController ()



-(void)handleBrightnessDrag:(UIPanGestureRecognizer *)recognizer;
-(void)appBecomeActive;
-(void)appEnteredBackground;
-(IBAction)settingsButtonTapped:(id)sender;
-(void)updateDisplayFont;

@end


@implementation DCDarkClockViewController

@synthesize brightnessSwipeRight = _brightnessSwipeRight;
@synthesize brightnessSwipeLeft = _brightnessSwipeLeft;
@synthesize infoController = _infoController;

@synthesize clockState = _clockState;
@synthesize calendar = _calendar;
@synthesize appTimer = _appTimer;

@synthesize timeLabel = _timeLabel;
@synthesize ampmLabel = _ampmLabel;
@synthesize secondsLabel = _secondsLabel;
@synthesize brightnessPanRecognizer = _brightnessPanRecognizer;
@synthesize brightnessTapRecognizer = _brightnessTapRecognizer;
@synthesize savedSeconds = _savedSeconds;
@synthesize brightnessLevel = _brightnessLevel;
@synthesize clockSettingsButton = _clockSettingsButton;

@synthesize editorModeDoneButton = _editorModeDoneButton;

@synthesize fontEditor = _fontEditor;

@synthesize startingOrigin = _startingOrigin;



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    NSCalendar *newCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    self.calendar = newCalendar;
    [newCalendar release];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                      target:self
                                                    selector:@selector(updateClock)
                                                    userInfo:nil
                                                     repeats:YES];
    self.appTimer = timer;
    
   
    [self.clockState addObserver:self 
                      forKeyPath:@"currentFont" 
                         options:NSKeyValueObservingOptionNew
                         context:NULL];
    
     [self.clockState addObserver:self 
                      forKeyPath:@"fontEditorDisplayed" 
                         options:NSKeyValueObservingOptionNew
                         context:NULL];

    [self.clockState addObserver:self 
                      forKeyPath:@"infoPageViewDisplayed" 
                         options:NSKeyValueObservingOptionNew
                         context:NULL];

    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    [self.clockState changeFontWithFontIndex:self.clockState.currentFontIndex viewWidth:screenRect.size.height];

    [self updateDisplayFont];
    
}


-(void)updateDisplayFont
{

}

-(void)handleBrightnessSwipeRight:(UISwipeGestureRecognizer *)recognizer
{
    
    if (self.clockState.fontEditorDisplayed) {
        return;
    }
    
    CGFloat currentBrightness;
    currentBrightness = self.clockState.clockBrightnessLevel;
    
    CGFloat brightness = currentBrightness + 0.1;
    if (brightness > 1.0) {
        brightness = 1.0;
    } else if (brightness < 0.15) {
        brightness = 0.15;
    }
    
    [self changeDisplayBrightnessWithBrightness:brightness];
}

-(void)handleBrightnessSwipeLeft:(UISwipeGestureRecognizer *)recognizer
{
    

    if (self.clockState.fontEditorDisplayed) {
        return;
    }
    
    CGFloat currentBrightness = self.clockState.clockBrightnessLevel;
    
    CGFloat brightness = currentBrightness - 0.1;
    if (brightness > 1.0) {
        brightness = 1.0;
    } else if (brightness < 0.15) {
        brightness = 0.1;
    }
    
    [self changeDisplayBrightnessWithBrightness:brightness];
}




- (void)viewDidUnload
{
    [self setTimeLabel:nil];
    [self setAmpmLabel:nil];
    [self setSecondsLabel:nil];
    [self setClockSettingsButton:nil];

    
    self.calendar = nil;
    self.brightnessPanRecognizer = nil;
    self.editorModeDoneButton = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft 
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - View Gesture methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer 
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)handleBrightnessDrag:(UIPanGestureRecognizer *)recognizer
{
    
}


-(void)changeDisplayBrightnessWithBrightness:(CGFloat)brightness
{
    
    self.brightnessLevel = brightness;
    self.timeLabel.alpha = brightness;
    self.ampmLabel.alpha = brightness;
    self.secondsLabel.alpha = brightness;
    self.clockSettingsButton.alpha = brightness;
    self.clockState.clockBrightnessLevel = brightness;
    
}

#pragma mark - Clock Methods


- (void)updateClock
{
    
    NSDate* now = [NSDate date];
    int second = [[self.calendar components:NSSecondCalendarUnit fromDate:now] second];
    
    if (second == self.savedSeconds) {
        return;
    }
    
    self.savedSeconds = second;
    
    self.timeLabel.text = [self.clockState currentTimeString];
    //self.timeLabel.text = @"8:58";
    
    self.secondsLabel.text = [self.clockState currentSecondsString];
    
    self.ampmLabel.text = [self.clockState currentAmPmString];
    
    
    
    //❋ ☸  U+2699⚙
    
}

-(void)appBecomeActive
{
    
}

-(void)appEnteredBackground
{
    
}

-(IBAction)settingsButtonTapped:(id)sender
{
    NSLog(@"this should not get called");
}



- (void)dealloc
{
    [_clockState release];
    [_timeLabel release];
    [_ampmLabel release];
    [_secondsLabel release];
    [_brightnessPanRecognizer release];
    [_clockSettingsButton release];
    [_editorModeDoneButton release];

    
    [super dealloc];
}




@end
