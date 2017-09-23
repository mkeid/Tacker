//
//  RequestsViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "RequestsViewController.h"

#import "AppDelegate.h"
#import "RequestCell.h"

@interface RequestsViewController ()

@end

@implementation RequestsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Requests";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
    
    CLLocationManager *locationManager;
    locationManager = [[CLLocationManager alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    if(CURRENT_USER.shouldRefreshRequests) {
        [self refresh:nil];
    }
    if(CURRENT_USER.shouldReloadRequests) {
        [_tableView reloadData];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"tab-bar-item-selected-yellow"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refresh:(id)sender {
    __weak id blockSafeSelf = self;
    [MY_APPDELEGATE.tackerAPI getMeRequests:^(NSArray *array){
        [((RequestsViewController *)blockSafeSelf).refreshControl endRefreshing];
        if(array) {
            [CURRENT_USER assignRequestsArray:array];
            [_tableView reloadData];
            [MY_APPDELEGATE setRequestsBadgeCount];
        }
        CURRENT_USER.shouldRefreshRequests = NO;
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {    
    return [CURRENT_USER.requestsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RequestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RequestCell"];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RequestCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell setCell:(Request *)[CURRENT_USER.requestsArray objectAtIndex:indexPath.row]];
    
    cell.tag = indexPath.row;
    
    return cell;
}

@end
