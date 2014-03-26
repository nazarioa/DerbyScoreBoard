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
-(void) setHomeTeamName: (NSString *) home visitorTeamName: (NSString *) visitor;
-(void) setTeamNameTo: (NSString *) name forTeam:(NSString *) team;
-(NSString *) getTeamNameFor: (NSString *) team;

@end