//
//  UIImage+Category.m
//  Category
//
//  Created by lihongfeng on 16/8/11.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import "UIImage+Category.h"
#import <ImageIO/ImageIO.h>

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

/** 获取GIF图片中所有帧 */
- (NSMutableArray<UIImage *> *)framesWithGIFImageData:(NSData *)imageData{
    if (!imageData) {
        return nil;
    }
    NSMutableArray<UIImage *> *frames = [NSMutableArray array];
    CGImageSourceRef imageSrcRef = CGImageSourceCreateWithData((CFDataRef)imageData, NULL);
    size_t l = CGImageSourceGetCount(imageSrcRef);
    if (l <= 1) {
        [frames addObject:[UIImage imageWithData:imageData]];
        return frames;
    }else{
        for (size_t i = 0; i < l; i++) {
            CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSrcRef, i, NULL);
            [frames addObject:[UIImage imageWithCGImage:imageRef]];
            CGImageRelease(imageRef);
        }
    }
    CFRelease(imageSrcRef);
    return frames;
}

/** GIF图片动画持续时间 */
- (float)durationWithGIFImageData:(NSData *)imageData{
    if (!imageData) {
        return 0;
    }
    float duration = 0;
    CGImageSourceRef imageSrcRef = CGImageSourceCreateWithData((CFDataRef)imageData, NULL);
    size_t l = CGImageSourceGetCount(imageSrcRef);
    if (l <= 1) {
        return 0;
    }else{
        for (size_t i = 0; i < l; i++) {
            NSDictionary *properties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(imageSrcRef, i, NULL));
            float delayTime = [[properties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime] floatValue];
            if (!delayTime) {
                delayTime = [[properties objectForKey:(NSString *)kCGImagePropertyGIFDelayTime] floatValue];
            }
            duration += delayTime;
            CFRelease((__bridge CFDictionaryRef)(properties));
        }
    }
    CFRelease(imageSrcRef);
    return duration;
}

@end
