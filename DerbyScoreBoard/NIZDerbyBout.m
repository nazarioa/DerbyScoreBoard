//
//  NIZDerbyBout.m
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/4/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import "NIZDerbyBout.h"

@interface NIZDerbyBout()

@property (strong, nonatomic) NSMutableArray * jamLog;

@end

@implementation NIZDerbyBout

@synthesize jamLog = _jamLog;
@synthesize boutEventDate = _boutEventDate;

-(id) init{
    self = [super init];
    if(self){
        _boutEventDate = [NSDate date];
    }
    
    return self;
}

-(void) addJam:(NIZDerbyJam *)jam{
    NSLog(@"  NIZDerbyBout: addJam: %@ withHomeScore %ld andVisitorScore: %ld", jam, (long)jam.homeJamScore, (long)jam.visitorJamScore);
    [self.jamLog addObject:jam];
}

@end
