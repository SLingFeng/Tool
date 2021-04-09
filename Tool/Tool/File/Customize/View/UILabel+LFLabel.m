//
//  UILabel+LFLabel.m
//  Tool
//
//  Created by mac on 2021/4/9.
//

#import "UILabel+LFLabel.h"
#import <objc/runtime.h>

static char onTapBlockKey;

@implementation UILabel (LFLabel)

- (OnTapLabelBlock)onTapBlock {
    return objc_getAssociatedObject(self, &onTapBlockKey);
}

- (void)setOnTapBlock:(OnTapLabelBlock)onTapBlock {
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)]];
    objc_setAssociatedObject(self, &onTapBlock, onTapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)tapClick:(UILabel *)label {
    if (self.onTapBlock) {
        self.onTapBlock(label);
    }
}

@end
