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
#import "DCNewClockEditorViewController.h"

@interface DCDarkClockViewController ()

@property (nonatomic, retain) UISwipeGestureRecognizer *brightnessSwipeRight;
@property (nonatomic, retain) UISwipeGestureRecognizer *brightnessSwipeLeft;


-(void)handleBrightnessDrag:(UIPanGestureRecognizer *)recognizer;
-(void)appBecomeActive;
-(void)appEnteredBackground;


-(IBAction)settingsButtonTapped:(id)sender;
-(void)updateDisplayFont;

@end


@implementation DCDarkClockViewController

@synthesize brightnessSwipeRight = _brightnessSwipeRight;
@synthesize brightnessSwipeLeft = _brightnessSwipeLeft;


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
    
    UISwipeGestureRecognizer *swipeRecognizer = 
                            [[UISwipeGestureRecognizer alloc] 
                             initWithTarget:self 
                             action:@selector(handleBrightnessSwipeRight:)];
    
    swipeRecognizer.numberOfTouchesRequired = 1;
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    self.brightnessSwipeRight = swipeRecognizer;
    [self.view addGestureRecognizer:self.brightnessSwipeRight];
    [swipeRecognizer release];
    
    UISwipeGestureRecognizer *leftSwipeRecognizer = 
                    [[UISwipeGestureRecognizer alloc] 
                     initWithTarget:self 
                     action:@selector(handleBrightnessSwipeLeft:)];
    
    leftSwipeRecognizer.numberOfTouchesRequired = 1;
    leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    
    self.brightnessSwipeLeft = leftSwipeRecognizer;
    [self.view addGestureRecognizer:self.brightnessSwipeLeft];
    [leftSwipeRecognizer release];

    
    [self.clockState addObserver:self 
                      forKeyPath:@"currentFont" 
                         options:NSKeyValueObservingOptionNew
                         context:NULL];
    
//    [self.clockState addObserver:self 
//                      forKeyPath:@"fontEditorDisplayed" 
//                         options:NSKeyValueObservingOptionNew
//                         context:NULL];
    
    [self updateDisplayFont];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context
{
    
    if ([keyPath isEqualToString:@"fontEditorDisplayed"]) {
        if ([self.clockState isFontEditorDisplayed]) {
            DCNewClockEditorViewController *editor = [[DCNewClockEditorViewController alloc] initWithNibName:nil bundle:nil];
            editor.clockState = self.clockState;
            self.fontEditor = editor;
            [self presentModalViewController:editor animated:YES];
            [editor release];
        } else {
            [self.fontEditor dismissModalViewControllerAnimated:YES];
            self.fontEditor = nil;
        }
    }
    
    [self updateDisplayFont];
    
    [self changeDisplayBrightnessWithBrightness:self.clockState.clockBrightnessLevel];
}

-(void)updateDisplayFont
{
    //    DCClockState *clockState = [DCClockState sharedClockTimerState];
    
    self.timeLabel.font = self.clockState.currentFont;
    self.ampmLabel.font = [self.clockState.currentFont fontWithSize:36];
    self.secondsLabel.font = [self.clockState.currentFont fontWithSize:36];
    
    self.timeLabel.frame = CGRectMake(0, self.clockState.displayLabelY, 480, 320);
    
    [self changeDisplayBrightnessWithBrightness:self.clockState.clockBrightnessLevel];
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
    
    CGFloat currentBrightness;
    currentBrightness = self.clockState.clockBrightnessLevel;
    
    CGFloat brightness = currentBrightness - 0.1;
    if (brightness > 1.0) {
        brightness = 1.0;
    } else if (brightness < 0.15) {
        brightness = 0.15;
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
    
    //    if (self.clockState.fontEditorDisplayed) {
    //        return;
    //    }
    //    
    //    CGPoint location = [recognizer locationInView:[[self.view superview] superview]];
    //    CGFloat deltaX = 0;
    //    CGFloat deltaY = 0;
    //    
    //    if (recognizer.state == UIGestureRecognizerStateBegan) {
    //        self.startingOrigin = self.view.frame.origin;
    //        self.clockState.startingDragLocation = location;
    //        return;
    //    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
    //        deltaX = fabs(self.clockState.startingDragLocation.x - location.x);
    //        deltaY = fabs(self.clockState.startingDragLocation.y - location.y);
    //        self.clockState.clockDeltaX = deltaX;
    //        self.clockState.clockDeltaY = deltaY;
    //                
    //        if (deltaX < 10) {
    //            return;
    //        } else if (deltaY > 20) {
    //            return;
    //        }
    //
    //    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
    //        return;
    //    }
    //    
    //    CGRect screen = [[UIScreen mainScreen] applicationFrame];
    //    
    //    CGFloat currentBrightness = self.clockState.clockBrightnessLevel;
    //    
    //    CGFloat adjustment = (location.x - self.clockState.startingDragLocation.x) / screen.size.height;
    //    
    //    CGFloat brightness = currentBrightness + adjustment;
    //    
    //    if (brightness >= 0.1) {
    //        self.clockState.clockBrightnessLevel = brightness;            
    //        [self changeDisplayBrightnessWithBrightness:brightness];
    //    }
    //    
}

-(void)handleBrightnessTap:(UIPanGestureRecognizer *)recognizer
{
    
    if (self.clockState.fontEditorDisplayed) {
        return;
    }
    
    CGPoint location = [recognizer locationInView:[[self.view superview] superview]];
    
    CGRect screen = [[UIScreen mainScreen] applicationFrame];
    
    
    CGFloat brightness = location.x / screen.size.height;
    
    NSLog(@"in handleBrightnessTap: %f", brightness);
    if (brightness >= 0.1) {
        self.clockState.clockBrightnessLevel = brightness;          
        [self changeDisplayBrightnessWithBrightness:brightness];
    } else {
        [self changeDisplayBrightnessWithBrightness:0.1];
    }
    
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



#pragma mark - Scroll View Delegate Methods


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
