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


//init
-(id) init{
    self = [self initWithTeamName:@"NO NAME" andTeamLogo:nil];
    return self;
}


-(id) initWithTeamName: (NSString *) name {
    self = [self initWithTeamName: name andTeamLogo:nil];
    return self;
}

-(id) initWithTeamName: (NSString *) name andTeamLogo:(UIImage *) teamLogo{
    self = [super init];
    if(self){
        self.teamName = name;
        self.teamLogo = teamLogo;
        self.teamRoster = [[NSMutableArray alloc] init];
    }
    return self;
}


//property set/get
-(void) setTeamName:(NSString *)teamName{
    if(teamName){
        _teamName = teamName;
        NSDictionary * data = @{@"TeamName" : teamName};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"teamNameHasChanged" object: self userInfo:data];
    }
}

-(void) addPlayer:(NIZPlayer *) player{
    if(player){
        if(player){
            [self.teamRoster addObject:player];
            NSDictionary * data = @{@"NewPlayer" : player};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"playerHasBeenAdded" object: self userInfo:data];
        }
    }
}

-(void) removePlayer:(NIZPlayer *) player{
    if(player){
        [self.teamRoster removeObject:player];
        NSDictionary * data = @{@"RemovedPlayer" : player};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"playerHasBeenRemoved" object: self userInfo:data];
    }
}

-(void) setTeamLogo:(UIImage *)teamLogo{
    if(teamLogo){
        _teamLogo = teamLogo;
        NSDictionary * data = @{@"teamLogo" : teamLogo};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"teamLogoHasBeenSet" object: self userInfo:data];
    }
}


//other
-(NIZPlayer *) getPlayerAtPosition: (NSInteger) position{
    if(-1 < position  &&  position < self.teamRoster.count){
        NIZPlayer * player = [self.teamRoster objectAtIndex:position];
        return player;
    }
    return nil;
}

-(NIZPlayer *) getPlayerAtPosition: (NSInteger) position isAJammer: (BOOL) isAJammer{
    if(-1 < position  &&  position < self.teamRoster.count){
        NIZPlayer * player = [self.teamRoster objectAtIndex:position];
        if(player.isJammer == isAJammer)
            return player;
    }
    return nil;
}

-(BOOL) isOnRoster:(NIZPlayer *) player{
    if([self.teamRoster indexOfObject:player] > -1 ){
        return YES;
    }else{
        return NO;
    }
}

-(NSInteger) rosterCount{
    return self.teamRoster.count;
}

-(NSInteger) jammerCount{
    NSInteger count = 0;
    for (int i = 0; i < [self.teamRoster count]; i++) {
        if([self getPlayerAtPosition: i isAJammer: YES]){
            count ++;
        }
    }
    return count;
}

-(NSString *) playerDerbyNameAtPosition: (NSInteger) position{
    NIZPlayer * temp = [self.teamRoster objectAtIndex:position];
    return [temp derbyName];
}

-(NSString *) playerDerbyNumberAtPosition: (NSInteger) position{
    NIZPlayer * temp = [self.teamRoster objectAtIndex:position];
    return [temp derbyNumber];
}

-(UIImage *) playerDerbyMugAtPosition: (NSInteger) position{
    NIZPlayer * player = [self.teamRoster objectAtIndex:position];
    return [player mugShot];
}

@end