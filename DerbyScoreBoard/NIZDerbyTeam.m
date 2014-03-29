//
//  NIZDerbyTeam.m
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/4/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import "NIZDerbyTeam.h"



@interface NIZDerbyTeam()
@property (strong, nonatomic) NSMutableArray * teamRoster;
@end



@implementation NIZDerbyTeam

@synthesize teamName = _teamName;
@synthesize teamRoster = _teamRoster;
@synthesize teamLogo = _teamLogo;

-(id) init{
    self = [self initWithTeamName:@"NO NAME" andTeamLogo:nil];
    return self;
}


-(id) initWithTeamName: (NSString *) name {
    self = [self initWithTeamName: name andTeamLogo:nil];
    return self;
}

-(id) initWithTeamName: (NSString *) name andTeamLogo:(NSURL *) teamLogo{
    self = [super init];
    if(self){
        self.teamName = name;
        self.teamLogo = nil;
        self.teamRoster = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void) addPlayer:(NIZPlayer *) player{
    if(player){
        [self.teamRoster addObject:player];
    }
}

-(void) removePlayer:(NIZPlayer *) player{
    if(player){
        [self.teamRoster addObject:player];
    }
}

-(BOOL) isOnRoster:(NIZPlayer *) player{
    //TODO
    return YES;
}

-(NSInteger) rosterCount{
    return self.teamRoster.count;
}

-(NSString *) playerDerbyNameAtPosition: (NSInteger) position{
    NIZPlayer * temp = [self.teamRoster objectAtIndex:position];
    return [temp derbyName];
}

-(NSString *) playerDerbyNumberAtPosition: (NSInteger) position{
    NIZPlayer * temp = [self.teamRoster objectAtIndex:position];
    return [temp derbyNumber];
}

@end