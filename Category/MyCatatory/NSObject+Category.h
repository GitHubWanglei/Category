//
//  NSObject+Category.h
//  Category
//
//  Created by lihongfeng on 16/8/2.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)

/** 交换实例(对象)方法 */
+ (void)swizzleInstanceSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector;

/** 交换类方法 */
+ (void)swizzleClassSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector;

@end
