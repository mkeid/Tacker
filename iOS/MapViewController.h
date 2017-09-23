//
//  MapViewController.h
//  Tacker
//
//  Created by Mohamed Eid on 11/26/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DirectionsViewController.h"
#import <Google-Mobile-Ads-SDK/GADInterstitial.h>


@interface MapViewController : UIViewController
@property (nonatomic) Tracker *tracker;
@property (nonatomic) NSMutableArray *trackersArray;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIButton *openInMapsButton;
@property (weak, nonatomic) IBOutlet UIButton *meButton;
@property (weak, nonatomic) IBOutlet UIButton *updateMyLocationButton;
@property (weak, nonatomic) IBOutlet UIButton *friendButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIButton *mapModeButton;
@property (nonatomic) MKRoute *route;
@property (weak, nonatomic) IBOutlet UIButton *alterShowAllTrackersButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *directionsButton;

@property (nonatomic) GADInterstitial *interstitial;

- (void)openInMaps;
- (id)initWithTracker:(Tracker *)tracker;
- (IBAction)returnToTrackers:(id)sender;
- (IBAction)findMe:(id)sender;
- (IBAction)popDirectionsController:(id)sender;
- (IBAction)changeMapMode:(id)sender;
- (IBAction)openOptions:(id)sender;
- (IBAction)findFriend:(id)sender;
@end
