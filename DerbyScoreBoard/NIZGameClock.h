//
//  NIZDerbyJamClock.h
//  PlayGround
//
//  Created by Nazario A. Ayala on 8/8/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class NIZGameClock;
//This line baiscly says that this class exists at compline if I were to pass itself in but since in timeDidChange: I am suing NS String. I dont need it.


@protocol NIZClockDelegate <NSObject>
@required
- (void) timeHasChangedFor: (NSString *) clockName hourNowIs: (NSNumber *) hours minuteNowIs:(NSNumber *) minutes secondNowIs: (NSNumber *) seconds;
@optional
- (void) clockReachedZero: (NSString *) clockName;
@end


@interface NIZGameClock : NSObject{}

//Properties
@property (weak, nonatomic) id <NIZClockDelegate> delegate;

-(id) initWithCounterLimitTo: (NSInteger)count named:(NSString *) name delegateIs:(id) delegateName;
-(id) initWithCounterLimitTo: (NSInteger) count named:(NSString *) clockName;
-(id) init;

//Functions from the working sample may ot may not need to be here.
-(void) updateCounter:(NSTimer *) theTimer;
-(void) countdownTimer;

//Functions I may need others to have access to
-(BOOL) isRunning;
-(void) startClock;
-(void) pauseClock;
-(void) stopClock;
-(void) resetClock;

//test line
-(int) secondsLeft;


@end