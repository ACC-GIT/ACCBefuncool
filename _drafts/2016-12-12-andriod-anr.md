---
date: '2016-12-12 06:43 +0800'
published: true
title: Android的ANR
category:
  - Android
tags:
  - Android
---
## ANR是什么？

ANR在Android里指Application not responding。用户可以终止程序，也可以继续等待。

{% fi http://afirsraftgarrier.qiniudn.com/ANR.jpg %}

## 思考ANR。

我们知道，Android应用程序是以`Message`（消息）驱动的，在应用程序的[`ActivityThread`](http://androidxref.com/7.0.0_r1/xref/frameworks/base/core/java/android/app/ActivityThread.java#6041)（主线程或称UI线程）内部有个`Looper`（循环）对`MessageQueue`（消息队列）进行处理，如果Android监测到应用程序的消息处理没有在规定时间内完成，就会弹出提示框让用户选择。

## 什么情况会出现ANR?

* 

## 如何避免ANR?

## 如何分析ANR。
