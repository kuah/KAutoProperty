# KAutoProperty
自动填充配置属性

## Preface
你的代码只要是符合国家标准，少用xib的话。那么，你肯定遇到下面`绝望`的情况~~~ 那么，这个库就能很大程度上帮到你~!
```
    self.headImageView = [UIImageView new];
    self.userNameLabel = [UILabel new];
    self.sex_ageView = [UIButton new];
    self.sexImageView= [UIImageView new];
    self.ageLabel = [UILabel new];
    self.arrowImageView = [UIImageView new];
    self.topView = [UIView new];
    self.actionLabel = [UILabel new];
    self.groupNameLabel = [UILabel new];
    self.timeLabel = [UILabel new];
    self.descLabel = [UILabel new];
    line1 = [UIView new];
    self.refuseButton = [UIButton new];
    self.agreeButton = [UIButton new];
    self.contentView = [UIView new];
```

## Example
```
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
```

## Install
```
pod 'KAutoProperty'

//version   版本2开头为yykit版 其余开头的为yymodel版
```

## Usage
### 导入头文件
```
#import "NSObject+KuahAutoProperty.h"
```
### 遵循协议
> 使用 `$$` 或 `<kap>`
```
@property (nonatomic,strong)NSArray $$ *arr;
@property (nonatomic,strong)UITextView <kap> *textView;
```
### 调用kap，一键加载
> kap方法可以放在自己喜欢的位置调用，但应该在`属性还没加载`和`还没有任何操作`的时刻去调用
```
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self kap];
}
```
