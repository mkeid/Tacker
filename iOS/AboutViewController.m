//
//  AboutViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 11/26/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"About";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if(MY_APPDELEGATE.tabBarController) {
        [self.navigationController setNavigationBarHidden:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    if(MY_APPDELEGATE.tabBarController) {
        [self.navigationController setNavigationBarHidden:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    NSURL *websiteUrl = [NSURL URLWithString:@"http://tacker.me"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [_webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
