//
//  NIZAddEditPlayerViewController.m
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 10/12/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import "NIZAddEditPlayerViewController.h"
#import "NIZPlayer.h"

@interface NIZAddEditPlayerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *playerFirstName;
@property (weak, nonatomic) IBOutlet UITextField *playerLastName;
@property (weak, nonatomic) IBOutlet UITextField *playerDerbyName;
@property (weak, nonatomic) IBOutlet UITextField *playerDerbyNumber;
@property (weak, nonatomic) IBOutlet UISwitch *playerIsJammer;
@property (weak, nonatomic) IBOutlet UIImageView *playerMug;

@end

@implementation NIZAddEditPlayerViewController

@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IB Actions

- (IBAction)btnTouchedFinishedEditingPlayer:(id)sender {
    if([self.playerDerbyName.text isEqualToString:@""] || [self.playerDerbyNumber.text isEqualToString:@""]){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Cannot Add Player" message:@"Your Player must have a Derby Name and a Derby Number in order to be added to the roster" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else{
        NIZPlayer * aPlayer = [[NIZPlayer alloc] initWithDerbyName: self.playerDerbyName.text derbyNumber:self.playerDerbyNumber.text firstName:self.playerFirstName.text lastName:self.playerLastName.text isJammer:self.playerIsJammer.enabled];
        [self.delegate forTeam:self.teamType savePlayer:aPlayer];
        [self.delegate refreshPlayerRoster];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)btnTouchedCancelEditingPlayer:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark my Functions

@end
