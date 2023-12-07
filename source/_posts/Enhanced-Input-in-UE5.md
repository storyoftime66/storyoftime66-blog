---
title: UE5中的增强输入
date: 2023-11-23 13:34:58
tags:
  - 输入
  - 增强输入
categories:
  - 虚幻引擎
---

# 核心概念
1. **InputAction 输入动作，以下简称`IA`**
    输入动作是一个抽象的概念，比如在游戏中，开门、拾取、射击都可以作为一个输入动作。
2. **InputMappingContext 输入映射上下文，以下简称`IMC`**
    输入映射顾名思义，就是**物理按键到`IA`的映射**，比如按“A”键可以向左移动、按“F”键可以进行拾取等。
    输入映射上下文包含一系列物理按键到`IA`的映射。

3. **PlayerMappableInputConfig 玩家可映射输入配置，以下简称`PMI`**
    玩家可映射输入配置实质上是一组`IMC`组成的集合。

4. Modifier 修饰器

5. Trigger 触发器

# Lyra输入系统

封装对应关系以及职能：
```
FMappableConfigPair -> UPlayerMappableInputConfig

ULyraHeroComponent -|> TArray<FMappableConfigPair> (TArray<UPlayerMappableInputConfig>)

ULyraPawnData (Asset) -> ULyraInputConfig (Asset) -> TArray<UInputAction> Native, TArray<UInputAction> Ability

```