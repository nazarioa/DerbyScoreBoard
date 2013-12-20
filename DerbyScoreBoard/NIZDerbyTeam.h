//
//  NIZDerbyTeam.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/4/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NIZDerbyTeam : NSObject

@property (strong, nonatomic) NSString * teamName;
@property (strong, nonatomic) NSURL * teamLogo;

-(void) addPlayer: (NSString *) name;
-(void) removePlayer: (int) position;

@end
