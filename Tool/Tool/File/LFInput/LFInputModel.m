//
//  LFInputModel.m
//
//
//  Created by 孙凌锋 on 2020/2/21.
//  Copyright © 2020 孙凌锋. All rights reserved.
//

#import "LFInputModel.h"

@implementation LFInputModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maxLeftSpace = 0;
        self.cellHeight = 60;
        self.leftImageSize = CGSizeMake(15, 15);
//        self.tfTextAlignment = NSTextAlignmentLeft;
    }
    return self;
}

@end
