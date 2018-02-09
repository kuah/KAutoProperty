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
@protocol b @end
@protocol c @end
@interface ViewController ()
/**
 *   <#decr#>
 */
@property (nonatomic,strong)UIView <kap,a> *viewq;
/**
 *   <#decr#>
 */
@property (nonatomic,assign)CGFloat flo;
/**
 *   <#decr#>
 */
@property (nonatomic,assign)CGRect r;
/**
 *   <#decr#>
 */
@property (nonatomic,assign)CGPoint p;
/**
 *
 */
@property (nonatomic,assign)CGSize *s;
/**
 *   <#decr#>
 */
@property (nonatomic,assign)NSUInteger *uin;
/**
 *   <#decr#>
 */
@property (nonatomic,assign)float fff;
/**
 *   <#decr#>
 */
@property (nonatomic,assign)long long  lll;
/**
 *   <#decr#>
 */
@property (nonatomic,copy)NSString *string;

/**
 *   <#decr#>
 */
@property (nonatomic,copy)id<UITextViewDelegate> delegate;
/**
 *   <#decr#>
 */
@property (nonatomic,strong)id ddddd;

/**
 *   <#decr#>
 */
@property (nonatomic,strong)NSNumber $$ *num;
/**
 *   <#decr#>
 */
@property (nonatomic,strong)NSSet $$ *set;
/**
 *   <#decr#>
 */
@property (nonatomic,strong)NSMutableArray $$ *marr;
/**
 *   <#decr#>
 */
@property (nonatomic,strong)NSArray $$ *arr;
/**
 *   <#decr#>
 */
@property (nonatomic,strong)UITextView <kap> *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self kap];
    NSLog(@"a");
    [self.marr addObject:@"a"];
    NSLog(@"%@",self.marr);
    self.textView.text = @"1";
    NSLog(@"%@",self.textView.text);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
