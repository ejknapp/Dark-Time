//
//  DCDarkClockViewController_iPhone.m
//  DarkTime
//
//  Created by Eric Knapp on 9/20/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCDarkClockViewController_iPhone.h"
#import "DCNewClockEditorViewController.h"

@implementation DCDarkClockViewController_iPhone


- (IBAction)settingsButtonTapped:(id)sender 
{
    NSLog(@"In settingsButtonTapped iPhone");
    DCNewClockEditorViewController *editor = [[DCNewClockEditorViewController alloc] 
                                              initWithNibName:nil bundle:nil];
    editor.clockState = self.clockState;
    self.fontEditor = editor;    
    [self presentModalViewController:self.fontEditor animated:YES];
    [editor release];
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
    
}

- (void)viewDidUnload
{
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


@end













