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

@interface NIZScoreBoardViewController : UIViewController <NIZClockDelegate, NIZJamDelegate, NIZDerbyGameProtocol>

{
    NIZGameClock *gameClock;
    NIZGameClock *jamClock;
    NIZGameClock *preJamClock;
}


-(void) updateConfiguration;
-(NIZDerbyTeam *) getTeam: (NSString *) team;
-(UIWindow *) scoreBoardSpectatorWindow;
-(void) setScoreBoardSpectatorWindow: (UIWindow *) theWindow;

@end