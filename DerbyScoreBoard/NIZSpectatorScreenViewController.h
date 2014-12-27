//
//  NIZSpectatorScreenViewController.h
//  Derby
//
//  Created by Nazario A. Ayala on 10/17/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NIZSpectatorScreenViewController : UIViewController

@property (nonatomic) NSInteger jamClockTime;
@property (nonatomic) NSInteger boutClockTime;
@property (nonatomic) NSInteger periodClockTime;

-(void) boutClockTime:(NSInteger) seconds;
-(void) jamClockTime:(NSInteger) seconds;
-(void) periodClockTime:(NSInteger) seconds;

@end
