//
//  RequestCell.h
//  Tacker
//
//  Created by Mohamed Eid on 11/27/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Request.h"

@interface RequestCell : UITableViewCell
@property (nonatomic) Request *request;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *approveButton;
@property (weak, nonatomic) IBOutlet UIButton *denyButton;

- (void)setCell:(Request *)request;
- (void)removeCell;
- (IBAction)acceptRequest:(id)sender;
- (IBAction)denyRequest:(id)sender;

@end
