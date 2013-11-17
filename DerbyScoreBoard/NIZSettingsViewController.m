//
//  NIZSettingsViewController.m
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 8/5/13.
//  Copyright (c) 2013 Nazario A. Ayala. All rights reserved.
//

#import "NIZSettingsViewController.h"

@interface NIZSettingsViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *settingsSelectorSegment;

@end

@implementation NIZSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Made it here");
    //self.settingsSelectorSegment = [[UISegmentedControl alloc] initWithItems:@[@"Game Settings", @"Bout Settings", @"Display Settings"]];
	// Do any additional setup after loading the view.
    /*
     [self.settingsSelectorSegment addTarget:self
                         action:@selector(settingsControllerTap:)
               forControlEvents:UIControlEventValueChanged];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)settingsControllerTap: (id) sender{
    // The segmented control was clicked, handle it here
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
	NSLog(@"Segment clicked: %d", segmentedControl.selectedSegmentIndex);
    NSLog(@"fuck balls.");
}

@end
