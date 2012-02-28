//
//  DCFontSelectTableViewController.m
//  DarkTime
//
//  Created by Eric Knapp on 9/24/11.
//  Copyright 2011 Dovetail Computing, Inc.. All rights reserved.
//

#import "DCFontSelectTableViewController.h"
#import "DCClockState.h"
#import "DCDarkClockViewController.h"
#import "DCIFontManager.h"


@implementation DCFontSelectTableViewController

@synthesize clockState = _clockState;
@synthesize currentCheckedCell = _currentCheckedCell;
@synthesize clockViewController = _clockViewController;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];

    self.currentCheckedCell = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
                                duration:(NSTimeInterval)duration
{
    self.clockState.currentOrientation = toInterfaceOrientation;
    
    [self.clockViewController switchToOrientationView:self.clockState.currentOrientation];
    
    [self.clockViewController.view layoutIfNeeded];

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
    return [self.clockState.fontManager fontCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    NSString *fontName = [self.clockState.fontManager fontNameAtIndex:indexPath.row];
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@ - 6:34", fontName];

    cell.textLabel.font = [UIFont fontWithName:fontName size:19];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
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
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    [self.clockState changeFontWithFontIndex:selectedRow viewWidth:screenRect.size.height];
    
    tappedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.currentCheckedCell = tappedCell;
        
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
