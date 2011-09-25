//
//  DCFontSelectTableViewController.m
//  DarkTime
//
//  Created by Eric Knapp on 9/24/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCFontSelectTableViewController.h"
#import "DCClockState.h"

@interface DCFontSelectTableViewController()

@property (nonatomic, retain) UITableViewCell *currentCheckedCell;

@end

@implementation DCFontSelectTableViewController

@synthesize clockState = _clockState;
@synthesize currentCheckedCell = _currentCheckedCell;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Select Font";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [self.clockState.fontNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [self.clockState.fontNames objectAtIndex:indexPath.row];
    if (self.clockState.currentFontIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.currentCheckedCell = cell;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger selectedRow = indexPath.row;
    UITableViewCell *tappedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.currentCheckedCell.accessoryType = UITableViewCellAccessoryNone;
    [self.clockState changeFontWithFontIndex:selectedRow];
    
    tappedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.currentCheckedCell = tappedCell;
    
    
    
}

-(void)dealloc
{
    [_clockState release];
    
    [super dealloc];
}

@end
