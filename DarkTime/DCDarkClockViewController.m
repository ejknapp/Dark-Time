//
//  DCDarkClockViewController.m
//  DarkTimePhone
//
//  Created by Eric Knapp on 6/1/11.
//  Copyright 2011 Dovetail Computing, Inc. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "DCDarkClockViewController.h"
#import "DCClockState.h"
#import "DCSettingsViewController.h"
#import "DCInfoViewController.h"
#import "DCClockConstants.h"
#import "DCSettingsTableViewController.h"


@interface DCDarkClockViewController ()

@property (strong, nonatomic) UINavigationController *settingsNavController;
@property (assign, nonatomic) CGFloat buttonAlphaLandscape;
@property (assign, nonatomic) CGFloat dottedLineAlpha;

-(IBAction)settingsButtonTapped:(id)sender;
-(void)updateDisplayFont;
- (void)createLeftSwipeRecognizer;
- (void)createRightSwipeRecognizer;
- (void)createUpSwipeRecognizer;
- (void)createDownSwipeRecognizer;

-(void)handleBrightnessSwipeRight:(UISwipeGestureRecognizer *)recognizer;
-(void)handleBrightnessSwipeLeft:(UISwipeGestureRecognizer *)recognizer;
-(void)updateClockOnLaunch;

@end


@implementation DCDarkClockViewController

@synthesize settingsNavController = _settingsNavController;

@synthesize brightnessSwipeRight = _brightnessSwipeRight;
@synthesize brightnessSwipeUp = _brightnessSwipeUp;
@synthesize brightnessSwipeLeft = _brightnessSwipeLeft;
@synthesize brightnessSwipeDown = _brightnessSwipeDown;
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
@synthesize dottedLine = _dottedLine;

@synthesize landscapeView = _landscapeView;
@synthesize portraitView = _portraitView;

@synthesize savedSeconds = _savedSeconds;
@synthesize brightnessLevel = _brightnessLevel;


@synthesize settingsEditor = _settingsEditor;

@synthesize modalStyle = _modalStyle;
@synthesize settingsViewNib = _settingsViewNib;

@synthesize buttonAlphaLandscape = _buttonAlphaLandscape;
@synthesize dottedLineAlpha = _dottedLineAlpha;

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
    
    [self createRightSwipeRecognizer];
    [self createLeftSwipeRecognizer];
    [self createUpSwipeRecognizer];
    [self createDownSwipeRecognizer];
   
    [self.clockState addObserver:self 
                      forKeyPath:@"currentFont" 
                         options:NSKeyValueObservingOptionNew
                         context:NULL];
        
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];

    [self.clockState changeFontWithFontIndex:self.clockState.currentFontIndex 
                                   viewWidth:screenRect.size.height];
    
    [self updateClockOnLaunch];
    
}

- (void)viewDidUnload
{
    [self setTimeLabel:nil];
    [self setAmpmLabel:nil];
    [self setSecondsLabel:nil];
    
    self.calendar = nil;
    self.appTimer = nil;
    self.settingsEditor = nil;
    self.landscapeView = nil;
    self.portraitView = nil;
    self.ampmLabelPortrait = nil;
    self.timeLabelHoursPortrait = nil;
    self.timeLabelMinutesPortrait = nil;
    self.infoController = nil;
    self.clockSettingsButton = nil;
    self.secondsLabelPortrait = nil;
    self.clockSettingsButtonPortrait = nil;
    
    
    [super viewDidUnload];
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated
{
    
    [self.settingsEditor dismissModalViewControllerAnimated:YES];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    //    [self.settingsEditor.infoController.infoWebView loadHTMLString:@"" baseURL:nil];
    self.settingsEditor = nil;
    
//    [self switchToOrientationView:self.clockState.currentOrientation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
                                         duration:(NSTimeInterval)duration
{
    self.clockState.currentOrientation = interfaceOrientation;
        
    [self switchToOrientationView:self.clockState.currentOrientation];
    
    [self.view layoutIfNeeded];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context
{
    
    if ([keyPath isEqualToString:@"currentFont"]) {
        [self updateDisplayFont];
        
        if (self.settingsEditor) {
            [self.settingsEditor updateFontCellDisplay];
        }
    } 
    
    [self updateDisplayFont];
    
}

#pragma mark - Create Recognizer methods

- (void)createLeftSwipeRecognizer
{
    self.brightnessSwipeLeft = 
    [[UISwipeGestureRecognizer alloc] 
     initWithTarget:self 
     action:@selector(handleBrightnessSwipeLeft:)];
    
    self.brightnessSwipeLeft.numberOfTouchesRequired = 1;
    self.brightnessSwipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:self.brightnessSwipeLeft];
}

- (void)createRightSwipeRecognizer
{
    self.brightnessSwipeRight = 
    [[UISwipeGestureRecognizer alloc] 
     initWithTarget:self 
     action:@selector(handleBrightnessSwipeRight:)];
    
    self.brightnessSwipeRight.numberOfTouchesRequired = 1;
    self.brightnessSwipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.brightnessSwipeRight];
}

- (void)createUpSwipeRecognizer
{
    self.brightnessSwipeUp = 
    [[UISwipeGestureRecognizer alloc] 
     initWithTarget:self 
     action:@selector(handleBrightnessSwipeRight:)];
    
    self.brightnessSwipeUp.numberOfTouchesRequired = 1;
    self.brightnessSwipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self.view addGestureRecognizer:self.brightnessSwipeUp];
}

- (void)createDownSwipeRecognizer
{
    self.brightnessSwipeDown = 
    [[UISwipeGestureRecognizer alloc] 
     initWithTarget:self 
     action:@selector(handleBrightnessSwipeLeft:)];
    
    self.brightnessSwipeDown.numberOfTouchesRequired = 1;
    self.brightnessSwipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:self.brightnessSwipeDown];
}



#pragma mark - UI methods

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
    
    [[NSUserDefaults standardUserDefaults] setFloat:brightness 
                                             forKey:@"clockBrightnessLevel"];

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
    
    self.settingsEditor = [[DCSettingsTableViewController alloc] 
                                        initWithNibName:self.settingsViewNib
                                        bundle:nil];
    self.settingsEditor.clockViewController = self;
    self.settingsEditor.modalPresentationStyle = self.modalStyle;
    self.settingsEditor.clockState = self.clockState;
    
    self.settingsNavController = [[UINavigationController alloc] 
                                  initWithRootViewController:self.settingsEditor];
    self.settingsNavController.navigationBar.barStyle = UIBarStyleBlack;
    self.settingsNavController.modalPresentationStyle = self.modalStyle;

    [self presentViewController:self.settingsNavController animated:YES 
                     completion:^{ }];
    
}


-(void)updateDisplayFontWithFontSize:(NSInteger)fontSize
{

    self.timeLabel.font = self.clockState.currentFont;
    self.timeLabelHoursPortrait.font = self.clockState.currentFont;
    self.timeLabelMinutesPortrait.font = self.clockState.currentFont;
    
    self.ampmLabel.font = [self.clockState.currentFont fontWithSize:fontSize];
    self.ampmLabelPortrait.font = [self.clockState.currentFont fontWithSize:fontSize];
    
    self.secondsLabel.font = [self.clockState.currentFont fontWithSize:fontSize];
    self.secondsLabelPortrait.font = [self.clockState.currentFont fontWithSize:fontSize];
    
    
    CGFloat newOriginY;
    if (UIInterfaceOrientationIsPortrait(self.clockState.currentOrientation)) {
        self.timeLabelMinutesPortrait.frame = self.clockState.timeLabelPortraitFrame;
        if ([self.clockState.currentFont.fontName isEqualToString:@"Verdana-Bold"]) {
            CGRect frame = self.timeLabelMinutesPortrait.frame;
            if (self.clockState.device == DCIDarkTimeDeviceiPhone) {
                newOriginY = frame.origin.y - 13;
            } else {
                newOriginY = frame.origin.y - 25;
            }
            CGRect newFrame = CGRectMake(frame.origin.x, newOriginY, frame.size.width, frame.size.height);
            self.timeLabelMinutesPortrait.frame = newFrame;
        } else if ([self.clockState.currentFont.fontName isEqualToString:@"MarkerFelt-Wide"]) {
            CGRect frame = self.timeLabelMinutesPortrait.frame;
            if (self.clockState.device == DCIDarkTimeDeviceiPhone) {
                newOriginY = frame.origin.y - 13;
            } else {
                newOriginY = frame.origin.y - 30;
            }
            CGRect newFrame = CGRectMake(frame.origin.x, newOriginY, frame.size.width, frame.size.height);
            self.timeLabelMinutesPortrait.frame = newFrame;
        } else if ([self.clockState.currentFont.fontName isEqualToString:@"Courier-Bold"]) {
            CGRect frame = self.timeLabelMinutesPortrait.frame;
            if (self.clockState.device == DCIDarkTimeDeviceiPhone) {
                newOriginY = frame.origin.y - 8;
            } else {
                newOriginY = frame.origin.y - 8;
            }
            CGRect newFrame = CGRectMake(frame.origin.x, newOriginY, frame.size.width, frame.size.height);
            self.timeLabelMinutesPortrait.frame = newFrame;
        } else if ([self.clockState.currentFont.fontName isEqualToString:@"Futura-CondensedExtraBold"]) {
            CGRect frame = self.timeLabelMinutesPortrait.frame;
            if (self.clockState.device == DCIDarkTimeDeviceiPhone) {
                newOriginY = frame.origin.y + 10;
            } else {
                newOriginY = frame.origin.y + 20;
            }
            CGRect newFrame = CGRectMake(frame.origin.x, newOriginY, frame.size.width, frame.size.height);
            self.timeLabelMinutesPortrait.frame = newFrame;
        }
    }
    
    
        
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
    self.timeLabelHoursPortrait.textColor = color;
    self.timeLabelMinutesPortrait.textColor = color;
    self.ampmLabel.textColor = color;
    self.ampmLabelPortrait.textColor = color;
    self.secondsLabel.textColor = color;
    self.secondsLabelPortrait.textColor = color;
    self.clockSettingsButton.alpha = redFactor + 0.1;
    self.clockSettingsButtonPortrait.alpha = redFactor + 0.1;
    self.dottedLine.alpha = redFactor + 0.1;
    
    self.buttonAlphaLandscape = self.clockSettingsButton.alpha;
    self.dottedLineAlpha = self.dottedLine.alpha;
    
    UIFont *hourFont = self.timeLabelHoursPortrait.font;
    UIFont *minsFont = self.timeLabelMinutesPortrait.font;
    
    CGFloat actualSizeHours;
    CGFloat actualSizeMins;
    
    [self.timeLabelHoursPortrait.text sizeWithFont:hourFont 
                                       minFontSize:10 
                                    actualFontSize:&actualSizeHours 
                                          forWidth:320 
                                     lineBreakMode:UILineBreakModeTailTruncation];

    [self.timeLabelMinutesPortrait.text sizeWithFont:minsFont 
                                         minFontSize:10 
                                      actualFontSize:&actualSizeMins 
                                            forWidth:320 
                                       lineBreakMode:UILineBreakModeTailTruncation];
    
}



- (void)switchToOrientationView:(UIInterfaceOrientation)interfaceOrientation
{

    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    [self.clockState changeFontWithFontIndex:self.clockState.currentFontIndex 
                                   viewWidth:screenRect.size.height];
    
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        [UIView animateWithDuration:0.6 animations:^{
            self.timeLabel.alpha = 0.0;
            self.ampmLabel.alpha = 0.0;
            self.secondsLabel.alpha = 0.0;
            self.clockSettingsButton.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self.view bringSubviewToFront:self.portraitView];
            [UIView animateWithDuration:0.6 animations:^{
                self.timeLabelHoursPortrait.alpha = 1.0;
                self.timeLabelMinutesPortrait.alpha = 1.0;
                self.ampmLabelPortrait.alpha = 1.0;
                self.secondsLabelPortrait.alpha = 1.0;
                self.clockSettingsButtonPortrait.alpha = self.buttonAlphaLandscape;
                self.dottedLine.alpha = self.dottedLineAlpha;
            }];
        }];
    } else {
        [UIView animateWithDuration:0.6 animations:^{
            self.timeLabelHoursPortrait.alpha = 0.0;
            self.timeLabelMinutesPortrait.alpha = 0.0;
            self.ampmLabelPortrait.alpha = 0.0;
            self.secondsLabelPortrait.alpha = 0.0;
            self.clockSettingsButtonPortrait.alpha = 0.0;
            self.dottedLine.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self.view bringSubviewToFront:self.landscapeView];
            [UIView animateWithDuration:0.6 animations:^{
                self.timeLabel.alpha = 1.0;
                self.ampmLabel.alpha = 1.0;
                self.secondsLabel.alpha = 1.0;
                self.clockSettingsButton.alpha = self.dottedLineAlpha;
            }];
        }];
        
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

-(void)updateClockOnLaunch
{

    NSDate* now = [NSDate date];
    int second = [[self.calendar components:NSSecondCalendarUnit fromDate:now] second];
    self.savedSeconds = second;
    self.timeLabel.text = [self.clockState currentTimeString];
    self.secondsLabel.text = [self.clockState currentSecondsString];
    self.ampmLabel.text = [self.clockState currentAmPmString];    
    self.timeLabelHoursPortrait.text = [self.clockState currentHourString];
    self.timeLabelMinutesPortrait.text = [self.clockState currentMinutesString];
    self.secondsLabelPortrait.text = [self.clockState currentSecondsString];
    self.ampmLabelPortrait.text = [self.clockState currentAmPmString];
}


- (void)updateClock
{
    
    NSDate* now = [NSDate date];
    int second = [[self.calendar components:NSSecondCalendarUnit fromDate:now] second];
    
    if (second == self.savedSeconds) {
        return;
    }
    
    self.savedSeconds = second;
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft 
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
