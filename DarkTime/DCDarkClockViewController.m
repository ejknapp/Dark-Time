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
#import "DCClockConstants.h"


@interface DCDarkClockViewController ()

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
@synthesize clockSettingsButton = _clockSettingsButton;

@synthesize timeLabelHoursPortrait = _timeLabelHoursPortrait;
@synthesize timeLabelMinutesPortrait = _timeLabelMinutesPortrait;
@synthesize ampmLabelPortrait = _ampmLabelPortrait;
@synthesize secondsLabelPortrait = _secondsLabelPortrait;
@synthesize clockSettingsButtonPortrait = _clockSettingsButtonPortrait;

@synthesize landscapeView = _landscapeView;
@synthesize portraitView = _portraitView;

@synthesize savedSeconds = _savedSeconds;
@synthesize brightnessLevel = _brightnessLevel;


@synthesize fontEditor = _fontEditor;

@synthesize modalStyle = _modalStyle;
@synthesize settingsViewNib = _settingsViewNib;

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
 
    self.clockState.currentOrientation = UIInterfaceOrientationPortrait;
    
    self.timeLabelHoursPortrait.text = @"";
    self.timeLabelMinutesPortrait.text = @"";
    self.ampmLabelPortrait.text = @"";
    self.secondsLabelPortrait.text = @"";
    
    self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    
    self.appTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                      target:self
                                                    selector:@selector(updateClock)
                                                    userInfo:nil
                                                     repeats:YES];
    
    self.brightnessSwipeRight = 
        [[UISwipeGestureRecognizer alloc] 
         initWithTarget:self 
         action:@selector(handleBrightnessSwipeRight:)];
    
    self.brightnessSwipeRight.numberOfTouchesRequired = 1;
    self.brightnessSwipeRight.direction = UISwipeGestureRecognizerDirectionRight 
            | UISwipeGestureRecognizerDirectionUp;
    
    [self.view addGestureRecognizer:self.brightnessSwipeRight];
    
    self.brightnessSwipeLeft = 
        [[UISwipeGestureRecognizer alloc] 
         initWithTarget:self 
         action:@selector(handleBrightnessSwipeLeft:)];
    
    self.brightnessSwipeLeft.numberOfTouchesRequired = 1;
    self.brightnessSwipeLeft.direction = UISwipeGestureRecognizerDirectionLeft 
            | UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:self.brightnessSwipeLeft];

    
   
    [self.clockState addObserver:self 
                      forKeyPath:@"currentFont" 
                         options:NSKeyValueObservingOptionNew
                         context:NULL];
    
//    NSLog(@"current font index %d", self.clockState.currentFontIndex);
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    [self.clockState changeFontWithFontIndex:self.clockState.currentFontIndex 
                                   viewWidth:screenRect.size.height];
    

//    [self updateDisplayFont];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context
{
    
    if ([keyPath isEqualToString:@"currentFont"]) {
        [self updateDisplayFont];
        
        if (self.fontEditor) {
            [self.fontEditor updateFontCellDisplay];
        }
    } 
    
//    NSLog(@"about to call updateDisplayFont");
    [self updateDisplayFont];
    
}


-(void)handleBrightnessSwipeRight:(UISwipeGestureRecognizer *)recognizer
{
    
    if (self.clockState.fontEditorDisplayed) {
        return;
    }
    
    CGFloat currentBrightness;
    currentBrightness = self.clockState.clockBrightnessLevel;
    
    CGFloat brightness = currentBrightness + 0.05;
    if (brightness > 1.0) {
        brightness = 1.0;
    } else if (brightness <= 0.0) {
        brightness = DCMinimumScreenBrightness;
    }
    
    [UIScreen mainScreen].brightness = brightness;

    self.clockState.clockBrightnessLevel = brightness;
    [self updateClockDisplayColorWithBrightness:brightness];
    
    [[NSUserDefaults standardUserDefaults] setFloat:brightness forKey:@"clockBrightnessLevel"];

}

-(void)handleBrightnessSwipeLeft:(UISwipeGestureRecognizer *)recognizer
{

    if (self.clockState.fontEditorDisplayed) {
        return;
    }
    
    CGFloat currentBrightness = self.clockState.clockBrightnessLevel;
    
    CGFloat brightness = currentBrightness - 0.05;
    if (brightness > 1.0) {
        brightness = 1.0;
    } else if (brightness <= DCMinimumScreenBrightness) {
        brightness = DCMinimumScreenBrightness;
    }

    [UIScreen mainScreen].brightness = brightness;

    self.clockState.clockBrightnessLevel = brightness;
    [self updateClockDisplayColorWithBrightness:brightness];
    [[NSUserDefaults standardUserDefaults] setFloat:brightness forKey:@"clockBrightnessLevel"];

}

- (IBAction)settingsButtonTapped:(id)sender 
{
    
    self.fontEditor = [[DCSettingsViewController alloc] 
                                        initWithNibName:self.settingsViewNib
                                        bundle:nil];
    self.fontEditor.clockViewController = self;
    self.fontEditor.modalPresentationStyle = self.modalStyle;
    self.fontEditor.clockState = self.clockState;

    [self presentModalViewController:self.fontEditor animated:YES];


}

- (void)dismissModalViewControllerAnimated:(BOOL)animated
{
    
    NSLog(@"In super dismiss");
    
    [self.fontEditor dismissModalViewControllerAnimated:YES];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    [self.fontEditor.infoController.infoWebView loadHTMLString:@"" baseURL:nil];
    self.fontEditor = nil;
}

-(void)updateDisplayFontWithFontSize:(NSInteger)fontSize
{
//    NSLog(@"In updateDisplayFontWithFontSize");
    self.timeLabel.font = self.clockState.currentFont;
    self.timeLabelHoursPortrait.font = self.clockState.currentFont;
    self.timeLabelMinutesPortrait.font = self.clockState.currentFont;
    
    self.ampmLabel.font = [self.clockState.currentFont fontWithSize:fontSize];
    self.ampmLabelPortrait.font = [self.clockState.currentFont fontWithSize:fontSize];
    
    self.secondsLabel.font = [self.clockState.currentFont fontWithSize:fontSize];
    self.secondsLabelPortrait.font = [self.clockState.currentFont fontWithSize:fontSize];
        
}

-(void)updateDisplayFont
{
    
}

-(void)updateClockDisplayColorWithBrightness:(CGFloat)brightness
{
    CGFloat redFactor;
    UIColor *color;
    
    if (brightness <= 0.6) {
        redFactor = brightness + 0.3;
    } else {
        redFactor = 1.0;
    }

    color = [UIColor colorWithRed:redFactor green:0.0 blue:0.0 alpha:1.0];
    self.timeLabel.textColor = color;
    self.ampmLabel.textColor = color;
    self.secondsLabel.textColor = color;
    self.clockSettingsButton.alpha = redFactor + 0.2;
}

- (void)viewDidUnload
{
    [self setTimeLabel:nil];
    [self setAmpmLabel:nil];
    [self setSecondsLabel:nil];
    
    self.calendar = nil;
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft 
//            || interfaceOrientation == UIInterfaceOrientationLandscapeRight);

    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
                                         duration:(NSTimeInterval)duration
{
    self.clockState.currentOrientation = interfaceOrientation;
    
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        [self.view bringSubviewToFront:self.portraitView];
    } else {
        [self.view bringSubviewToFront:self.landscapeView];
    }

}

#pragma mark - View Gesture methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer 
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


-(void)changeDisplayBrightnessWithBrightness:(CGFloat)brightness
{

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
    
    if (self.clockState.currentOrientation == UIInterfaceOrientationLandscapeLeft 
            || self.clockState.currentOrientation == UIInterfaceOrientationLandscapeRight) {
        self.timeLabel.text = [self.clockState currentTimeString];
        
        self.secondsLabel.text = [self.clockState currentSecondsString];
        
        self.ampmLabel.text = [self.clockState currentAmPmString];
    } else {
        self.timeLabelHoursPortrait.text = [self.clockState currentHourString];
        
        self.timeLabelMinutesPortrait.text = [self.clockState currentMinutesString];
        
        self.secondsLabelPortrait.text = [self.clockState currentSecondsString];
        
        self.ampmLabelPortrait.text = [self.clockState currentAmPmString];
    }
    
    
    
        
}






@end
