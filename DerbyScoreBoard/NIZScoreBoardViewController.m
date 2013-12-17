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
NIZDerbyJam *currentJam; //? Why is this outside?

@interface NIZScoreBoardViewController ()

//--LABELS and TEXTFIELDS
@property (weak, nonatomic) IBOutlet UILabel *jamClockLabel;
@property (weak, nonatomic) IBOutlet UILabel *boutClockLabel;
@property (weak, nonatomic) IBOutlet UILabel *preJamClockLabel;
@property (weak, nonatomic) IBOutlet UIButton *officialTimeOutBtn;
@property (weak, nonatomic) IBOutlet UIButton *jamTimeOutBtn;


//----Jam Stuff
@property (strong, nonatomic) NIZDerbyJam *jam1;
//@property (strong, nonatomic) NIZDerbyJam *jam2;
//@property (strong, nonatomic) NIZDerbyJam *jam3;


//---Game Stuff
@property (strong, nonatomic) NIZDerbyBout *game;
@property (strong, nonatomic) NIZGameClock *gameClock;
@property (strong, nonatomic) NIZGameClock *jamClock;
@property (strong, nonatomic) NIZGameClock *preJamClock;

//----Home Team Side
@property (weak, nonatomic) NSString *homeTeamName;
@property (nonatomic) NSInteger homeTeamTotalScore;

@property (weak, nonatomic) IBOutlet UILabel *homeTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTOCountLabel;
@property (weak, nonatomic) IBOutlet UITextField *homeJamScoreTextField;
@property (weak, nonatomic) IBOutlet UITextField *homeTotalScoreTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *homeJammerPicker;
@property (strong, nonatomic) NSArray *homeTeamRoster;

//----Visitor Team Side
@property (weak, nonatomic) NSString *visitorTeamName;
@property (nonatomic) NSInteger visitorTeamTotalScore;

@property (weak, nonatomic) IBOutlet UILabel *visitorTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitorTOCountLabel;
@property (weak, nonatomic) IBOutlet UITextField *visitorJamScoreTextField;
@property (weak, nonatomic) IBOutlet UITextField *visitorTotalScoreTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *visitorJammerPicker;
@property (strong, nonatomic) NSArray *visitorTeamRoster;

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
@synthesize homeJammerPicker;
@synthesize homeTeamRoster;

//----Visitor Team
@synthesize visitorTeamName;
@synthesize visitorTeamTotalScore;
@synthesize visitorJammerPicker;
@synthesize visitorTeamRoster;

//----Jam Stuff
@synthesize jam1;
//@property (strong, nonatomic) NIZDerbyJam *jam2;
//@property (strong, nonatomic) NIZDerbyJam *jam3;

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"== Setting Jam Objects ==");
    //TODO: Create a jam object
    self.jam1 = [[NIZDerbyJam alloc] initHomeJammer:@"marsiPanner" visitorJammer:@"bubba-fist"];
    currentJam = self.jam1;
    
    NSLog(@"== Setting Clock Objects ==");
    [self primeClocks];
    
    
    
    NSLog(@"== Setting Team Objects ==");
    self.homeTeamName           = @"The Banchee";
    self.homeTeamLabel.text     = self.homeTeamName;
    
    self.visitorTeamName        = @"Jack Asses";
    self.visitorTeamLabel.text  = self.visitorTeamName;
    
    //creating team roster
    //TODO: We need to make this a proper data object
    self.homeTeamRoster = [[NSArray alloc] initWithObjects:@"Maria Mayem", @"Susie Queue", @"Princes Bea", @"Wounder Woman", nil];
    self.visitorTeamRoster = [[NSArray alloc] initWithObjects:@"Rob-ert", @"Menaice Mike", @"Kernal Panic", @"Buba-fet", @"Neo", @"Mister Mind", nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)preJamClockStop {
    NSLog(@"PreJam Clock: Stop Clock");
    [self.preJamClock stopClock];
}

- (void)primeClocks
{
    self.gameClock    = [[NIZGameClock alloc] initWithCounterLimitTo:1800 named:@"GameClock"];
    self.jamClock     = [[NIZGameClock alloc] initWithCounterLimitTo:120 named:@"JamClock"];
    self.preJamClock  = [[NIZGameClock alloc] initWithCounterLimitTo:20 named:@"preJamClock"];
    
    //self.gameClock.delle
    [self.gameClock setDelegate:self];
    [self.jamClock setDelegate:self];
    [self.preJamClock setDelegate:self];
    
    [self.officialTimeOutBtn setTitle:@"Start Game Clock" forState: UIControlStateNormal];
    [self.jamTimeOutBtn setTitle:@"Start Jam" forState: UIControlStateNormal];
}


#pragma mark - boutClock
- (IBAction)boutClockBtnTouched:(UIButton *)sender {
    if([self.gameClock isRunning] == YES){
        [self boutClockStop];
        [self jamClockStop];
        [self preJamClockStop];
    }else{
        [self boutClockStart];
    }
}

- (void)boutClockStop {
    NSLog(@"Official Clock: Stop Clock");
    [self.officialTimeOutBtn setTitle:@"Start Game Clock" forState: UIControlStateNormal];
    //self.officialTimeOutBtn.backgroundColor = [UIColor redColor];
    [self.jamClock stopClock];
    [self.gameClock stopClock];
    [self.preJamClock stopClock];
}

- (void)boutClockStart {
    NSLog(@"Official Clock: Start Clock");
    [self.officialTimeOutBtn setTitle:@"Stop Game Clock" forState: UIControlStateNormal];
    [self.gameClock countdownTimer];
}

#pragma mark - jamClock
- (IBAction)jamClockBtnTouched:(UIButton *)sender {
    if([self.jamClock isRunning] == YES){
        [self jamClockStop];
    }else{
        [self jamClockStart];
    }
}



- (void)jamClockStart {
    NSLog(@"jamClockButton: Started Jam");
    [self.jamTimeOutBtn setTitle:@"Stop Jam" forState: UIControlStateNormal];
    //self.jamTimeOutBtn.backgroundColor = [UIColor redColor];
    [self.preJamClock stopClock];
    [self.jamClock countdownTimer];
    if([self.gameClock isRunning] == NO){
        [self boutClockStart];
    }
}

- (void)jamClockStop {
    NSLog(@"jamClockButton: Stopped Jam");
    [self.jamTimeOutBtn setTitle:@"Start Jam" forState: UIControlStateNormal];
    self.jamTimeOutBtn.backgroundColor = [UIColor grayColor];
    [self.jamClock stopClock];
    [self.preJamClock countdownTimer];
    
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


#pragma mark - Game Clock Delegate functions
-(void) clock:(NSString *)clockName hourIs:(NSNumber *)hours minutesIs:(NSNumber *)minutes secondsIs:(NSNumber *)seconds{
    if([clockName isEqual: @"GameClock"]){
        self.boutClockLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", [hours integerValue], [minutes integerValue], [seconds integerValue]];
    }else if ([clockName isEqual: @"JamClock" ]){
        self.jamClockLabel.text = [NSString stringWithFormat:@"%02d:%02d", [minutes integerValue], [seconds integerValue]];
    }else if([clockName isEqual: @"preJamClock" ]){
        self.preJamClockLabel.text = [NSString stringWithFormat:@"%02d", [seconds integerValue]];
    }
}


#pragma mark - UI Picker Deleagte Functions
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if([self.homeJammerPicker isEqual:pickerView]){
        return 1;
    }else if([pickerView isEqual:self.visitorJammerPicker]){
        return 1;
    }else{
        return 1;
    }
}

-(void) clockRechedZero:(NSString *)clockName{
    if([clockName isEqual: @"GameClock"]){
        NSLog(@"end of game clock");
    }else if ([clockName isEqual: @"JamClock" ]){
        NSLog(@"end of jam clock");
    }else if([clockName isEqual: @"preJamClock" ]){
        NSLog(@"end of pre jam clock");
    }
}


#pragma -

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if([self.homeJammerPicker isEqual:pickerView]){
        return self.homeTeamRoster.count;
    }else if([pickerView isEqual:self.visitorJammerPicker]){
        return self.visitorTeamRoster.count;
    }else{
        return 1;
    }
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if([self.homeJammerPicker isEqual:pickerView]){
        return [self.homeTeamRoster objectAtIndex:row];
    }else if([pickerView isEqual:self.visitorJammerPicker]){
        return [self.visitorTeamRoster objectAtIndex:row];
    }else{
        return @"Null";
    }
}


#pragma mark - test

@end