//
//  SignUpViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "SignUpViewController.h"

#import "AppDelegate.h"
#import "AboutViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Sign Up";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *aboutButton = [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStylePlain target:self action:@selector(loadAboutViewController)];
    self.navigationItem.rightBarButtonItem = aboutButton;
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    _hud.mode = MBProgressHUDAnimationFade;
    _hud.labelText = @"Signing Up";
    _hud.hidden = YES;
    [_hud hide:YES];
    
    CALayer *layer = [_signUpButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
}

- (void)viewDidAppear:(BOOL)animated {
    _hud.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadAboutViewController {
    AboutViewController *aboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (IBAction)signUp:(id)sender {
    if(_emailTextField.text.length > 0 && _usernameTextField.text.length > 0 && _passwordTextField.text.length > 0) {
        if([self NSStringIsValidEmail:_emailTextField.text] && [self NSStringIsValidUsername:_usernameTextField.text]) {
            [self resignFirstResponder:nil];
            NSDictionary *userInfo = @{@"user":@{@"email": _emailTextField.text, @"username": _usernameTextField.text, @"password": _passwordTextField.text}};
            [_hud show:YES];
            [User create:userInfo completionBlock:^(User *user){
                if(user) {
                    [MY_APPDELEGATE switchToSession:self.navigationController];
                }
                [_hud hide:YES];
            }];
        }
    }
    else {
        [self alertIncompleteForm];
    }
}

- (IBAction)resignFirstResponder:(id)sender {
    [_emailTextField resignFirstResponder];
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == _emailTextField) {
        [_usernameTextField becomeFirstResponder];
    }
    if(textField == _usernameTextField) {
        [_passwordTextField becomeFirstResponder];
    }
    if(textField == _passwordTextField) {
        [self signUp:nil];
    }
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self resignFirstResponder:nil];
}

@end
