//
//  DCSettingsViewController_iPhone.m
//  DarkTime
//
//  Created by Eric Knapp on 9/25/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCSettingsViewController_iPhone.h"
#import "DCSettingsTableViewController.h"
#import "DCSettingsTableViewController_iPhone.h"
#import "DCFontSelectTableViewController_iPhone.h"

@implementation DCSettingsViewController_iPhone


#pragma mark - View lifecycle


-(DCSettingsTableViewController *)createTableViewController
{
    NSLog(@"in createTableViewController iPhone");

    DCSettingsTableViewController_iPhone *tableViewController = 
            [[[DCSettingsTableViewController_iPhone alloc] 
              initWithNibName:@"DCSettingsTableView_iPhone"
              bundle:nil] autorelease];

    tableViewController.clockState = self.clockState;
    
    return tableViewController;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
        DCFontSelectTableViewController_iPhone *fontViewController = [[DCFontSelectTableViewController_iPhone alloc] 
                                                               initWithNibName:@"DCFontSelectTableView_iPhone"
                                                               bundle:nil];
        fontViewController.clockState = self.clockState;
        
        [self.navigationController pushViewController:fontViewController animated:YES];
        [fontViewController release];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}


@end
