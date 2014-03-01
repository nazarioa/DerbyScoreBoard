//
//  NIZDerbyJam.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/4/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NIZJamDelegate <NSObject>
@optional
-(void) homeTeamJamScoreDidChange: (NSInteger) newScore;
-(void) homeTeamScoreDidChange: (NSInteger) newScore;
-(void) visitorTeamJamScoreDidChange: (NSInteger) newScore;
-(void) visitorTeamScoreDidChange: (NSInteger) newScore;
@end

@interface NIZDerbyJam : NSObject

@property (weak, nonatomic) id <NIZJamDelegate> delegate;
@property NSInteger homeJamScore;
@property NSInteger visitorJamScore;

-(id) initHomeJammer: (NSString *) home visitorJammer: (NSString *) visitor;

-(void) addOneTo:(NSString *) team;
-(void) subtractOneFrom:(NSString *) team;

-(void) setHomeJammerName: (NSString *) name;
-(void) setVisitorJammerName: (NSString *) name;

-(NSString *) homeJammerName;
-(NSString *) visitorJammerName;

//+(void) jamOrderNumber; //a way for the Jam to know what ID it is.

@end
