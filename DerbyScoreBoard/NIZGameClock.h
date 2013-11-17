//
//  NIZDerbyJamClock.h
//  PlayGround
//
//  Created by Nazario A. Ayala on 8/8/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameClockDelegate <NSObject>

@required
-(void) didTimeChange: (NSDate *) newTime named:(NSString *) clockName;
-(void) didReachLimitOf:(NSString *) clockName;
@end

@interface NIZGameClock : NSObject

-(void) startClock;
-(void) pauseClock;
-(void) stopClock;
-(id) initWithCounterLimitTo: (NSInteger) count named:(NSString *) clockName;
-(id) init;
-(BOOL) clockIsRunning;

//This line makes a link back to the object(delegate) that will execute on behalf of this object -- the delegate must implement the did * do code;
//id means that it can be any object the <stuff> means it must conform to the protocall stuff.
@property (nonatomic, assign) id<GameClockDelegate> delegate;

@end