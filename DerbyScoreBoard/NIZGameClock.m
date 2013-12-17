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

    @synthesize delegate;
    @synthesize clockName = _clockName;
    @synthesize timer = _timer;
    @synthesize secondsLeft = _secondsLeft;
    @synthesize hours = _hours, minutes = _minutes, seconds = _seconds;
    @synthesize isRunning = _isRunning;
    @synthesize timerDuration = _timerDuration;

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


    -(void)startClock{
        NSLog(@"startClock");
        [self countdownTimer];
    }

    -(void)countdownTimer{
        NSLog(@"countdownTimer");
        self.hours = self.minutes = self.seconds = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
        self.isRunning = YES;
    }

    - (void)updateCounter:(NSTimer *)theTimer {
        if(self.secondsLeft > 0 ){
            self.secondsLeft--;
            self.hours = self.secondsLeft / 3600;
            self.minutes = (self.secondsLeft % 3600) / 60;
            self.seconds = (self.secondsLeft % 3600) % 60;
            self.isRunning = YES;
            
            //if ( [self.delegate respondsToSelector:@selector(clock:timeChangeTo:)] ) {
            if( [self.delegate respondsToSelector:@selector(clock:hourIs:minutesIs:secondsIs:)] ){
                [self.delegate clock:self.clockName hourIs: [NSNumber numberWithInt: self.hours] minutesIs:[NSNumber numberWithInt:self.minutes] secondsIs: [NSNumber numberWithInt:self.seconds]];
            }
            
        }else{
            [self pauseClock];
            if( [self.delegate respondsToSelector:@selector(clockRechedZero:)]){
                [self.delegate clockRechedZero:self.clockName];
            }
        }
    }

    -(void) stopClock{
        [self pauseClock];
    }

    -(void) pauseClock{
        NSLog(@"pauseClock");
        [self.timer invalidate];
        self.timer = nil;
        self.isRunning = NO;
    }

    -(void) resetClock{
        [self resetClockTo: self.timerDuration];
    }

    -(void) resetClockTo: (NSInteger) newSecondsLeft{
        NSLog(@"resetClockTo: %i ", newSecondsLeft);
        self.secondsLeft = newSecondsLeft;
    }

    -(void) expired{
        NSLog(@"expired");
        self.isRunning = NO;
    }

    -(bool) isExpired{
        return self.isRunning;
    }



@end
