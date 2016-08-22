//
//  UIViewController+Category.m
//
//  Created by wanglei on 16/7/28.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import "UIViewController+Category.h"
#import <objc/message.h>

@implementation UIViewController (Category)

//----------------------------------Tracking method start--------------------------------------
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        swizzMethod(class, @selector(viewWillAppear:), @selector(custom_viewWillAppear:));
    });
}

static void swizzMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (!didAddMethod) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)custom_viewWillAppear:(BOOL)animated {
    [self custom_viewWillAppear:animated];
    NSLog(@"\n\n\n----->>>>>>>>>>>>>>>>>>> Tracking:%@", NSStringFromClass([self class]));
}
//----------------------------------Tracking method end---------------------------------------

@end
