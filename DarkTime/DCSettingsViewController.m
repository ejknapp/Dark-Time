//
//  DCSettingsViewController.m
//  DarkTime
//
//  Created by Eric Knapp on 9/23/11.
//  Copyright 2011 Dovetail Computing, Inc.. All rights reserved.
//

#import "DCSettingsViewController.h"
#import "DCSettingsTableViewController.h"
#import "DCClockState.h"
#import "DCInfoViewController.h"
#import "DCDarkClockViewController.h"


@implementation DCSettingsViewController

@synthesize navigationController = _navigationController;
@synthesize clockState = _clockState;
@synthesize settingsTableViewController = _settingsTableViewController;
@synthesize infoController = _infoController;

@synthesize clockViewController = _clockViewController;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    
}

-(void)doneButtonTapped:(id)sender
{
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}


-(void)displayInfoPage
{

    self.infoController = [[DCInfoViewController alloc] initWithNibName:nil bundle:nil];
    
    [self.navigationController pushViewController:self.infoController animated:YES];
    
}


-(void)updateFontCellDisplay
{
    [self.settingsTableViewController updateFontCellDisplay];
}

#pragma mark - View lifecycle

-(DCSettingsTableViewController *)createTableViewController
{
    DCSettingsTableViewController *tableViewController = [[DCSettingsTableViewController alloc] 
                                                          initWithStyle:UITableViewStyleGrouped];    
    
    tableViewController.clockViewController = self.clockViewController;
    tableViewController.clockState = self.clockState;

    return tableViewController;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.settingsTableViewController = [self createTableViewController];
        
    self.navigationController = [[UINavigationController alloc] 
                                initWithRootViewController:self.settingsTableViewController];



    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" 
                                                             style:UIBarButtonItemStylePlain 
                                                            target:self 
                                                            action:@selector(doneButtonTapped:)];
    
    self.settingsTableViewController.navigationItem.rightBarButtonItem = done;
  
    [self.view addSubview:self.navigationController.view];
}

- (void)viewDidUnload
{

    [super viewDidUnload];

    self.navigationController = nil;
    self.clockState = nil;
    self.settingsTableViewController = nil;
    self.infoController = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft 
//            || interfaceOrientation == UIInterfaceOrientationLandscapeRight);

    return YES;
}

@end
