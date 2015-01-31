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

@end


@implementation NIZConfigureViewController

@synthesize delegate = _delegate;


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IB Actions

- (IBAction)btnTouchedConfigureDone:(id)sender {
    //TODO: Fix the checks on code completion
    /*
    if([ self.delegate isEqualToString: @""] || [self.inputVisitorTeamName.text isEqualToString:@""] ){
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
     
    }else*/{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



- (IBAction)enableSpectatorBtnTouched:(id)sender {
    if( [UIScreen screens].count > 1 ){
        NSLog(@" Number of available displays: %li",(long)[UIScreen screens].count);
        [self connectExternalScreen];
    }else{
        [self performSegueWithIdentifier: @"spectatorScreenHowToScreen" sender: self];
    }
}

- (IBAction)dismissInstructionsBtnTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - External Screens

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


#pragma mark - My Functions

- (IBAction)resetClocks:(id)sender {
    [self.delegate resetClocks];
}

@end
