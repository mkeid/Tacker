//
//  ResetPasswordViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Reset Password";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_emailTextField becomeFirstResponder];
    
    CALayer *layer = [_sendEmailButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
}

- (void)viewDidAppear:(BOOL)animated {
    //[_emailTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)resignFirstResponder:(id)sender {
    [_emailTextField resignFirstResponder];
}

- (IBAction)sendEmail:(id)sender {
    if(_emailTextField.text.length >0) {
        if([self NSStringIsValidEmail:_emailTextField.text]) {
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid email."
                                                            message:@"Please enter a valid email addess."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete form."
                                                        message:@"You forgot to enter your email."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == _emailTextField) {
        [self sendEmail:nil];
    }
    return YES;
}

- (BOOL) NSStringIsValidEmail:(NSString *)checkString {
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

@end
