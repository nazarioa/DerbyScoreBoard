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
    self.inputHomeTeamName.text = [self.delegate getTeamNameFor:@"home"];
    self.inputVisitorTeamName.text = [self.delegate getTeamNameFor:@"visitor"];
    
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
    [self.delegate setTeamNameTo: [sender text] forTeam:@"home"];
    
}

- (IBAction)visitorTeamNameDidEndEditing:(id)sender {
    [self.delegate setTeamNameTo: [sender text] forTeam:@"visitor"];
    //TODO
}


@end
