//
//  RequestsViewController.h
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) UIRefreshControl *refreshControl;
- (IBAction)refresh:(id)sender;
@end
