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
    return [self initWithDerbyName:@"NO NAME" derbyNumber:@"NO NUMBER" firstName:@"NO NAME" lastName:@"NO LASTNAME" mugShot:nil isJammer:FALSE];
}

-(id) initWithDerbyName: (NSString *) name derbyNumber: (NSString *) number firstName: (NSString *) first lastName: (NSString *) last mugShot: (UIImage *) picture isJammer: (BOOL) isJammer{
    self = [super init];
    if(self){
        _derbyName = name;
        _derbyNumber = number;
        _firstName = first;
        _lastName = last;
        _mugShot = picture;
        _isJammer = isJammer;
    }
    
    return self;
}

-(void) setDerbyName:(NSString *)derbyName{
    _derbyName = derbyName;
    NSDictionary * data = @{@"PlayerDerbyName" : derbyName};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerDerbyNameHasChanged" object: self userInfo:data];
}

-(void) setDerbyNumber:(NSString *)derbyNumber{
    _derbyNumber = derbyNumber;
    NSDictionary * data = @{@"PlayerDerbyNumber" : derbyNumber};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerDerbyNumberHasChanged" object: self userInfo:data];
}

-(void) setFirstName:(NSString *)firstName{
    _firstName = firstName;
    NSDictionary * data = @{@"PlayerDerbyFirstName" : firstName};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerDerbyFirstNameHasChanged" object: self userInfo:data];
}

-(void) setLastName:(NSString *)lastName{
    _lastName = lastName;
    NSDictionary * data = @{@"PlayerDerbyFirstName" : lastName};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerDerbyLastNameHasChanged" object: self userInfo:data];
}

-(void) setMugShot:(UIImage *)mugShot{
    _mugShot = mugShot;
    NSDictionary * data = @{@"PlayerDerbyMug" : mugShot};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerDerbyMugHasChanged" object: self userInfo:data];
}

-(void) setIsJammer:(BOOL)isJammer{
    _isJammer = isJammer;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayerDerbyIsJammerHasChanged" object: self userInfo:nil];
}

@end
