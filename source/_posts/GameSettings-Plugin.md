---
title: GameSettings插件
date: 2023-11-24 10:38:54
tags:
- 插件
- UI
- settings
categories:
- 虚幻引擎
---

虚幻的学习项目《Lyra》中包含很多没上虚幻商城的插件。GameSettings是其中用来处理游戏设置相关逻辑的插件。

[UE5.2的官方文档](https://docs.unrealengine.com/5.2/zh-CN/lyra-sample-game-settings-in-unreal-engine/)中也有一点对GameSettings插件的描述，但目前内容还不够完善，插件的功能和使用方法还需要自己探索。


# 结构

主要类 | 说明
--- | --- 
UGameSettingRegistry | 包含多个UGameSettingCollection
UGameSettingCollection | 一个设置集合，可以包含多个UGameSetting，通常是同一个功能模块的设置，如画面设置、声音设置等
UGameSetting | 一个设置项，通常包含一个UGameSettingValue
UGameSettingValue | 一种类型的设置值

UI相关类和资产 | 说明
---|---
UGameSettingPanel | 
UGameSettingListEntryBase | 
UGameSettingVisualData | 数据资产，连接UGameSettingListEntryBase和UGameSetting
FGameSettingDataSource | 单条设置的数据来源

# UGameSettingCollection
UGameSettingCollection继承自UGameSetting

Initialize(LocalPlayer)
