//
//  NSString+Category.m
//
//  Created by wanglei on 16/7/28.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

- (CGSize)sizeWithFontOfSize:(CGFloat)fontOfSize{
    CGSize size;
    size = [self sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontOfSize]}];
    CGFloat width = ceil(size.width);
    CGFloat height = ceil(size.height);
    return CGSizeMake(width, height);
}

- (CGSize)sizeWithMaxSize:(CGSize)maxSize FontOfSize:(CGFloat)fontOfSize{
    CGSize size;
    size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontOfSize]} context:nil].size;
    CGFloat width = ceil(size.width);
    CGFloat height = ceil(size.height);
    return CGSizeMake(width, height);
}

- (CGFloat)sizeWithMaxWidth:(CGFloat)width FontOfSize:(CGFloat)fontOfSize{
    return [self sizeWithMaxSize:CGSizeMake(width, MAXFLOAT) FontOfSize:fontOfSize].height;
}

- (NSMutableAttributedString *)attributedStringWithColor:(UIColor *)color partialColor:(UIColor *)partialColor partialRange:(NSRange)partialRange{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, self.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:partialColor range:partialRange];
    return attributedString;
}

- (NSMutableAttributedString *)attributedStringWithImage:(UIImage *)image size:(CGSize)size replaceRange:(NSRange)range{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, size.width, size.height);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attachment];
    [attributedString replaceCharactersInRange:range withAttributedString:string];
    return attributedString;
}

- (NSMutableAttributedString *)attributedStringWithPattern:(NSString *)pattern imageNames:(NSArray *)imageNames{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSError *error;
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
        return nil;
    }
    NSArray *resultArr = [regularExp matchesInString:self
                                             options:NSMatchingReportProgress
                                               range:NSMakeRange(0, self.length)];
    if (resultArr.count == 0) {
        return attributedString;
    }
    for (NSInteger i = resultArr.count - 1; i >= 0; i--) {
        NSTextCheckingResult *checkingResult = resultArr[i];
        NSString *imageName = [self substringWithRange:checkingResult.range];
        for (NSString *localImageName in imageNames) {
            if ([imageName isEqualToString:localImageName]) {
                NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
                attachment.image = [UIImage imageNamed:imageName];
                NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attachment];
                [attributedString replaceCharactersInRange:checkingResult.range withAttributedString:string];
            }
        }
    }
    return attributedString;
}



@end






