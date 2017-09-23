//
//  UIViewController+Utilities.h
//  Tacker
//
//  Created by Mohamed Eid on 12/18/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utilities)
- (BOOL) NSStringIsValidEmail:(NSString *)checkString;
- (BOOL) NSStringIsValidUsername:(NSString *)checkString;
- (NSString *)NSStringStripToNumbers:(NSString *)originalString;
- (void)alertIncompleteForm;
@end
