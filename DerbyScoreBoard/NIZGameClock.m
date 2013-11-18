//
//  NIZDerbyJamClock.m
//  PlayGround
//
//  Created by Nazario A. Ayala on 8/8/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import "NIZGameClock.h"


@interface NIZGameClock()

{
    //QUESTION: Instance variables go here?
    NSString *clockName;
    NSTimer *timer;
    int secondsLeft;
    int hours, minutes, seconds;
    BOOL isRunning;
}

// @properties go here.
// They just declare the _existance_ of methods for variables.
// QUESTION. Where are these variables defined?
@property (strong, nonatomic) NSString * clockName;
@property (strong, nonatomic) NSTimer * timer;
@property NSInteger timerDuration;
@property int secondsLeft;
@property int hours, minutes, seconds;
@property BOOL isRunning;

@end


@implementation NIZGameClock


// QUESTION: What sort of variables go here?

//@synthesize delegate;
//@synthesize clockName;
//@synthesize clockDisplayCount = _clockDisplayCount;
//@synthesize isRunning = _isRunning;
//double timerInterval = 1.00;
//double timerElapsed = 0.0;
//NSDate *timerStarted;
//NSTimer *timer;
//NSInteger clockDisplayCount;


-(id)init{
    NSLog(@"init");
    self = [self initWithCounterLimitTo: 10 named:(NSString *) nil];
    return self;
}

-(id)initWithCounterLimitTo:(NSInteger)count named:(NSString *) name{
    NSLog(@"initWithCounterLimitTo");
    self = [super init];
    if(self){
        NSLog(@"initWithCounterLimitTo: %ld", (long)count);
        _clockName = name;
        _timerDuration = _secondsLeft = count;
        _isRunning = NO;
    }
    
    return self;
}

-(void)countdownTimer{
    NSLog(@"countdownTimer");
    self.hours = self.minutes = self.seconds = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
    //timer = [NSTimer scheduledTimerWithTimeInterval:(timerInterval - timerElapsed) target:self selector:@selector(fired) userInfo:nil repeats:NO];
    //timerStarted = [NSDate date];
    
}

- (void)updateCounter:(NSTimer *)theTimer {
    //NSLog(@"Clock name: (%@) time left (%i)", self.clockName, self.secondsLeft);
    
    if(self.secondsLeft > 0 ){
        self.secondsLeft--;
        self.hours = self.secondsLeft / 3600;
        self.minutes = (self.secondsLeft % 3600) / 60;
        self.seconds = (self.secondsLeft % 3600) % 60;
        self.isRunning = YES;
        NSLog(@"Clock name: (%@) time left (%i) -- (%02d:%02d:%02d)", self.clockName, self.secondsLeft, self.hours, self.minutes, self.seconds);
        
    }else{
        [self expired];
        [self pauseClock];
        //[self resetClockTo:_counterLimit];
    }
}

-(void) expired{
    NSLog(@"expired");
    self.isRunning = NO;
}

-(bool) isExpired{
    return self.isRunning;
}

-(void) pauseClock{
    NSLog(@"pauseClock");
    [self.timer invalidate];
    self.timer = nil;
}

-(void) stopClock{
    [self pauseClock];
}

-(void) resetClock{
    [self resetClockTo: self.timerDuration];
}

-(void) resetClockTo: (NSInteger) newSecondsLeft{
    self.secondsLeft = newSecondsLeft;
}


/*
-(void) timeChange: (NSDate *) newTime{
    NSLog(@"timeChange -- Clock Name: %@", [self clockName]);
    [self.delegate didTimeChange:newTime named:[self clockName]];
}

-(void) reachLimit{
    NSLog(@"reachLimit");
    [self.delegate didReachLimitOf: [self clockName]];
}
*/


@synthesize clockName = _clockName;
@synthesize timer = _timer;
@synthesize secondsLeft = _secondsLeft;
@synthesize hours = _hours, minutes = _minutes, seconds = _seconds;
@synthesize isRunning = _isRunning;
@synthesize timerDuration = _timerDuration;

@end
