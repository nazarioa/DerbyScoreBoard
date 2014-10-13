//
//  NIZConfigureViewController.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 3/10/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIZDerbyTeam.h"
#import "NIZAddEditPlayerViewController.h"
//#import "NIZScoreBoardViewController.h"

@class NIZScoreBoardViewController;

@protocol NIZDerbyGameProtocol <NSObject>
-(void) updateConfiguration;
-(NIZDerbyTeam *) getTeam: (NSString *) type;
-(void) setTeam: (NSString *) type with: (NIZDerbyTeam *) team;
-(void) resetClocks;


-(UIWindow *) scoreBoardSpectatorWindow;
-(void) setScoreBoardSpectatorWindow: (UIWindow *) theWindow;
@end


@interface NIZConfigureViewController : UIViewController <addEditPlayerProtocol>
@property (weak, nonatomic) id <NIZDerbyGameProtocol> delegate;
-(NSInteger) numExternalDisplays;
@end
