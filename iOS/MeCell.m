//
//  MeCell.m
//  Tacker
//
//  Created by Mohamed Eid on 12/26/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "MeCell.h"

@implementation MeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        if(CURRENT_USER.name.length > 0) {
            _bigUsernameLabel.hidden = YES;
            _nameLabel.text = CURRENT_USER.name;
            _usernameLabel.text = CURRENT_USER.username;
        }
        else {
            _nameLabel.hidden = YES;
            _usernameLabel.hidden = YES;
            _bigUsernameLabel.text = [NSString stringWithFormat:@"@%@",CURRENT_USER.username];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    CALayer *layer = [_editButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
}

- (void)setCell {
    if(CURRENT_USER.name && CURRENT_USER.name.length > 0) {
        _bigUsernameLabel.hidden = YES;
        _nameLabel.hidden = NO;
        _usernameLabel.hidden = NO;
        
        _nameLabel.text = CURRENT_USER.name;
        _usernameLabel.text = [NSString stringWithFormat:@"@%@",CURRENT_USER.username];
    }
    else {
        _bigUsernameLabel.hidden = NO;
        _nameLabel.hidden = YES;
        _usernameLabel.hidden = YES;
        
        _bigUsernameLabel.text = [NSString stringWithFormat:@"@%@",CURRENT_USER.username];
    }
}

- (IBAction)editMe:(id)sender {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Edit name for @%@", CURRENT_USER.username]
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:nil];
    message.tag = 0;
    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [message textFieldAtIndex:0].text = [NSString stringWithFormat:@"%@", CURRENT_USER.name];
    [message addButtonWithTitle:@"Save"];
    [message show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) {
        [MY_APPDELEGATE.tackerAPI postMeUpdateName:@{@"user":@{@"name":[alertView textFieldAtIndex:0].text}} completionBlock:^(NSDictionary *responseDictionary){
            CURRENT_USER.name = [alertView textFieldAtIndex:0].text;
            [self setCell];
        }];
    }
}

@end
