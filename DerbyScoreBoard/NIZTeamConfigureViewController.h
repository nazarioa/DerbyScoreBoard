//
//  NIZTeamConfigureViewController.h
//  Derby
//
//  Created by Nazario A. Ayala on 1/22/15.
//  Copyright (c) 2015 Nazario A. Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIZConstants.pch"
#import "NIZDerbyTeam.h"
#import "NIZAddEditPlayerViewController.h"

@protocol NIZConfigureTeamScreenDataSourceProtocol <NSObject>
-(NIZDerbyTeam *) getTeam: (NSString *) type;
-(void) setHomeOrVisitor: (NSString *) type asTeam: (NIZDerbyTeam *) team;
@end

@interface NIZTeamConfigureViewController : UIViewController <AddEditPlayerProtocol, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) id <NIZConfigureTeamScreenDataSourceProtocol> dataSource;
@property (weak, nonatomic) id delegate;
@property (nonatomic, strong) NIZDerbyTeam * team;
@property (nonatomic, strong) NSString * teamType;
@end
