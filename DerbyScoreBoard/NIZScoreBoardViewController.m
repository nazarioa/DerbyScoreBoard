//
//  NIZViewController.m
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/3/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import "NIZAppDelegate.h"
#import "NIZScoreBoardViewController.h"
#import "NIZDerbyBout.h"
#import "NIZDerbyJam.h"
#import "NIZDerbyTeam.h"
#import "NIZPlayer.h"

//allows access to the most recent jam
NIZDerbyJam *currentJam; //? Why is this outside? // I feel as though this is a Class level?
UIColor * blueColor;
UIColor * btnGreyColor;
//UIColor * btnGreenColor;
//UIColor * btnRedColor;
//UIColor * btnYellowColor;
UIColor * labelGreyColor;
UIFont * gothamMedium50;
UIFont * gothamMedium30;

@interface NIZScoreBoardViewController ()

@property (strong, nonatomic) NIZGameClock *gameClock;
@property (strong, nonatomic) NIZGameClock *jamClock;
@property (strong, nonatomic) NIZGameClock *periodClock;

@property (weak, nonatomic) NSMutableArray *jamLog;
@property (strong, nonatomic) NIZDerbyJam *jam1; //eventaully I need to make this into some kind of storage for this data type

@property (weak, nonatomic) IBOutlet UILabel *jamClockLabel;
@property (weak, nonatomic) IBOutlet UILabel *boutClockLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodClockLabel;
@property (weak, nonatomic) IBOutlet UIButton *officialTimeOutBtn;
@property (weak, nonatomic) IBOutlet UIButton *jamTimeOutBtn;


@property (strong, nonatomic) NIZDerbyTeam *homeTeam;
@property NSInteger homeTeamTotalScore;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTOCountLabel;
@property (weak, nonatomic) IBOutlet UITextField *homeJamScoreTextField;
@property (weak, nonatomic) IBOutlet UITextField *homeTotalScoreTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *homeJammerPicker;
@property (weak, nonatomic) IBOutlet UIButton *homeLeadJammerBtn;


@property (strong, nonatomic) NIZDerbyTeam *visitorTeam;
@property NSInteger visitorTeamTotalScore;
@property (weak, nonatomic) IBOutlet UILabel *visitorTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitorTOCountLabel;
@property (weak, nonatomic) IBOutlet UITextField *visitorJamScoreTextField;
@property (weak, nonatomic) IBOutlet UITextField *visitorTotalScoreTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *visitorJammerPicker;
@property (weak, nonatomic) IBOutlet UIButton *visitorLeadJammerBtn;

@property (strong, nonatomic) UIWindow * spectatorWindow;

@property (weak, nonatomic) UIScreen * extScreen;

@property (weak, nonatomic) NIZAppDelegate * appDelegate;

@end


@implementation NIZScoreBoardViewController

//@synthesize game;
@synthesize gameClock = _gameClock;
@synthesize jamClock = _jameClock;
@synthesize periodClock = _periodClock;

@synthesize jam1 = _jam1;

@synthesize homeTeam = _homeTeam;
@synthesize homeTeamTotalScore = _homeTeamTotalScore; //this is tequnically a model and should not be here
@synthesize homeTotalScoreTextField = _homeTotalScoreTextField; //not sure why this cannot be removed


@synthesize visitorTeam = _visitorTeam;
@synthesize visitorTeamTotalScore = _visitorTeamTotalScore; //this is tequnically a model and should not be here
@synthesize visitorTotalScoreTextField = _visitorTotalScoreTextField; //not sure why this cannot be removed

@synthesize spectatorWindow = _spectatorWindow;
@synthesize appDelegate = _appDelegate;


#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupColors];
    [self setupFonts];
    
    //UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    //tapGesture.numberOfTapsRequired = 2;
    //[self.view addGestureRecognizer:tapGesture];
    //Because I am learning the tap gesture stuff I modifed the function below from the original above. The goal is to see
    //where / when the script gets called.
    
    UITapGestureRecognizer *jamBtnTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleJamDoubleTapGesture:)];
    jamBtnTapGesture.numberOfTapsRequired = 2;
    [self.jamTimeOutBtn addGestureRecognizer:jamBtnTapGesture];
    
    [self primeClocks];
    [self updateConfiguration];
    //NSLog(@"* NIZScoreBoardViewController: %@", self);
    
}

-(void) viewDidAppear:(BOOL)animated{
    if(self.homeTeam == nil || self.visitorTeam == nil){
        [self performSegueWithIdentifier: @"toConfigureSegue" sender: self];
    }
}

-(void) setupFonts{
    gothamMedium50 = [UIFont fontWithName:@"Gotham-Black" size:50.0];
    gothamMedium30 = [UIFont fontWithName:@"Gotham-Black" size:30.0];
    
    [self.jamClockLabel setFont:gothamMedium50];
    [self.boutClockLabel setFont:gothamMedium30];
}

-(void) setupColors{
    blueColor     = [[UIColor alloc] initWithRed:8/255.0f green:107/255.0f blue:255/255.0f alpha:1.0f]; //blue
    /*
    btnGreyColor  = [[UIColor alloc] initWithRed:0.36 green:0.36 blue:0.36 alpha:1.0]; //grey
    btnGreenColor = [[UIColor alloc] initWithRed:92/255.0f green:188/255.0f blue:97/255.0f alpha:1.0f]; //green
    btnRedColor   = [[UIColor alloc] initWithRed:188/255.0f green:94/255.0f blue:94/255.0f alpha:1.0f]; //red
    btnYellowColor= [[UIColor alloc] initWithRed:188/255.0f green:179/255.0f blue:94/255.0f alpha:1.0f]; //yeleow
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateConfiguration{
    NSLog(@"UPDATE CONFIGURATION");
    //TODO: FIX Create a jam object
    //TODO: Maybe the Jam creation wont happen here.
    self.jam1 = [[NIZDerbyJam alloc] initHomeJammer:@"marsiPanner" visitorJammer:@"bubba-fist"];
    currentJam = self.jam1;
    
    self.homeTeamLabel.text     = [self.homeTeam teamName];
    self.visitorTeamLabel.text  = [self.visitorTeam teamName];
    
    self.homeJamScoreTextField.text     = @"0";
    self.visitorJamScoreTextField.text  = @"0";
    self.homeTotalScoreTextField.text   = @"0";
    self.visitorTotalScoreTextField.text= @"0";
}

- (void)primeClocks
{
    if(self.gameClock == nil){
        self.gameClock    = [[NIZGameClock alloc] initWithCounterLimitTo:1800 named:@"GameClock" delegateIs:self];
        self.jamClock     = [[NIZGameClock alloc] initWithCounterLimitTo:120 named:@"JamClock" delegateIs:self];
        self.periodClock  = [[NIZGameClock alloc] initWithCounterLimitTo:20 named:@"preJamClock" delegateIs:self];
    }else{
        [self.gameClock pauseClock];
        [self.jamClock pauseClock];
        [self.periodClock pauseClock];
        
        [self.gameClock resetClock];
        [self.jamClock resetClock];
        [self.periodClock resetClock];
    }
    
    UIImage * gameClockImage = [UIImage imageNamed:@"gameClock_start"];
    [self.officialTimeOutBtn setImage:gameClockImage forState: UIControlStateNormal];
    
    UIImage * jamClockImage = [UIImage imageNamed:@"jamClock_start_a"];
    [self.jamTimeOutBtn setImage:jamClockImage forState: UIControlStateNormal];
}

-(void)resetClocks{
    [self primeClocks];
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
    UIImage * image = [UIImage imageNamed:@"gameClock_start"];
    [self.officialTimeOutBtn setImage:image forState: UIControlStateNormal];
    
    [self.jamClock stopClock];
    [self.periodClock stopClock];
    [self.gameClock pauseClock];
}

- (void)boutClockStart {
    UIImage * image = [UIImage imageNamed:@"gameClock_stop"];
    [self.officialTimeOutBtn setImage:image forState: UIControlStateNormal];
    [self.gameClock startClock];
}


#pragma mark - jamClock
- (void)jamClockStart {
    UIImage * image = [UIImage imageNamed:@"jamClock_stop"];
    [self.jamTimeOutBtn setImage:image forState: UIControlStateNormal];
    [self.periodClock stopClock];
    [self.jamClock startClock];
    if([self.gameClock isRunning] == NO){
        [self boutClockStart];
    }
}

- (void)calculateJamTotals {
    //add score to running total for home team
    NSInteger newHomeScore = [currentJam homeJamScore ] + self.homeTeamTotalScore;
    self.homeTeamTotalScore = newHomeScore;
    self.homeTotalScoreTextField.text = [[NSString alloc] initWithFormat:@"%li", (long)newHomeScore];
    currentJam.homeJamScore = 0;
    self.homeJamScoreTextField.text = @"0";
    
    //add score to running total for visitor team
    NSInteger newVisitorScore = [currentJam visitorJamScore] + self.visitorTeamTotalScore;
    self.visitorTeamTotalScore = newVisitorScore;
    self.visitorTotalScoreTextField.text = [[NSString alloc] initWithFormat:@"%li", (long)newVisitorScore];
    currentJam.visitorJamScore = 0;
    self.visitorJamScoreTextField.text = @"0";
}

- (void)jamClockStop {
    UIImage * image = [UIImage imageNamed:@"jamClock_start_a"];
    [self.jamTimeOutBtn setImage:image forState: UIControlStateNormal];
    [self.jamClock stopClock];
    [self.periodClock startClock];
    [self calculateJamTotals];
}

- (void)jamClockPause {
    NSLog(@"jamClockButton: Stopped Jam");
    UIImage * image = [UIImage imageNamed:@"jamClock_start_a"];
    [self.jamTimeOutBtn setImage:image forState: UIControlStateNormal];
    [self.jamClock pauseClock];
}

#pragma mark - PreJamClock
- (void)preJamClockStop {
    NSLog(@"PreJam Clock: Stop Clock");
    [self.periodClock stopClock];
}

- (void)preJamClockStart {
    NSLog(@"PreJam Clock: Stop Clock");
    [self.periodClock startClock];
}


#pragma mark -  Main inputs
// the following functions may not be needed since the delegate to the textfield handels tapping and stuff.
- (IBAction)visitorJamScoreInput:(id)sender {
    NSLog(@"  ƒVisitor Jam Score Input");
}

- (IBAction)visitorTotalScoreInput:(id)sender {
    NSLog(@"  ƒVisitor Total Score Input");
}

- (IBAction)homeJamScoreInput:(id)sender {
    NSLog(@"  ƒHome Jam Score Input");
}

- (IBAction)homeTotalScoreInput:(id)sender {
    NSLog(@"  ƒHome Total Score Input");
}

- (IBAction)visitorScoreDownButton:(UIButton *)sender {
    NSLog(@"  Visitor Score Down");
    [currentJam subtractOneFrom:@"Visitor"];
    self.visitorJamScoreTextField.text = [NSString stringWithFormat:@"%li", (long)[currentJam visitorJamScore]];
}

- (IBAction)visitorScoreUpButton:(UIButton *)sender {
    NSLog(@"  Visitor Score Up");
    [currentJam addOneTo:@"Visitor"];
    self.visitorJamScoreTextField.text = [NSString stringWithFormat:@"%li", (long)[currentJam visitorJamScore]];
}

- (IBAction)homeScoreDownButton:(UIButton *)sender {
    NSLog(@"  Home Score Down");
    [currentJam subtractOneFrom:@"Home"];
    self.homeJamScoreTextField.text = [NSString stringWithFormat:@"%li", (long)[currentJam homeJamScore]];
}

- (IBAction)homeScoreUpButton:(UIButton *)sender {
    NSLog(@"  Home Score Up");
    [currentJam addOneTo:@"Home"];
    self.homeJamScoreTextField.text = [NSString stringWithFormat:@"%li", (long)[currentJam homeJamScore]];
}

- (IBAction)homeLeadJammerBtnTouched:(id)sender {
    if([currentJam leadJammerStatus] != HOME){
        [currentJam setLeadJammerStatus:HOME];
        self.homeLeadJammerBtn.backgroundColor = blueColor;
        self.visitorLeadJammerBtn.backgroundColor = btnGreyColor;
    }else if([currentJam leadJammerStatus] == HOME){
        [self resetLeadJammerStatus];
    }
}

//TODO -- I think that the above and below functions can be reduced.

- (IBAction)visitorLeadJammerBtnTouched:(id)sender {
    if([currentJam leadJammerStatus] != VISITOR){
        [currentJam setLeadJammerStatus:VISITOR];
        self.visitorLeadJammerBtn.backgroundColor = blueColor;
        self.homeLeadJammerBtn.backgroundColor = btnGreyColor;
    }else if([currentJam leadJammerStatus] == VISITOR){
        [self resetLeadJammerStatus];
    }
}

- (void)resetLeadJammerStatus {
    [currentJam setLeadJammerStatus:NONE];
    self.homeLeadJammerBtn.backgroundColor = btnGreyColor;
    self.visitorLeadJammerBtn.backgroundColor = btnGreyColor;
}

#pragma mark - NIZClockDelegate:Game Clock Delegate functions
- (void) timeHasChangedFor: (NSString *) clockName timeInSecondsIs: (NSInteger) secondsLeft{

    if([clockName isEqual: @"GameClock"]){
        self.boutClockLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",
                                    [NIZGameClock getHoursFromTimeInSeconds:secondsLeft],
                                    [NIZGameClock getMinutesFromTimeInSeconds:secondsLeft],
                                    [NIZGameClock getSecondsFromTimeInSeconds:secondsLeft]];
        [self.spectatorViewController boutClockTime:secondsLeft];
        
    }else if ([clockName isEqual: @"JamClock" ]){
        self.jamClockLabel.text = [NSString stringWithFormat:@"%02d:%02d",
                                   [NIZGameClock getMinutesFromTimeInSeconds:secondsLeft],
                                   [NIZGameClock getSecondsFromTimeInSeconds:secondsLeft]];
        
    }else if([clockName isEqual: @"preJamClock"]){
        self.periodClockLabel.text = [NSString stringWithFormat:@"%02d",
                                      [NIZGameClock getSecondsFromTimeInSeconds:secondsLeft]];
        [self.spectatorViewController periodClockTime: secondsLeft];
        
        if(secondsLeft < 6){
            self.periodClockLabel.textColor = [UIColor redColor];
        }else{
            self.periodClockLabel.textColor = [UIColor whiteColor];
        }
    }
}

-(void) clockReachedZero:(NSString *)clockName{
    if([clockName isEqual: @"GameClock"]){
        NSLog(@"Game clock end");
        
    }else if ([clockName isEqual: @"JamClock"]){
        NSLog(@"Jam clock end");
        [self.periodClock resetClock];
        [self.periodClock startClock];
        [self calculateJamTotals];
        [self resetLeadJammerStatus];
        
    }else if([clockName isEqual: @"preJamClock"]){
        NSLog(@"Pre jam clock end");
        [self.jamClock stopClock];
        [self.jamClock startClock];
    }
}

#pragma mark - Tap gestures
- (void)handleJamDoubleTapGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded){
        if([self.jamClock isRunning] == YES){
            [self jamClockStop];
            [self preJamClockStart];
            [self resetLeadJammerStatus];
        }else{
            [self jamClockStart];
            [self preJamClockStop];
        }
    }
}

#pragma mark - UI Picker Deleagte Functions
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if([pickerView isEqual:self.homeJammerPicker]){
        return 1;
    }else if([pickerView isEqual:self.visitorJammerPicker]){
        return 1;
    }else{
        return 1;
    }
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if([pickerView isEqual:self.homeJammerPicker]){
        return [self.homeTeam rosterCount];
    }else if([pickerView isEqual:self.visitorJammerPicker]){
        return [self.visitorTeam rosterCount];
    }else{
        return 1;
    }
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NIZPlayer *aTempPlayer;
    if([pickerView isEqual: self.homeJammerPicker]){
        aTempPlayer = [self.homeTeam getPlayerAtPosition:row isAJammer:TRUE];
    }else if([pickerView isEqual:self.visitorJammerPicker]){
        aTempPlayer = [self.visitorTeam  getPlayerAtPosition:row isAJammer:TRUE];
    }
    
    if(aTempPlayer != nil){
        return [NSString stringWithFormat:@"%@ : %@", aTempPlayer.derbyNumber , aTempPlayer.derbyName];
    }
    return nil;
}

#pragma mark - UITextFieldDelegate

- (void)textInputTotalScores:(UITextField *)textField {
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle: NSNumberFormatterNoStyle];
    NSNumber * tempScore = [f numberFromString: textField.text];
    
    if ([textField isEqual:self.homeTotalScoreTextField]){
        NSLog(@"    homeTotalScoreTextField : textFieldDidEndEditing %@", textField);
        self.homeTeamTotalScore = [tempScore integerValue];
        
    }else if ([textField isEqual:self.visitorTotalScoreTextField]){
        NSLog(@"    visitorTotalScoreTextField : textFieldDidEndEditing %@", textField);
        self.visitorTeamTotalScore = [tempScore integerValue];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //TODO: may want to make sure that the above code behavior matches the intended text
    NSLog(@"textFieldShouldReturn");
    [self textInputTotalScores:textField];
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    //TODO: may want to make sure that the above code behavior matches the intended text
    NSLog(@"textFieldDidEndEditing");
    [self textInputTotalScores:textField];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"toConfigureSegue" ]){
        NIZConfigureViewController *configureScoreBoard = (NIZConfigureViewController *) segue.destinationViewController;
        [configureScoreBoard setDelegate:self];
    }
}

-(NIZDerbyTeam *) getTeam:(NSString *)type{
    NIZDerbyTeam * resultTeam = nil;
    
    if([type isEqualToString:@"Home"]){
        resultTeam = self.homeTeam;
    }else if([type isEqualToString:@"Visitor"]){
        resultTeam =  self.visitorTeam;
    }
    
    return resultTeam;
}

-(void) setTeam:(NSString *)type with:(NIZDerbyTeam *)team{
    if( [type isEqualToString:@"Home"] ){
        self.homeTeam = team;
    }else if( [type isEqualToString:@"Visitor"]){
        self.visitorTeam = team;
    }
}

-(void) setupSpectatorScreen:(NSArray *) avilableScreens{
    NSLog(@"  setupSpectatorScreen:");
    //There must be screens
    
    self.extScreen = [avilableScreens objectAtIndex:1];

    if( self.extScreen != nil){
        NSLog(@"  setupSpectatorScreen - 3");
    
        CGRect extScreenBounds = self.extScreen.bounds;
        NSLog(@"extScreenBounds  origin.x: %f and origin.y: %f", extScreenBounds.origin.x, extScreenBounds.origin.y);
        NSLog(@"extScreenBounds  size.width: %f and size.height: %f", extScreenBounds.size.width,  extScreenBounds.size.height);
        
        self.spectatorWindow = [[UIWindow alloc] initWithFrame:extScreenBounds];
        self.spectatorWindow.screen = self.extScreen;
        
        NSLog(@"  setupSpectatorScreen - 4");
        self.spectatorViewController  = [[NIZSpectatorScreenViewController alloc] initWithNibName:@"SpectatorWindow" bundle:nil];
        self.spectatorWindow.rootViewController = self.spectatorViewController;
        
        NSLog(@"  setupSpectatorScreen - 5");
        self.spectatorWindow.hidden = NO;
        
        
        
        //UIView * spectatorView = [[UIView alloc] initWithFrame:extScreenBounds];
        //spectatorView.backgroundColor = [UIColor purpleColor];
        //[self.scoreBoardSpectatorWindow addSubview: spectatorView];
        
        //CGRect temp = CGRectMake(40, 300, 400, 30);
        //UILabel * testLabel = [[UILabel alloc] initWithFrame:temp];
        //testLabel.text = @"smary monkey";
        
        
        //[self.scoreBoardSpectatorWindow.rootViewController.view addSubview: testLabel];
        
        //self.scoreBoardSpectatorWindow.backgroundColor = [UIColor redColor];
        
        
        //[self logText: [NSString stringWithFormat:@"  screenDescription: %@",[self.extScreen description]]];
    }else{
        NSLog(@"  setupSpectatorScreen. Only here during dev");
    }
}


@end