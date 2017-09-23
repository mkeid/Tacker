//
//  SettingsViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "SettingsViewController.h"

#import "AccountSettingsViewController.h"
#import "AboutViewController.h"
#import "UpdatePasswordViewController.h"
#import "WelcomeViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Settings";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Set default border radius.
    CALayer * layer = [_accountSettingsButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
    
    layer = [_updatePasswordButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
    
    layer = [_aboutButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
    
    layer = [_signOutButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"tab-bar-item-selected-blue"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)loadAccountSettingsViewController:(id)sender {
    AccountSettingsViewController *accountSettingsViewController = [[AccountSettingsViewController alloc] initWithNibName:@"AccountSettingsView" bundle:nil];
    [self.tabBarController presentViewController:accountSettingsViewController animated:YES completion:nil];
}

- (IBAction)loadUpdatePasswordViewController:(id)sender {
    UpdatePasswordViewController *updatePasswordViewController = [[UpdatePasswordViewController alloc] initWithNibName:@"UpdatePasswordView" bundle:nil];
    [self.tabBarController presentViewController:updatePasswordViewController animated:YES completion:nil];
}

- (IBAction)loadAboutViewController:(id)sender {
    AboutViewController *aboutViewController = [[AboutViewController alloc] init];
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

- (IBAction)signOut:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign Out" message:@"Are you sure you want to sign out?"  delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: @"Sign Out", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1) {
        //[TackerAuth signout];
        CURRENT_USER = nil;
        [TackerAuth signOut:^(BOOL success){}];
        WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc] initWithNibName:@"WelcomeView" bundle:nil];
        [self.navigationController setNavigationBarHidden:YES];
        [self.navigationController setViewControllers:@[welcomeViewController] animated:YES];
    }
}
@end
