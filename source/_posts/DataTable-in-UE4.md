---
title: 虚幻引擎中的数据表
date: 2023-09-09 15:38:57
tags: 
  - 虚幻引擎
  - 数据表
categories:
  - 虚幻引擎
---

- UE版本: 4.27.2, 系统: Windows

# 1. 数据表是什么？

数据表（DataTable）是UE4中的一种数据结构，它可以看成是键为`FName`、值为`UStruct`的map，通常用于保存结构化游戏数据。例如角色各等级升级需要的经验，不同怪物的攻击力、血量、防御、头像等数据，在初始化Actor时可以查询数据表来获取属性初值。

# 2. 数据表的创建和使用

## 2.1. 在编辑器中创建和使用数据表

**（1）手动创建数据表**

在UE编辑器的内容浏览器中点选 ***右键->其他->数据表格*** 即可创建数据表。
![创建数据表](1.png)

创建数据表时需要选择一种行结构 ，这种结构可以在编辑器中 ***蓝图->结构*** 直接创建，也可以在C++中创建`UStruct`。

**（2）导入数据生成数据表**

TODO

**（3）在蓝图中使用数据表**

需要在蓝图中使用数据表时，搜索“数据表格”（或"DataTable"）即可找到相关的蓝图节点。常用的蓝图节点有：

## 2.2. 在C++中定义和使用数据表

**（1）C++定义行结构**

要使用数据表就先要定义一个结构体作为数据表的行结构。要使结构体可以作为数据表的行结构，就需要继承`FTableRowBase`。 参考下面的代码示例：

```C++
USTRUCT(BlueprintType)
struct FMyTableRow : public FTableRowBase
{
    GENERATED_BODY()

    /** 字段示例 */
    UPROPERTY(EditEverywhere)
    float MyField;

    ...  // 添加其他字段
};
```

其中`USTRUCT`的`BlueprintType`说明符的作用是在蓝图中给这个结构体生成`Make`和`Break`节点，非必须；而字段MyField的`EditEverywhere`说明符的作用是使字段能在数据表中直接编辑，通常只添加到可手动修改的字段上。

**（2）C++定义数据表**

TODO

**（3）C++使用数据表**

数据表的C++类型是`UDataTable`，下面是一些常用的查表方法。更多方法可以直接查看`UDataTable`源码。

```C++
UDataTable* DataTable;
FName RowName = FName("RowName");
FString DebugMsg = FString("DebugMsg");

FMyRowStruct* RowData = DataTable->FindRow<FMyRowStruct>(RowName, DebugMsg);    // 查找特定行
TArray<FName> RowNames = DataTable->GetRowNames();                              // 获取所有行名
TArray<FMyRowStruct*> Rows;
DataTable->GetAllRows<FMyRowStruct>(DebugMsg, Rows);                            // 获取所有行
```

**（4）可能遇到的问题**

使用C++结构体作为行结构时可能出现一个问题，就是在UE编辑器中无法编辑数据表中的某些字段。
这时只需要将该字段`UPROPERTY`中`Category`标识符的分类深度缩减成一层就可以了 ，参考下面的代码示例。推测这是UE编辑器的一个Bug。

```C++
USTRUCT(BlueprintType)
struct FMyTableRow : public FTableRowBase
{
    GENERATED_BODY()

    /** 这个字段*无法*在数据表中编辑 */
    UPROPERTY(EditEverywhere, Category="Cate0|Cate1")
    float MyField1;

    /** 这个字段可以在数据表中编辑 */
    UPROPERTY(EditEverywhere, Category="Cate0")
    float MyField2;
};
```

# 3. 为什么要用数据表？
看了上面的介绍，可能你会觉得数据表不就是一个轻量的结构化数据集吗？为什么不用JSON、CSV这些格式来存储数据呢？  
数据表对于非程序人员比较友好。数据表与UE编辑器整合度高，可以在编辑器中直接编辑，并且在处理如类型、引用、材质纹理等资源时可以在编辑器内直接选择，方便快捷。
数据表可以导出成CSV，也可以通过导入CSV生成。