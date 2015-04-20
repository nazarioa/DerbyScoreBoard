//
//  NIZConfigurePageViewController.h
//  Derby
//
//  Created by Nazario A. Ayala on 1/23/15.
//  Copyright (c) 2015 Nazario A. Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIZConstants.pch"
#import "NIZGameClock.h"
#import "NIZDerbyJam.h"
#import "NIZConfigureViewController.h"
#import "NIZTeamConfigureViewController.h"

@interface NIZConfigurePageViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) IBOutlet UIPageViewController *configPageViewController;
//I think that this could be connected via Storybaord but is instead connected programaticaly in self.m file -(void) viewDidLoad
@property (nonatomic, strong) NSDictionary * pagesDict;
@property (weak, nonatomic) id delegate;

@end
