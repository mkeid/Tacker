//
//  BlockedUsersViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 11/26/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "BlockedUsersViewController.h"
#import "BlockedUserCell.h"

@interface BlockedUsersViewController ()

@end

@implementation BlockedUsersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [CURRENT_USER.blockedUsersArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlockedUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlockedUserCell"];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BlockedUserCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    [cell setCell:(BlockedUser *)[CURRENT_USER.blockedUsersArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (IBAction)dismissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
