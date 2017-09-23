//
//  AddFriendsViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "AddFriendsViewController.h"
#import <AddressBook/AddressBook.h>
#import "ContactCell.h"
#import "InviteCell.h"
#import "Invitee.h"
#import "RecentFriendshipCell.h"

@interface AddFriendsViewController ()

@end

@implementation AddFriendsViewController

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
    _allPhoneNumbers = [[NSMutableArray alloc] init];
    _numbersToInviteArray = [[NSMutableArray alloc] init];
    
    [_tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"tab-bar-item-selected-blue"]];
    
    [_tabBar setSelectedItem:[_tabBar.items objectAtIndex:0]];
    [((UITabBarItem *)[_tabBar.items objectAtIndex:0]) setImage:[UIImage imageNamed:@"contacts-item"]];
    [((UITabBarItem *)[_tabBar.items objectAtIndex:1]) setImage:[UIImage imageNamed:@"recent-item"]];
    [((UITabBarItem *)[_tabBar.items objectAtIndex:2]) setImage:[UIImage imageNamed:@"username-item"]];
    
    [self showContacts];
    
    CALayer *layer = [_addFriendButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
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
    if(tableView == _contactsTableView) {
        return 2;
    }
    else if(tableView == _recentTableView) {
        return 1;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(tableView == _contactsTableView) {
        if(section == 0) {
            return @"Tacker Users in My Contacts";
        }
        else if(section == 1) {
            return @"Invite Friends from Contacts";
        }
    }
    else if(tableView == _recentTableView) {
        return @"Tacker Users Who Added Me";
    }
    return nil;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(tableView == _contactsTableView && section == 0 && [CURRENT_USER.contactsArray count] == 0) {
        return 0;
    }
    return  25.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 320, 25);
    label.backgroundColor = [UIColor darkGrayColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:17];
    label.text = sectionTitle;
    label.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = [[UIView alloc] init];
    [view addSubview:label];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == _recentTableView) {
        return [CURRENT_USER.recentFriendshipsArray count];
    }
    else if(tableView == _contactsTableView) {
        if(section == 0) {
            return [CURRENT_USER.contactsArray count];
        }
        else if(section == 1) {
            return [CURRENT_USER.inviteeArray count];
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _contactsTableView && indexPath.section == 1) {
        Invitee *invitee = (Invitee *)CURRENT_USER.inviteeArray[indexPath.row];
        if(invitee.isFriended) {
            return 0;
        }
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _recentTableView) {
        RecentFriendshipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecentFriendshipCell"];
        
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RecentFriendshipCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        [cell setCell:(RecentFriendship *)[CURRENT_USER.recentFriendshipsArray objectAtIndex:indexPath.row]];
        
        if([_allPhoneNumbers containsObject:cell.recentFriendship.friendingUser.phone_number]) {
            BOOL *isFound = NO;
            int x = 0;
            while(x < CURRENT_USER.inviteeArray.count && !isFound) {
                Invitee *invitee = CURRENT_USER.inviteeArray[x];
                if([invitee.phoneNumber isEqualToString:cell.recentFriendship.friendingUser.phone_number]) {
                    cell.recentFriendship.name = invitee.name;
                    cell.nameLabel.text = invitee.name;
                    isFound = (BOOL *)YES;
                }
                x++;
            }
        }
        
        return cell;
    }
    else if(tableView == _contactsTableView) {
        if(indexPath.section == 0) {
            ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
            
            if(cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ContactCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            [cell setCell:(User *)[CURRENT_USER.contactsArray objectAtIndex:indexPath.row]];
             
            return cell;
        }
        else if(indexPath.section == 1){
            InviteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InviteCell"];
            
            if(cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InviteCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            Invitee *invitee = CURRENT_USER.inviteeArray[indexPath.row];
            [cell setCell:invitee];
            
            return cell;
        }
        
        return nil;
    }
    
    return nil;
}

- (void)populateContacts {
    CURRENT_USER.inviteeArray = [[NSMutableArray alloc] init];
    _numbersToInviteArray = [[NSMutableArray alloc] init];
    _allPhoneNumbers = [[NSMutableArray alloc] init];
    
    NSMutableArray *friendPhoneNumbers = [[NSMutableArray alloc] init];
    for(int x = 0; x < CURRENT_USER.friendshipsArray.count; x++) {
        Friendship *friendship = (Friendship *)CURRENT_USER.friendshipsArray[x];
        [friendPhoneNumbers addObject:friendship.friendedUser.phone_number];
    }
    
    __block BOOL userDidGrantAddressBookAccess;
    CFErrorRef addressBookError = NULL;
    
    if ( ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized )
    {
        ABAddressBookRef *addressBook = (ABAddressBookRef *)ABAddressBookCreateWithOptions(NULL, &addressBookError);
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
            userDidGrantAddressBookAccess = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
        CFIndex nPeople = ABAddressBookGetPersonCount( addressBook );
        
        CFArraySortValues(allPeople,
                          CFRangeMake(0, CFArrayGetCount(allPeople)),
                          (CFComparatorFunction) ABPersonComparePeopleByName,
                          (void*) ABPersonGetSortOrdering()
                          );
        
        for ( int i = 0; i < nPeople; i++ )
        {
            ABRecordRef person = CFArrayGetValueAtIndex( allPeople, i );
            
            NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
            NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
            //NSLog(@"Name:%@ %@", firstName, lastName);
            
            ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
            
            Invitee *invitee = [[Invitee alloc] init];
            for (CFIndex i = 0; i < ABMultiValueGetCount(phoneNumbers); i++) {
                NSString *phoneNumber = (__bridge_transfer NSString *) ABMultiValueCopyValueAtIndex(phoneNumbers, i);
                //NSLog(@"phone:%@", phoneNumber);
                if(i == 0) {
                    NSString *strippedPhoneNumber = [self NSStringStripToNumbers:phoneNumber];
                    if(phoneNumber.length > 10) {
                        strippedPhoneNumber = [strippedPhoneNumber substringFromIndex:1];
                    }
                    invitee.phoneNumber = strippedPhoneNumber;
                }
            }
            
            // Assign a name to the invitee model.
            if(firstName.length > 0 && lastName.length > 0) {
                invitee.name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
            }
            else if(firstName.length > 0) {
                invitee.name = [NSString stringWithFormat:@"%@", firstName];
            }
            else if(lastName.length > 0) {
                invitee.name = [NSString stringWithFormat:@"%@", lastName];
            }
            
            //NSLog(@"=============================================");
            
            if([friendPhoneNumbers containsObject:invitee.phoneNumber]) {
                invitee.isFriended = (BOOL *)YES;
            }
            
            if(invitee.phoneNumber.length >= 10) {
                [CURRENT_USER.inviteeArray addObject:invitee];
                _allPhoneNumbers[[_allPhoneNumbers count]] = invitee.phoneNumber;
            }
            
        }
        
        NSDictionary *contactNumbers = (NSDictionary *)_allPhoneNumbers;
        
        NSDictionary *contactsToCheck = @{@"phone_numbers": contactNumbers};
        
        CURRENT_USER.contactsArray = [[NSMutableArray alloc] init];
        [MY_APPDELEGATE.tackerAPI getUsersFindFromContacts:contactsToCheck completionBlock:^(NSDictionary *dictionary){
            if(dictionary) {
                NSArray *usersArray = (NSArray *)[dictionary objectForKey:@"users"];
                
                for(int x = 0; x < [usersArray count]; x++) {
                    User *user = [User parse:(NSDictionary *)usersArray[x]];
                    CURRENT_USER.contactsArray[x] = user;
                }
                
                AddFriendsViewController *addFriendsViewController = (AddFriendsViewController *)MY_APPDELEGATE.tabBarController.navigationController.visibleViewController;
                [addFriendsViewController setTackerUsersFromMyContacts];
            }
        }];
    }
    else
    {
        if ( ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
            ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted )
        {
            // Display an error.
        }
    }
    _shouldRefreshContacts = NO;
    [_contactsTableView reloadData];
}

- (void)setTackerUsersFromMyContacts {
    for(int x = 0; x < CURRENT_USER.contactsArray.count; x++) {
        User *contact = (User *)CURRENT_USER.contactsArray[x];
        BOOL *isFound = NO;
        
        int y = 0;
        while(y < CURRENT_USER.inviteeArray.count && !isFound) {
            Invitee *invitee = (Invitee *)CURRENT_USER.inviteeArray[y];
            
            if([contact.phone_number isEqualToString:invitee.phoneNumber]) {
                contact.name = invitee.name;
                [CURRENT_USER.inviteeArray removeObjectAtIndex:y];
            }
            y++;
        }
    }
    [_contactsTableView reloadData];
}

- (void)showContacts {
    _contactsTableView.hidden = NO;
    _recentTableView.hidden = YES;
    _usernameView.hidden = YES;
    _refreshButtonItem.enabled = YES;
    [_usernameTextField resignFirstResponder];
    
    if(([CURRENT_USER.contactsArray count] == 0 && [CURRENT_USER.inviteeArray count] == 0) || _shouldRefreshContacts) {
        [self populateContacts];
    }
}
- (void)showRecent {
    [self sendInAppSMS];
    
    _contactsTableView.hidden = YES;
    _recentTableView.hidden = NO;
    _usernameView.hidden = YES;
    _refreshButtonItem.enabled = YES;
    [_usernameTextField resignFirstResponder];
    
    if(_shouldRefreshRecents) {
        [self refreshRecentAdds];
    }
}
- (void)showUsername {
    [self sendInAppSMS];
    
    _contactsTableView.hidden = YES;
    _recentTableView.hidden = YES;
    _usernameView.hidden = NO;
    _refreshButtonItem.enabled = NO;
    [_usernameTextField becomeFirstResponder];
}

- (IBAction)addFriend:(id)sender {
    if(_usernameTextField.text.length > 0) {
        if([self NSStringIsValidUsername:_usernameTextField.text]) {
            [MY_APPDELEGATE.tackerAPI postFriendshipsCreate:@{@"user": @{@"username": [_usernameTextField.text lowercaseString]}} completionBlock:^(Friendship *friendship){
                if(friendship) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                    message:[NSString stringWithFormat:@"@%@ has been friended.",_usernameTextField.text]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                    [alert show];
                    [CURRENT_USER addFriendship:friendship];
                }
                _usernameTextField.text = @"";
            }];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete Form"
                                                        message:@"Username cannot be blank."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)dismissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)refresh:(id)sender {
    if(!_contactsTableView.hidden) {
        [self populateContacts];
    }
    else if(!_recentTableView.hidden) {
        [self refreshRecentAdds];
    }
}

- (void)refreshRecentAdds {
    [MY_APPDELEGATE.tackerAPI getMeRecentFriendships:^(NSArray *array){
        if(array) {
            [CURRENT_USER assignRecentFriendshipsArray:array];
            [_recentTableView reloadData];
        }
        _shouldRefreshRecents = NO;
    }];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if(item == _contactsTabItem) {
        [self showContacts];
    }
    else if(item == _recentTabItem) {
        [self showRecent];
    }
    else if(item == _usernameTabItem) {
        [self showUsername];
    }
}

- (void)grayOutInviteButtons {
    for(int x = 0; x < [CURRENT_USER.inviteeArray count]; x++) {
        InviteCell *cell = (InviteCell *)[_contactsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:x inSection:1]];
        [cell.inviteButton setBackgroundColor:[UIColor grayColor]];
    }
}

- (void)sendInAppSMS {
    if([_numbersToInviteArray count] > 0) {
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        if([MFMessageComposeViewController canSendText])
        {
            controller.body = [NSString stringWithFormat:@"Hey add me on Tacker! My username is @%@. Get it on the App Store: %@", CURRENT_USER.username, @"http://tacker.me/download"];
            controller.recipients = _numbersToInviteArray;
            controller.messageComposeDelegate = self;
            [self presentViewController:controller animated:YES completion:nil];
            
            [self grayOutInviteButtons];
            _numbersToInviteArray = [[NSMutableArray alloc] init];
        }
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
