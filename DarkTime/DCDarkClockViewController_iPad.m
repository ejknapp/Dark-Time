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

@property (nonatomic, retain) UIPopoverController *settingsPopover;

@end


@implementation DCDarkClockViewController_iPad

@synthesize settingsPopover = _settingsPopover;

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
    NSLog(@"observeValueForKeyPath: iPad");
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
    }
    
    if ([keyPath isEqualToString:@"currentFont"]) {
        [self updateDisplayFont];
    }
    
    //    NSLog(@"About to call updateDisplayFont");
    [self updateDisplayFont];
    
    [self changeDisplayBrightnessWithBrightness:self.clockState.clockBrightnessLevel];
}


-(void)updateDisplayFont
{
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat width = screenRect.size.width;
    CGFloat height = screenRect.size.height;
    
    NSLog(@"iPad app rect %@", NSStringFromCGRect(screenRect));
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self updateDisplayFont];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
