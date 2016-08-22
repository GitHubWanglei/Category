//
//  UIView+Category.h
//
//  Created by wanglei on 16/7/18.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

/** 晃动动画 */
- (void)shake;

@end
