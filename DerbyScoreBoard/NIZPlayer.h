//
//  NIZPlayer.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 2/25/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIZConstants.pch"

@interface NIZPlayer : NSObject
@property (nonatomic, strong) NSString * derbyName;
@property (nonatomic, strong) NSString * derbyNumber;
@property (nonatomic, strong) NSString * firstName;
@property (nonatomic, strong) NSString * lastName;
@property (nonatomic, strong) UIImage * mugShot;
@property (nonatomic) BOOL isJammer;


-(id) initWithDerbyName: (NSString *) name derbyNumber: (NSString *) number firstName: (NSString *) first lastName: (NSString *) last mugShot: (UIImage *) picture isJammer: (BOOL) isJammer;
@end
