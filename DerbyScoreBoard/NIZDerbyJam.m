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

@synthesize delegate = _delegate;
@synthesize homeJammerName = _homeJammerName;
@synthesize visitorJammerName = _visitorJammerName;
@synthesize homeJamScore = _homeJamScore;
@synthesize visitorJamScore = _visitorJamScore;
@synthesize leadJammerStatus = _leadJammerStatus;


- (id)initHomeJammer: (NSString *) home visitorJammer: (NSString *) visitor{
    self = [super init];
    if (self) {
        _homeJammerName = home;
        _visitorJammerName = visitor;
        _visitorJamScore = 0;
        _homeJamScore = 0;
    }
    return self;
}


//TODO: these could be more concise.
-(void) addOneTo:(NSString *) team{
    if([team isEqualToString:@"Visitor"]){
        self.visitorJamScore = self.visitorJamScore+1;
        if(self.delegate){
            [self.delegate visitorTeamJamScoreDidChange: self.visitorJamScore];
        }
    }else if([team isEqualToString:@"Home"]){
        self.homeJamScore = self.homeJamScore+1;
        if(self.delegate){
            [self.delegate homeTeamJamScoreDidChange: self.homeJamScore];
        }
    }
}

-(void) subtractOneFrom:(NSString *) team{
    if([team isEqualToString:@"Visitor"]){
        if(self.visitorJamScore > 0){
            self.visitorJamScore = self.visitorJamScore-1;
            if(self.delegate){
                [self.delegate visitorTeamJamScoreDidChange: self.visitorJamScore];
            }
        }
    }else if([team isEqualToString:@"Home"]){
        if(self.homeJamScore > 0){
            self.homeJamScore = self.homeJamScore-1;
            if(self.delegate){
                [self.delegate homeTeamJamScoreDidChange: self.homeJamScore];
            }
        }
    }
}

@end
