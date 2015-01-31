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
@property (strong, nonatomic) IBOutlet UITextField *playerFirstName;
@property (strong, nonatomic) IBOutlet UITextField *playerLastName;
@property (strong, nonatomic) IBOutlet UITextField *playerDerbyName;
@property (strong, nonatomic) IBOutlet UITextField *playerDerbyNumber;
@property (strong, nonatomic) IBOutlet UISwitch *playerIsJammer;
@property (strong, nonatomic) IBOutlet UIImageView *playerMug;
@property (strong, nonatomic) IBOutlet UIButton *mugBtn;
@property (strong, nonatomic) IBOutlet UILabel * addEditViewModeLabel;

@end

@implementation NIZAddEditPlayerViewController

@synthesize delegate = _delegate;
@synthesize mode = _mode;
@synthesize addEditViewModeLabel = _addEditViewModeLabel;
@synthesize playerToBeEdited = _playerToBeEdited;


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer * layer = [self.playerMug layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:self.playerMug.bounds.size.width/2.0];
    [layer setBorderWidth:4.0];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [self setupView];
}

-(void) viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
}
-(void) viewDidAppear:(BOOL)animated{
    NSLog(@"vieDidAppear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IB Actions

- (IBAction)btnTouchedFinishedEditingPlayer:(id)sender {
    if([self.playerDerbyName.text isEqualToString:@""] || [self.playerDerbyNumber.text isEqualToString:@""]){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Cannot Add Player" message:@"Players must have a \n\"Derby Name\"\n and \"Derby Number\"\n in order to be added to the roster." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else{
        if( [self.mode isEqual: ADD_MODE]){
            NIZPlayer * aPlayer = [[NIZPlayer alloc] initWithDerbyName: self.playerDerbyName.text
                                                           derbyNumber: self.playerDerbyNumber.text
                                                             firstName: self.playerFirstName.text
                                                              lastName: self.playerLastName.text
                                                               mugShot: self.playerMug.image
                                                              isJammer: self.playerIsJammer.enabled];
            [self.delegate forTeam:self.teamType savePlayer:aPlayer];
            
        }else if( [self.mode isEqual: EDIT_MODE]){
            self.playerToBeEdited.derbyName = self.playerDerbyName.text;
            self.playerToBeEdited.derbyNumber = self.playerDerbyNumber.text;
            self.playerToBeEdited.firstName = self.playerFirstName.text;
            self.playerToBeEdited.lastName = self.playerLastName.text;
            self.playerToBeEdited.mugShot = self.playerMug.image;
            self.playerToBeEdited.isJammer = self.playerIsJammer.enabled;
        }
        [self.delegate refreshPlayerRoster];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)btnTouchedCancelEditingPlayer:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnTouchedMug:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.modalPresentationStyle = UIModalPresentationPageSheet;
    picker.delegate = self;
    
    if((UIButton *) sender == self.mugBtn) {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.playerMug.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    CALayer * layer = [self.playerMug layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:self.playerMug.bounds.size.width/2.0];
    [layer setBorderWidth:4.0];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
}


#pragma mark - My Functions

-(void) setupView{
    if([self.mode isEqual: EDIT_MODE]){
        self.addEditViewModeLabel.text  = @"Edit";
        if(self.playerToBeEdited){
            self.playerDerbyName.text   = self.playerToBeEdited.derbyName;
            self.playerDerbyNumber.text = self.playerToBeEdited.derbyNumber;
            self.playerFirstName.text   = self.playerToBeEdited.firstName;
            self.playerLastName.text    = self.playerToBeEdited.lastName;
            self.playerMug.image        = self.playerToBeEdited.mugShot;
            [self.playerIsJammer setOn: self.playerToBeEdited.isJammer animated:NO];
        }
        
    }else if([self.mode isEqual: ADD_MODE]){
        self.addEditViewModeLabel.text  = @"Add";
    }
}

@end
