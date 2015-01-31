//
//  NIZDerbyJam.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/4/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIZConstants.pch"

//@protocol NIZJamDelegate <NSObject>
//
//@end

@interface NIZDerbyJam : NSObject
//@property (weak, nonatomic) id <NIZJamDelegate> delegate;
@property (nonatomic) NSInteger homeJamScore;
@property (nonatomic) NSInteger visitorJamScore;
@property (strong, nonatomic) NSString * leadJammerStatus;

-(id) initHomeJammer: (NSString *) home visitorJammer: (NSString *) visitor;

-(void) addOneTo:(NSString *) team;
-(void) subtractOneFrom:(NSString *) team;

-(void) setHomeJammerName: (NSString *) name;
-(void) setVisitorJammerName: (NSString *) name;

-(NSString *) homeJammerName;
-(NSString *) visitorJammerName;

//+(void) jamOrderNumber; //a way for the Jam to know what ID it is.

@end
