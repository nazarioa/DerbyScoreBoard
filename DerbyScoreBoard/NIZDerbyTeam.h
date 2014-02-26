//
//  NIZDerbyTeam.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/4/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIZPlayer.h"

@interface NIZDerbyTeam : NSObject

@property (strong, nonatomic) NSString * teamName;
@property (strong, nonatomic) NSURL * teamLogo;


-(id) initWithTeamName: (NSString *) name;
-(id) initWithTeamName: (NSString *) name andTeamLogo:(NSURL *) teamLogo;

-(void) addPlayer: (NIZPlayer *) player;
-(void) removePlayer: (NIZPlayer *) player;
-(NSInteger) rosterCount;
-(NSString *) playerDerbyNameAtPosition: (int) position;
-(NSString *) playerDerbyNumberAtPosition: (int) position;

@end