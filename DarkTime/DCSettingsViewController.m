//
//  DCSettingsViewController.m
//  DarkTime
//
//  Created by Eric Knapp on 9/23/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCSettingsViewController.h"
#import "DCSettingsTableViewController.h"
#import "DCClockState.h"

@implementation DCSettingsViewController

@synthesize navigationController = _navigationController;
@synthesize clockState = _clockState;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    
}

-(void)doneButtonTapped:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    self.navigationController = nil;
}

-(void)helpButtonTapped:(id)sender
{

}


#pragma mark - View lifecycle

-(DCSettingsTableViewController *)createTableViewController
{
    NSLog(@"in createTableViewController super");
    DCSettingsTableViewController *tableViewController = [[[DCSettingsTableViewController alloc] 
                                                          initWithStyle:UITableViewStyleGrouped] autorelease];    
    
    tableViewController.clockState = self.clockState;

    return tableViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"in viewDidLoad for settings view controller");
    
    DCSettingsTableViewController *tableViewController = [self createTableViewController];

        
    UINavigationController *navController = [[UINavigationController alloc] 
                                             initWithRootViewController:tableViewController];


    navController.navigationBar.barStyle = UIBarStyleBlack;
        
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" 
                                                             style:UIBarButtonItemStylePlain 
                                                            target:self 
                                                            action:@selector(doneButtonTapped:)];
    
    UIBarButtonItem *help = [[UIBarButtonItem alloc] initWithTitle:@"Help" 
                                                             style:UIBarButtonItemStylePlain 
                                                            target:self 
                                                            action:@selector(helpButtonTapped:)];
    
    tableViewController.navigationItem.leftBarButtonItem = help;
    tableViewController.navigationItem.rightBarButtonItem = done;

    [help release];
    [done release];
   
    self.navigationController = navController;
    [navController release];
    
  
    [self.view addSubview:self.navigationController.view];
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.navigationController = nil;
    self.clockState = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc {
    [_navigationController release];
    [_clockState release];
    [super dealloc];
}
@end
