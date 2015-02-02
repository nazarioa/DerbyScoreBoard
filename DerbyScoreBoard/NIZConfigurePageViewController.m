//
//  NIZConfigurePageViewController.m
//  Derby
//
//  Created by Nazario A. Ayala on 1/23/15.
//  Copyright (c) 2015 Nazario A. Ayala. All rights reserved.
//

#import "NIZConfigurePageViewController.h"

@interface NIZConfigurePageViewController (){
    NSArray * pageDictArray;
}


@end

@implementation NIZConfigurePageViewController

@synthesize delegate = _delegate;

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    self.configPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ConfigurePageViewController"];
    self.configPageViewController.dataSource = self;
    
    NIZTeamConfigureViewController * homeTeamScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeTeamConfigureScreen"];
    homeTeamScreen.teamType = HOME_TEAM;
    homeTeamScreen.delegate = self.delegate;
    
    NIZTeamConfigureViewController * visitorTeamScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"VisitorTeamConfigureScreen"];
    visitorTeamScreen.teamType = VISITOR_TEAM;
    visitorTeamScreen.delegate = self.delegate;
    
    NIZConfigureViewController * configureScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"ConfigureScreen"];
    self.pagesDict = [NSDictionary dictionaryWithObjectsAndKeys: homeTeamScreen, HOME_TEAM, configureScreen, CONFIGURE, visitorTeamScreen, VISITOR_TEAM, nil];
    configureScreen.delegate = self.delegate;
    
    NSArray *viewControllers = @[configureScreen];
    [self.configPageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.configPageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController: self.configPageViewController];
    [self.view addSubview: self.configPageViewController.view];
    [self.configPageViewController didMoveToParentViewController:self];
}

//TODO: Make the correct screen load when team and players are missing
/*
-(void) viewDidAppear:(BOOL)animated{
    if( [self.delegate 
        [self performSegueWithIdentifier: @"toConfigureScreenSegue" sender: self];
    }
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - My Functions


- (UIViewController *)viewControllerAtKey:(NSString *)index
{
    UIViewController *temp = nil;
    if(index == HOME_TEAM){
        temp = [self.pagesDict objectForKey: HOME_TEAM];
        //set stuff here
    }else if (index == CONFIGURE){
        temp = [self.pagesDict objectForKey: CONFIGURE];
        //set stuff here
    }else if(index == VISITOR_TEAM){
        temp = [self.pagesDict objectForKey: VISITOR_TEAM];
        //set stuff here
    }
    return temp;
}



#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    UIViewController * page = nil;
    if( [pageViewController isEqual: self.configPageViewController] ){
        if( [viewController isEqual: [self.pagesDict objectForKey: VISITOR_TEAM]] ){
            page = [self.pagesDict objectForKey: CONFIGURE];
        }else if ( [viewController isEqual: [self.pagesDict objectForKey: CONFIGURE]] ){
            page = [self.pagesDict objectForKey: HOME_TEAM];
        }
    }
    return page;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    UIViewController * page = nil;
    if( [pageViewController isEqual: self.configPageViewController]){
        if( [viewController isEqual: [self.pagesDict objectForKey: HOME_TEAM]] ){
            page = [self.pagesDict objectForKey: CONFIGURE];
        }else if ( [viewController isEqual: [self.pagesDict objectForKey: CONFIGURE]] ){
            page = [self.pagesDict objectForKey: VISITOR_TEAM];
        }
    }
    return page;
}

@end
