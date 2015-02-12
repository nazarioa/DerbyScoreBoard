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

@synthesize dataSource = _dataSource;
@synthesize delegate =_delegate;


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
    UIAlertView * alert = NULL;
    if( [[self.dataSource getTeam: HOME_TEAM].teamName isEqualToString:@""] || [self.dataSource getTeam: HOME_TEAM].teamName == NULL){
        alert = [[UIAlertView alloc]
                 initWithTitle:@"Home Team Name is Missing"
                 message:@"Please give your team a name by swiping to the left and touching the \"Home Team Name\" text input fields."
                 delegate:self
                 cancelButtonTitle:@"Ok"
                 otherButtonTitles: nil];
        
    } else if( [[self.dataSource getTeam:HOME_TEAM] jammerCount]  < 1){
        alert = [[UIAlertView alloc]
                 initWithTitle:@"Not Enough Players"
                 message:@"Please add at least one jammer player to each team by touching the \"Add Player\" button."
                 delegate:self
                 cancelButtonTitle:@"Ok"
                 otherButtonTitles: nil];
        
    } else if([[self.dataSource getTeam: VISITOR_TEAM].teamName isEqualToString:@""] || [self.dataSource getTeam: VISITOR_TEAM].teamName == NULL){
        alert = [[UIAlertView alloc]
                 initWithTitle:@"Visitor Team Name is Missing"
                 message:@"Please give your team a name by swiping to the right and touching the \"Visitor Team Name\" text input fields."
                 delegate:self
                 cancelButtonTitle:@"Ok"
                 otherButtonTitles: nil];
        
    }else if( [[self.dataSource getTeam:VISITOR_TEAM] jammerCount]  < 1){
        alert = [[UIAlertView alloc]
                 initWithTitle:@"Not Enough Players"
                 message:@"Please add at least one jammer player to each team by touching the \"Add Player\" button."
                 delegate:self
                 cancelButtonTitle:@"Ok"
                 otherButtonTitles: nil];
    }
    
    if(alert ==  NULL){
        [self dismissViewControllerAnimated:YES completion:nil]; //temp
    }else{
        [alert show];
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
