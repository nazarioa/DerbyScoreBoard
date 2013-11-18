//
//  NIZDerbyJamClock.h
//  PlayGround
//
//  Created by Nazario A. Ayala on 8/8/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameClockDelegate <NSObject>

//@required
//-(void) didTimeChange: (NSDate *) newTime named:(NSString *) clockName;
//-(void) didReachLimitOf:(NSString *) clockName;
@end

@interface NIZGameClock : NSObject{
    //QUESTION: What are the properties of what goes here? Why would you put something here VS somewhere else.
}

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


//This line makes a link back to the object(delegate) that will execute on behalf of this object -- the delegate must implement the did * do code;
//id means that it can be any object the <stuff> means it must conform to the protocall stuff.
//@property (nonatomic, assign) id<GameClockDelegate> delegate;

@end