//
//  RequestCell.m
//  Tacker
//
//  Created by Mohamed Eid on 11/27/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "RequestCell.h"
#import "RequestsViewController.h"

@implementation RequestCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    CALayer *layer = [_approveButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
    
    layer = [_denyButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
}

- (void)setCell:(Request *)request {
    _request = request;
    NSString *name = (_request.name.length > 0 && _request.name) ? _request.name : [NSString stringWithFormat:@"@%@",_request.requesting_user.username];
    if([_request.kind isEqualToString:@"Friendship"]) {
        _nameLabel.text = [NSString stringWithFormat:@"%@ wants to be your friend.", name];
    }
    else if([_request.kind isEqualToString:@"Tracker"]) {
        _nameLabel.text = [NSString stringWithFormat:@"%@ wants to share locations with you.", name];
    }
}

- (void)removeCell {
    NSMutableArray *alteredArray = [[NSMutableArray alloc] initWithArray:CURRENT_USER.requestsArray];
    [alteredArray removeObjectAtIndex:self.tag];
    CURRENT_USER.requestsArray = alteredArray;
    
    [((RequestsViewController *)(MY_APPDELEGATE.tabBarController.viewControllers[1])).tableView reloadData];
    [MY_APPDELEGATE setRequestsBadgeCount];
}

- (IBAction)acceptRequest:(id)sender {
    [_request approve:^(BOOL success) {
        [self removeCell];
        
        if([_request.kind isEqualToString:@"Friendship"]) {
            CURRENT_USER.shouldReloadFriends = (BOOL *)YES;
        }
        else if([_request.kind isEqualToString:@"Tracker"]) {
            CURRENT_USER.shouldReloadTrackers = (BOOL *)YES;
        }
    }];
}

- (IBAction)denyRequest:(id)sender {
    [_request destroy:^(BOOL success) {
        [self removeCell];
    }];
}
@end
