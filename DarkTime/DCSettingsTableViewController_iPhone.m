//
//  DCSettingsTableViewController_iPhone.m
//  DarkTime
//
//  Created by Eric Knapp on 9/25/11.
//  Copyright 2011 Madison Area Technical College. All rights reserved.
//

#import "DCSettingsTableViewController_iPhone.h"
#import "DCFontSelectTableViewController_iPhone.h"

@implementation DCSettingsTableViewController_iPhone


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
        DCFontSelectTableViewController_iPhone *controller = [[DCFontSelectTableViewController_iPhone alloc] 
                                                              initWithStyle:UITableViewStyleGrouped];
        controller.clockState = self.clockState;

        controller.clockState = self.clockState;
        
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}


@end
