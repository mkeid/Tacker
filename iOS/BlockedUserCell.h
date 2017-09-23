//
//  BlockedUserCell.h
//  Tacker
//
//  Created by Mohamed Eid on 11/27/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockedUser.h"

@interface BlockedUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *blockButton;
@property (nonatomic) BlockedUser *blockedUser;

- (void)setCell:(BlockedUser *)blockedUser;
- (IBAction)alterBlockedUser:(id)sender;

@end
