//
//  NIZViewController.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/3/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIZGameClock.h"

@interface NIZScoreBoardViewController : UIViewController <NIZClockDelegate>

{
    NIZGameClock *gameClock;
    NIZGameClock *jamClock;
    NIZGameClock *preJamClock;
    
}

@end