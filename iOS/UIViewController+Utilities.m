//
//  UIViewController+Utilities.m
//  Tacker
//
//  Created by Mohamed Eid on 12/18/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "UIViewController+Utilities.h"


@implementation UIViewController (Utilities)

- (BOOL) NSStringIsValidEmail:(NSString *)checkString {
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    BOOL isValid = [emailTest evaluateWithObject:checkString];
    if(!isValid) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Email"
                                                        message:@"Please enter a valid email addess."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    return isValid;
}

- (BOOL) NSStringIsValidUsername:(NSString *)checkString {
    NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
    
    BOOL isValid = [[checkString stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
    if(!isValid) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Username"
                                                        message:@"Please enter a valid username. Your username can only contain letters of the alphabet and numbers."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    return isValid;
}

- (NSString *)NSStringStripToNumbers:(NSString *)originalString {
    NSMutableString *strippedString = [NSMutableString
                                       stringWithCapacity:originalString.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet
                               characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
            
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    return strippedString;
}

- (void)alertIncompleteForm {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete Form"
                                                    message:@"You forgot to fully fill out the form."
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}
@end
