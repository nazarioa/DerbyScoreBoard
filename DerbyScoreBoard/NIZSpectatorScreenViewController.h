//
//  NIZSpectatorScreenViewController.h
//  Derby
//
//  Created by Nazario A. Ayala on 10/17/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NIZSpectatorScreenViewController : UIViewController

@property (strong, nonatomic) UILabel *specHomeTeamJamScore;
@property (strong, nonatomic) UILabel *specVistorTeamJamScore;

@property (strong, nonatomic) UILabel *specHomeTeamTotalScore;
@property (strong, nonatomic) UILabel *specVistorTeamTotalScore;

@property (strong, nonatomic) UILabel *specHomeTeamJammerNameNumber;
@property (strong, nonatomic) UILabel *specVistorTeamJammerNameNumber;

@property (strong, nonatomic) UILabel *specHomeTeamName;
@property (strong, nonatomic) UILabel *specVistorTeamName;

@end
