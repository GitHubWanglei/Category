//
//  UIImage+Category.m
//  Category
//
//  Created by lihongfeng on 16/8/11.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color cornerRadius:(CGFloat)radius{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)scaleImageToSize:(CGSize)size cornerRadius:(CGFloat)radius{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)scaleToSize:(CGSize)size{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    } else {
        UIGraphicsBeginImageContext(size);
    }
#else
    UIGraphicsBeginImageContext(size);
#endif
    
    [self drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
