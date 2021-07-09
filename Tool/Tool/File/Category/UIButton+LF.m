//
//  UIButton+LF.m
//  Tool
//
//  Created by mac on 2021/4/9.
//

#import "UIButton+LF.h"
#import <objc/runtime.h>

@implementation UIButton (LF)

static char onClickBlockKey;

- (OnClickBlock)onClickBlock {
    return objc_getAssociatedObject(self, &onClickBlockKey);
}

- (void)setOnClickBlock:(OnClickBlock)onClickBlock {
    [self addTarget:self action:@selector(onClick:) forControlEvents:(UIControlEventTouchUpInside)];
    objc_setAssociatedObject(self, &onClickBlockKey, onClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)onClick:(UIButton *)btn {
    //    OnClickBlock block = objc_getAssociatedObject(self, &onClickBlockKey);
    //    if (block) {
    //        block(btn);
    //    }
    if (self.onClickBlock) {
        self.onClickBlock(btn);
    }
}

#pragma mark - 设置
- (instancetype)setWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color {
    [self setTitleColor:color forState:(UIControlStateNormal)];
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    //        [self setupButton];
    return self;
}

- (instancetype)setWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color text:(NSString *)text {
    [self setTitleColor:color forState:(UIControlStateNormal)];
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    //        [self setupButton];
    return self;
}

- (instancetype)setWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color text:(NSString *)text backg:(UIColor *)backg radius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    [self setTitleColor:color forState:(UIControlStateNormal)];
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self setTitle:text forState:UIControlStateNormal];
    
    [self setBackgroundColor:backg];
    self.layer.cornerRadius = radius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    
    //        [self setupButton];
    
    return self;
}

- (void)setBtnWithFontSize:(NSInteger)fontSize fontColor:(UIColor *)color backg:(UIColor *)backg {
    [self setTitleColor:color forState:(UIControlStateNormal)];
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self setBackgroundColor:backg];
}

- (void)setImageTopAndTitleBottom:(NSString *)str {
    NSString * buttonSelectedTitle = str;
    [self setTitle:buttonSelectedTitle forState:UIControlStateNormal];
    
    CGPoint buttonBoundsCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    // 找出imageView最终的center
    CGPoint endImageViewCenter = CGPointMake(buttonBoundsCenter.x, CGRectGetMidY(self.imageView.bounds));
    
    // 找出titleLabel最终的center
    CGPoint endTitleLabelCenter = CGPointMake(buttonBoundsCenter.x, CGRectGetHeight(self.bounds)-CGRectGetMidY(self.titleLabel.bounds));
    
    // 取得imageView最初的center
    CGPoint startImageViewCenter = self.imageView.center;
    
    // 取得titleLabel最初的center
    CGPoint startTitleLabelCenter = self.titleLabel.center;
    
    // 设置imageEdgeInsets
    CGFloat imageEdgeInsetsTop = endImageViewCenter.y - startImageViewCenter.y;
    
    CGFloat imageEdgeInsetsLeft = endImageViewCenter.x - startImageViewCenter.x;
    
    CGFloat imageEdgeInsetsBottom = -imageEdgeInsetsTop;
    
    CGFloat imageEdgeInsetsRight = -imageEdgeInsetsLeft;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(imageEdgeInsetsTop, imageEdgeInsetsLeft, imageEdgeInsetsBottom, imageEdgeInsetsRight);
    
    // 设置titleEdgeInsets
    CGFloat titleEdgeInsetsTop = endTitleLabelCenter.y-startTitleLabelCenter.y;
    
    CGFloat titleEdgeInsetsLeft = endTitleLabelCenter.x - startTitleLabelCenter.x;
    
    CGFloat titleEdgeInsetsBottom = -titleEdgeInsetsTop;
    
    CGFloat titleEdgeInsetsRight = -titleEdgeInsetsLeft;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(titleEdgeInsetsTop, titleEdgeInsetsLeft, titleEdgeInsetsBottom, titleEdgeInsetsRight);
}

- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style

                        imageTitleSpace:(CGFloat)space

{
    
    [self layoutButtonWithEdgeInsetsStyle:style imageTitleSpace:space size:CGSizeZero];
    
}
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style

                        imageTitleSpace:(CGFloat)space size:(CGSize)size

{
    
    //    self.backgroundColor = [UIColor cyanColor];
    
    /**
     
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     
     */
    
    // 1. 得到imageView和titleLabel的宽、高
    
    CGFloat imageWith = [UIDevice currentDevice].systemVersion.floatValue >= 8.0?self.imageView.intrinsicContentSize.width:self.imageView.frame.size.width;
    
    CGFloat imageHeight = [UIDevice currentDevice].systemVersion.floatValue >= 8.0?self.imageView.intrinsicContentSize.height:self.imageView.frame.size.height;
    
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        imageWith = size.width;
        imageHeight = size.height;
    }
    
    CGFloat labelWidth = 0.0;
    
    CGFloat labelHeight = 0.0;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        
        labelHeight = self.titleLabel.intrinsicContentSize.height;
        
    } else {
        
        labelWidth = self.titleLabel.frame.size.width;
        
        labelHeight = self.titleLabel.frame.size.height;
        
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    
    switch (style) {
            
            case MKButtonEdgeInsetsStyleTop:
            
        {
            
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
            
        }
            
            break;
            
            case MKButtonEdgeInsetsStyleLeft:
            
        {
            
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
            
        }
            
            break;
            
            case MKButtonEdgeInsetsStyleBottom:
            
        {
            
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
            
        }
            
            break;
            
            case MKButtonEdgeInsetsStyleRight:
            
        {
            
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
            
        }
            
            break;
            
        default:
            
            break;
            
    }
    
    // 4. 赋值
    
    self.titleEdgeInsets = labelEdgeInsets;
    
    self.imageEdgeInsets = imageEdgeInsets;
    
}

@end
