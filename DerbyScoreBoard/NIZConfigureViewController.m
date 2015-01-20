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
@property (weak, nonatomic) IBOutlet UIImageView *homeTeamLogo;
@property (weak, nonatomic) IBOutlet UIImageView *visitorTeamLogo;

@property (strong, nonatomic) NIZDerbyTeam * homeTeam;
@property (strong, nonatomic) NIZDerbyTeam * visitorTeam;

@end


@implementation NIZConfigureViewController

@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self makePretty];
    
    // Home team exists, bring in the data to manipulate
    if([self.delegate getTeam: HOME_TEAM] == nil){
        self.homeTeam = [[NIZDerbyTeam alloc] initWithTeamName: nil];
        [self.delegate setHomeOrVisitor: HOME_TEAM asTeam: self.homeTeam];
    }else{
        self.homeTeam = [self.delegate getTeam: HOME_TEAM];
        self.inputHomeTeamName.text = self.homeTeam.teamName;
    }
    
    // Visitor team exists, bring in the data to manipulate
    if([self.delegate getTeam: VISITOR_TEAM] == nil){
        self.visitorTeam = [[NIZDerbyTeam alloc] initWithTeamName: nil];
        [self.delegate setHomeOrVisitor: VISITOR_TEAM asTeam: self.visitorTeam];
    }else{
        self.visitorTeam = [self.delegate getTeam: VISITOR_TEAM];
        self.inputVisitorTeamName.text = self.visitorTeam.teamName;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void) performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    NSLog(@"\n\n   performSegueWithIdentifier:%@ \nsender: %@\n\n", identifier, sender);
//}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"\n\n   prepareForSegue:withIdentifier: %@", sender);
    
    if([segue.identifier isEqualToString:@"AddVisitorPlayerSegue" ]){
        NIZAddEditPlayerViewController * addVisitor = (NIZAddEditPlayerViewController *) segue.destinationViewController;
        [addVisitor setDelegate:self];
        addVisitor.mode = ADD_MODE;
        addVisitor.teamType = VISITOR_TEAM;
        
    }else if([segue.identifier isEqualToString:@"AddHomePlayerSegue" ]){
        NIZAddEditPlayerViewController * addHome = (NIZAddEditPlayerViewController *) segue.destinationViewController;
        [addHome setDelegate:self];
        addHome.mode = ADD_MODE;
        addHome.teamType = HOME_TEAM;
        
    }else if([segue.identifier isEqualToString:@"EditPlayerSegue" ]){
        NIZAddEditPlayerViewController * editPlayer = (NIZAddEditPlayerViewController *) segue.destinationViewController;
        [editPlayer setDelegate:self];
        editPlayer.mode = EDIT_MODE;
        NSLog(@"   the sender: %@", sender);
        editPlayer.teamType =  [sender objectForKey:@"TEAM"];
        editPlayer.playerToBeEdited = [sender objectForKey:@"PLAYER"];
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
        
        /*UITableViewCell *test = [[UITableViewCell alloc] init];
        test.textLabel.text = [self.homeTeam playerDerbyNameAtPosition: (int) indexPath.row];
        return test;*/
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if( [tableView isEqual: self.homeTeamRosterTV]){
        NSDictionary * temp = @{@"SENDER" : self, @"PLAYER" : [self.homeTeam getPlayerAtPosition:indexPath.row], @"TEAM" : HOME_TEAM };
        [self performSegueWithIdentifier: @"EditPlayerSegue" sender: temp];
        
    }else if ( [tableView isEqual: self.visitorTeamRosterTV] ){
        NSDictionary * temp = @{@"SENDER" : self, @"PLAYER" : [self.visitorTeam getPlayerAtPosition:indexPath.row], @"TEAM" : VISITOR_TEAM };
        [self performSegueWithIdentifier: @"EditPlayerSegue" sender: temp];
    }
}


#pragma mark IB Actions

- (IBAction)btnTouchedConfigureDone:(id)sender {
    if([self.inputHomeTeamName.text isEqualToString: @""] || [self.inputVisitorTeamName.text isEqualToString:@""] ){
        UIAlertView * alert = [[UIAlertView alloc]
                               initWithTitle:@"Team Names are Missing"
                               message:@"Please give your team names by touching the \"Home Team Name\" or \"Visitor Team Name\" text input fields."
                               delegate:self
                               cancelButtonTitle:@"Ok"
                               otherButtonTitles: nil];
        [alert show];
    }else if(self.homeTeam.rosterCount < 1 || self.visitorTeam.rosterCount < 1 ){
        UIAlertView * alert = [[UIAlertView alloc]
                               initWithTitle:@"Not Enough Players"
                               message:@"Please add at least one player to each team by touching the \"Add Player\" button."
                               delegate:self
                               cancelButtonTitle:@"Ok"
                               otherButtonTitles: nil];
        [alert show];
    }else{
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
    if( [UIScreen screens].count > 1 ){
        NSLog(@" Number of available displays: %li",(long)[UIScreen screens].count);
        [self connectExternalScreen];
    }else{
        NSLog(@" No extrnal displays found. Displaying modal error screen");
    }
}

- (IBAction)teamLogoTouched:(UIButton *)sender {
    if( [[sender restorationIdentifier] isEqual: @"homeTeamLogoBtn"] ){
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.modalPresentationStyle = UIModalPresentationPageSheet;
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:picker animated:YES completion:nil];
        
    }else if( [[sender restorationIdentifier] isEqual: @"visitorTeamLogoBtn"] ){
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.modalPresentationStyle = UIModalPresentationPageSheet;
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:picker animated:YES completion:nil];
    }
}


#pragma mark My Functions

-(void) refreshPlayerRoster{
    [self.homeTeamRosterTV reloadData];
    [self.visitorTeamRosterTV reloadData];
}

-(void) forTeam: (NSString *) type savePlayer: (NIZPlayer *) player{
    if( (player != nil) & ([type isEqualToString: HOME_TEAM]) ){
        [self.homeTeam addPlayer:player];
    }else if( (player != nil) & ([type isEqualToString: VISITOR_TEAM]) ){
        [self.visitorTeam addPlayer:player];
    }
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

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //TODO: not sure how to tell the button to put the image back in here.
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@" --> -> > : %@ ", info);
    //self.playerMug.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

-(void) makePretty{
    CALayer * layer = [self.visitorTeamLogo layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius: self.visitorTeamLogo.bounds.size.width/2.0];
    [layer setBorderWidth:4.0];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    layer = nil;
    layer = [self.homeTeamLogo layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius: self.homeTeamLogo.bounds.size.width/2.0];
    [layer setBorderWidth:4.0];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
}

@end
