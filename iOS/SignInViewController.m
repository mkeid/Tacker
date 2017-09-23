//
//  SignInViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "SignInViewController.h"

#import "AppDelegate.h"
#import "FriendsViewController.h"
#import "RequestsViewController.h"
#import "ResetPasswordViewController.h"
#import "SettingsViewController.h"
#import "TrackersViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Sign In";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *aboutButton = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(popResetPasswordViewController:)];
    self.navigationItem.rightBarButtonItem = aboutButton;
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    _hud.mode = MBProgressHUDAnimationFade;
    _hud.labelText = @"Signing In";
    _hud.hidden = YES;
    [_hud hide:YES];
    
    CALayer *layer = [_signInButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
    
    layer = [_forgotPasswordButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
}

- (void)viewDidAppear:(BOOL)animated {
   [_signInTextField becomeFirstResponder];
    _hud.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    [_hud hide:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)signIn:(id)sender {
    if(_signInTextField.text.length > 0 && _passwordTextField.text.length > 0) {
        
        [self resignFirstResponder:nil];
        _signInButton.enabled = NO;
        [_hud show:YES];
        
        [TackerAuth signIn:@{@"user":@{@"signin": _signInTextField.text, @"password": _passwordTextField.text}} completionBlock:^(NSDictionary *userDictionary){
            if(userDictionary) {
                // Add the confirmed account to the keychain.
                [SSKeychain setPassword:_passwordTextField.text forService:@"tacker" account:_signInTextField.text];
                
                User *currentUser = [User createUserFromDict:[(NSDictionary *)userDictionary objectForKey:@"me"]];
                MY_APPDELEGATE.tackerAPI.tackerAuth.currentUser = currentUser;
                [MY_APPDELEGATE switchToSession:self.navigationController];
            }
            [_hud hide:YES];
            _signInButton.enabled = YES;
        }];
    }
    else {
        [self alertIncompleteForm];
    }
}

- (IBAction)resignFirstResponder:(id)sender {
    [_signInTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

- (IBAction)popResetPasswordViewController:(id)sender {
    ResetPasswordViewController *resetPasswordViewController = [[ResetPasswordViewController alloc] initWithNibName:@"ResetPasswordView" bundle:nil];
    
    [self.navigationController pushViewController:resetPasswordViewController animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == _signInTextField) {
        [_passwordTextField becomeFirstResponder];
    }
    if(textField == _passwordTextField) {
        [self signIn:nil];
    }
    return YES;
}

@end
