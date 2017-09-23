//
//  WelcomeViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "WelcomeViewController.h"
#import "SignInViewController.h"
#import "SignUpViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Welcome";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CALayer *layer = [_signInButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
    
    layer = [_signUpButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)loadSignInView:(id)sender {
    SignInViewController *signInViewController = [[SignInViewController alloc] initWithNibName:@"SignInView" bundle:nil];
    [self.navigationController pushViewController:signInViewController animated:YES];
}

- (IBAction)loadSignUpView:(id)sender {
    SignUpViewController *signUpViewController = [[SignUpViewController alloc] initWithNibName:@"SignUpView" bundle:nil];
    [self.navigationController pushViewController:signUpViewController animated:YES];
}

@end
