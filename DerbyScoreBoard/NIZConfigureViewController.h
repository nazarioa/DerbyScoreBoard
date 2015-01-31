//
//  NIZConfigureViewController.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 3/10/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIZConstants.pch"
#import "NIZDerbyTeam.h"

@class NIZScoreBoardViewController;

@protocol NIZConfigureScreenProtocol <NSObject>
-(void) resetClocks;
-(void) setupSpectatorScreen:(NSArray *) avilableScreens;
-(id) spectatorViewController;
@end


@interface NIZConfigureViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate>
@property (weak, nonatomic) id <NIZConfigureScreenProtocol> delegate;
@end
