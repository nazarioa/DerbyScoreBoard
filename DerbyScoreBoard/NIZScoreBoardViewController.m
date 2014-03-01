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
#import "NIZDerbyTeam.h"
#import "NIZPlayer.h"

//allows access to the most recent jam
NIZDerbyJam *currentJam; //? Why is this outside? // I feel as though this is a Class level?

@interface NIZScoreBoardViewController ()

@property (strong, nonatomic) NIZDerbyBout *game;
@property (strong, nonatomic) NIZGameClock *gameClock;
@property (strong, nonatomic) NIZGameClock *jamClock;
@property (strong, nonatomic) NIZGameClock *preJamClock;

@property (strong, nonatomic) NIZDerbyJam *jam1;
//@property (strong, nonatomic) NIZDerbyJam *jam2;
//@property (strong, nonatomic) NIZDerbyJam *jam3; //eventaully I need to make this into some kidn of storage for this data type

@property (weak, nonatomic) IBOutlet UILabel *jamClockLabel;
@property (weak, nonatomic) IBOutlet UILabel *boutClockLabel;
@property (weak, nonatomic) IBOutlet UILabel *preJamClockLabel;
@property (weak, nonatomic) IBOutlet UIButton *officialTimeOutBtn;
@property (weak, nonatomic) IBOutlet UIButton *jamTimeOutBtn;


@property (strong, nonatomic) NIZDerbyTeam *homeTeam;
@property NSInteger homeTeamTotalScore;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTOCountLabel;
@property (weak, nonatomic) IBOutlet UITextField *homeJamScoreTextField;
@property (weak, nonatomic) IBOutlet UITextField *homeTotalScoreTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *homeJammerPicker;


@property (strong, nonatomic) NIZDerbyTeam *visitorTeam;
@property NSInteger visitorTeamTotalScore;
@property (weak, nonatomic) IBOutlet UILabel *visitorTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitorTOCountLabel;
@property (weak, nonatomic) IBOutlet UITextField *visitorJamScoreTextField;
@property (weak, nonatomic) IBOutlet UITextField *visitorTotalScoreTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *visitorJammerPicker;

@end


@implementation NIZScoreBoardViewController

@synthesize game;
@synthesize gameClock;
@synthesize jamClock;
@synthesize preJamClock;

@synthesize jam1;
//@property (strong, nonatomic) NIZDerbyJam *jam2;
//@property (strong, nonatomic) NIZDerbyJam *jam3;

@synthesize jamClockLabel;
@synthesize boutClockLabel;


@synthesize homeTeam;
@synthesize homeTeamTotalScore;
@synthesize homeJammerPicker;
@synthesize homeTeamLabel;
@synthesize homeTOCountLabel;
@synthesize homeJamScoreTextField;
@synthesize homeTotalScoreTextField;


@synthesize visitorTeam;
@synthesize visitorTeamTotalScore;
@synthesize visitorJammerPicker;
@synthesize visitorTeamLabel;
@synthesize visitorTOCountLabel;
@synthesize visitorJamScoreTextField;
@synthesize visitorTotalScoreTextField;


#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    //UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    //tapGesture.numberOfTapsRequired = 2;
    //[self.view addGestureRecognizer:tapGesture];
    //Because I am learning the tap gesture stuff I modifed the function below from the original above. The goal is to see
    //where / when the script gets called.
    
    UITapGestureRecognizer *jamBtnTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleJamDoubleTapGesture:)];
    jamBtnTapGesture.numberOfTapsRequired = 2;
    [self.jamTimeOutBtn addGestureRecognizer:jamBtnTapGesture];
    
    NSLog(@"== Setting Jam Objects ==");
    //TODO: Create a jam object
    self.jam1 = [[NIZDerbyJam alloc] initHomeJammer:@"marsiPanner" visitorJammer:@"bubba-fist"];
    currentJam = self.jam1;
    
    NSLog(@"== Setting Clock Objects ==");
    [self primeClocks];
    
    NSLog(@"== Setting Team Objects ==");
    self.homeTeam = [[NIZDerbyTeam alloc] initWithTeamName:@"The Banchee 2"];
    self.visitorTeam = [[NIZDerbyTeam alloc] initWithTeamName:@"Jac Asses Duce"];
    
    self.homeTeamLabel.text     = [self.homeTeam teamName];
    self.visitorTeamLabel.text  = [self.visitorTeam teamName];
    
    ////SCRATCH PAPER
    //TODO: Eventually these objects will be part of a collection that will be created in another view.
    //For now they shall hang here.
    NIZPlayer * homeP1 = [[NIZPlayer alloc] initWithDerbyName:@"H Playa1" derbyNumber:@"no1" firstName:nil lastName:nil];
    NIZPlayer * homeP2 = [[NIZPlayer alloc] initWithDerbyName:@"H Playa2" derbyNumber:@"no2" firstName:nil lastName:nil];
    NIZPlayer * homeP3 = [[NIZPlayer alloc] initWithDerbyName:@"H Playa3" derbyNumber:@"no3" firstName:nil lastName:nil];
    NIZPlayer * homeP4 = [[NIZPlayer alloc] initWithDerbyName:@"H Playa4" derbyNumber:@"no4" firstName:nil lastName:nil];
    NIZPlayer * homeP5 = [[NIZPlayer alloc] initWithDerbyName:@"H Playa5" derbyNumber:@"no5" firstName:nil lastName:nil];
    
    NIZPlayer * visitorP1 = [[NIZPlayer alloc] initWithDerbyName:@"V Playa1" derbyNumber:@"no1" firstName:nil lastName:nil];
    NIZPlayer * visitorP2 = [[NIZPlayer alloc] initWithDerbyName:@"V Playa2" derbyNumber:@"no2" firstName:nil lastName:nil];
    NIZPlayer * visitorP3 = [[NIZPlayer alloc] initWithDerbyName:@"V Playa3" derbyNumber:@"no3" firstName:nil lastName:nil];
    
    [self.homeTeam addPlayer:homeP1];
    [self.homeTeam addPlayer:homeP2];
    [self.homeTeam addPlayer:homeP3];
    [self.homeTeam addPlayer:homeP4];
    [self.homeTeam addPlayer:homeP5];
    
    [self.visitorTeam addPlayer:visitorP1];
    [self.visitorTeam addPlayer:visitorP2];
    [self.visitorTeam addPlayer:visitorP3];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)primeClocks
{
    self.gameClock    = [[NIZGameClock alloc] initWithCounterLimitTo:1800 named:@"GameClock" delegateIs:self];
    self.jamClock     = [[NIZGameClock alloc] initWithCounterLimitTo:120 named:@"JamClock" delegateIs:self];
    self.preJamClock  = [[NIZGameClock alloc] initWithCounterLimitTo:20 named:@"preJamClock" delegateIs:self];
    
    [self.officialTimeOutBtn setTitle:@"Start Game Clock" forState: UIControlStateNormal];
    [self.jamTimeOutBtn setTitle:@"Start Jam" forState: UIControlStateNormal];
    self.jamTimeOutBtn.backgroundColor = [UIColor colorWithRed:92/255.0f green:188/255.0f blue:97/255.0f alpha:1.0f]; //GREEN
}


#pragma mark - boutClock
- (IBAction)boutClockBtnTouched:(UIButton *)sender {
    if([self.gameClock isRunning] == YES){
        [self boutClockPaused];
        [self jamClockStop];
        [self preJamClockStop];
    }else{
        [self boutClockStart];
    }
}

- (void)boutClockPaused {
    NSLog(@"Official Clock: Paused Clock");
    [self.officialTimeOutBtn setTitle:@"Start Game Clock" forState: UIControlStateNormal];
    self.officialTimeOutBtn.backgroundColor = [UIColor grayColor];
    [self.jamClock stopClock];
    [self.preJamClock stopClock];
    [self.gameClock pauseClock];
}

- (void)boutClockStart {
    NSLog(@"Official Clock: Start Clock");
    [self.officialTimeOutBtn setTitle:@"Pause Game Clock" forState: UIControlStateNormal];
    self.officialTimeOutBtn.backgroundColor = [UIColor colorWithRed:188/255.0f green:94/255.0f blue:94/255.0f alpha:1.0f]; //RED
    [self.gameClock countdownTimer];
}


#pragma mark - jamClock
//- (IBAction)jamClockBtnTouched:(UIButton *)sender {
//    if([self.jamClock isRunning] == YES){
//        [self jamClockPause];
//    }else{
//        [self jamClockStart];
//    }
//}

- (void)jamClockStart {
    [self.jamTimeOutBtn setTitle:@"Stop Jam" forState: UIControlStateNormal];
    self.jamTimeOutBtn.backgroundColor = [UIColor grayColor];
    [self.preJamClock stopClock];
    [self.jamClock countdownTimer];
    if([self.gameClock isRunning] == NO){
        [self boutClockStart];
    }
}

- (void)calculateJamTotals {
    //add score to running total for home team
    NSInteger newHomeScore = [currentJam homeJamScore ] + self.homeTeamTotalScore;
    self.homeTeamTotalScore = newHomeScore;
    self.homeTotalScoreTextField.text = [[NSString alloc] initWithFormat:@"%i", newHomeScore];
    currentJam.homeJamScore = 0;
    self.homeJamScoreTextField.text = @"0";
    
    //add score to running total for visitor team
    NSInteger newVisitorScore = [currentJam visitorJamScore] + self.visitorTeamTotalScore;
    self.visitorTeamTotalScore = newVisitorScore;
    self.visitorTotalScoreTextField.text = [[NSString alloc] initWithFormat:@"%i", newVisitorScore];
    currentJam.visitorJamScore = 0;
    self.visitorJamScoreTextField.text = @"0";
}

- (void)jamClockStop {
    [self.jamTimeOutBtn setTitle:@"Start Jam" forState: UIControlStateNormal];
    self.jamTimeOutBtn.backgroundColor = [UIColor colorWithRed:92/255.0f green:188/255.0f blue:97/255.0f alpha:1.0f]; //GREEN
    [self.jamClock stopClock];
    [self.preJamClock countdownTimer];
    
    [self calculateJamTotals];
}

- (void)jamClockPause {
    NSLog(@"jamClockButton: Stopped Jam");
    [self.jamTimeOutBtn setTitle:@"Start Jam" forState: UIControlStateNormal];
    self.jamTimeOutBtn.backgroundColor = [UIColor colorWithRed:188/255.0f green:179/255.0f blue:94/255.0f alpha:1.0f]; //YELOW
    [self.jamClock pauseClock];
}

#pragma mark - PreJamClock
- (void)preJamClockStop {
    NSLog(@"PreJam Clock: Stop Clock");
    [self.preJamClock stopClock];
}

- (void)preJamClockStart {
    NSLog(@"PreJam Clock: Stop Clock");
    [self.preJamClock startClock];
}


#pragma mark -  Main inputs
// the following functions may not be needed since the delegate to the textfield handels tapping and stuff.
- (IBAction)visitorJamScoreInput:(id)sender {
    NSLog(@"  Visitor Jam Score Input");
}

- (IBAction)visitorTotalScoreInput:(id)sender {
    NSLog(@"  Visitor Total Score Input");
}

- (IBAction)homeJamScoreInput:(id)sender {
    NSLog(@"  Home Jam Score Input");
}

- (IBAction)homeTotalScoreInput:(id)sender {
    NSLog(@"  Home Total Score Input");
}

- (IBAction)visitorScoreDownButton:(UIButton *)sender {
    NSLog(@"  Visitor Score Down");
    [currentJam subtractOneFrom:@"Visitor"];
    self.visitorJamScoreTextField.text = [NSString stringWithFormat:@"%i", [currentJam visitorJamScore]];
}

- (IBAction)visitorScoreUpButton:(UIButton *)sender {
    NSLog(@"  Visitor Score Up");
    [currentJam addOneTo:@"Visitor"];
    self.visitorJamScoreTextField.text = [NSString stringWithFormat:@"%i", [currentJam visitorJamScore]];
}

- (IBAction)homeScoreDownButton:(UIButton *)sender {
    NSLog(@"  Home Score Down");
    [currentJam subtractOneFrom:@"Home"];
    self.homeJamScoreTextField.text = [NSString stringWithFormat:@"%i", [currentJam homeJamScore]];
}

- (IBAction)homeScoreUpButton:(UIButton *)sender {
    NSLog(@"  Home Score Up");
    [currentJam addOneTo:@"Home"];
    self.homeJamScoreTextField.text = [NSString stringWithFormat:@"%i", [currentJam homeJamScore]];
}


#pragma mark - NIZClockDelegate:Game Clock Delegate functions
-(void) timeHasChangedFor:(NSString *)clockName hourNowIs:(NSNumber *)hours minuteNowIs:(NSNumber *)minutes secondNowIs:(NSNumber *)seconds{
    if([clockName isEqual: @"GameClock"]){
        self.boutClockLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", [hours integerValue], [minutes integerValue], [seconds integerValue]];
    }else if ([clockName isEqual: @"JamClock" ]){
        self.jamClockLabel.text = [NSString stringWithFormat:@"%02d:%02d", [minutes integerValue], [seconds integerValue]];
    }else if([clockName isEqual: @"preJamClock" ]){
        self.preJamClockLabel.text = [NSString stringWithFormat:@"%02d", [seconds integerValue]];
    }
}

-(void) clockReachedZero:(NSString *)clockName{
    if([clockName isEqual: @"GameClock"]){
        NSLog(@"Game clock end");
    }else if ([clockName isEqual: @"JamClock" ]){
        NSLog(@"Jam clock end");
        [self.preJamClock resetClock];
        [self.preJamClock startClock];
        [self calculateJamTotals];
    }else if([clockName isEqual: @"preJamClock" ]){
        NSLog(@"Pre jam clock end");
        [self.jamClock stopClock];
        [self.jamClock startClock];
    }
}

#pragma mark - NIZDerbyJamDelegate
-(void) homeTeamScoreDidChange:(NSInteger)newScore{
    
}

-(void) visitorTeamScoreDidChange:(NSInteger)newScore{
    
}

-(void) homeTeamJamScoreDidChange:(NSInteger)newScore{
    
}

-(void) visitorTeamJamScoreDidChange:(NSInteger)newScore{
    
}


#pragma mark - Tap gestures
- (void)handleJamDoubleTapGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded){
        if([self.jamClock isRunning] == YES){
            [self jamClockStop];
            [self preJamClockStart];
        }else{
            [self jamClockStart];
            [self preJamClockStop];
        }
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

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if([self.homeJammerPicker isEqual:pickerView]){
        return [self.homeTeam rosterCount];
    }else if([pickerView isEqual:self.visitorJammerPicker]){
        return [self.visitorTeam rosterCount];
    }else{
        return 1;
    }
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if([self.homeJammerPicker isEqual:pickerView]){
        return [NSString stringWithFormat:@"%@ - %@", [self.homeTeam playerDerbyNumberAtPosition:row], [self.homeTeam playerDerbyNameAtPosition:row]];
    }else if([pickerView isEqual:self.visitorJammerPicker]){
        return [NSString stringWithFormat:@"%@ - %@", [self.visitorTeam playerDerbyNumberAtPosition:row], [self.visitorTeam playerDerbyNameAtPosition:row]];
    }else{
        return @"Null";
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle: NSNumberFormatterNoStyle];
    NSInteger tempScore = (int)[f numberFromString: textField.text];
    
    if ([textField isEqual:homeTotalScoreTextField]){
        NSLog(@"    homeTotalScoreTextField : textFieldDidEndEditing %@", textField);
        self.homeTeamTotalScore = tempScore;
        
    }else if ([textField isEqual:visitorTotalScoreTextField]){
        NSLog(@"    visitorTotalScoreTextField : textFieldDidEndEditing %@", textField);
        self.visitorTeamTotalScore = tempScore;
    }
}


/*
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    / * if([textField isEqual:homeJamScoreTextField]){
        NSLog(@"    homeJamScoreTextField : textFieldShouldReturn %@", textField);
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle: NSNumberFormatterNoStyle];
        NSInteger tempNewHomeJamScore = [f numberFromString: textField.text];
        
        [currentJam setHomeJamScore: tempNewHomeJamScore];
        self.homeJamScoreTextField.text = [NSString stringWithFormat:@"%d", [currentJam homeJamScore]];
    }else if([textField isEqual:visitorJamScoreTextField]){
        NSLog(@"visitorJamScoreTextField : textFieldShouldReturn %@", textField);
    }else* /
    if ([textField isEqual:homeTotalScoreTextField]){
        NSLog(@"homeTotalScoreTextField : textFieldShouldReturn %@\n---------", textField);
        //
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle: NSNumberFormatterNoStyle];
        NSInteger tempNewJamScore = [f numberFromString: textField.text];
        
        [currentJam subtractOneFrom:@"Visitor"];
        self.visitorJamScoreTextField.text = [NSString stringWithFormat:@"%i", [currentJam visitorJamScore]];
        
    }else if ([textField isEqual:visitorTotalScoreTextField]){
        NSLog(@"visitorTotalScoreTextField : textFieldShouldReturn %@\n---------", textField);
    }
    
    [textField resignFirstResponder];
    return YES;
}

*/



//TODO: constant color
//const UIColor * blarb = [[UIColor alloc] initWithRed:188/255.0f green:179/255.0f blue:94/255.0f alpha:1.0f];

@end