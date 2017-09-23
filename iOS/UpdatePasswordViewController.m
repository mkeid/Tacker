//
//  UpdatePasswordViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 11/27/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "UpdatePasswordViewController.h"

@interface UpdatePasswordViewController ()

@end

@implementation UpdatePasswordViewController

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
    [_passwordTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)updatePassword:(id)sender {
    if(_passwordTextField.text.length > 0 && _changedPassword1TextField.text.length > 0 && _changedPassword2TextField.text.length > 0) {
        if([_changedPassword1TextField.text isEqualToString:_changedPassword2TextField.text]) {
            if(_passwordTextField.text != _changedPassword1TextField.text) {
                [MY_APPDELEGATE.tackerAPI postMeUpdatePassword:@{@"passwords":@{@"password1":_passwordTextField.text,@"password2":_changedPassword1TextField.text, @"password3":_changedPassword2TextField.text}} completionBlock:^(BOOL success) {
                    if(success) {
                        // alert success
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved."
                                                                        message:@"Your password has been updated."
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                        [alert show];
                    }
                    else {
                        // alert error
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops."
                                                                        message:@"There was an error."
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                        [alert show];
                    }
                }];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unchanged password."
                                                                message:@"Your new password is the same as your current one. Watcha trying to change?"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unmatching new password."
                                                            message:@"Your new password is not entered exactly the same for both fields."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete form."
                                                        message:@"You forgot to fully fill out the form."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)resignFirstResponders:(id)sender {
    [_passwordTextField resignFirstResponder];
    [_changedPassword1TextField resignFirstResponder];
    [_changedPassword2TextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == _passwordTextField) {
        [_changedPassword1TextField becomeFirstResponder];
    }
    if(textField == _changedPassword1TextField) {
        [_changedPassword2TextField becomeFirstResponder];
    }
    if(textField == _changedPassword2TextField) {
        [self updatePassword:nil];
    }
    return YES;
}

@end
