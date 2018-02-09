# KAutoProperty
自动填充配置属性

![](http://upload-images.jianshu.io/upload_images/2170902-bd2ac34e6a90ddf0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

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
