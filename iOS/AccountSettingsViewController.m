//
//  AccountSettingsViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 11/27/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "AccountSettingsViewController.h"
#import "AppDelegate.h"

@interface AccountSettingsViewController ()

@end

@implementation AccountSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_emailTextField setText:CURRENT_USER.email];
    [_usernameTextField setText:CURRENT_USER.username];
    if(CURRENT_USER.phone_number) {
        [_phoneNumberTextField setText:CURRENT_USER.phone_number];
    }
    
    if(CURRENT_USER.is_private) {
        [_privacySegmentedControl setSelectedSegmentIndex:1];
    }
    else {
        [_privacySegmentedControl setSelectedSegmentIndex:0];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveAccountSettings:(id)sender {
    if(_emailTextField.text.length > 0 && _usernameTextField.text.length > 0) {
        if([self NSStringIsValidEmail:_emailTextField.text] && [self NSStringIsValidUsername:_usernameTextField.text]) {
            BOOL userPrivacy = NO;
            if([_privacySegmentedControl selectedSegmentIndex] == 1) {
                userPrivacy = YES;
                //NSLog([NSString stringWithFormat:@"%s",CURRENT_USER.is_private]);
            }
            
            NSDictionary *userInfo = @{@"user":@{@"email": _emailTextField.text, @"username": _usernameTextField.text, @"is_private": [NSNumber numberWithBool:userPrivacy], @"phone_number": _phoneNumberTextField.text}};
            [MY_APPDELEGATE.tackerAPI postMeUpdateAccount:userInfo completionBlock:^(NSDictionary *dictionary){
                if([(NSDictionary *)dictionary objectForKey:@"errors"]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops."
                                                                    message:[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"errors"]]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                else {
                    // Update auth user info.
                    User *currentUser = [User createUserFromDict:[dictionary objectForKey:@"me"]];
                    MY_APPDELEGATE.tackerAPI.tackerAuth.currentUser = currentUser;
                    
                    // Alert success.
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved."
                                                                    message:@"Your account settings have been saved."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
                    [alert show];
                }

            }];
        }
    }
    else {
        [self alertIncompleteForm];
    }
}

- (IBAction)resignFirstResponders:(id)sender {
    [_emailTextField resignFirstResponder];
    [_usernameTextField resignFirstResponder];
    [_phoneNumberTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == _emailTextField) {
        [_usernameTextField becomeFirstResponder];
    }
    if(textField == _usernameTextField) {
        [_phoneNumberTextField becomeFirstResponder];
    }
    if(textField == _phoneNumberTextField) {
        [_phoneNumberTextField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField == _phoneNumberTextField) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return !(newLength > 10);
    }
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self resignFirstResponders:nil];
}

@end
