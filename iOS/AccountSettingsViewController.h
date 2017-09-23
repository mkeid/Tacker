//
//  AccountSettingsViewController.h
//  Tacker
//
//  Created by Mohamed Eid on 11/27/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountSettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *privacySegmentedControl;


- (IBAction)dismissViewController:(id)sender;
- (IBAction)saveAccountSettings:(id)sender;
- (IBAction)resignFirstResponders:(id)sender;

@end
