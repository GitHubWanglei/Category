//
//  NSObject+Category.m
//  Category
//
//  Created by lihongfeng on 16/8/2.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/message.h>

@implementation NSObject (Category)

+ (void)swizzleInstanceSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector{
    Method origMethod = class_getInstanceMethod(self, origSelector);
    Method swizzleMethod = class_getInstanceMethod(self, swizzleSelector);
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (!isAdd) {
        method_exchangeImplementations(origMethod, swizzleMethod);
    }
}

+ (void)swizzleClassSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector{
    Method origMethod = class_getClassMethod(self, origSelector);
    Method swizzleMethod = class_getClassMethod(self, swizzleSelector);
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (!isAdd) {
        method_exchangeImplementations(origMethod, swizzleMethod);
    }
}

@end
