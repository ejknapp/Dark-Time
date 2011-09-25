//
//  DCDarkClockViewController_iPhone.m
//  DarkTime
//
//  Created by Eric Knapp on 9/20/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCDarkClockViewController_iPhone.h"
#import "DCDarkClockViewController.h"
#import "DCSettingsViewController.h"
#import "DCSettingsViewController_iPhone.h"
#import "DCClockState.h"

@implementation DCDarkClockViewController_iPhone


- (IBAction)settingsButtonTapped:(id)sender 
{
    self.clockState.fontEditorDisplayed = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context
{
    NSLog(@"observeValueForKeyPath: iPhone");
    
    if ([keyPath isEqualToString:@"fontEditorDisplayed"]) {
        if (self.clockState.isFontEditorDisplayed) {
            DCSettingsViewController_iPhone *editor = [[DCSettingsViewController_iPhone alloc] 
                                                initWithNibName:@"DCSettingView_iPhone" 
                                                bundle:nil];
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
    
    [self updateDisplayFont];
    
    [self changeDisplayBrightnessWithBrightness:self.clockState.clockBrightnessLevel];
}


-(void)updateDisplayFont
{
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat width = screenRect.size.width;
    CGFloat height = screenRect.size.height;
    
    NSLog(@"iPhone line h: %f", self.clockState.currentFont.lineHeight);
    
    CGRect newFrame = CGRectMake(0, (width - self.clockState.currentFont.lineHeight) / 2, 
                                 height, 
                                 self.clockState.currentFont.lineHeight);
    self.timeLabel.frame = newFrame;
    self.timeLabel.font = self.clockState.currentFont;
    self.ampmLabel.font = [self.clockState.currentFont fontWithSize:36];
    self.secondsLabel.font = [self.clockState.currentFont fontWithSize:36];
        
    [self changeDisplayBrightnessWithBrightness:self.clockState.clockBrightnessLevel];
}

@end













