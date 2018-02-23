//
//  ViewController.m
//  KAuto
//
//  Created by 陈世翰 on 2018/2/9.
//  Copyright © 2018年 Kuah. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+KuahAutoProperty.h"
@protocol a @end
@interface ViewController ()
@property (nonatomic,strong)UIView <kap,a> *testview;
@property (nonatomic,strong)NSMutableArray $$ *marr;
@property (nonatomic,strong)NSArray $$ *arr;
@property (nonatomic,strong)UITextView <kap> *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self kap];
    
    [self.marr addObject:@"a"];
    NSLog(@"%@",self.marr);
    self.textView.text = @"1";
    NSLog(@"%@",self.textView.text);
}
@end
