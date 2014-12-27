//
//  NIZSpectatorScreenViewController.m
//  Derby
//
//  Created by Nazario A. Ayala on 10/17/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import "NIZSpectatorScreenViewController.h"
#import "NIZGameClock.h"

@interface NIZSpectatorScreenViewController ()
@property (strong, nonatomic) IBOutlet UILabel *specJamClockLabel;
@property (strong, nonatomic) IBOutlet UILabel *specBoutClockLabel;
@property (strong, nonatomic) IBOutlet UILabel *specPeriodClockLabel;
@property (strong, nonatomic) IBOutlet UIView *specClockView;

@end


@implementation NIZSpectatorScreenViewController

@synthesize specBoutClockLabel = _specBoutClockLabel;
@synthesize specJamClockLabel = _specJamClockLabel;
@synthesize specPeriodClockLabel = _specPeriodClockLabel;

@synthesize boutClockTime = _boutClockTime;
@synthesize jamClockTime = _jamClockTime;
@synthesize periodClockTime = _periodClockTime;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.specBoutClockLabel.adjustsFontSizeToFitWidth = YES;
    self.specJamClockLabel.adjustsFontSizeToFitWidth = YES;
    
    NSLog(@"NIZSpectatorScreenViewController is on screen");
    NSLog(@"  NIZSpectatorScreenViewController");
    NSLog(@" ");
    NSLog(@"  - view.bounds.size.width: %f",  self.view.bounds.size.width);
    NSLog(@"  - view.bounds.size.height: %f", self.view.bounds.size.height);
    NSLog(@" ");
    NSLog(@"  - view.bounds.origin.x: %f", self.view.bounds.origin.x);
    NSLog(@"  - view.bounds.origin.y: %f", self.view.bounds.origin.y);
    NSLog(@" ");
    NSLog(@"   - view.bounds.center is: %f", self.view.center.x);
    
    //CGPoint boutClockCenter = CGPointMake(self.view.center.x - (self.specBoutClockLabel.bounds.size.width / 2.0), 0);
    CGPoint boutClockCenter = CGPointMake(0.0, 0.0);
    
    self.specBoutClockLabel.center = boutClockCenter;
    //[self.specClockView setCenter:boutClockCenter];
    [self.specPeriodClockLabel setCenter:boutClockCenter];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) jamClockTime:(NSInteger) timeInSeconds{
    self.specJamClockLabel.text = [NSString stringWithFormat:@"%02d:%02d",
                                    [NIZGameClock getMinutesFromTimeInSeconds:timeInSeconds],
                                    [NIZGameClock getSecondsFromTimeInSeconds:timeInSeconds]];
}

-(void) boutClockTime:(NSInteger) seconds{
    self.specBoutClockLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",
                                    [NIZGameClock getHoursFromTimeInSeconds:seconds],
                                    [NIZGameClock getMinutesFromTimeInSeconds:seconds], 
                                    [NIZGameClock getSecondsFromTimeInSeconds:seconds]];
}

-(void) periodClockTime:(NSInteger) timeInSeconds{
    self.specPeriodClockLabel.text = [NSString stringWithFormat:@"%02d",
                                    [NIZGameClock getSecondsFromTimeInSeconds:timeInSeconds]];
}

@end
