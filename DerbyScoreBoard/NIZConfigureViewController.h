//
//  NIZConfigureViewController.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 3/10/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NIZScoreBoardViewController.h"

@class NIZScoreBoardViewController;

@protocol NIZDerbyGameProtocol <NSObject>
-(void) updateConfiguration;
-(void) setTeamNameTo: (NSString *) name forTeam:(NSString *) team;
-(NSString *) getTeamNameFor: (NSString *) team;
@end


@interface NIZConfigureViewController : UIViewController
@property (weak, nonatomic) id <NIZDerbyGameProtocol> delegate;
@end
