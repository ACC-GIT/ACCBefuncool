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

[ANR](https://developer.android.google.cn/training/articles/perf-anr.html#anr)在Android里指Application not responding。用户可以终止程序，也可以继续等待。

{% fi http://afirsraftgarrier.qiniudn.com/ANR.jpg %}

## 思考ANR。

我们知道`Application`无非就是四大组件：`Activity`、`Service`、`BroadcastReceiver`、`ContentProvider`。怎么觉察到`not responding`，当然是通过系统服务来监测和处理，主要是运行在系统进程的负责组件的`AMS`(ActivityManagerService)和负责输入的`WMS`(WindowManagerService)，这些系统服务会在与组件交互的过程中进行监测，例如启动各组件的时候，或者是触摸屏幕事件分发的时候，如果没有在规定的时间内完成，就会触发ANR，这个ANR有可能只是后台做了记录，有可能是最终由`AMS`来处理，弹出ANR对话框。


## 什么情况会出现ANR?

* 

## 如何避免ANR?

## 如何分析ANR。
