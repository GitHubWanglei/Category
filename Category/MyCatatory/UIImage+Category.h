//
//  UIImage+Category.h
//  Category
//
//  Created by lihongfeng on 16/8/11.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

/** 绘制图片 */
+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color cornerRadius:(CGFloat)radius;

/** 重绘图片, 设置圆角, 防止离屏渲染 */
- (UIImage *)scaleImageToSize:(CGSize)size cornerRadius:(CGFloat)radius;

/** 重绘图片至指定尺寸大小 */
- (UIImage *)scaleToSize:(CGSize)size;

/** 获取GIF图片中所有帧 */
- (NSMutableArray<UIImage *> *)framesWithGIFImageData:(NSData *)imageData;

/** GIF图片动画持续时间 */
- (float)durationWithGIFImageData:(NSData *)imageData;

@end
