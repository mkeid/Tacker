//
//  FriendsViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "FriendsViewController.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Friends";
        _alphabetArray = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", @"Other", nil];
        _alphabetDictionary = [[NSMutableDictionary alloc] init];
        for(int x = 0; x < [_alphabetArray count]; x++) {
            [_alphabetDictionary setObject:[[NSMutableArray alloc] init] forKey:(NSString *)_alphabetArray[x]];
        }
        
        [self orderFriendships];
        
    }
    return self;
}

- (void)viewDidLayoutSubviews {
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)viewDidAppear:(BOOL)animated {
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    if(CURRENT_USER.shouldRefreshFriends) {
        [self refresh];
    }
    if(CURRENT_USER.shouldReloadFriends) {
        [self orderFriendships];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"tab-bar-item-selected-green"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)orderFriendships {
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _orderedFriendships = [[NSMutableDictionary alloc] init];
    for(int x = 0; x < [_alphabetArray count]; x++) {
        [_orderedFriendships setObject:[[NSMutableArray alloc] init] forKey:(NSString *)_alphabetArray[x]];
    }
    
    for(int x = 0; x < [CURRENT_USER.friendshipsArray count]; x++) {
        Friendship *friendship = (Friendship *)CURRENT_USER.friendshipsArray[x];
        NSMutableArray *array = (NSMutableArray *)[_orderedFriendships objectForKey:@"Other"];
        
        if(friendship.name.length > 0 && [[_orderedFriendships allKeys] containsObject:[[friendship.name substringToIndex:1] uppercaseString]]) {
            array = (NSMutableArray *)[_orderedFriendships objectForKey:[(NSString *)[friendship.name substringToIndex:1] uppercaseString]];
        }
        else if(friendship.friendedUser.username.length > 0 && [[_orderedFriendships allKeys] containsObject:[[friendship.friendedUser.username substringToIndex:1] uppercaseString]]) {
            array = (NSMutableArray *)[_orderedFriendships objectForKey:[(NSString *)[friendship.friendedUser.username substringToIndex:1] uppercaseString]];
        }
        [array addObject:friendship];
    }
    [_tableView reloadData];
    CURRENT_USER.shouldReloadFriends = NO;
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 28;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"Me";
    }
    else {
        return [_alphabetArray objectAtIndex:section-1];
    }
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return 20;
    }
    else {
        if([(NSMutableArray *)[_orderedFriendships objectForKey:(NSString *)_alphabetArray[section-1]] count] == 0) {
            return 0;
        }
        else {
            return  20.0;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, 0, 300, 20);
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.text = sectionTitle;
    label.textAlignment = NSTextAlignmentLeft;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f];
    [view addSubview:label];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // If it is the "me" section
    if(section == 0) {
        return 1;
    }
    else {
        NSMutableArray *array = (NSMutableArray *)[_orderedFriendships objectForKey:(NSString *)_alphabetArray[section-1]];
        
        return [array count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        MeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeCell"];
        
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MeCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [cell setCell];
        
        return cell;
    }
    else {
        FriendshipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendshipCell"];
        
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FriendshipCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        NSLog(@"CREATING CELLS");
        NSMutableArray *array = (NSMutableArray *)[_orderedFriendships objectForKey:(NSString *)_alphabetArray[indexPath.section-1]];
        Friendship *friendship = (Friendship *)array[indexPath.row];
        
        [cell setCell:friendship];
        
        return cell;
    }
    UITableViewCell *tableCell = [[UITableViewCell alloc] init];
    return tableCell;
}

- (IBAction)loadBlockedUsersViewController:(id)sender {
    BlockedUsersViewController *blockedUsersViewController = [[BlockedUsersViewController alloc] initWithNibName:@"BlockedUsersView" bundle:nil];
    [self.tabBarController.navigationController presentViewController:blockedUsersViewController animated:YES completion:nil];
}

- (IBAction)loadAddFriendsViewController:(id)sender {
    AddFriendsViewController *addFriendsViewController = [[AddFriendsViewController alloc] initWithNibName:@"AddFriendsView" bundle:nil];
    [self.tabBarController.navigationController presentViewController:addFriendsViewController animated:YES completion:nil];
}

- (void)refresh {
    __weak id blockSafeSelf = self;
    [MY_APPDELEGATE.tackerAPI getMeFriendships:^(NSArray *array) {
        [((FriendsViewController *)blockSafeSelf).refreshControl endRefreshing];
        if(array) {
            [CURRENT_USER assignFriendshipsArray:array];
            [self orderFriendships];
        }
    }];
}

@end
