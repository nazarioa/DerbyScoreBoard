//
//  NIZDerbyJamClock.m
//  PlayGround
//
//  Created by Nazario A. Ayala on 8/8/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import "NIZGameClock.h"

@interface NIZGameClock()

@property (strong, nonatomic) NSTimer * timer;
@property (nonatomic) NSInteger timerDuration;
@property (nonatomic) NSInteger hours, minutes, seconds;
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


//init
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
//    [self notifyOfTimeChange];
    return self;
}


//properties getters/setters
-(void) setSecondsLeft:(NSInteger)secondsLeft{
    _secondsLeft = secondsLeft;
    NSDictionary * data = @{@"ClockName" : self.clockName, @"SecondsLeft" : [NSNumber numberWithInteger:secondsLeft] };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clockTimeHasChangedFor" object: self userInfo:data];
}


//other
-(void)startClock{
    if([self isRunning] == NO){
        NSLog(@"startClock");
        [self countdownTimer];
    }
}

-(void)countdownTimer{
    NSLog(@"countdownTimer");
    self.hours = self.minutes = self.seconds = 0;
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateCounter) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes]; //magical line here
    self.isRunning = YES;
}

- (void)updateCounter {
    if(self.secondsLeft > 0 ){
        self.secondsLeft--;
        
    }else{
        [self stopClock];
        if( [self.delegate respondsToSelector:@selector(clockReachedZero:)]){
            [self.delegate clockReachedZero:self.clockName];
        }
    }
}

-(void) stopClock{
    if( [self isRunning] == YES){
        [self pauseClock];
        [self resetClock];
    }
}

-(void) pauseClock{
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
    NSLog(@"resetClockTo: %i ", (int)newSecondsLeft);
    self.secondsLeft = newSecondsLeft;
}

-(void) expired{
    NSLog(@"expired");
    self.isRunning = NO;
}

-(bool) isExpired{
    return self.isRunning;
}


//class
+(NSInteger) getHoursFromTimeInSeconds:(NSInteger) timeInSeconds{
    return timeInSeconds / 3600;
}

+(NSInteger) getMinutesFromTimeInSeconds:(NSInteger) timeInSeconds{
    return (timeInSeconds % 3600) / 60;
}

+(NSInteger) getSecondsFromTimeInSeconds:(NSInteger) timeInSeconds{
    return (timeInSeconds % 3600) % 60;
}

@end