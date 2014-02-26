//
//  NIZPlayer.m
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 2/25/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import "NIZPlayer.h"

@implementation NIZPlayer

@synthesize derbyName = _derbyName;
@synthesize derbyNumber = _derbyNumber;
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize mugShot = _mugShot;

-(id) init{
    return [self initWithDerbyName:@"NO NAME" derbyNumber:@"NO NUMBER" firstName:@"NO NAME" lastName:@"NO LASTNAME"];
}

-(id) initWithDerbyName: (NSString *) name derbyNumber: (NSString *) number firstName: (NSString *) first lastName: (NSString *) last{
    self = [super init];
    if(self){
        _derbyName = name;
        _derbyNumber = number;
        _firstName = first;
        _lastName = last;
        _mugShot = nil;
    }
    
    return self;
}

@end
