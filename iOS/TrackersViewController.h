//
//  TrackersViewController.h
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Google-Mobile-Ads-SDK/GADBannerView.h>

@interface TrackersViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ADBannerView *iAdBannerView;
@property (nonatomic, copy) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet GADBannerView *gAdBannerView;
- (IBAction)refresh:(id)sender;

@end
