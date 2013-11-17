//
//  NIZDerbyJam.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/4/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NIZDerbyJam : NSObject

-(id) initHomeJammer: (NSString *) home visitorJammer: (NSString *) visitor;

-(void) setHomeJamScore:(NSInteger) score;
-(void) setVisitorJamScore:(NSInteger) score;

-(void) addOneToHome;
-(void) addOneToVisitor;

-(void) subtractOneFromHome;
-(void) subtractOneFromVisitor;

-(void) setHomeJammerName: (NSString *) name;
-(void) setVisitorJammerName: (NSString *) name;

-(NSInteger) homeJamScore;
-(NSInteger) visitorJamScore;

-(NSString *) homeJammerName;
-(NSString *) visitorJammerName;

//+(void) jamOrderNumber; //a way for the Jam to know what ID it is.

@end
