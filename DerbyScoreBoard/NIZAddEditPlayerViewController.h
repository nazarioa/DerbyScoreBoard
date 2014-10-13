//
//  NIZAddEditPlayerViewController.h
//  DerbyScoreBoard
//
//  Created by Nazario A. Ayala on 10/12/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NIZPlayer;
@protocol addEditPlayerProtocol <NSObject>
-(void) forTeam: (NSString *) type savePlayer: (NIZPlayer *) player;
@end

@interface NIZAddEditPlayerViewController : UIViewController
@property (weak, nonatomic) id <addEditPlayerProtocol> delegate;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) NSString * teamType;
@end
