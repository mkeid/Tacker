//
//  SignInViewController.h
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SignInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *signInTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (nonatomic) MBProgressHUD *hud;

- (IBAction)signIn:(id)sender;
- (IBAction)resignFirstResponder:(id)sender;
- (IBAction)popResetPasswordViewController:(id)sender;

@end
