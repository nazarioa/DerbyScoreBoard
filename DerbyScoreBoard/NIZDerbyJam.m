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


//init
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

//property set/get
-(void) setVisitorJamScore:(NSInteger)visitorJamScore{
    _visitorJamScore = visitorJamScore;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"VisitorJamScore has changed" object: self userInfo:nil];
}

-(void) setHomeJamScore:(NSInteger)homeJamScore{
    _homeJamScore = homeJamScore;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeJamScore has changed" object: self userInfo:nil];
}

-(void) setLeadJammerStatus:(TEAM_DESIGNATION)leadJammerStatus{
    _leadJammerStatus = leadJammerStatus;
    
}

//other
-(void) addOneTo:(NSString *) team{
    if([team isEqualToString:@"Visitor"]){
        self.visitorJamScore = self.visitorJamScore+1;
    }else if([team isEqualToString:@"Home"]){
        self.homeJamScore = self.homeJamScore+1;
    }
}

-(void) subtractOneFrom:(NSString *) team{
    if([team isEqualToString:@"Visitor"]){
        if(self.visitorJamScore > 0){
            self.visitorJamScore = self.visitorJamScore-1;
        }
    }else if([team isEqualToString:@"Home"]){
        if(self.homeJamScore > 0){
            self.homeJamScore = self.homeJamScore-1;
        }
    }
}

@end
