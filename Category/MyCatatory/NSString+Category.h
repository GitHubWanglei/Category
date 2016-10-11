//
//  NSString+Category.h
//
//  Created by wanglei on 16/7/28.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Category)

/** 计算单行文字尺寸 */
- (CGSize)sizeWithFontOfSize:(CGFloat)fontOfSize;

/** 计算文字尺寸 */
- (CGSize)sizeWithMaxSize:(CGSize)maxSize FontOfSize:(CGFloat)fontOfSize;

/** 计算文字高度 */
- (CGFloat)sizeWithMaxWidth:(CGFloat)width FontOfSize:(CGFloat)fontOfSize;

/** 将字符串中的某段文字设置为某种颜色, 并返回富文本字符串 */
- (NSMutableAttributedString *)attributedStringWithColor:(UIColor *)color partialColor:(UIColor *)partialColor partialRange:(NSRange)partialRange;

/** 将字符串中的某段文字替换为表情图片, 并返回富文本字符串 */
- (NSMutableAttributedString *)attributedStringWithImage:(UIImage *)image size:(CGSize)size replaceRange:(NSRange)range;

/** 将字符串中所有表情文字替换为表情图片, 并返回富文本字符串 */
- (NSMutableAttributedString *)attributedStringWithPattern:(NSString *)pattern imageNames:(NSArray *)imageNames;

@end
