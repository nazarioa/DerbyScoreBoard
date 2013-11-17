//
//  NIZDerbyJam.m
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/4/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import "NIZDerbyJam.h"

@interface NIZDerbyJam()
@property (nonatomic) NSInteger homeJamScore;
@property (nonatomic) NSInteger visitorJamScore;
@property (strong, nonatomic) NSString * homeJammerName;
@property (strong, nonatomic) NSString * visitorJammerName;
@end


@implementation NIZDerbyJam


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

@synthesize homeJammerName = _homeJammerName;
@synthesize visitorJammerName = _visitorJammerName;
@synthesize homeJamScore = _homeJamScore;
@synthesize visitorJamScore = _visitorJamScore;

-(void) setHomeJamScore:(NSInteger) score{
    _homeJamScore = score;
}

-(void) setVisitorJamScore:(NSInteger) score{
    _visitorJamScore = score;
}

-(void) addOneToHome{
    _homeJamScore = _homeJamScore+1;
}

-(void) addOneToVisitor{
    _visitorJamScore = _visitorJamScore+1;
}

-(void) subtractOneFromHome{
    if(_homeJamScore > 0){
        _homeJamScore = _homeJamScore-1;
    }
}
-(void) subtractOneFromVisitor{
    if(_visitorJamScore > 0){
        _visitorJamScore = _visitorJamScore-1;
    }
}

-(NSInteger) homeJamScore{
    return _homeJamScore;
}
-(NSInteger) visitorJamScore{
    return _visitorJamScore;
}


@end
