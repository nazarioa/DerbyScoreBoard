//
//  NIZDerbyJamClock.m
//  PlayGround
//
//  Created by Nazario A. Ayala on 8/8/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import "NIZGameClock.h"


@interface NIZGameClock()

//    {
//        //QUESTION: Instance variables go here?
//        //NSString *clockName;
//        //NSTimer *timer;
//        //int secondsLeft;
//        //int hours, minutes, seconds;
//        //BOOL isRunning;
//    }

// @properties go here.
// QUESTION. Where are these variables defined?
// They just declare the _existance_ of methods for variables.
@property (strong, nonatomic) NSString * clockName;
@property (strong, nonatomic) NSTimer * timer;
@property NSInteger timerDuration;
@property int secondsLeft;
@property int hours, minutes, seconds;
@property BOOL isRunning;

@end


@implementation NIZGameClock

@synthesize delegate = _delegate;
@synthesize clockName = _clockName;
@synthesize timer = _timer;
@synthesize secondsLeft = _secondsLeft;
@synthesize hours = _hours, minutes = _minutes, seconds = _seconds;
@synthesize isRunning = _isRunning;
@synthesize timerDuration = _timerDuration;

-(id)init{
    NSLog(@"init");
    self = [self initWithCounterLimitTo: 10 named: nil];
    return self;
}

-(id)initWithCounterLimitTo:(NSInteger)count named:(NSString *) name{
    self = [super init];
    if(self){
        NSLog(@"initWithCounterLimitTo: %ld", (long)count);
        _clockName = name;
        _timerDuration = _secondsLeft = count;
        _isRunning = NO;
    }
    
    return self;
}

-(id)initWithCounterLimitTo:(NSInteger)count named:(NSString *) name delegateIs:(id) delegateName{
    self = [self initWithCounterLimitTo:count named:name];
    [self setDelegate:delegateName];
    [self updateDisplay];
    return self;
}


-(void)startClock{
    if([self isRunning] == NO){
        NSLog(@"startClock");
        [self countdownTimer];
    }
}

-(void)countdownTimer{
    //TODO: 7.14 -- aka start painting
        NSLog(@"countdownTimer");
        self.hours = self.minutes = self.seconds = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
        self.isRunning = YES;
}

- (void)updateCounter:(NSTimer *)theTimer {
    //TODO: 7.14 -- aka paint
    if(self.secondsLeft > 0 ){
        self.secondsLeft--;
        [self updateDisplay];
        
    }else{
        [self stopClock];
        if( [self.delegate respondsToSelector:@selector(clockReachedZero:)]){
            [self.delegate clockReachedZero:self.clockName];
        }
    }
}

- (void)updateDisplay{
    self.hours = self.secondsLeft / 3600;
    self.minutes = (self.secondsLeft % 3600) / 60;
    self.seconds = (self.secondsLeft % 3600) % 60;
    if( [self.delegate respondsToSelector:@selector(timeHasChangedFor:hourNowIs:minuteNowIs:secondNowIs:)] ){
        [self.delegate timeHasChangedFor:self.clockName hourNowIs: [NSNumber numberWithInt: self.hours] minuteNowIs:[NSNumber numberWithInt:self.minutes] secondNowIs: [NSNumber numberWithInt:self.seconds]];
        // NSLog(@"Clock: %@ %02d:%02d:%02d", self.clockName, self.hours, self.minutes, self.seconds);
    }else{
        NSLog(@"DELEGATE NOT FOUND -- Clock: %@ %02d:%02d:%02d", self.clockName, self.hours, self.minutes, self.seconds);
    }
}

-(void) stopClock{
    if( [self isRunning] == YES){
        [self pauseClock];
        [self resetClock];
    }
}

-(void) pauseClock{
    //TODO: 7.14 -- stop painting
    if( [self isRunning] == YES ){
        [self.timer invalidate];
        self.timer = nil;
        self.isRunning = NO;
    }
}

-(void) resetClock{
    [self resetClockTo: self.timerDuration];
}

-(void) resetClockTo: (NSInteger) newSecondsLeft{
    NSLog(@"resetClockTo: %i ", newSecondsLeft);
    self.secondsLeft = newSecondsLeft;
    [self updateDisplay];
}

-(void) expired{
    NSLog(@"expired");
    self.isRunning = NO;
}

-(bool) isExpired{
    return self.isRunning;
}



@end
