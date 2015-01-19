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
@property (strong, nonatomic) NSNumber *teamNameFontSize;

@end


@implementation NIZSpectatorScreenViewController

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
    [self setupNotification];
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
    [self setupScoreViews: HOME_TEAM];
    [self setupScoreViews: VISITOR_TEAM];
    [self setupTeamNames: HOME_TEAM];
    [self setupTeamNames: VISITOR_TEAM];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupClockView{
    
    UIFont * jamClockLabelFont= [UIFont fontWithName:@"Courier" size:130];
    UIFont * boutClockLabelFont= [UIFont fontWithName:@"Courier" size:85];
    
    // We are making the bound.size of the view 1/3 the width of the rootview (IE window)
    CGFloat clocksViewWidth = self.view.bounds.size.width/3;
    CGFloat clocksViewHeight = self.view.bounds.size.height/3;
    
    CGRect clocksViewPosition = CGRectMake(self.view.center.x - (clocksViewWidth/2),
                                           self.view.center.y - (clocksViewHeight/2),
                                           clocksViewWidth, clocksViewHeight);
    self.specClocksView = [[UIView alloc] initWithFrame:clocksViewPosition];
    
    
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
    self.specBoutClockLabel.backgroundColor = [UIColor colorWithRed:180.0 green:40.0 blue:140.0 alpha:1];
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
    
    if([team isEqualToString: HOME_TEAM]){
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
        
    }else if([team isEqualToString: VISITOR_TEAM]){
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

-(void) setupTeamNames:(NSString *) team{
    //TODO: Figure out a way to control the the offset of the names where the font used for the names is taken into account.
    
    CGRect teamNamePosition = CGRectMake(0, 100, 300, 75);
    //CGFloat offestX = 20;
    UIFont * teamNameFont = [UIFont fontWithName:@"Gotham" size:80];
    
    if([team isEqualToString: HOME_TEAM]){
        teamNamePosition.origin.x = (self.view.center.x * .5)-(teamNamePosition.size.width/2);
        self.specHomeTeamName = [[UILabel alloc] initWithFrame:teamNamePosition];
        self.specHomeTeamName.textAlignment = NSTextAlignmentCenter;
        self.specHomeTeamName.backgroundColor = [UIColor greenColor];
        self.specHomeTeamName.font = teamNameFont;
        [self.view addSubview: self.specHomeTeamName];
        
    }else if([team isEqualToString: VISITOR_TEAM]){
        teamNamePosition.origin.x = (self.view.center.x * 1.5)-(teamNamePosition.size.width/2);
        self.specVistorTeamName = [[UILabel alloc] initWithFrame:teamNamePosition];
        self.specVistorTeamName.textAlignment = NSTextAlignmentCenter;
        self.specVistorTeamName.backgroundColor = [UIColor greenColor];
        self.specVistorTeamName.font = teamNameFont;
        [self.view addSubview: self.specVistorTeamName];
    }
    
}


-(void) grandSlamFor:(NSString *) team times:(NSInteger) number{
    if([team isEqualToString: HOME_TEAM]){
        NSLog(@"home team got GRANDSLAM: %d", (int) number);
    }else if([team isEqualToString: VISITOR_TEAM]){
        NSLog(@"home vistor got GRANDSLAM: %d", (int) number);
    }
}

-(void) handleClockTimeHasChangedFor: (NSNotification *) notification{
    NIZGameClock * clock = notification.object;
    
    if([[clock clockName] isEqual: BOUT_CLOCK]){
        self.specBoutClockLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",
                                        (int)[NIZGameClock getHoursFromTimeInSeconds: [clock secondsLeft]],
                                        (int)[NIZGameClock getMinutesFromTimeInSeconds: [clock secondsLeft]],
                                        (int)[NIZGameClock getSecondsFromTimeInSeconds: [clock secondsLeft]]];
        
    }else if ([[clock clockName] isEqual: JAM_CLOCK ]){
        
        self.specJamClockLabel.text = [NSString stringWithFormat:@"%02d:%02d",
                                       (int)[NIZGameClock getMinutesFromTimeInSeconds: [clock secondsLeft]],
                                       (int)[NIZGameClock getSecondsFromTimeInSeconds: [clock secondsLeft]]];
        
    }else if([[clock clockName] isEqual: PERIOD_CLOCK]){
        self.specPeriodClockLabel.text = [NSString stringWithFormat:@"%02d",
                                          (int)[NIZGameClock getSecondsFromTimeInSeconds: [clock secondsLeft]]];
    }
}

-(void) setupNotification{
    //NSLog(@"  NIZScoreBoardViewController: Setup Notification");
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleTeamNameHasChanged:)
                                                 name:@"teamNameHasChanged"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleClockTimeHasChangedFor:)
                                                 name:@"clockTimeHasChangedFor"
                                               object:nil];
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
