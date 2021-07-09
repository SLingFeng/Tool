//
//  NSString+LF.m
//  Tool
//
//  Created by mac on 2021/7/9.
//

#import "NSString+LF.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+LF.h"

@implementation NSString (LF)


- (NSDate *)date
{
    NSTimeZone * local = [NSTimeZone localTimeZone];
    
    NSString * format = @"yyyy-MM-dd HH:mm:ss";
    NSString * text = [(NSString *)self substringToIndex:format.length];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return [NSDate dateWithTimeInterval:(3600 + [local secondsFromGMT])
                              sinceDate:[dateFormatter dateFromString:text]];
}

- (NSString *)MD5
{
    NSData * value;
    
    value = [NSData dataWithBytes:[self UTF8String] length:[self length]];
    value = [value MD5];
    
    if (value)
    {
        char            tmp[16];
        unsigned char *    hex = (unsigned char *)malloc( 2048 + 1 );
        unsigned char *    bytes = (unsigned char *)[value bytes];
        unsigned long    length = [value length];
        
        hex[0] = '\0';
        
        for ( unsigned long i = 0; i < length; ++i )
        {
            sprintf( tmp, "%02X", bytes[i] );
            strcat( (char *)hex, tmp );
        }
        
        NSString * result = [NSString stringWithUTF8String:(const char *)hex];
        free( hex );
        return result;
    }
    else
    {
        return nil;
    }
}

- (NSString *)SHA1
{
    const char *    cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *        data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t            digest[CC_SHA1_DIGEST_LENGTH] = { 0 };
    CC_LONG            digestLength = (CC_LONG)data.length;
    
    CC_SHA1( data.bytes, digestLength, digest );
    
    NSMutableString * output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for ( int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++ )
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)eq:(NSString *)other
{
    return [self isEqualToString:other];
}

- (BOOL)equal:(NSString *)other
{
    return [self isEqualToString:other];
}

- (BOOL)is:(NSString *)other
{
    return [self isEqualToString:other];
}

- (BOOL)isNot:(NSString *)other
{
    return NO == [self isEqualToString:other];
}

- (BOOL)isValueOf:(NSArray *)array
{
    return [self isValueOf:array caseInsens:NO];
}

- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens
{
    NSStringCompareOptions option = caseInsens ? NSCaseInsensitiveSearch : 0;  /** NSCaseInsensitiveSearch 不区分大小写比较*/
    
    for ( NSObject * obj in array )
    {
        if ( NO == [obj isKindOfClass:[NSString class]] )
            continue;
        
        if ( [(NSString *)obj compare:self options:option] )
            return YES;
    }
    
    return NO;
}

- (BOOL)isTelephone
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:self]   ||
    [regextestphs evaluateWithObject:self]      ||
    [regextestct evaluateWithObject:self]       ||
    [regextestcu evaluateWithObject:self]       ||
    [regextestcm evaluateWithObject:self];
}

- (BOOL)isMobilephone
{
    NSString    *MOBILE          = @"^[1-9]\\d{10}$";
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return  [regextestMobile evaluateWithObject:self];
}

- (BOOL)isEmail
{
    NSString *        regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)isUrl
{
    NSString *        regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)isIPAddress
{
    NSArray *            components = [self componentsSeparatedByString:@"."];
    NSCharacterSet *    invalidCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    
    if ( [components count] == 4 )
    {
        NSString *part1 = [components objectAtIndex:0];
        NSString *part2 = [components objectAtIndex:1];
        NSString *part3 = [components objectAtIndex:2];
        NSString *part4 = [components objectAtIndex:3];
        
        if ( [part1 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part2 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part3 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part4 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound )
        {
            if ( [part1 intValue] < 255 &&
                [part2 intValue] < 255 &&
                [part3 intValue] < 255 &&
                [part4 intValue] < 255 )
            {
                return YES;
            }
        }
    }
    
    return NO;
}

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

- (CGSize)sizeWithFont:(UIFont *)font byWidth:(CGFloat)width
{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment     = NSTextAlignmentLeft;
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:self attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:style}];
    
    CGSize size =  [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    return CGSizeMake(size.width, size.height + 1);
}

- (CGSize)sizeWithFont:(UIFont *)font byHeight:(CGFloat)height
{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment     = NSTextAlignmentLeft;
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:self attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:style}];
    
    CGSize size =  [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    return CGSizeMake(size.width + 1, size.height);
}

#endif    // #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)


//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstPinyinCharactor:(NSString *)aString
{
    NSString *str    = [self transform:aString];
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

+ (NSString *)firstCharactor:(NSString *)aString
{
    NSString *first = [[aString substringToIndex:1] uppercaseString];
    
    return  first.length ? first : @"无";
}

+ (NSString *)transform:(NSString *)chinese
{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripDiacritics, NO);
    //返回最近结果
    return pinyin;
}

- (NSString *)sha256
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data     = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, (int32_t)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (NSString *)encodeBase64:(NSString *)string
{
    if (string.length == 0) {
        return nil;
    }
    
    NSData *encodeData      = [string     dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String  = [encodeData base64EncodedStringWithOptions:0];
    
    return base64String;
}
+ (NSString *)decodeBase64:(NSString *)base64String
{
    if (base64String.length == 0) {
        return nil;
    }
    
    NSData   *decodedData   = [[NSData alloc]   initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    
    return decodedString;
}

- (NSMutableAttributedString *)trattrStr:(NSString *)key font:(UIFont *)font color:(UIColor *)color {
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:color
                    range:NSMakeRange(0, self.length)];
    [attrStr addAttribute:NSFontAttributeName
                    value:font
                    range:NSMakeRange(0, self.length)];
    if (key) {
        //关键字
        NSRange range = [self rangeOfString:key];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:kMainColor
                        range:range];
    }
    

    return attrStr;

}

@end
