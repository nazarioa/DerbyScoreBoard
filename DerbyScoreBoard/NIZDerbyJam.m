//
//  NIZDerbyJam.m
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/4/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import "NIZDerbyJam.h"

@interface NIZDerbyJam()

@property (nonatomic, strong) NSString * homeJammerName;
@property (nonatomic, strong) NSString * visitorJammerName;
@end


@implementation NIZDerbyJam

//@synthesize delegate = _delegate;
@synthesize homeJammerName = _homeJammerName;
@synthesize visitorJammerName = _visitorJammerName;
@synthesize homeJamScore = _homeJamScore;
@synthesize visitorJamScore = _visitorJamScore;
@synthesize leadJammerStatus = _leadJammerStatus;


//init
- (id)init{
    self = [super init];
    if (self) {
        _visitorJamScore = 0;
        _homeJamScore = 0;
    }
    
    NSLog(@" New Jam: %@", self);
    return self;
}

- (id)initHomeJammer: (NSString *) home visitorJammer: (NSString *) visitor{
    self = [self init];
    if (self) {
        _homeJammerName = home;
        _visitorJammerName = visitor;
    }
    
    NSDictionary * score = @{@"TEAM" : VISITOR_TEAM, @"SCORE" : [NSString stringWithFormat: @"%d", self.visitorJamScore] };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"JamScoreHasChanged" object: self userInfo:score];
    
    score = @{@"TEAM" : HOME_TEAM, @"SCORE" : [NSString stringWithFormat: @"%d", self.homeJamScore] };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"JamScoreHasChanged" object: self userInfo:score];
    
    return self;
}

//property set/get
-(void) setVisitorJamScore:(NSInteger)visitorJamScore{
    _visitorJamScore = visitorJamScore;
    NSDictionary * score = @{@"TEAM" : VISITOR_TEAM, @"SCORE" : [NSString stringWithFormat: @"%d", self.visitorJamScore] };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"JamScoreHasChanged" object: self userInfo:score];
}

-(void) setHomeJamScore:(NSInteger)homeJamScore{
    _homeJamScore = homeJamScore;
    NSDictionary * score = @{@"TEAM" : HOME_TEAM, @"SCORE" : [NSString stringWithFormat: @"%d", self.homeJamScore] };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"JamScoreHasChanged" object: self userInfo:score];
}

-(void) setLeadJammerStatus:(NSString *)leadJammerStatus{
    _leadJammerStatus = leadJammerStatus;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LeadJammerStatusHasChanged" object: self userInfo:nil];
}

//other
-(void) addOneTo:(NSString *) team{
    if([team isEqualToString: VISITOR_TEAM]){
        self.visitorJamScore = self.visitorJamScore + 1;
    }else if([team isEqualToString: HOME_TEAM]){
        self.homeJamScore = self.homeJamScore + 1;
    }
}

-(void) subtractOneFrom:(NSString *) team{
    if([team isEqualToString: VISITOR_TEAM]){
        if(self.visitorJamScore > 0){
            self.visitorJamScore = self.visitorJamScore-1;
        }
    }else if([team isEqualToString: HOME_TEAM]){
        if(self.homeJamScore > 0){
            self.homeJamScore = self.homeJamScore-1;
        }
    }
}

@end
