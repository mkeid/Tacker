//
//  TrackersViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 11/19/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "TrackersViewController.h"

#import <Google-Mobile-Ads-SDK/GADBannerView.h>
#import "MapViewController.h"
#import "TrackerCell.h"

@interface TrackersViewController ()

@end

@implementation TrackersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Trackers";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
    
    _gAdBannerView.adUnitID = @"ca-app-pub-1976056318408736/5152487607";
    _gAdBannerView.rootViewController = self;
}

- (void)viewDidAppear:(BOOL)animated {
    if(CURRENT_USER.shouldRefreshTrackers) {
        [self refresh:nil];
    }
    if(CURRENT_USER.shouldReloadTrackers) {
        [_tableView reloadData];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"tab-bar-item-selected-red"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [CURRENT_USER.trackersArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrackerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackerCell"];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TrackerCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell setCell:(Tracker *)[CURRENT_USER.trackersArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MapViewController *mapViewController = [[MapViewController alloc] initWithTracker:((TrackerCell *)[tableView cellForRowAtIndexPath:indexPath]).tracker];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

- (IBAction)refresh:(id)sender {
    __weak id blockSafeSelf = self;
    [MY_APPDELEGATE.tackerAPI getMeTrackers:^(NSArray *array){
        [((TrackersViewController *)blockSafeSelf).refreshControl endRefreshing];
        if(array){
            [CURRENT_USER assignTrackersArray:array];
            [_tableView reloadData];
            [MY_APPDELEGATE setTrackersBadgeCount];
        }
        CURRENT_USER.shouldRefreshTrackers = NO;
    }];
}

-(void)hideBanner:(UIView*)banner
{
    if (banner && ![banner isHidden])
    {
        [UIView beginAnimations:@"hideBanner" context:nil];
        //banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
        banner.hidden = YES;
    }
}

-(void)showBanner:(UIView*)banner
{
    if (banner && [banner isHidden])
    {
        [UIView beginAnimations:@"showBanner" context:nil];
        //banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        [UIView commitAnimations];
        banner.hidden = NO;
    }
}

// Called before the add is shown, time to move the view
- (void)bannerViewWillLoadAd:(ADBannerView *)banner
{
    NSLog(@"iAd load");
    [self hideBanner:self.gAdBannerView];
    [self showBanner:self.iAdBannerView];
}

// Called when an error occured
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"iAd error: %@", error);
    [self hideBanner:self.iAdBannerView];
    [self.gAdBannerView loadRequest:[GADRequest request]];
    [GADRequest request].testDevices = @[ @"15f180adb6e0f8b689c668f14f28599f" ];
}

// Called before ad is shown, good time to show the add
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    NSLog(@"Admob load");
    [self hideBanner:self.iAdBannerView];
    [self showBanner:self.gAdBannerView];
}

// An error occured
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"Admob error: %@", error);
    [self hideBanner:self.gAdBannerView];
}
@end
