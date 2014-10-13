//
//  NIZConfigureViewController.m
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 3/10/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import "NIZConfigureViewController.h"

@interface NIZConfigureViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputHomeTeamName;
@property (weak, nonatomic) IBOutlet UITextField *inputVisitorTeamName;
@property (weak, nonatomic) IBOutlet UITableView *homeTeamRosterTV;
@property (weak, nonatomic) IBOutlet UITableView *visitorTeamRosterTV;

@property (strong, nonatomic) NIZDerbyTeam * homeTeam;
@property (strong, nonatomic) NIZDerbyTeam * visitorTeam;

//@property (weak, nonatomic) UIPopoverController * mirrorResolutionSelector;
@property (weak, nonatomic) IBOutlet UISwitch *mirrorSwitch;


@end


@implementation NIZConfigureViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Home team exists, bring in the data to manipulate
    if([self.delegate getTeam:@"Home"] == nil){
        self.homeTeam = [[NIZDerbyTeam alloc] initWithTeamName:@"Home"];
        [self.delegate setTeam:@"Home" with: self.homeTeam];
    }else{
        self.homeTeam = [self.delegate getTeam:@"Home"];
    }
    
    // Visitor team exists, bring in the data to manipulate
    if([self.delegate getTeam:@"Visitor"] == nil){
        self.visitorTeam = [[NIZDerbyTeam alloc] initWithTeamName:@"Visitor"];
        [self.delegate setTeam:@"Visitor" with: self.visitorTeam];
    }else{
        self.visitorTeam = [self.delegate getTeam: @"Visitor"];
    }
    
    // Display team names
    self.inputHomeTeamName.text = self.homeTeam.teamName;
    self.inputVisitorTeamName.text = self.visitorTeam.teamName;

    
    //UITableView * availableResolutionSelector
    //self.mirrorResolutionSelector = [UIPopoverController alloc] initWithContentViewController:<#(UIViewController *)#>;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"AddHomePlayerSegue" ]){
        NIZAddEditPlayerViewController *addEditPlayer = (NIZAddEditPlayerViewController *) segue.destinationViewController;
        [addEditPlayer setDelegate:self];
        addEditPlayer.teamType = @"Home";
        addEditPlayer.teamLabel.text = self.homeTeam.teamName;
    }else if([[segue identifier] isEqualToString:@"AddVisitorPlayerSegue" ]){
        NIZAddEditPlayerViewController *addEditPlayer = (NIZAddEditPlayerViewController *) segue.destinationViewController;
        [addEditPlayer setDelegate:self];
        addEditPlayer.teamType = @"Visitor";
        addEditPlayer.teamLabel.text = self.visitorTeam.teamName;
    }
}

- (IBAction)configureDoneBtnTouched:(id)sender {
    [self.delegate updateConfiguration];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)homeTeamNameDidEndEditing:(id)sender {
    self.homeTeam.teamName = [sender text];
    NSLog(@"config homeTeamNameDidEndEditing");
}

- (IBAction)visitorTeamNameDidEndEditing:(id)sender {
    self.visitorTeam.teamName = [sender text];
    NSLog(@"config visitorTeamNameDidEndEditing");
}

- (IBAction)resetClocks:(id)sender {
    [self.delegate resetClocks];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if([self.homeTeamRosterTV isEqual:tableView] || [self.visitorTeamRosterTV isEqual:tableView]){
        return 1;
    }
    return 0;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rosterCount = 0;
    if( [self.homeTeamRosterTV isEqual:tableView]){
        rosterCount =  (int)[self.homeTeam rosterCount];
    }else if( [self.visitorTeamRosterTV isEqual:tableView]){
        rosterCount =  (int)[self.visitorTeam rosterCount];
    }
    return rosterCount;
}

-(void) forTeam: (NSString *) type savePlayer: (NIZPlayer *) player{
    if( (player != nil) & ([type isEqualToString:@"Home"]) ){
        NSLog(@"Attempting to add a new player to Home");
        [self.homeTeam addPlayer:player];
    }else if( (player != nil) & ([type isEqualToString:@"Visitor"]) ){
        NSLog(@"Attempting to add a new player to Visitor");
        [self.visitorTeam addPlayer:player];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[UITableViewCell alloc] init];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setBackgroundColor: [UIColor colorWithRed:0.36 green:0.36 blue:0.36 alpha:1.0]];
        cell.textLabel.textColor = [UIColor whiteColor];
    }

    // Configure the cell...
    if([self.homeTeamRosterTV isEqual: tableView]){
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.homeTeam playerDerbyNumberAtPosition:(int)indexPath.row], [self.homeTeam playerDerbyNameAtPosition:(int)indexPath.row]];
    }else if([self.visitorTeamRosterTV isEqual: tableView]){
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.visitorTeam playerDerbyNumberAtPosition:(int)indexPath.row], [self.visitorTeam playerDerbyNameAtPosition:(int)indexPath.row]];
    }
    
    return cell;
}


- (IBAction)mirrorSwitchToched:(id)sender {
    //if the mirroring is available allow the switch to change
    if ([sender isOn] == YES && [self numExternalDisplays] > 1) {
        NSLog(@"  Switch is OFF, turning it ON");
        NSLog(@"  Number of external displays: %i",[self numExternalDisplays]);
    } else if([sender isOn] == NO) {
        NSLog(@"  Switch is ON, turning it OFF");
        NSLog(@"  Number of external displays: %i",[self numExternalDisplays]);
    } else{
        UIAlertView * noScreenAlert = [[UIAlertView alloc]initWithTitle:@"External Display Not Found" message:@"No external display was found. Make sure your Airplay device is on the same network as your scoreboard." delegate:NULL cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [noScreenAlert show];
        [sender setOn: NO];
    }
}

-(NSInteger) numExternalDisplays{
    return [UIScreen screens].count;
}

/*
-(void) nazExperiment{
    NSArray * avilableScreens  = [UIScreen screens];
    
    if( [self numExternalDisplays]  > 1 ){
        
        
        //There must be screens
        self.extScreen = [avilableScreens objectAtIndex:1];
        CGRect extScreenBounds = self.extScreen.bounds;
        
        self.scoreBoardSpectatorWindow = [[UIWindow alloc] initWithFrame:extScreenBounds];
        
        self.scoreBoardSpectatorWindow.screen = self.extScreen;
        self.scoreBoardSpectatorWindow.rootViewController = self;
        
        
        CGRect temp = CGRectMake(40, 40, 100, 30);
        UIButton * testButton = [[UIButton alloc] initWithFrame:temp];
        [testButton setTitle:@"BLAR" forState:UIControlStateNormal];
        
        
        [self.scoreBoardSpectatorWindow addSubview: testButton];
        
        self.scoreBoardSpectatorWindow.backgroundColor = [UIColor redColor];
        
        self.scoreBoardSpectatorWindow.hidden = NO;
        
        [self logText: [NSString stringWithFormat:@"  screenDescription: %@",[self.extScreen description]]];
    }else{
        [self logText:@"Nothing Here"];
    }
}
*/


@end
