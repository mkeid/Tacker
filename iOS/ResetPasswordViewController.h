//
//  ResetPasswordViewController.h
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendEmailButton;

- (IBAction)resignFirstResponder:(id)sender;
- (IBAction)sendEmail:(id)sender;

@end
