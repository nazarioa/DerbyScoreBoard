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
@property (strong, nonatomic) UIImage * teamLogo;
//@property (strong, nonatomic) NSString * teamT


-(id) initWithTeamName: (NSString *) name;
-(id) initWithTeamName: (NSString *) name andTeamLogo:(UIImage *) teamLogo;

-(void) addPlayer: (NIZPlayer *) player;
-(void) removePlayer: (NIZPlayer *) player;

-(NIZPlayer *) getPlayerAtPosition: (NSInteger) position;
-(NIZPlayer *) getPlayerAtPosition: (NSInteger) position isAJammer: (BOOL) isAJammer;

-(NSInteger) rosterCount;
-(NSString *) playerDerbyNameAtPosition: (NSInteger) position;
-(NSString *) playerDerbyNumberAtPosition: (NSInteger) position;
-(UIImage *) playerDerbyMugAtPosition: (NSInteger) position;

@end