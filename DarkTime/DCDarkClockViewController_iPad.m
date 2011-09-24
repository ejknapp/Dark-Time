//
//  DCDarkClockViewController_iPad.m
//  DarkTime
//
//  Created by Eric Knapp on 9/20/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCDarkClockViewController_iPad.h"
#import "DCClockState.h"
#import "DCNewClockEditorViewController.h"
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

-(void)updateDisplayFont
{
    self.timeLabel.font = [self.clockState.currentFont fontWithSize:360];
    self.ampmLabel.font = [self.clockState.currentFont fontWithSize:72];
    self.secondsLabel.font = [self.clockState.currentFont fontWithSize:72];

    self.timeLabel.frame = CGRectMake(0, self.clockState.displayLabelY, 1024, 768);
    
    [self changeDisplayBrightnessWithBrightness:self.clockState.clockBrightnessLevel];
}

- (IBAction)settingsButtonTapped:(id)sender 
{
    NSLog(@"In settingsButtonTapped iPad");
        
    DCSettingsViewController *settings = [[DCSettingsViewController alloc] 
                                          initWithNibName:nil bundle:nil];
    settings.clockState = self.clockState;
    
    settings.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentModalViewController:settings animated:YES];
    
    
//    if (self.settingsPopover) {
//        NSLog(@"self.settingsPopover is true");
//        [self.settingsPopover dismissPopoverAnimated:YES];
//        self.settingsPopover = nil;
//        self.fontEditor = nil;
//    } else {
//        NSLog(@"self.settingsPopover is false");
//        DCNewClockEditorViewController *editor = [[DCNewClockEditorViewController alloc] 
//                                                  initWithNibName:nil bundle:nil];
//        editor.clockState = self.clockState;
//        self.fontEditor = editor;    
//        self.settingsPopover = [[UIPopoverController alloc] 
//                                initWithContentViewController:self.fontEditor];
//        
//        self.settingsPopover.popoverContentSize = self.fontEditor.view.frame.size;
//        self.settingsPopover.delegate = self;
//        
//        
//        CGRect popoverRect = CGRectMake(940, 25, 20, 30);
//        [self.settingsPopover presentPopoverFromRect:popoverRect inView:self.view 
//                            permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//
//        [editor release];
//        
//    }
    
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.settingsPopover = nil;
    self.fontEditor = nil;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
