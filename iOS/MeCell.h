//
//  MeCell.h
//  Tacker
//
//  Created by Mohamed Eid on 12/26/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bigUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
- (IBAction)editMe:(id)sender;
- (void)setCell;
@end
