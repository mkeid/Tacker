//
//  UpdatePasswordViewController.h
//  Tacker
//
//  Created by Mohamed Eid on 11/27/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface UpdatePasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *changedPassword1TextField;
@property (weak, nonatomic) IBOutlet UITextField *changedPassword2TextField;


- (IBAction)dismissViewController:(id)sender;
- (IBAction)updatePassword:(id)sender;
- (IBAction)resignFirstResponders:(id)sender;

@end
