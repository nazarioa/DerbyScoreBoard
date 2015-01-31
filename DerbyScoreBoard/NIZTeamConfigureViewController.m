//
//  NIZTeamConfigureViewController.m
//  Derby
//
//  Created by Nazario A. Ayala on 1/22/15.
//  Copyright (c) 2015 Nazario A. Ayala. All rights reserved.
//

#import "NIZTeamConfigureViewController.h"
#import "NIZPlayerTableViewCell.h"

@interface NIZTeamConfigureViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *teamLogo;
@property (weak, nonatomic) IBOutlet UITableView *teamRosterTV;
@property (weak, nonatomic) IBOutlet UITextField *inputTeamName;

@end

@implementation NIZTeamConfigureViewController

@synthesize team = _team;
@synthesize teamType = _teamType;
@synthesize delegate = _delegate;


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self makePretty];
    
    if([self.delegate getTeam: self.teamType] == nil){
        self.team = [[NIZDerbyTeam alloc] initWithTeamName: nil];
        [self.delegate setHomeOrVisitor: self.teamType asTeam: self.team];
        
    }else{
        self.team = [self.delegate getTeam: self.teamType];
        self.inputTeamName.text = self.team.teamName;
        
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSLog(@"Team Screen Did Appear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(void) performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    NSLog(@"\n\n   performSegueWithIdentifier:%@ \nsender: %@\n\n", identifier, sender);
//}


#pragma mark - UINavigationControllerDelegate

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString: @"AddHomePlayerSegue" ] || [segue.identifier isEqualToString: @"AddVisitorPlayerSegue" ]){
        NIZAddEditPlayerViewController * addPlayer = (NIZAddEditPlayerViewController *) segue.destinationViewController;
        [addPlayer setDelegate:self];
        addPlayer.mode = ADD_MODE;
        addPlayer.teamType = self.teamType;
        
    }else if([segue.identifier isEqualToString: @"EditPlayerSegue" ]){
        NIZAddEditPlayerViewController * editPlayer = (NIZAddEditPlayerViewController *) segue.destinationViewController;
        [editPlayer setDelegate:self];
        editPlayer.mode = EDIT_MODE;
        editPlayer.teamType =  [sender objectForKey: @"TEAM"];
        editPlayer.playerToBeEdited = [sender objectForKey: @"PLAYER"];
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger rows = 0;
    if([self.teamRosterTV isEqual:tableView]){
        rows = 1;
    }
    return rows;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rosterCount = 0;
    if( [self.teamRosterTV isEqual:tableView]){
        rosterCount =  (int)[self.team rosterCount];
    }
    return rosterCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NIZPlayerTableViewCell *cell;
    
    // Configure the cell...
    if([self.teamRosterTV isEqual: tableView]){
        static NSString *CellIdentifier = @"HomePlayerCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) cell = [[NIZPlayerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.playerName.text = [self.team playerDerbyNameAtPosition:(int)indexPath.row];
        cell.playerNumber.text = [self.team playerDerbyNumberAtPosition:(int)indexPath.row];
        cell.playerMug.image = [self.team playerDerbyMugAtPosition:(int)indexPath.row];
        
        /*UITableViewCell *test = [[UITableViewCell alloc] init];
         test.textLabel.text = [self.homeTeam playerDerbyNameAtPosition: (int) indexPath.row];
         return test;*/
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
        if([tableView isEqual: self.teamRosterTV]){
            [self.team removePlayer: [self.team getPlayerAtPosition: indexPath.row]];
        }
    }
    [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if( [tableView isEqual: self.teamRosterTV]){
        NSDictionary * temp = @{@"SENDER" : self, @"PLAYER" : [self.team getPlayerAtPosition:indexPath.row], @"TEAM" : HOME_TEAM };
        [self performSegueWithIdentifier: @"EditPlayerSegue" sender: temp];
    }
}


#pragma mark - UIImagePickerControllerDelegate

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.teamLogo.image =[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - IB Actions

- (IBAction) teamNameDidEndEditing:(id)sender {
    self.team.teamName = [sender text];
    NSLog(@"config homeTeamNameDidEndEditing");
}

- (IBAction) teamLogoTouched:(UIButton *)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.modalPresentationStyle = UIModalPresentationPageSheet;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma marks - AddEditPlayerProtocol

-(void) refreshPlayerRoster{
    [self.teamRosterTV reloadData];
}

-(void) forTeam:(NSString *) type savePlayer: (NIZPlayer *) player{
    [self.team addPlayer:player];
}


#pragma mark - My Functions

-(void) makePretty{
    CALayer * layer = [self.teamLogo layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius: self.teamLogo.bounds.size.width/2.0];
    [layer setBorderWidth:4.0];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
}

@end
