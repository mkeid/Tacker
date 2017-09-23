//
//  BlockedUsersViewController.h
//  Tacker
//
//  Created by Mohamed Eid on 11/26/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface BlockedUsersViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)dismissViewController:(id)sender;

@end
