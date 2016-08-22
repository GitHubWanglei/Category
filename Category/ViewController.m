//
//  ViewController.m
//  Category
//
//  Created by lihongfeng on 16/7/28.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Category.h"
#import "SecondViewController.h"
#import "UIImage+Category.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSString *str = @"好感[face]和欧文和购物和欧冠和维护工额外";
    NSLog(@"---size1:%@", NSStringFromCGSize([str sizeWithFontOfSize:15]));
    NSLog(@"---size2:%@", NSStringFromCGSize([str sizeWithMaxSize:CGSizeMake(200, MAXFLOAT) FontOfSize:15]));
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, self.view.bounds.size.width-20, 30)];
//    label.attributedText = [str attributedStringWithColor:[UIColor redColor] addColor:[UIColor blueColor] range:NSMakeRange(3, 5)];
//    label.attributedText = [str attributedStringWithImage:[UIImage imageNamed:@"face"]
//                                                     size:CGSizeMake(25, 25)
//                                             replaceRange:NSMakeRange(3, 2)];
    label.attributedText = [str attributedStringWithPattern:@"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]" imageNames:@[@"[face]"]];
    [self.view addSubview:label];
    
//    UIImage *image = [UIImage imageWithSize:CGSizeMake(50, 50) color:[UIColor redColor] cornerRadius:0];
//    UIImage *resultImage = [[UIImage imageNamed:@"image1.png"] scaleImageToSize:CGSizeMake(100, 100) cornerRadius:20];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:resultImage];
//    imageView.frame = CGRectMake(100, 100, 100, 100);
//    [self.view addSubview:imageView];
    
    NSLog(@"-----%@", NSHomeDirectory());
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:[[SecondViewController alloc] init] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
