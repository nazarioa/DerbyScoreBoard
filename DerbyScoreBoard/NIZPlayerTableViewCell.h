//
//  NIZPlayerTableViewCell.h
//  Derby
//
//  Created by Nazario A. Ayala on 12/26/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIZConstants.pch"

@interface NIZPlayerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *playerNumber;
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UIImageView *playerMug;
//@property (weak, nonatomic) id <UITableViewDelegate> delegate;

@end
