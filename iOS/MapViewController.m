//
//  MapViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 11/26/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController ()

@end

#define METERS_PER_MILE 1609.344
@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTracker:(Tracker *)tracker {
    self = [super initWithNibName:@"MapView" bundle:nil];
    if (self) {
        // Custom initialization
        _tracker = tracker;
        _trackersArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (IBAction)returnToTrackers:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)findMe:(id)sender {
    CLLocationManager *locationManager;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    float latitude = locationManager.location.coordinate.latitude;
    float longitude = locationManager.location.coordinate.longitude;
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = latitude;
    zoomLocation.longitude= longitude;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    [_mapView setRegion:viewRegion animated:YES];
}

- (IBAction)popDirectionsController:(id)sender {
    DirectionsViewController *directionsController = [[DirectionsViewController alloc]init];
    directionsController.title = _navigationBar.topItem.title;
    directionsController.route = _route;
    [MY_APPDELEGATE.tabBarController.navigationController pushViewController:directionsController animated:YES];
}

- (IBAction)changeMapMode:(id)sender {
    if(_mapView.mapType == MKMapTypeStandard) {
        _mapView.mapType = MKMapTypeHybrid;
    }
    else {
        _mapView.mapType = MKMapTypeStandard;
    }
}

- (IBAction)openOptions:(id)sender {
    NSString *name = _tracker.name.length > 0 ? _tracker.name : [NSString stringWithFormat:@"@%@",_tracker.tracked_user.username];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Options"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:[NSString stringWithFormat:@"Block %@",name]
                                                    otherButtonTitles:@"Delete Tracker", @"Change Map Mode", nil];
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // block user
    if(buttonIndex == 0) {
        [_tracker.tracked_user block:^(BOOL success){
            if(success) {
                CURRENT_USER.shouldRefreshTrackers = (BOOL *)YES;
                CURRENT_USER.shouldReloadFriends = (BOOL *)YES;
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    // delete tracker
    if(buttonIndex == 1) {
        [_tracker destroy:^(BOOL success){
            if(success){
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    // change map mode
    if(buttonIndex == 2) {
        [self changeMapMode:nil];
    }
}

- (IBAction)askToOpenInMaps:(id)sender {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Would you like directions to this tracker using a maps application?"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:nil];
    [message addButtonWithTitle:@"Apple Maps"];
    if ([[UIApplication sharedApplication] canOpenURL:
         [NSURL URLWithString:@"comgooglemaps://"]]) {
       [message addButtonWithTitle:@"Google Maps"];
    }
    [message show];
}

- (void)openInMaps {
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        // Create an MKMapItem to pass to the Maps app
        CLLocationCoordinate2D coordinate =
        CLLocationCoordinate2DMake(_tracker.latitude, _tracker.longitude);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        
        NSString *name = _tracker.name.length > 0 ? _tracker.name : [NSString stringWithFormat:@"@%@",_tracker.tracked_user.username];
        [mapItem setName:name];
        
        // Set the directions mode to "Walking"
        // Can use MKLaunchOptionsDirectionsModeDriving instead
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking};
        // Get the "Current User Location" MKMapItem
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        // Pass the current location and destination map items to the Maps app
        // Set the direction mode in the launchOptions dictionary
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
                       launchOptions:launchOptions];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) {
        [self openInMaps];
    }
    else if(buttonIndex == 2) {
        CLLocationManager *locationManager;
        locationManager = [[CLLocationManager alloc] init];
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        float latitude = locationManager.location.coordinate.latitude;
        float longitude = locationManager.location.coordinate.longitude;
        
        NSString *googleMapsURLString = [NSString stringWithFormat:@"comgooglemaps://?saddr=%1.6f,%1.6f&daddr=%1.6f,%1.6f&directionsmode=driving",
                                         latitude, longitude, _tracker.latitude, _tracker.longitude];
        
        [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString:googleMapsURLString]];
    }
}

- (IBAction)findFriend:(id)sender {
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = _tracker.latitude;
    zoomLocation.longitude= _tracker.longitude;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    [_mapView setRegion:viewRegion animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _navigationBar.topItem.title = _tracker.name.length > 0 ? _tracker.name : [NSString stringWithFormat:@"@%@",_tracker.tracked_user.username];
    
    // Set up interstitial Google ad
    _interstitial = [[GADInterstitial alloc] init];
    _interstitial.delegate = self;
    _interstitial.adUnitID = @"ca-app-pub-1976056318408736/6629220802";
    [_interstitial loadRequest:[GADRequest request]];

    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate *date = [dateFormat dateFromString:_tracker.updatedAt];
    
    // Convert date object to desired output format
    [dateFormat setDateFormat:@"EEEE MM.dd @ hh:mm a"];
    
    NSTimeZone *tz = [NSTimeZone localTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: date];
    NSDate *localDate = [NSDate dateWithTimeInterval: seconds sinceDate:date];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake(_tracker.latitude, _tracker.longitude);
    point.title = _tracker.name.length > 0 ? _tracker.name : [NSString stringWithFormat:@"@%@",_tracker.tracked_user.username];
    point.subtitle = [dateFormat stringFromDate:localDate];
    [self.mapView addAnnotation:point];
    [_mapView selectAnnotation:point animated:YES];
    
    CALayer *layer = [_meButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
    
    layer = [_updateMyLocationButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
    
    layer = [_friendButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
    
    layer = [_mapModeButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];
    
    /*layer = [_refreshButton layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:3.0];*/
    
    [self findFriend:nil];
    //[self getDirections];
}

- (void)viewDidAppear:(BOOL)animated {
    [_tracker see];
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    [_interstitial presentFromRootViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)getDirections {
    // Create an instance of MKDirectionsRequest
    MKDirectionsRequest *request =
    [[MKDirectionsRequest alloc] init];
    
    // Define the starting point for routing direction
    request.source = [MKMapItem mapItemForCurrentLocation];
    
    // Define the ending point for routing direction
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = _tracker.latitude;
    zoomLocation.longitude= _tracker.longitude;
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:zoomLocation addressDictionary:nil];
    request.destination = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    // Define if your app wants multiple routes
    // when they are available
    request.requestsAlternateRoutes = YES;
    
    // Initialize directions object MKDirections
    MKDirections *directions =
    [[MKDirections alloc] initWithRequest:request];
    
    // Finally, calculate the directions
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {         
         MKRoute *route= (MKRoute *)response.routes[0];
         [_mapView addOverlay:route.polyline];
         _route = route;
     }];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.strokeColor = [UIColor orangeColor];
    renderer.lineWidth = 6.0;
    return renderer;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolygon class]])
    {
        MKPolygonView* aView = [[MKPolygonView alloc] initWithPolygon:(MKPolygon*)overlay];
        
        aView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        aView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        aView.lineWidth = 3;
        
        return aView;
    }
    else return nil;
}

@end
