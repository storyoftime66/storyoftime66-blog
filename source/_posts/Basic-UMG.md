---
title: UMG基础
date: 2024-01-24 14:10:10
tags:
  - UMG
  - UI
categories:
  - 虚幻引擎
---

# 用户控件的生命周期

## 蓝图中的生命周期事件

我们将继承自用户控件(`UUserWidget`)的蓝图都称为用户控件。  
下面列出的几个是用户控件带有的用于控制生命周期的事件，这几个事件也可以下面生命周期示意图中找到对应的C++函数。

![用户控件中的事件](用户控件事件.png)

其中，  
`事件初始化`在**控件创建时**立即触发，`事件预构造`和`事件构造`在控件被**添加到视口**，或成为**已添加到视口的面板控件**的子项时触发。  
`事件Tick`在控件**对用户可见**时触发。  
`事件解构`在控件**从视口移除**，或**从已添加到视口的面板控件移除**时触发。

`事件初始化` `事件预构造` `事件构造`都可以用于控件的初始化，但由于控件可能会被多次从添加到视口和从视口移除，所以只需要执行一次的初始化逻辑可以放到`事件初始化`中完成。
那么`事件预构造` `事件构造`又有什么区别呢？`事件预构造`在**编译控件蓝图**时也会触发，它的本意是用来方便UI设计的，如果在控件样式相关的初始化逻辑放在`事件预构造`中，编译蓝图后样式变化会直接反映在设计器中，使开发者不需要运行游戏也可以预览UI样式。

小结，若要初始化用户控件，对于只需要执行一次的逻辑，最好放到`事件初始化`中执行；对于样式相关的逻辑，放到`事件预构造`中可以直接预览到样式的变化。


## C++中的生命周期函数

用户控件生命周期函数：
```
virtual bool Initialize();
virtual void NativeOnInitialized();
virtual void NativePreConstruct();
virtual void NativeConstruct();
virtual void NativeTick(const FGeometry& MyGeometry, float InDeltaTime);
virtual void NativeDestruct();
virtual void BeginDestroy() override; // virtual void RemoveFromParent();
```

下面是用户控件生命周期的示意图，其中蓝色部分代表会暴露到蓝图的函数。
![用户控件的生命周期](用户控件的生命周期.png)


## 用户控件内变量的初始化

在用户控件中创建变量后，可以发现变量有很多属性。
![变量属性](变量属性.png)
以上属性中，“*可编辑实例*”“*生成时公开*”与变量的初始值有关。  
勾选*可编辑实例*后，可在控件实例的细节窗口中设置该变量的初始值，如下图所示。
![可编辑实例](可编辑实例.png)

勾选*生成时公开*后，在使用`创建控件(CreateWidget)`节点创建该控件时，会有变量对应的引脚出现，如下图所示。
![生成时公开](生成时公开.png)

以上两种变量值设置的时间点有所不同，*可编辑实例*变量的默认值是保存在硬盘里的，在加载父控件时会一并加载，所以*可编辑实例*变量在`事件初始化`时就已经具有默认值。  
*生成时公开*则不同，这类变量是控件创建后才传入的值，所以在`事件初始化(OnInitialized)`时值还未设置成传入的值，此时读取的话只能读取到在控件蓝图中设置的默认值。在`创建控件(CreateWidget)`节点执行完成后，则可以读取到正确的值。显然，若控件需要动态传入的值进行初始化，则不可以在`事件初始化`中进行初始化，仅可在`事件预构造`或`事件构造`进行。


# 控件的属性

## 可视性

可视性 | 是否绘制 | 是否影响布局 | 是否可点击
---|---|---|---
可视 | ✓ | ✓ | ✓
已折叠 | × | × | ×
隐藏 | × | ✓ | ×
非可命中测试 | ✓ | ✓ | × 
