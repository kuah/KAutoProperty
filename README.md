# KAutoProperty
自动填充配置属性

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
