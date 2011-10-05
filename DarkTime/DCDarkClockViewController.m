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
    self.brightnessSwipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.brightnessSwipeRight];
    
    self.brightnessSwipeLeft = 
        [[UISwipeGestureRecognizer alloc] 
         initWithTarget:self 
         action:@selector(handleBrightnessSwipeLeft:)];
    
    self.brightnessSwipeLeft.numberOfTouchesRequired = 1;
    self.brightnessSwipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:self.brightnessSwipeLeft];

    
   
    [self.clockState addObserver:self 
                      forKeyPath:@"currentFont" 
                         options:NSKeyValueObservingOptionNew
                         context:NULL];
    
     [self.clockState addObserver:self 
                      forKeyPath:@"clockBrightnessLevel" 
                         options:NSKeyValueObservingOptionNew
                         context:NULL];

    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    [self.clockState changeFontWithFontIndex:self.clockState.currentFontIndex 
                                   viewWidth:screenRect.size.height];

    [self updateDisplayFont];
    
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
    
    [self updateDisplayFont];
    
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
    
    self.clockState.clockBrightnessLevel = brightness;
//    [self changeDisplayBrightnessWithBrightness:brightness];
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

    self.clockState.clockBrightnessLevel = brightness;

//    [self changeDisplayBrightnessWithBrightness:brightness];
}

- (IBAction)settingsButtonTapped:(id)sender 
{
    
    self.fontEditor = [[DCSettingsViewController alloc] 
                                        initWithNibName:self.settingsViewNib
                                        bundle:nil];
    self.fontEditor.modalPresentationStyle = self.modalStyle;
    self.fontEditor.clockState = self.clockState;

    [self presentModalViewController:self.fontEditor animated:YES];


}

- (void)dismissModalViewControllerAnimated:(BOOL)animated
{
    NSLog(@"in dismissModalViewControllerAnimated: in super");
    [self.fontEditor dismissModalViewControllerAnimated:YES];
    
    [self.fontEditor.infoController.infoWebView loadHTMLString:@"" baseURL:nil];
    self.fontEditor = nil;
}

-(void)updateDisplayFontWithFontSize:(NSInteger)fontSize
{
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat width = screenRect.size.width;
    CGFloat height = screenRect.size.height;
    
    CGRect newFrame = CGRectMake(0, (width - self.clockState.currentFont.lineHeight) / 2, 
                                 height, 
                                 self.clockState.currentFont.lineHeight);
    self.timeLabel.frame = newFrame;
    self.timeLabel.font = self.clockState.currentFont;
    self.ampmLabel.font = [self.clockState.currentFont fontWithSize:fontSize];
    self.secondsLabel.font = [self.clockState.currentFont fontWithSize:fontSize];
    
    
    [self changeDisplayBrightnessWithBrightness:self.clockState.clockBrightnessLevel];
    
}

-(void)updateDisplayFont
{
    
}

- (void)viewDidUnload
{
    [self setTimeLabel:nil];
    [self setAmpmLabel:nil];
    [self setSecondsLabel:nil];
    
    self.calendar = nil;


    
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


-(void)changeDisplayBrightnessWithBrightness:(CGFloat)brightness
{

    UIScreen *screen = [UIScreen mainScreen];
    screen.brightness = brightness;
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






@end
