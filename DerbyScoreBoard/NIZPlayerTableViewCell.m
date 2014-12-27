//
//  NIZPlayerTableViewCell.m
//  Derby
//
//  Created by Nazario A. Ayala on 12/26/14.
//  Copyright (c) 2014 Nazario A. Ayala. All rights reserved.
//

#import "NIZPlayerTableViewCell.h"

@implementation NIZPlayerTableViewCell


- (void)awakeFromNib {
    // Initialization code
    [self setup];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    //[self setup];
}

-(void)setup
{
    self.contentMode = UIViewContentModeRedraw;
    self.backgroundColor = [UIColor colorWithWhite: .3 alpha:1];
}


@end
