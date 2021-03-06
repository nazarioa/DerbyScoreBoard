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
//NIZDerbyJam *selectJam;
//TODO: make it so that the user can select and alter a previous jam

UIColor * blueColor;
UIColor * btnGreyColor;
//UIColor * btnGreenColor;
//UIColor * btnRedColor;
//UIColor * btnYellowColor;
UIColor * labelGreyColor;
UIFont * gothamMedium50;
UIFont * gothamMedium30;

@interface NIZScoreBoardViewController ()

@property (strong, nonatomic) NIZDerbyBout *theGame;

@property (strong, nonatomic) NIZGameClock *boutClock;
@property (strong, nonatomic) NIZGameClock *jamClock;
@property (strong, nonatomic) NIZGameClock *periodClock;

@property (weak, nonatomic) IBOutlet UILabel *jamClockLabel;
@property (weak, nonatomic) IBOutlet UILabel *boutClockLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodClockLabel;
@property (weak, nonatomic) IBOutlet UIButton *boutClockBtn;
@property (weak, nonatomic) IBOutlet UIButton *jamClockBtn;

@property (weak, nonatomic) IBOutlet UIButton *homeJamScoreUpBtn;
@property (weak, nonatomic) IBOutlet UIButton *homeJamScoreDownBtn;
@property (weak, nonatomic) IBOutlet UIButton *visitorJamScoreUpBtn;
@property (weak, nonatomic) IBOutlet UIButton *visitorJamScoreDownBtn;


@property NSInteger homeTeamTotalScore;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTOCountLabel;
@property (weak, nonatomic) IBOutlet UITextField *homeJamScoreTextField;
@property (weak, nonatomic) IBOutlet UITextField *homeTotalScoreTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *homeJammerPicker;
@property (weak, nonatomic) IBOutlet UIButton *homeLeadJammerBtn;


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

@synthesize theGame = _theGame;
@synthesize boutClock = _boutClock;
@synthesize jamClock = _jamClock;
@synthesize periodClock = _periodClock;

@synthesize homeTeam = _homeTeam;
@synthesize homeTeamTotalScore = _homeTeamTotalScore; //this is tequnically a model and should not be here
@synthesize homeTotalScoreTextField = _homeTotalScoreTextField; //not sure why this cannot be removed


@synthesize visitorTeam = _visitorTeam;
@synthesize visitorTeamTotalScore = _visitorTeamTotalScore; //this is tequnically a model and should not be here
@synthesize visitorTotalScoreTextField = _visitorTotalScoreTextField; //not sure why this cannot be removed

@synthesize spectatorWindow = _spectatorWindow;
@synthesize appDelegate = _appDelegate;


#pragma mark - UIViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self enableDisableTouchForMainItems:NO];
    [self setupColors];
    [self setupFonts];
    [self setupNotification];
    
    self.theGame = [[NIZDerbyBout alloc] init];
    if(currentJam == nil){
        currentJam = [[NIZDerbyJam alloc] init];
    }
    
    self.homeTotalScoreTextField.text   = @"0";
    self.visitorTotalScoreTextField.text= @"0";
    self.homeJamScoreTextField.text = @"0";
    self.visitorJamScoreTextField.text = @"0";
    
    //UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    //tapGesture.numberOfTapsRequired = 2;
    //[self.view addGestureRecognizer:tapGesture];
    //Because I am learning the tap gesture stuff I modifed the function below from the original above. The goal is to see
    //where / when the script gets called.
    
    UITapGestureRecognizer *jamBtnTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleJamDoubleTapGesture:)];
    jamBtnTapGesture.numberOfTapsRequired = 2;
    [self.jamClockBtn addGestureRecognizer:jamBtnTapGesture];
    
    [self primeClocks];
}

-(void) viewDidAppear:(BOOL)animated{
    if(self.homeTeam == nil || self.visitorTeam == nil){
        [self performSegueWithIdentifier: @"toConfigureScreenSegue" sender: self];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"toConfigureScreenSegue" ]){
        NIZConfigurePageViewController * configureScoreBoardPageViewController = (NIZConfigurePageViewController *) segue.destinationViewController;
        configureScoreBoardPageViewController.delegate = self;
    }
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -  IBActions

- (IBAction) visitorScoreDownButton:(UIButton *)sender {
    [currentJam subtractOneFrom: VISITOR_TEAM];
}

- (IBAction) visitorScoreUpButton:(UIButton *)sender {
    [currentJam addOneTo: VISITOR_TEAM];
}

- (IBAction) homeScoreDownButton:(UIButton *)sender {
    [currentJam subtractOneFrom: HOME_TEAM];
}

- (IBAction) homeScoreUpButton:(UIButton *)sender {
    [currentJam addOneTo: HOME_TEAM];
}

- (IBAction) homeLeadJammerBtnTouched:(id)sender {
    if([currentJam leadJammerStatus] != HOME_TEAM){
        [currentJam setLeadJammerStatus: HOME_TEAM];
        self.homeLeadJammerBtn.backgroundColor = blueColor;
        self.visitorLeadJammerBtn.backgroundColor = btnGreyColor;
    }else if([currentJam leadJammerStatus] == HOME_TEAM){
        [self resetLeadJammerStatus];
    }
}

- (IBAction) configureBtnTouched:(id)sender {
    
}

- (IBAction) boutClockBtnTouched:(UIButton *)sender {
    if([self.boutClock isRunning] == YES){
        [self boutClockPaused];
        [self jamClockStop];
        [self periodClockStop];
    }else{
        [self boutClockStart];
    }
}


//TODO -- I think that the above and below functions can be reduced.

- (IBAction) visitorLeadJammerBtnTouched:(id)sender {
    if([currentJam leadJammerStatus] != VISITOR_TEAM){
        [currentJam setLeadJammerStatus: VISITOR_TEAM];
        self.visitorLeadJammerBtn.backgroundColor = blueColor;
        self.homeLeadJammerBtn.backgroundColor = btnGreyColor;
    }else if([currentJam leadJammerStatus] == VISITOR_TEAM){
        [self resetLeadJammerStatus];
    }
}


#pragma mark - Clock Functions

- (void) primeClocks
{
    if(self.boutClock == nil){
        self.boutClock    = [[NIZGameClock alloc] initWithCounterLimitTo:1800 named: BOUT_CLOCK delegateIs:self];
        self.jamClock     = [[NIZGameClock alloc] initWithCounterLimitTo:120 named: JAM_CLOCK delegateIs:self];
        self.periodClock  = [[NIZGameClock alloc] initWithCounterLimitTo:20 named: PERIOD_CLOCK delegateIs:self];
        
    }else{
        [self.boutClock pauseClock];
        [self.jamClock pauseClock];
        [self.periodClock pauseClock];
        
        [self.boutClock resetClock];
        [self.jamClock resetClock];
        [self.periodClock resetClock];
    }
    
    self.boutClockLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",
                                (int) [NIZGameClock getHoursFromTimeInSeconds: [self.boutClock timerDuration]],
                                (int) [NIZGameClock getMinutesFromTimeInSeconds: [self.boutClock timerDuration]],
                                (int) [NIZGameClock getSecondsFromTimeInSeconds: [self.boutClock timerDuration]]];
    
    self.jamClockLabel.text = [NSString stringWithFormat:@"%02d:%02d",
                               (int) [NIZGameClock getMinutesFromTimeInSeconds: [self.jamClock timerDuration]],
                               (int) [NIZGameClock getSecondsFromTimeInSeconds: [self.jamClock timerDuration]]];
    
    self.periodClockLabel.text = [NSString stringWithFormat:@"%02d",
                                  (int) [NIZGameClock getSecondsFromTimeInSeconds: [self.periodClock timerDuration]]];
    
    UIImage * gameClockImage = [UIImage imageNamed:@"gameClock_start"];
    [self.boutClockBtn setImage:gameClockImage forState: UIControlStateNormal];
    
    UIImage * jamClockImage = [UIImage imageNamed:@"jamClock_start_a"];
    [self.jamClockBtn setImage:jamClockImage forState: UIControlStateNormal];
}

-(void) resetClocks{
    [self primeClocks];
}


#pragma mark Bout Clock
- (void) boutClockPaused {
    UIImage * image = [UIImage imageNamed:@"gameClock_start"];
    [self.boutClockBtn setImage:image forState: UIControlStateNormal];
    
    [self.jamClock stopClock];
    [self.periodClock stopClock];
    [self.boutClock pauseClock];
}

- (void) boutClockStart {
    UIImage * image = [UIImage imageNamed:@"gameClock_stop"];
    [self.boutClockBtn setImage:image forState: UIControlStateNormal];
    [self.boutClock startClock];
}


#pragma mark Jam Clock
- (void) jamClockStart {
    UIImage * image = [UIImage imageNamed:@"jamClock_stop"];
    [self.jamClockBtn setImage:image forState: UIControlStateNormal];
    [self.periodClock stopClock];
    [self.jamClock startClock];
    
    if([self.boutClock isRunning] == NO){
        [self boutClockStart];
    }
}

- (void) jamClockStop {
    UIImage * image = [UIImage imageNamed:@"jamClock_start_a"];
    [self.jamClockBtn setImage:image forState: UIControlStateNormal];
    [self.jamClock stopClock];
    [self.periodClock startClock];
    [self calculateJamTotals];
}

- (void) jamClockPause {
    NSLog(@"jamClockButton: Stopped Jam");
    UIImage * image = [UIImage imageNamed:@"jamClock_start_a"];
    [self.jamClockBtn setImage:image forState: UIControlStateNormal];
    [self.jamClock pauseClock];
}


#pragma mark Period Clock
- (void) periodClockStop {
    NSLog(@"PeriodClock Clock: Stop Clock");
    [self.periodClock stopClock];
}

- (void) periodClockStart {
    NSLog(@"PeriodClock Clock: Stop Clock");
    [self.periodClock startClock];
}

#pragma mark - Game Logic
- (void) calculateJamTotals {
    //add score to running total for home team
    NSInteger newHomeScore = [currentJam homeJamScore ] + self.homeTeamTotalScore;
    self.homeTeamTotalScore = newHomeScore;
    self.homeTotalScoreTextField.text = [[NSString alloc] initWithFormat:@"%li", (long)newHomeScore];
    self.spectatorViewController.specHomeTeamTotalScore.text = [[NSString alloc] initWithFormat:@"%li", (long)newHomeScore];
    currentJam.homeJamScore = 0;
    
    //add score to running total for visitor team
    NSInteger newVisitorScore = [currentJam visitorJamScore] + self.visitorTeamTotalScore;
    self.visitorTeamTotalScore = newVisitorScore;
    self.visitorTotalScoreTextField.text = [[NSString alloc] initWithFormat:@"%li", (long)newVisitorScore];
    self.spectatorViewController.specVistorTeamTotalScore.text = [[NSString alloc] initWithFormat:@"%li", (long)newVisitorScore];
    currentJam.visitorJamScore = 0;
}


#pragma mark - NIZClockDelegate
- (void) clockReachedZero:(NSString *)clockName{
    if([clockName isEqual: BOUT_CLOCK]){
        NSLog(@"Game clock end");
        
    }else if ([clockName isEqual: JAM_CLOCK]){
        NSLog(@"Jam clock end");
        [self.periodClock resetClock];
        [self.periodClock startClock];
        [self calculateJamTotals];
        [self resetLeadJammerStatus];
        
    }else if([clockName isEqual: PERIOD_CLOCK]){
        NSLog(@"Pre jam clock end");
        [self.jamClock stopClock];
        [self.jamClock startClock];
    }
}

#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"   ---- 0: %@ : %@", tableView, indexPath);
    //TODO: send notifictaion that the derby player has changed and have the spectator pick it up.
}

#pragma mark - UIPickerDeleagte
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
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
        NSLog(@"  home jammerCount: %i", [self.homeTeam jammerCount]);
        return [self.homeTeam jammerCount];
        
    }else if([pickerView isEqual:self.visitorJammerPicker]){
        NSLog(@"  visitor jammerCount: %i", [self.visitorTeam rosterCount]);
        return [self.visitorTeam rosterCount];

    }else{
        return 1;
    }
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NIZPlayer *aTempPlayer = nil;
    if([pickerView isEqual: self.homeJammerPicker]){
        aTempPlayer = [self.homeTeam getPlayerAtPosition:row isAJammer:TRUE];
    }else if([pickerView isEqual:self.visitorJammerPicker]){
        aTempPlayer = [self.visitorTeam  getPlayerAtPosition:row isAJammer:TRUE];
    }
    
    NSLog(@"  aTempPlayer: %@", aTempPlayer);
    
    if(aTempPlayer != nil){
        return [NSString stringWithFormat:@"%@ : %@", aTempPlayer.derbyNumber, aTempPlayer.derbyName];
    }
    return nil;
}

-(void)pickerView: (UIPickerView *) pickerView didSelectRow: (NSInteger) row inComponent: (NSInteger) component{
    NSLog(@"   PickerView:didSelectRow:inComponenet\n%@\n%i\n%i", pickerView, row, component);
}

#pragma mark - UITextFieldDelegate
//TODO: The following two functions may be redundant
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    //TODO: may want to make sure that the above code behavior matches the intended text
    NSLog(@"textFieldShouldReturn");
    [self textInputTotalScores:textField];
    
    [textField resignFirstResponder];
    return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
    //TODO: may want to make sure that the above code behavior matches the intended text
    NSLog(@"textFieldDidEndEditing");
    [self textInputTotalScores:textField];
}


#pragma mark - Tap Gestures
- (void) handleJamDoubleTapGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded){
        if([self.jamClock isRunning] == YES){
            [self jamClockStop];
            [self periodClockStart];
            [self resetLeadJammerStatus];
            
            [self.theGame addJam: currentJam];
            currentJam = [[NIZDerbyJam alloc] init];
            
        }else{
            [self jamClockStart];
            [self periodClockStop];
        }
    }
    
    [self enableDisableTouchForMainItems:YES];
}


#pragma mark - My Functions

- (NIZDerbyTeam *) getTeam:(NSString *)type{
    NIZDerbyTeam * resultTeam = nil;
    
    if([type isEqualToString: HOME_TEAM]){
        resultTeam = self.homeTeam;
    }else if([type isEqualToString: VISITOR_TEAM]){
        resultTeam =  self.visitorTeam;
    }
    
    return resultTeam;
}

- (void) setHomeOrVisitor:(NSString *)type asTeam:(NIZDerbyTeam *)team{
    if( [type isEqualToString: HOME_TEAM] ){
        self.homeTeam = team;
        
    }else if( [type isEqualToString: VISITOR_TEAM]){
        self.visitorTeam = team;
    }
}

- (void) textInputTotalScores:(UITextField *)textField {
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

- (void) enableDisableTouchForMainItems: (BOOL) result{
    self.homeLeadJammerBtn.userInteractionEnabled = result;
    self.homeJammerPicker.userInteractionEnabled = result;
    self.visitorLeadJammerBtn.userInteractionEnabled = result;
    self.visitorJammerPicker.userInteractionEnabled = result;
    
    self.boutClockBtn.userInteractionEnabled = result;
    
    self.homeJamScoreUpBtn.userInteractionEnabled = result;
    self.homeJamScoreDownBtn.userInteractionEnabled = result;
    self.visitorJamScoreUpBtn.userInteractionEnabled = result;
    self.visitorJamScoreDownBtn.userInteractionEnabled = result;
    
    if(result == YES){
        //TODO: set the color or image of the above mentioned items to grey or transparent
    }else if(result == NO){
        
    }
}


- (void) resetLeadJammerStatus {
    [currentJam setLeadJammerStatus: NO_TEAM];
    self.homeLeadJammerBtn.backgroundColor = btnGreyColor;
    self.visitorLeadJammerBtn.backgroundColor = btnGreyColor;
}

- (void) setupSpectatorScreen:(NSArray *) avilableScreens{
    //There must be screens
    
    self.extScreen = [avilableScreens objectAtIndex:1];

    if( self.extScreen != nil){
        NSLog(@" ");
        NSLog(@"\n========================");
        NSLog(@"   NIZScoreBoardViewController setupSpectatorScreen");
        
        CGRect extScreenBounds = self.extScreen.bounds;
        self.spectatorWindow = [[UIWindow alloc] initWithFrame:extScreenBounds];
        self.spectatorWindow.screen = self.extScreen;
        self.spectatorWindow.backgroundColor = [UIColor greenColor];
        
        self.spectatorViewController = [[NIZSpectatorScreenViewController alloc] init];
        self.spectatorWindow.rootViewController = self.spectatorViewController;
        [self.spectatorWindow.rootViewController.view setBounds:extScreenBounds];
        
        /*
        NSLog(@"     extScreenBounds  origin.x: %f and origin.y: %f", extScreenBounds.origin.x, extScreenBounds.origin.y);
        NSLog(@"     extScreenBounds  size.width: %f and size.height: %f", extScreenBounds.size.width,  extScreenBounds.size.height);
        NSLog(@"     self.spectatorWindow.rootViewController.view.bounds  origin.x: %f and origin.y: %f", self.spectatorWindow.rootViewController.view.bounds.origin.x, self.spectatorWindow.rootViewController.view.bounds.origin.y);
        NSLog(@"     self.spectatorWindow.rootViewController.view.bounds  size.width: %f and size.height: %f", self.spectatorWindow.rootViewController.view.bounds.size.width,  self.spectatorWindow.rootViewController.view.bounds.size.height);
         */
        
        //Initial Dispaly Info
        self.spectatorViewController.specHomeTeamName.text = self.homeTeam.teamName;
        self.spectatorViewController.specVistorTeamName.text = self.visitorTeam.teamName;
        self.spectatorViewController.specHomeTeamTotalScore.text = [NSString stringWithFormat:@"%d", self.homeTeamTotalScore];
        self.spectatorViewController.specVistorTeamTotalScore.text = [NSString stringWithFormat:@"%d", self.visitorTeamTotalScore];
        self.spectatorWindow.hidden = NO;
    }else{
        NSLog(@"  setupSpectatorScreen. Only here during dev");
    }
}

- (void) setupFonts{
    gothamMedium50 = [UIFont fontWithName:@"London Font" size:70.0];
    gothamMedium30 = [UIFont fontWithName:@"London Font" size:45.0];
    
    [self.jamClockLabel setFont:gothamMedium50];
    [self.boutClockLabel setFont:gothamMedium30];
}

- (void) setupColors{
    blueColor     = [[UIColor alloc] initWithRed:8/255.0f green:107/255.0f blue:255/255.0f alpha:1.0f]; //blue
    btnGreyColor  = [[UIColor alloc] initWithRed:0.36 green:0.36 blue:0.36 alpha:1.0]; //grey
    
    /*
     btnGreenColor = [[UIColor alloc] initWithRed:92/255.0f green:188/255.0f blue:97/255.0f alpha:1.0f]; //green
     btnRedColor   = [[UIColor alloc] initWithRed:188/255.0f green:94/255.0f blue:94/255.0f alpha:1.0f]; //red
     btnYellowColor= [[UIColor alloc] initWithRed:188/255.0f green:179/255.0f blue:94/255.0f alpha:1.0f]; //yeleow
     */
}


#pragma mark - Notification Stuff

- (void) setupNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleTeamNameHasChanged:)
                                                 name:@"teamNameHasChanged"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handlePlayerHasBeenAdded:)
                                                 name:@"playerHasBeenAdded"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handlePlayerHasBeenRemoved:)
                                                 name:@"playerHasBeenRemoved"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleClockTimeHasChangedFor:)
                                                 name:@"clockTimeHasChangedFor"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleJamScoreHasChanged:)
                                                 name:@"JamScoreHasChanged"
                                               object:nil];
}

- (void) handleTeamNameHasChanged: (NSNotification *) notification{
    NIZDerbyTeam * tempTeam = notification.object;
    NSLog(@"  handleTeamNameHasChanged: someParam: %@", notification.object);
    if([tempTeam isEqual: self.homeTeam]){
        self.homeTeamLabel.text = tempTeam.teamName;
        self.spectatorViewController.specHomeTeamName.text = tempTeam.teamName;
    }else if([notification.object isEqual: self.visitorTeam]){
        self.visitorTeamLabel.text = tempTeam.teamName;
        self.spectatorViewController.specVistorTeamName.text = tempTeam.teamName;
    }
}

- (void) handlePlayerHasBeenAdded: (NSNotification *) notification{
//    NSLog(@"  handlePlayerHasBeenAdded: %@", notification);
    [self.homeJammerPicker reloadAllComponents];
    [self.visitorJammerPicker reloadAllComponents];
}

- (void) handlePlayerHasBeenRemoved: (NSNotification *) notification{
//    NSLog(@"  handlePlayerHasBeenRemoved: %@", notification);
    [self.homeJammerPicker reloadAllComponents];
    [self.visitorJammerPicker reloadAllComponents];
}

- (void) handleClockTimeHasChangedFor: (NSNotification *) notification{
    NIZGameClock * clock = notification.object;
    
    if([[clock clockName] isEqual: BOUT_CLOCK]){
        self.boutClockLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",
                                    (int) [NIZGameClock getHoursFromTimeInSeconds: [clock secondsLeft]],
                                    (int) [NIZGameClock getMinutesFromTimeInSeconds: [clock secondsLeft]],
                                    (int) [NIZGameClock getSecondsFromTimeInSeconds: [clock secondsLeft]]];
        
    }else if ([[clock clockName] isEqual: JAM_CLOCK ]){
        self.jamClockLabel.text = [NSString stringWithFormat:@"%02d:%02d",
                                   (int) [NIZGameClock getMinutesFromTimeInSeconds: [clock secondsLeft]],
                                   (int) [NIZGameClock getSecondsFromTimeInSeconds: [clock secondsLeft]]];
        
    }else if([[clock clockName] isEqual: PERIOD_CLOCK]){
        self.periodClockLabel.text = [NSString stringWithFormat:@"%02d",
                                    (int) [NIZGameClock getSecondsFromTimeInSeconds: [clock secondsLeft]]];
        if([clock secondsLeft] > 5 && [clock secondsLeft] < 11){
            self.periodClockLabel.textColor = [UIColor yellowColor];
        }else if([clock secondsLeft] < 6){
            self.periodClockLabel.textColor = [UIColor redColor];
        }else{
            self.periodClockLabel.textColor = [UIColor whiteColor];
        }
    }
}

- (void) handleJamScoreHasChanged: (NSNotification *) notification{
    if( [[notification.userInfo objectForKey:@"TEAM"] isEqual: HOME_TEAM]){
        self.homeJamScoreTextField.text = [notification.userInfo objectForKey:@"SCORE"];
        self.spectatorViewController.specHomeTeamJamScore.text = [notification.userInfo objectForKey:@"SCORE"];
    }
    if( [[notification.userInfo objectForKey:@"TEAM"] isEqual: VISITOR_TEAM]){
        self.visitorJamScoreTextField.text = [notification.userInfo objectForKey:@"SCORE"];
        self.spectatorViewController.specVistorTeamJamScore.text = [notification.userInfo objectForKey:@"SCORE"];
    }
}

@end