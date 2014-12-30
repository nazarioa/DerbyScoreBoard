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

@property (strong, nonatomic) UIView *specClocksView;
@property (strong, nonatomic) UILabel *specJamClockLabel;
@property (strong, nonatomic) UILabel *specBoutClockLabel;
@property (strong, nonatomic) UILabel *specPeriodClockLabel;

@end


@implementation NIZSpectatorScreenViewController
//CLOCKS
@synthesize boutClockTime = _boutClockTime;
@synthesize jamClockTime = _jamClockTime;
@synthesize periodClockTime = _periodClockTime;

//LABELS
@synthesize specClocksView = _specClocksView;
@synthesize specBoutClockLabel = _specBoutClockLabel;
@synthesize specJamClockLabel = _specJamClockLabel;
@synthesize specPeriodClockLabel = _specPeriodClockLabel;

@synthesize specHomeTeamJamScore = _specHomeTeamJamScore;
@synthesize specVistorTeamJamScore = _specVistorTeamJamScore;

@synthesize specHomeTeamTotalScore = _specHomeTeamTotalScore;
@synthesize specVistorTeamTotalScore = _specVistorTeamTotalScore;

@synthesize specHomeTeamJammerNameNumber = _specHomeTeamJammerNameNumber;
@synthesize specVistorTeamJammerNameNumber = _specVistorTeamJammerNameNumber;

@synthesize specHomeTeamName = _specHomeTeamName;
@synthesize specVistorTeamName = _specVistorTeamName;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.specBoutClockLabel.adjustsFontSizeToFitWidth = YES;
    self.specJamClockLabel.adjustsFontSizeToFitWidth = YES;
    self.view.backgroundColor = [UIColor yellowColor];

}

-(void) viewWillAppear:(BOOL)animated{
    NSLog(@"NIZSpectatorScreenViewController WILL APPEAR");
    NSLog(@"=============================================");
    NSLog(@"  - view.bounds.size.width: %f",  self.view.bounds.size.width);
    NSLog(@"  - view.bounds.size.height: %f", self.view.bounds.size.height);
    NSLog(@" ");
    NSLog(@"  - view.bounds.origin.x: %f", self.view.bounds.origin.x);
    NSLog(@"  - view.bounds.origin.y: %f", self.view.bounds.origin.y);
    NSLog(@" ");
    NSLog(@"  - view.bounds.center.x: %f", self.view.center.x);
    NSLog(@"  - view.bounds.center.y: %f", self.view.center.y);
    NSLog(@"---------------------------------------------");
    
    [self setupRulers];
    [self setupClockView];
    [self setupScoreViews:@"home"];
    [self setupScoreViews:@"visitor"];
    
//    CGPoint DAPOINT = CGPointMake(self.view.center.x - (590/2), self.view.center.y - (512/2));
//    [self.specClockView setCenter:DAPOINT];
//    NSLog(@"self.specClockView.bounds.size.width: %f", self.specClockView.bounds.size.width);
//    NSLog(@"self.specClockView.bounds.size.height: %f", self.specClockView.bounds.size.height);
//    
//    CGRect TESTRECT = CGRectMake(self.view.center.x - (590/2), self.view.center.y - (256/2), 590, 256);
//    UIView *TESTVIEW = [[UIView alloc] initWithFrame:TESTRECT];
//    TESTVIEW.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:TESTVIEW];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) jamClockTime:(NSInteger) timeInSeconds{
    self.specJamClockLabel.text = [NSString stringWithFormat:@"%02d:%02d",
                                    (int)[NIZGameClock getMinutesFromTimeInSeconds:timeInSeconds],
                                    (int)[NIZGameClock getSecondsFromTimeInSeconds:timeInSeconds]];
}

-(void) boutClockTime:(NSInteger) seconds{
    self.specBoutClockLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",
                                    (int)[NIZGameClock getHoursFromTimeInSeconds:seconds],
                                    (int)[NIZGameClock getMinutesFromTimeInSeconds:seconds],
                                    (int)[NIZGameClock getSecondsFromTimeInSeconds:seconds]];
}

-(void) periodClockTime:(NSInteger) timeInSeconds{
    self.specPeriodClockLabel.text = [NSString stringWithFormat:@"%02d",
                                    (int)[NIZGameClock getSecondsFromTimeInSeconds:timeInSeconds]];
}

-(void) setupClockView{
    
    UIFont * jamClockLabelFont= [UIFont fontWithName:@"Courier" size:130];
    UIFont * boutClockLabelFont= [UIFont fontWithName:@"Courier" size:85];
    
    /*
     UIFont * jamClockLabelFont= [UIFont fontWithName:@"Gotham" size:130];
     UIFont * boutClockLabelFont= [UIFont fontWithName:@"Gotham" size:85];
     */
    
    // We are making the bound.size of the view 1/3 the width of the rootview (IE window)
    CGFloat clocksViewWidth = self.view.bounds.size.width/3;
    CGFloat clocksViewHeight = self.view.bounds.size.height/3;
    
    CGRect clocksViewPosition = CGRectMake(self.view.center.x - (clocksViewWidth/2),
                                           self.view.center.y - (clocksViewHeight/2),
                                           clocksViewWidth, clocksViewHeight);
    self.specClocksView = [[UIView alloc] initWithFrame:clocksViewPosition];
//    self.specClocksView.backgroundColor = [UIColor purpleColor];
    
    
    //jamClockView will be 2/3 the height of specClocksView
    CGRect jamClockViewPosition = CGRectMake(0,0, clocksViewWidth, 2*clocksViewHeight/3);
    self.specJamClockLabel = [[UILabel alloc] initWithFrame:jamClockViewPosition];
    self.specJamClockLabel.text = @"00:00";
    self.specJamClockLabel.backgroundColor = [UIColor greenColor];
    self.specJamClockLabel.textAlignment = NSTextAlignmentCenter;
    self.specJamClockLabel.font = jamClockLabelFont;
    
    //boutClockView will be 1/3 the height of the specClocksView and it's y will be 2/3 the way down.
    CGRect boutClockViewPosition = CGRectMake(0,2*clocksViewHeight/3, clocksViewWidth, clocksViewHeight/3);
    self.specBoutClockLabel = [[UILabel alloc] initWithFrame:boutClockViewPosition];
    self.specBoutClockLabel.text = @"00:00:00";
    self.specBoutClockLabel.backgroundColor = [UIColor orangeColor];
    self.specBoutClockLabel.textAlignment = NSTextAlignmentCenter;
    self.specBoutClockLabel.font = boutClockLabelFont;

    [self.specClocksView addSubview:self.specBoutClockLabel];
    [self.specClocksView addSubview:self.specJamClockLabel];
    
    [self.view addSubview: self.specClocksView];
    
}

-(void) setupScoreViews:(NSString *) team{
    UIFont * teamTotalScoreFont = [UIFont fontWithName:@"Gotham" size:130];
    UIFont * teamJamScoreFont = [UIFont fontWithName:@"Gotham" size:85];
    
    CGFloat teamJamScoreViewWidth = (self.view.bounds.size.width / 5);
    CGFloat teamJamScoreViewHeight = 120;
    
    CGRect teamTotalScoreViewPosition = CGRectMake(0, self.view.center.y, teamJamScoreViewWidth, teamJamScoreViewHeight);
    CGRect jamScoreViewPosition = CGRectMake(0, self.view.center.y - teamJamScoreViewHeight, teamJamScoreViewWidth, teamJamScoreViewHeight);
    
    if([team isEqualToString:@"home"]){
        jamScoreViewPosition.origin.x = (self.view.center.x * .4) - (teamJamScoreViewWidth/2);
        teamTotalScoreViewPosition.origin.x = jamScoreViewPosition.origin.x;
        
        self.specHomeTeamJamScore = [[UILabel alloc] initWithFrame:jamScoreViewPosition];
        self.specHomeTeamJamScore.text = @"0";
        self.specHomeTeamJamScore.backgroundColor = [UIColor brownColor];
        self.specHomeTeamJamScore.textAlignment = NSTextAlignmentCenter;
        self.specHomeTeamJamScore.font = teamJamScoreFont;
        
        self.specHomeTeamTotalScore = [[UILabel alloc] initWithFrame:teamTotalScoreViewPosition];
        self.specHomeTeamTotalScore.text = @"0";
        self.specHomeTeamTotalScore.backgroundColor = [UIColor brownColor];
        self.specHomeTeamTotalScore.textAlignment = NSTextAlignmentCenter;
        self.specHomeTeamTotalScore.font = teamTotalScoreFont;
        
        [self.view addSubview: self.specHomeTeamJamScore];
        [self.view addSubview: self.specHomeTeamTotalScore];
        
    }else if([team isEqualToString:@"visitor"]){
        jamScoreViewPosition.origin.x = (self.view.center.x * 1.6 ) - (teamJamScoreViewWidth/2);
        teamTotalScoreViewPosition.origin.x = jamScoreViewPosition.origin.x;
        
        self.specVistorTeamJamScore = [[UILabel alloc] initWithFrame:jamScoreViewPosition];
        self.specVistorTeamJamScore.text = @"0";
        self.specVistorTeamJamScore.backgroundColor = [UIColor blueColor];
        self.specVistorTeamJamScore.textAlignment = NSTextAlignmentCenter;
        self.specVistorTeamJamScore.font = teamJamScoreFont;
        
        self.specVistorTeamTotalScore = [[UILabel alloc] initWithFrame:teamTotalScoreViewPosition];
        self.specVistorTeamTotalScore.text = @"0";
        self.specVistorTeamTotalScore.backgroundColor = [UIColor blueColor];
        self.specVistorTeamTotalScore.textAlignment = NSTextAlignmentCenter;
        self.specVistorTeamTotalScore.font = teamTotalScoreFont;
        
        [self.view addSubview: self.specVistorTeamJamScore];
        [self.view addSubview: self.specVistorTeamTotalScore];
    }
}


-(void) grandSlamFor:(NSString *) team times:(NSInteger) number{
    if([team isEqualToString:@"home"]){
        NSLog(@"home team got GRANDSLAM: %d", (int) number);
    }else if([team isEqualToString:@"visitor"]){
        NSLog(@"home vistor got GRANDSLAM: %d", (int) number);
    }
}


-(void) setupRulers{
    CGRect ruler1280 =  CGRectMake(0, 0, 1280, 10);
    CGRect ruler720 =  CGRectMake(0, 0, 10, 720);
    UIView *rulerView1080 = [[UIView alloc] initWithFrame:ruler1280];
    rulerView1080.backgroundColor = [UIColor redColor];
    
    UIView *rulerView720 = [[UIView alloc] initWithFrame:ruler720];
    rulerView720.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:rulerView720];
    [self.view addSubview:rulerView1080];
}

@end
