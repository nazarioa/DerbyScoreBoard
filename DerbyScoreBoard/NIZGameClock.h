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
- (void) clock: (NSString *) clockName hourIs: (NSNumber *) hours minutesIs:(NSNumber *) minutes secondsIs: (NSNumber *) seconds;
- (void) clockRechedZero: (NSString *) clockName;
@end


@interface NIZGameClock : NSObject{}

//Properties
@property (weak, nonatomic) id <NIZClockDelegate> delegate;

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