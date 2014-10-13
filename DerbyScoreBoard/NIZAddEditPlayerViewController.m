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

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnTouchedFinishedEditingPlayer:(id)sender {
    
    NIZPlayer * aPlayer = [[NIZPlayer alloc] initWithDerbyName: self.playerDerbyName.text derbyNumber:self.playerDerbyNumber.text firstName:self.playerFirstName.text lastName:self.playerLastName.text isJammer:self.playerIsJammer.enabled];
    [self.delegate forTeam:self.teamType savePlayer:aPlayer];
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
