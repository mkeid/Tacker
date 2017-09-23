//
//  DirectionsViewController.h
//  Tacker
//
//  Created by Mohamed Eid on 12/26/13.
//  Copyright (c) 2013 Mohamed Eid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "DirectionCell.h"

@interface DirectionsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) AVSpeechSynthesizer *speechSynth;
@property (nonatomic) MKRoute *route;
@end
