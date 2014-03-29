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
        NSLog(@"    home is not nil");
        self.homeTeam = [self.delegate getTeam:@"Home"];
        self.visitorTeam = [self.delegate getTeam:@"Visitor"];
    }
    
    self.inputHomeTeamName.text = self.homeTeam.teamName;
    self.inputVisitorTeamName.text = self.visitorTeam.teamName;
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
    }

    // Configure the cell...
    if([self.homeTeamRosterTV isEqual: tableView]){
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.homeTeam playerDerbyNumberAtPosition:(int)indexPath.row], [self.homeTeam playerDerbyNameAtPosition:(int)indexPath.row]];
    }else if([self.visitorTeamRosterTV isEqual: tableView]){
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.visitorTeam playerDerbyNumberAtPosition:(int)indexPath.row], [self.visitorTeam playerDerbyNameAtPosition:(int)indexPath.row]];
    }
    
    return cell;
}


@end
