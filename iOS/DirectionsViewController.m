//
//  DirectionsViewController.m
//  Tacker
//
//  Created by Mohamed Eid on 12/26/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import "DirectionsViewController.h"

@interface DirectionsViewController ()

@end

@implementation DirectionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _speechSynth = [[AVSpeechSynthesizer alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _route.steps.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DirectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Directionell"];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DirectionCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.stepCountLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    MKRouteStep *routeStep = (MKRouteStep *)_route.steps[indexPath.row];
    cell.instructionLabel.text = routeStep.instructions;
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*DirectionCell *cell = (DirectionCell *)[_tableView cellForRowAtIndexPath:indexPath];
    AVSpeechUtterance *speechUtterance = [[AVSpeechUtterance alloc] initWithString:cell.instructionLabel.text];
    speechUtterance.rate = 0.25;
    [_speechSynth speakUtterance:speechUtterance];*/
}

@end
