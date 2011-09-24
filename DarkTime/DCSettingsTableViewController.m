//
//  DCSettingsTableViewController.m
//  DarkTime
//
//  Created by Eric Knapp on 9/23/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCSettingsTableViewController.h"
#import "DCClockState.h"
#import "DCSettingsViewController.h"
#import "DCFontSelectTableViewController.h"

@interface DCSettingsTableViewController()

@property (nonatomic, retain) NSArray *settingsArray;

@end

@implementation DCSettingsTableViewController

@synthesize clockState = _clockState;
@synthesize settingsArray = _settingsArray;

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

    self.title = @"Clock Settings";
    
    NSDictionary *ampmSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"Display AM/PM", @"header",
                                 @"YES", @"display",
                                 nil];

    NSDictionary *secondsSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"Display Seconds", @"header",
                                 @"YES", @"display",
                                 nil];

    NSDictionary *fontSection = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    @"Select Font", @"header",
                                    nil];

    NSArray *sections = [[NSArray alloc] initWithObjects:ampmSection, secondsSection, fontSection, nil];

    self.settingsArray = sections;
    
    [ampmSection release];
    [secondsSection release];
    [sections release];
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
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDictionary = [self.settingsArray objectAtIndex:section];
    
    return [sectionDictionary objectForKey:@"header"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [self.settingsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    NSInteger rowCount;
    
    if (section == 0) {
        rowCount = 2;
    } else if (section == 1) {
        rowCount = 2;
    } else if (section == 3) {
        rowCount = 1;
    }
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Yes";
            if (self.clockState.displayAmPm) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"No";
            if (self.clockState.displayAmPm) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Yes";
            if (self.clockState.displaySeconds) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"No";
            if (self.clockState.displaySeconds) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    } else if (indexPath.section == 2) {
        cell.textLabel.text = self.clockState.currentFontName;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *nextPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
    NSIndexPath *previousPath = [NSIndexPath indexPathForRow:(indexPath.row - 1) inSection:indexPath.section];

    UITableViewCell *tappedCell = [tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *nextCell = [tableView cellForRowAtIndexPath:nextPath];
    UITableViewCell *previousCell = [tableView cellForRowAtIndexPath:previousPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.clockState.displayAmPm = YES;
            tappedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            nextCell.accessoryType = UITableViewCellAccessoryNone;
        } else if (indexPath.row == 1) {
            self.clockState.displayAmPm = NO;
            tappedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            previousCell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            self.clockState.displaySeconds = YES;
            tappedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            nextCell.accessoryType = UITableViewCellAccessoryNone;
        } else if (indexPath.row == 1) {
            self.clockState.displaySeconds = NO;
            tappedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            previousCell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if (indexPath.section == 2) {
        // Navigation logic may go here. Create and push another view controller.
        
        DCFontSelectTableViewController *fontViewController = [[DCFontSelectTableViewController alloc] 
                                                               initWithNibName:@"DCFontSelectTableViewController"
                                                               bundle:nil];
        fontViewController.clockState = self.clockState;
        
        [self.navigationController pushViewController:fontViewController animated:YES];
        [fontViewController release];
    }
         
}

@end
