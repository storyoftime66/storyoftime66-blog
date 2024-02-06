---
title: "CommonUI: Activatable Widgets"
date: 2023-12-07 18:21:35
tags:
  - UI
  - CommonUI
categories:
  - 虚幻引擎
---


# Activatable Widget

`Activatable Widget`直译为可激活控件，它继承自`UCommonUserWidget`（这个类继承自`UUserWidget`），下面是它的简化结构。

```c++
// CommonActivatableWidget.h

class COMMONUI_API UCommonActivatableWidget : public UCommonUserWidget
{
    // ...

private:
    UPROPERTY(BlueprintReadOnly, Category = ActivatableWidget, meta = (AllowPrivateAccess = true))
    bool bIsActive = false;

    UPROPERTY(Transient)
    TArray<TWeakObjectPtr<UCommonActivatableWidget>> VisibilityBoundWidgets;

    ESlateVisibility ActivatedBindVisibility = ESlateVisibility::SelfHitTestInvisible;
    ESlateVisibility DeactivatedBindVisibility = ESlateVisibility::SelfHitTestInvisible;
    bool bAllActive = true;

    mutable FSimpleMulticastDelegate OnActivatedEvent;
    mutable FSimpleMulticastDelegate OnDeactivatedEvent;
    mutable FSimpleMulticastDelegate OnSlateReleasedEvent;
    mutable FSimpleMulticastDelegate OnRequestRefreshFocusEvent;
};
```

# Activatable Widget Container

顾名思义
