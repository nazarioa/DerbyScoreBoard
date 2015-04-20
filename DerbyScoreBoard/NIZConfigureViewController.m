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

@synthesize scoreBoardDataSource = _scoreBoardDataSource;
@synthesize delegate =_delegate;


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/*
 -(void) viewDidAppear:(BOOL)animated{
    if( [self.scoreBoardDataSource getTeam:HOME_TEAM] == nil ){
        NSLog(@" What is the scoreBoardDataSource");
        NSLog(self.scoreBoardDataSource);
        NSLog(@" What is the delegate");
        NSLog(self.delegate);
        [self.delegate viewControllerForKey: HOME_TEAM];
    }else if( [self.scoreBoardDataSource getTeam:VISITOR_TEAM] == nil ){
        
    }
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IB Actions

- (IBAction)btnTouchedConfigureDone:(id)sender {
    UIAlertView * alert = NULL;
    NSString * noteEnoughJammersTitle = @"%@ Team Needs Jammers";
    NSString * noteEnoughJammersMessage = @"Swipe %@ and touch the \n\"%@ Team Name\" \nand add at least one jammer player to the team.";
    
    NSString * missingTeamNameTitle = @"%@ Team Needs a Name";
    NSString * missingTeamNameMessage = @"Swipe %@ and touch the\n \"%@ Team Name\" text input fields.";
    
    
    if( [[self.scoreBoardDataSource getTeam: HOME_TEAM].teamName isEqualToString:@""] || [self.scoreBoardDataSource getTeam: HOME_TEAM].teamName == NULL){
        alert = [[UIAlertView alloc]
                 initWithTitle: [NSString stringWithFormat: missingTeamNameTitle, [HOME_TEAM capitalizedString]]
                 message: [NSString stringWithFormat: missingTeamNameMessage, @"right", [HOME_TEAM capitalizedString]]
                 delegate:self
                 cancelButtonTitle: OK_BUTTON
                 otherButtonTitles: nil];
        
    } else if( [[self.scoreBoardDataSource getTeam:HOME_TEAM] jammerCount]  < 1){
        alert = [[UIAlertView alloc]
                 initWithTitle: [NSString stringWithFormat: noteEnoughJammersTitle, [HOME_TEAM capitalizedString]]
                 message: [NSString stringWithFormat: noteEnoughJammersMessage, @"right", [HOME_TEAM capitalizedString]]
                 delegate:self
                 cancelButtonTitle: OK_BUTTON
                 otherButtonTitles: nil];
        
    } else if([[self.scoreBoardDataSource getTeam: VISITOR_TEAM].teamName isEqualToString:@""] || [self.scoreBoardDataSource getTeam: VISITOR_TEAM].teamName == NULL){
        alert = [[UIAlertView alloc]
                 initWithTitle: [NSString stringWithFormat: noteEnoughJammersTitle, [VISITOR_TEAM capitalizedString]]
                 message: [NSString stringWithFormat: noteEnoughJammersMessage, @"left", [VISITOR_TEAM capitalizedString]]
                 delegate:self
                 cancelButtonTitle: OK_BUTTON
                 otherButtonTitles: nil];
        
    }else if( [[self.scoreBoardDataSource getTeam:VISITOR_TEAM] jammerCount]  < 1){
        alert = [[UIAlertView alloc]
                 initWithTitle: [NSString stringWithFormat: noteEnoughJammersTitle, [VISITOR_TEAM capitalizedString]]
                 message: [NSString stringWithFormat: noteEnoughJammersMessage, @"left", [VISITOR_TEAM capitalizedString]]
                 delegate:self
                 cancelButtonTitle: OK_BUTTON
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
         [self.scoreBoardDataSource setupSpectatorScreen: avilableScreens];
         NSLog(@"Yes Screens");
     }else{
         NSLog(@"No Screens");
     }
 }


#pragma mark - My Functions

- (IBAction)resetClocks:(id)sender {
    [self.scoreBoardDataSource resetClocks];
}

@end
