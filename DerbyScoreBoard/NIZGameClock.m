//
//  NIZDerbyJamClock.m
//  PlayGround
//
//  Created by Nazario A. Ayala on 8/8/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import "NIZGameClock.h"


@interface NIZGameClock()
@property NSInteger counterLimit;
@property NSInteger clockDisplayCount;
@property BOOL isRunning;
@property NSString * clockName;
@end


@implementation NIZGameClock

@synthesize delegate;

@synthesize clockName = _clockName;
@synthesize counterLimit = _counterLimit;
@synthesize clockDisplayCount = _clockDisplayCount;
@synthesize isRunning = _isRunning;
double timerInterval = 1.00;
double timerElapsed = 0.0;
NSDate *timerStarted;
NSTimer *timer;

//NSInteger clockDisplayCount;

-(id)init{
    NSLog(@"Init");
    self = [self initWithCounterLimitTo: 10 named:(NSString *) nil];
    return self;
}

-(id)initWithCounterLimitTo:(NSInteger)count named:(NSString *) clockName{
    NSLog(@"initWithCounterLimitTo");
    self = [super init];
    if(self){
        NSLog(@"initWithCounterLimitTo: %ld", (long)count);
        
        _counterLimit = count;
        _clockDisplayCount = count;
        _clockName = clockName;
        [self resetClockTo: count];
        self.isRunning = NO;
    }
    
    return self;
}

-(void) startClock{
    //NSLog(@"startClock");
    timer = [NSTimer scheduledTimerWithTimeInterval:(timerInterval - timerElapsed) target:self selector:@selector(fired) userInfo:nil repeats:NO];
    timerStarted = [NSDate date];
    self.isRunning = YES;
}

-(void) fired{
    //NSLog(@"fired %ld", (long)[self clockDisplayCount]);
    [timer invalidate];
    timer = nil;
    timerElapsed = 0.0;
    [self startClock];
    [self timeChange: [NSDate date]];
    
    //Clock Stuff here.
    _clockDisplayCount --;
    
    if(_clockDisplayCount == 0){
        [self reachLimit];
        [self stopClock];
        [self resetClockTo:_counterLimit];
    }
}

-(void) pauseClock{
    NSLog(@"pauseClock");
    [timer invalidate];
    timer = nil;
    timerElapsed = [[NSDate date] timeIntervalSinceDate: timerStarted];
    self.isRunning = NO;
}

-(void) stopClock{
    [self pauseClock];
}


-(void) resetClockTo: (NSInteger) count{
    NSLog(@"resetClockTo %ld", (long)count);
    if(count < self.counterLimit){
        self. clockDisplayCount = count;
    }else{
        self.clockDisplayCount = self.counterLimit;
    }
}

-(void) resetClock{
    //NSLog(@"resetClock");
    [self resetClockTo: self.counterLimit];
}

-(BOOL) clockIsRunning{
    return self.isRunning;
}

-(void) timeChange: (NSDate *) newTime{
    NSLog(@"timeChange -- Clock Name: %@", [self clockName]);
    [self.delegate didTimeChange:newTime named:[self clockName]];
}

-(void) reachLimit{
    NSLog(@"reachLimit");
    [self.delegate didReachLimitOf: [self clockName]];
}


@end
