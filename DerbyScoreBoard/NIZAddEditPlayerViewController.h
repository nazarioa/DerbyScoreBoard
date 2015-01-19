//
//  NIZAddEditPlayerViewController.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 10/12/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIZConstants.pch"

@class NIZPlayer;
@protocol addEditPlayerProtocol <NSObject>
-(void) forTeam: (NSString *) type savePlayer: (NIZPlayer *) player;
-(void) refreshPlayerRoster;
@end

@interface NIZAddEditPlayerViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) id <addEditPlayerProtocol> delegate;
@property (strong, nonatomic) NSString * teamType;
@property (strong, nonatomic) NSString * mode;
@property (weak, nonatomic) NIZPlayer * playerToBeEdited;
@end
