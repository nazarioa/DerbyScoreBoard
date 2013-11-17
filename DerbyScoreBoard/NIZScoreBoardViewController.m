//
//  NIZViewController.m
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/3/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import "NIZScoreBoardViewController.h"
#import "NIZDerbyBout.h"
#import "NIZDerbyJam.h"
#import "NIZGameClock.h"

//allows access to the most recent jam
NIZDerbyJam *currentJam;

@interface NIZScoreBoardViewController ()

//--LABELS and TEXTFIELDS
@property (weak, nonatomic) IBOutlet UILabel *homeTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitorTeamLabel;

@property (weak, nonatomic) IBOutlet UILabel *jamClockLabel;
@property (weak, nonatomic) IBOutlet UILabel *boutClockLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitorTOCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTOCountLabel;

@property (weak, nonatomic) IBOutlet UITextField *homeJamScoreTextField;
@property (weak, nonatomic) IBOutlet UITextField *visitorJamScoreTextField;
@property (weak, nonatomic) IBOutlet UITextField *homeTotalScoreTextField;
@property (weak, nonatomic) IBOutlet UITextField *visitorTotalScoreTextField;


//--DATA STUFF

//---Game Stuff
@property (strong, nonatomic) NIZDerbyBout *game;
@property (strong, nonatomic) NIZGameClock *gameClock;
@property (strong, nonatomic) NIZGameClock *jamClock;
@property (strong, nonatomic) NIZGameClock *preJamClock;

//----Home Team
@property (weak, nonatomic) NSString *homeTeamName;
@property (nonatomic) NSInteger homeTeamTotalScore;

//----Visitor Team
@property (weak, nonatomic) NSString *visitorTeamName;
@property (nonatomic) NSInteger visitorTeamTotalScore;

//----Jam Stuff
@property (strong, nonatomic) NIZDerbyJam *jam1;
//@property (strong, nonatomic) NIZDerbyJam *jam2;
//@property (strong, nonatomic) NIZDerbyJam *jam3;

@end



@implementation NIZScoreBoardViewController

@synthesize homeTeamLabel;
@synthesize visitorTeamLabel;

@synthesize jamClockLabel;
@synthesize boutClockLabel;
@synthesize visitorTOCountLabel;
@synthesize homeTOCountLabel;

@synthesize homeJamScoreTextField;
@synthesize visitorJamScoreTextField;
@synthesize homeTotalScoreTextField;
@synthesize visitorTotalScoreTextField;


//--DATA STUFF

//---Game Stuff
@synthesize game;
@synthesize gameClock;
@synthesize jamClock;
@synthesize preJamClock;

//----Home Team
@synthesize homeTeamName;
@synthesize homeTeamTotalScore;

//----Visitor Team
@synthesize visitorTeamName;
@synthesize visitorTeamTotalScore;

//----Jam Stuff
@synthesize jam1;
//@property (strong, nonatomic) NIZDerbyJam *jam2;
//@property (strong, nonatomic) NIZDerbyJam *jam3;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gameClock    = [[NIZGameClock alloc] initWithCounterLimitTo:1800 named:@"GameClock"];
    self.jamClock     = [[NIZGameClock alloc] initWithCounterLimitTo:120 named:@"JamClock"];
    self.preJamClock  = [[NIZGameClock alloc] initWithCounterLimitTo:20 named:@"preJamClock"];
    
    NSLog(@"Setting team names");
    self.homeTeamName = @"The Banchee";
    self.visitorTeamName = @"Jack Asses";
    
    
    self.jam1 = [[NIZDerbyJam alloc] initHomeJammer:@"marsiPanner" visitorJammer:@"bubba-fist"];
    currentJam = self.jam1;
    NSLog(@"current jam %@",currentJam);
    NSLog(@"jam1 %@",self.jam1);

    
    self.homeTeamLabel.text = self.homeTeamName;
    self.visitorTeamLabel.text = self.visitorTeamName;
    
    //creating team roster
    //NSArray * homeTeam = @[@"Maria Mayem", @"Susie Queue", @"Bust her Possy", @"Princes Bea"];
    //NSArray * visitorTeam = @[@"Rob-ert", @"Menaice Mike", @"Kernal Panic", @"Buba-fet"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - clock buttons
- (IBAction)boutClockButton:(UIButton *)sender {
    NSLog(@"Official Clock");
    if([self.gameClock clockIsRunning] == YES){
        NSLog(@"Official Clock: Stop Clock");
        [self.gameClock stopClock];
    }else{
        NSLog(@"Official Clock: Start Clock");
        [self.gameClock startClock];
    }
}

- (IBAction)jamClockButton:(UIButton *)sender {
    NSLog(@"Jam Clock Stop / Start -- Starting a new jam");
    
    if([self.jamClock clockIsRunning] == YES){
        NSLog(@"A -- JamClock is running. Stopping jamclock starting prejam clock");
        [self.jamClock stopClock];
        [self.preJamClock startClock];
        
        //add score to running total for home team
        NSInteger newHomeScore = currentJam.homeJamScore + self.homeTeamTotalScore;
        self.homeTeamTotalScore = newHomeScore;
        self.homeTotalScoreTextField.text = [[NSString alloc] initWithFormat:@"%i", newHomeScore];
        currentJam.homeJamScore = 0;
        self.homeJamScoreTextField.text = @"0";
        
        //add score to running total for visitor team
        NSInteger newVisitorScore = currentJam.visitorJamScore + self.visitorTeamTotalScore;
        self.visitorTeamTotalScore = newVisitorScore;
        self.visitorTotalScoreTextField.text = [[NSString alloc] initWithFormat:@"%i", newVisitorScore];
        currentJam.visitorJamScore = 0;
        self.visitorJamScoreTextField.text = @"0";
    }else{
        NSLog(@"B -- JamClock is NOT running. starting jamclock stopping prejam clock");
        [self.preJamClock stopClock];
        [self.jamClock startClock];
        //[self.gameClock startClock];
        if([self.gameClock clockIsRunning] == NO){
            [self.gameClock startClock];
        }
    }
}


#pragma mark - Visitor inputs
- (IBAction)visitorJamScoreInput:(id)sender {
    NSLog(@"Visitor Jam Score Input");
}

- (IBAction)visitorTotalScoreInput:(id)sender {
    NSLog(@"Visitor Total Score Input");
}

- (IBAction)visitorScoreDownButton:(UIButton *)sender {
    NSLog(@"Visitor Score Down");
    [currentJam subtractOneFromVisitor];
    self.visitorJamScoreTextField.text = [NSString stringWithFormat:@"%i", [currentJam visitorJamScore]];
}

- (IBAction)visitorScoreUpButton:(UIButton *)sender {
    NSLog(@"Visitor Score Up");
    [currentJam addOneToVisitor];
    self.visitorJamScoreTextField.text = [NSString stringWithFormat:@"%i", [currentJam visitorJamScore]];
}


#pragma mark - Home inputs
- (IBAction)homeJamScoreInput:(id)sender {
    NSLog(@"Home Jam Score Input");
}

- (IBAction)homeTotalScoreInput:(id)sender {
    NSLog(@"Home Total Score Input");
}

- (IBAction)homeScoreDownButton:(UIButton *)sender {
    NSLog(@"Home Score Down");
    [currentJam subtractOneFromHome];
    self.homeJamScoreTextField.text = [NSString stringWithFormat:@"%i", [currentJam homeJamScore]];
}

- (IBAction)homeScoreUpButton:(UIButton *)sender {
    NSLog(@"Home Score Up");
    [currentJam addOneToHome];
    self.homeJamScoreTextField.text = [NSString stringWithFormat:@"%i", [currentJam homeJamScore]];
}


#pragma mark - Other stuff
- (IBAction)appSettings:(UIButton *)sender {
    NSLog(@"Settings Button");
}


#pragma mark - Game Clock Delegate functions
-(void)didReachLimitOf:(NSString *)clockName{
    if([@"GameClock" isEqual: clockName]){
        NSLog(@" -- game clock");
    }else if ([@"JamClock" isEqual: clockName]){
        NSLog(@" -- jam clock");
    }else if([@"preJamClock" isEqual: clockName]){
        NSLog(@" -- pre jam clock");
    }
}

-(void)didTimeChange:(NSDate *)newTime named:(NSString *)clockName{
    NSLog(@" didTimeChange for the clock: %@ it's time is: %@ ", clockName, newTime);
}


@end
