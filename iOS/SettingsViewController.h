//
//  SettingsViewController.h
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *changedPassword1TextField;
@property (weak, nonatomic) IBOutlet UITextField *changedPassword2TextField;
@property (weak, nonatomic) IBOutlet UIButton *accountSettingsButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;
@property (weak, nonatomic) IBOutlet UIButton *updatePasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;

- (IBAction)loadAccountSettingsViewController:(id)sender;
- (IBAction)loadUpdatePasswordViewController:(id)sender;
- (IBAction)loadAboutViewController:(id)sender;
- (IBAction)signOut:(id)sender;
@end
