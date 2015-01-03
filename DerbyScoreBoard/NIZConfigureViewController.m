//
//  NIZConfigureViewController.m
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 3/10/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import "NIZConfigureViewController.h"
#import "NIZPlayerTableViewCell.h"

@interface NIZConfigureViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputHomeTeamName;
@property (weak, nonatomic) IBOutlet UITextField *inputVisitorTeamName;
@property (weak, nonatomic) IBOutlet UITableView *homeTeamRosterTV;
@property (weak, nonatomic) IBOutlet UITableView *visitorTeamRosterTV;

@property (strong, nonatomic) NIZDerbyTeam * homeTeam;
@property (strong, nonatomic) NIZDerbyTeam * visitorTeam;

@end


@implementation NIZConfigureViewController

@synthesize delegate = _delegate;

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NIZPlayerTableViewCell *cell;

    // Configure the cell...
    if([self.homeTeamRosterTV isEqual: tableView]){
        static NSString *CellIdentifier = @"HomePlayerCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) cell = [[NIZPlayerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
        cell.playerName.text = [self.homeTeam playerDerbyNameAtPosition:(int)indexPath.row];
        cell.playerNumber.text = [self.homeTeam playerDerbyNumberAtPosition:(int)indexPath.row];
        cell.playerMug.image = [self.homeTeam playerDerbyMugAtPosition:(int)indexPath.row];
    
    }else if([self.visitorTeamRosterTV isEqual: tableView]){
        static NSString *CellIdentifier = @"VistorPlayerCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) cell = [[NIZPlayerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.playerName.text = [self.visitorTeam playerDerbyNameAtPosition:(int)indexPath.row];
        cell.playerNumber.text = [self.visitorTeam playerDerbyNumberAtPosition:(int)indexPath.row];
        cell.playerMug.image = [self.visitorTeam playerDerbyMugAtPosition:(int)indexPath.row];
        
    }
    
    CALayer * layer = [cell.playerMug layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:cell.playerMug.bounds.size.width/2.0];
    [layer setBorderWidth:2.0];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if([tableView isEqual: self.homeTeamRosterTV]){
            [self.homeTeam removePlayer: [self.homeTeam getPlayerAtPosition: indexPath.row]];
        }else if([tableView isEqual: self.visitorTeamRosterTV]){
            [self.visitorTeam removePlayer: [self.visitorTeam getPlayerAtPosition: indexPath.row]];
        }
    }
    [tableView reloadData];
}

#pragma mark IB Actions

- (IBAction)btnTouchedConfigureDone:(id)sender {
    if(self.homeTeam.rosterCount < 1 || self.visitorTeam.rosterCount < 1 ){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Not Enough Players" message:@"Please add at least one player to each team by touching the \"Add Player\" button." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }else{
        [self.delegate updateConfiguration];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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

- (IBAction)enableSpectatorBtnTouched:(id)sender {
    if( [self numExternalDisplays] > 1 ){
        NSLog(@" Number of available displays: %li",(long)[self numExternalDisplays]);
        [self connectExternalScreen];
    }else{
        NSLog(@" No extrnal displays found. Displaying modal error screen");
    }
}


#pragma mark My Functions

-(void) refreshPlayerRoster{
    [self.homeTeamRosterTV reloadData];
    [self.visitorTeamRosterTV reloadData];
}

-(void) forTeam: (NSString *) type savePlayer: (NIZPlayer *) player{
    if( (player != nil) & ([type isEqualToString:@"Home"]) ){
        [self.homeTeam addPlayer:player];
    }else if( (player != nil) & ([type isEqualToString:@"Visitor"]) ){
        [self.visitorTeam addPlayer:player];
    }
}

 -(NSInteger) numExternalDisplays{
    return [UIScreen screens].count;
}

 -(void) connectExternalScreen{
     NSLog(@"  connectExternalScreen");
     NSArray * avilableScreens  = [UIScreen screens];
     
     if( avilableScreens.count  > 1 ){
         [self.delegate setupSpectatorScreen: avilableScreens];
         NSLog(@"Yes Screens");
     }else{
         NSLog(@"No Screens");
     }
 }


@end
