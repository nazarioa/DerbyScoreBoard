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

@property (weak, nonatomic) NIZDerbyTeam * homeTeam;
@property (weak, nonatomic) NIZDerbyTeam * visitorTeam;

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
    
    if([self.delegate getTeam:@"Home"] != nil){
        self.homeTeam = [self.delegate getTeam:@"Home"];
        self.visitorTeam = [self.delegate getTeam:@"Visitor"];
        
        self.inputHomeTeamName.text = self.homeTeam.teamName;
        self.inputVisitorTeamName.text = self.visitorTeam.teamName;
    }
    
    
    //UITableView * availableResolutionSelector
    //self.mirrorResolutionSelector = [UIPopoverController alloc] initWithContentViewController:<#(UIViewController *)#>;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)configureDoneBtnTouched:(id)sender {
    [self.delegate updateConfiguration];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)homeTeamNameDidEndEditing:(id)sender {
    self.homeTeam.teamName = [sender text];
}

- (IBAction)visitorTeamNameDidEndEditing:(id)sender {
    self.visitorTeam.teamName = [sender text];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if([self.homeTeamRosterTV isEqual:tableView] || [self.visitorTeamRosterTV isEqual:tableView]){
        return 1;
    }
    return 0;
}
- (IBAction)resetClocks:(id)sender {
    [self.delegate resetClocks];
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
    if ([sender isOn] == YES) {
        NSLog(@"  Switch is ON");
    } else if([sender isOn] == NO) {
        NSLog(@"  Switch is OFF");
    }
    //else, alert user to airplay
}

-(void) nazExperiment{
    NSInteger numbScreens = [UIScreen screens].count;
    NSArray * avilableScreens  = [UIScreen screens];
    
    if( numbScreens > 1 ){
        
        
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


@end
