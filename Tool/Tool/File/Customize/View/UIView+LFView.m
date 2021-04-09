//
//  UIView+LFView.m
//  Tool
//
//  Created by mac on 2021/4/9.
//

#import "UIView+LFView.h"
#import <objc/runtime.h>

static char OnTapViewBlockKey;

@implementation UIView (LFView)

- (OnTapViewBlock)onTapViewBlock {
    return objc_getAssociatedObject(self, &OnTapViewBlockKey);
}

- (void)setOnTapViewBlock:(OnTapViewBlock)onTapViewBlock {
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)]];

    objc_setAssociatedObject(self, &OnTapViewBlockKey, onTapViewBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)tapClick:(UIView *)view {
    if (self.onTapViewBlock) {
        self.onTapViewBlock(view);
    }
}
@end
