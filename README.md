# MKWaveButton
一个优雅的水波纹 UIButton

![waveBtn](http://7xtc4k.com1.z0.glb.clouddn.com/waveBtn-1.gif)

[欢迎 star ](https://github.com/maker997/MKWaveButton)
 看到很多安卓 APP 的 按钮带有这种点击效果忍不住写了一个看看

<!---more--->
>使用

```
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(100, 100, 250, 60);
    [self.view addSubview:button];
    [button setTitle:@"点我" forState:0];
    [button setTitleColor:[UIColor blueColor] forState:0];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    
    //水波纹效果
    button.isShowWave = YES;

```

>想实现的效果

*  给 UIButton 增加一个水波纹的图层来展示这个波纹
*  给 UIButton 增加一个属性用来是否显示水波纹效果

>想到的方案

* 方案一: 自定义 UIButton
* 方案二: 给 UIButton 添加一个分类,利用Runtime给 UIButton 添加属性,交换方法达到想要的效果

>方案对比
 
*  方案一的优点: 实现起来比较顺滑,容易理解.
*  方案一的缺点: 别人想使用波纹效果,必须使用这个自定义的 UIButton.如果项目中已经使用了系统的 UIButton 想使用这种效果.还得修改以前代码.
*  方案二的优点: 使用简单,不用修改之前的代码.
*  方案二的缺点: 开始不容易想到,想到了就好了啊.

>实现思路

1. 要给 button 添加两个属性. 
`isShowWave`: 是否显示水波纹
`waveView`: 水波纹视图
2. 实现这个两个属性的 setter,getter 方法.配合 runtime 动态添加属性
3. `+ (void)load` 方法中实现方法交换
4. `- (instancetype)initWithFrame:(CGRect)frame`为了保证水波视图只创建一次,就从系统的这个方法中创建
5. `- (void)setFrame:(CGRect)frame`这个方法中可以拿到 UIButton 的大小,从这个方法中设置波纹视图的大小比较合适
6. `- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event` 这个方法中可以拿到手势,从这个方法中可以设置水波视图的开始显示的位置,并做动画.比较合适.
7. 所以要写三个自己的方法用 runtime 替换到系统的方法

>难点

 1. 找到合适的系统的方法
 2. `objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)`给属性添加方法
    `objc_getAssociatedObject(id object, const void *key)`获取类的属性方法
 3. `method_exchangeImplementations(Method m1, Method m2)`交换方法的实现
 4. `class_addMethod(__unsafe_unretained Class cls, SEL name, IMP imp, const char *types)`给类添加方法


