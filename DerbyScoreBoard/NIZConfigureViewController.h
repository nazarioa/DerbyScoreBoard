//
//  NIZConfigureViewController.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 3/10/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIZDerbyTeam.h"
//#import "NIZScoreBoardViewController.h"

@class NIZScoreBoardViewController;

@protocol NIZDerbyGameProtocol <NSObject>
-(void) updateConfiguration;
-(NIZDerbyTeam *) getTeam: (NSString *) team;
-(void) resetClocks;
@end


@interface NIZConfigureViewController : UIViewController
@property (weak, nonatomic) id <NIZDerbyGameProtocol> delegate;
@end
