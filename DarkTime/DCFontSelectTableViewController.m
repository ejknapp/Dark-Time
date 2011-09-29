//
//  DCFontSelectTableViewController.m
//  DarkTime
//
//  Created by Eric Knapp on 9/24/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCFontSelectTableViewController.h"
#import "DCClockState.h"


@implementation DCFontSelectTableViewController

@synthesize clockState = _clockState;
@synthesize currentCheckedCell = _currentCheckedCell;


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
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    NSString *fontName = [self.clockState.fontNames objectAtIndex:indexPath.row];
    NSString *cellText = [[NSString alloc] initWithFormat:@"%@ - 6:34", fontName];
    cell.textLabel.text = cellText;
    [cellText release];
    UIFont *cellFont = [UIFont fontWithName:fontName size:19];
    cell.textLabel.font = cellFont;
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

-(void)dealloc
{
    [_clockState release];
    [_currentCheckedCell release];
    
    [super dealloc];
}

@end
