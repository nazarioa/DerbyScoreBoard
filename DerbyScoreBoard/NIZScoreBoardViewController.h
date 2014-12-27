//
//  NIZViewController.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/3/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIZGameClock.h"
#import "NIZDerbyJam.h"
#import "NIZConfigureViewController.h"
#import "NIZSpectatorScreenViewController.h"

@interface NIZScoreBoardViewController : UIViewController <NIZClockDelegate, NIZJamDelegate, NIZConfigureScreenProtocol>

@property (strong, nonatomic) NIZSpectatorScreenViewController * spectatorViewController;

-(void) updateConfiguration;


@end