//
//  NIZViewController.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/3/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIZConstants.pch"
#import "NIZGameClock.h"
#import "NIZDerbyJam.h"
#import "NIZConfigurePageViewController.h"
#import "NIZSpectatorScreenViewController.h"

@interface NIZScoreBoardViewController : UIViewController <NIZClockDelegate, /*NIZJamDelegate,*/ NIZConfigureScreenProtocol, NIZConfigureTeamScreenProtocol, NSFileManagerDelegate>

@property (strong, nonatomic) NIZSpectatorScreenViewController * spectatorViewController;

@end