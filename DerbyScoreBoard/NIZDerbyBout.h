//
//  NIZDerbyBout.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/4/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIZConstants.pch"
#import "NIZDerbyJam.h"

@interface NIZDerbyBout : NSObject

@property (strong, nonatomic) NSDate * boutEventDate;

-(void) addJam: (NIZDerbyJam *) jam;

@end
