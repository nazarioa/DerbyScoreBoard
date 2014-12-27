//
//  NIZDerbyJamClock.h
//  PlayGround
//
//  Created by Nazario A. Ayala on 8/8/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NIZClockDelegate <NSObject>
@required
- (void) timeHasChangedFor: (NSString *) clockName timeInSecondsIs: (NSInteger) seconds;

@optional
- (void) clockReachedZero: (NSString *) clockName;

@end


@interface NIZGameClock : NSObject

@property (weak, nonatomic) id <NIZClockDelegate> delegate;

-(id) initWithCounterLimitTo: (NSInteger)count named:(NSString *) name delegateIs:(id) delegateName;
-(id) initWithCounterLimitTo: (NSInteger) count named:(NSString *) clockName;
-(id) init;

//Functions I may need VC to be able to call to control the clock
-(BOOL) isRunning;
-(void) startClock;
-(void) pauseClock;
-(void) stopClock;
-(void) resetClock;

+(NSInteger) getHoursFromTimeInSeconds:(NSInteger) timeInSeconds;
+(NSInteger) getMinutesFromTimeInSeconds:(NSInteger) timeInSeconds;
+(NSInteger) getSecondsFromTimeInSeconds:(NSInteger) timeInSeconds;

@end