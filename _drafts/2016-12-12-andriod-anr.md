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

* `Service`启动过程超过一定时间（比如前台20秒）。
* `BroadcastReceiver`处理超过一定时间（比如前台10秒）。
* `ContentProvider`执行过程超过一定时间（比如设定10秒）。
* `Activity`在规定时间（5秒）内没有对输入事件（触摸、键盘、鼠标）做回应。

我们可以看到上面涵盖了四大组件和两大系统服务（`AMS`和`WMS`）。

## 如何避免ANR?

* UI线程尽量只做UI相关工作。
* 耗时工作（比如网络请求、I/O、数据库操作）放入其他线程执行（可以用AsyncTask）。
* 如果你自己实现`Thread`或`HandlerThread`，记得将其优先级调低一些（默认跟UI线程一样），通过设置Process.setThreadPriority(THREAD_PRIORITY_BACKGROUND)。
* 不要在UI线程里面执行如Thread.sleep()、Thread.wait()来等待工作线程的结果，可以用Handler来进行工作线程和UI线程进行结果传递。
* 由于`BroadcastReceiver`处理时间限制，里面如果需要耗时操作的最好用` IntentService`去处理。
* 可以使用`StrictMode`模式来发现潜在的耗时操作。

## 更进一步优化程序的流畅性。

* 可以将耗时操作放到后台执行，然后给个进度条。
* 一些耗时的计算，可以放到后台执行。
* 初始化很耗时的，可以在后台操作然后提示正在加载当中之类的信息。
* 利用性能优化工具如`Systrace`和`Traceview`来进一步找出程序的流畅度瓶颈。

## 如何分析ANR。

* 本地的话可以分析`/data/anr/traces.txt`日志。
* 线上版可以通过一些第三方插件，进入其后台分析日志。
