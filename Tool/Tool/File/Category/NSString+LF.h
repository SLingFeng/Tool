//
//  NSString+LF.h
//  Tool
//
//  Created by mac on 2021/7/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LF)

@property (nonatomic, readonly) NSDate   * date;
@property (nonatomic, readonly) NSString * MD5;

- (NSString *)trim;

- (BOOL)eq:(NSString *)other;
- (BOOL)equal:(NSString *)other;

- (BOOL)is:(NSString *)other;
- (BOOL)isNot:(NSString *)other;

- (BOOL)isValueOf:(NSArray *)array;
- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens;


- (BOOL)isTelephone;    /** match telephone*/
- (BOOL)isMobilephone;  /** match mobilephone, 11 numberic*/
- (BOOL)isEmail;
- (BOOL)isUrl;
- (BOOL)isIPAddress;

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
- (CGSize)sizeWithFont:(UIFont *)font byWidth:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font byHeight:(CGFloat)height;
#endif    // #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

+ (NSString *)transform:(NSString *)chinese;
// 获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstPinyinCharactor:(NSString *)aString;
+ (NSString *)firstCharactor      :(NSString *)aString;

- (NSString *)sha256;
+ (NSString *)encodeBase64:(NSString *)string;
+ (NSString *)decodeBase64:(NSString *)base64String;


- (NSMutableAttributedString *)trattrStr:(NSString *)key font:(UIFont *)font color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
