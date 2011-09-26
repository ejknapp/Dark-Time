//
//  DCDarkClockViewController_iPad.m
//  DarkTime
//
//  Created by Eric Knapp on 9/20/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCDarkClockViewController_iPad.h"
#import "DCClockState.h"
#import "DCDarkClockViewController.h"
#import "DCSettingsTableViewController.h"
#import "DCSettingsViewController.h"

@interface DCDarkClockViewController_iPad()

-(void)addRecognizers;
-(void)removeRecognizers;

@end


@implementation DCDarkClockViewController_iPad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"fontEditorDisplayed"]) {
        if (self.clockState.isFontEditorDisplayed) {

            DCSettingsViewController *editor = [[DCSettingsViewController alloc] 
                                                initWithNibName:nil 
                                                bundle:nil];

            editor.modalPresentationStyle = UIModalPresentationFormSheet;
            editor.clockState = self.clockState;
            self.fontEditor = editor;
            [self presentModalViewController:editor animated:YES];
            [editor release];
        } else {
            [self.fontEditor dismissModalViewControllerAnimated:YES];
            self.fontEditor = nil;

        }
    } else if ([keyPath isEqualToString:@"currentFont"]) {
        [self updateDisplayFont];
        
        if (self.fontEditor) {
            [self.fontEditor updateFontCellDisplay];
        }
    }    

    [self updateDisplayFont];
    
    [self changeDisplayBrightnessWithBrightness:self.clockState.clockBrightnessLevel];
}


-(void)updateDisplayFont
{
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat width = screenRect.size.width;
    CGFloat height = screenRect.size.height;
    
    CGRect newFrame = CGRectMake(0, (width - self.clockState.currentFont.lineHeight) / 2, 
                                 height, 
                                 self.clockState.currentFont.lineHeight);
    self.timeLabel.frame = newFrame;

    self.timeLabel.font = self.clockState.currentFont;
    self.ampmLabel.font = [self.clockState.currentFont fontWithSize:64];
    self.secondsLabel.font = [self.clockState.currentFont fontWithSize:64];

    
    [self changeDisplayBrightnessWithBrightness:self.clockState.clockBrightnessLevel];
    
}

- (IBAction)settingsButtonTapped:(id)sender 
{

    self.clockState.fontEditorDisplayed = YES;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


-(void)addRecognizers
{
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

}

-(void)removeRecognizers
{
    [self.view removeGestureRecognizer:self.brightnessSwipeLeft];
    [self.view removeGestureRecognizer:self.brightnessSwipeRight];
    
    self.brightnessSwipeRight = nil;
    self.brightnessSwipeLeft = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addRecognizers];
    
//    UISwipeGestureRecognizer *swipeRecognizer = 
//    [[UISwipeGestureRecognizer alloc] 
//     initWithTarget:self 
//     action:@selector(handleBrightnessSwipeRight:)];
//    
//    swipeRecognizer.numberOfTouchesRequired = 1;
//    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
//    
//    self.brightnessSwipeRight = swipeRecognizer;
//    [self.view addGestureRecognizer:self.brightnessSwipeRight];
//    [swipeRecognizer release];
//    
//    UISwipeGestureRecognizer *leftSwipeRecognizer = 
//    [[UISwipeGestureRecognizer alloc] 
//     initWithTarget:self 
//     action:@selector(handleBrightnessSwipeLeft:)];
//    
//    leftSwipeRecognizer.numberOfTouchesRequired = 1;
//    leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
//    
//    self.brightnessSwipeLeft = leftSwipeRecognizer;
//    [self.view addGestureRecognizer:self.brightnessSwipeLeft];
//    [leftSwipeRecognizer release];
//    
    
    [self updateDisplayFont];
}




@end
