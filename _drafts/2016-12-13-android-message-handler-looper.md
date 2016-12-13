---
date: '2016-12-13 11:34 +0800'
published: true
title: Android消息通信机制
category:
  - Android
tags:
  - Android
---
## Android消息通信机制是什么？

我们知道Android进程间通信机制（IPC）用的是大名鼎鼎的Binder，撑起了Android整个江山（关于什么是Binder，可以看看这篇[经典](http://blog.csdn.net/universus/article/details/6211589)）。而在进程内部，线程之间用什么通信呢？那就是`Looper`+`Handler`+`Message`，这也就是Android应用赖以生存的消息通信机制。

## 如何理解Android消息通信机制？

怎么实现线程间的通信？比较合理的做法是本线程有个消息队列，其他线程可以对这个消息队列做添加删除等操作，本线程则从队列里面取出任务进行处理，这大概就是`Looper`+`Handler`+`Message`所干的事情。

Android应用可以说是以消息驱动的，我们可以看下主线程`ActivityThread`的[代码](http://androidxref.com/7.0.0_r1/xref/frameworks/base/core/java/android/app/ActivityThread.java#204)。里面有个`Looper`成员变量。我们还可以看看其`main`[函数](http://androidxref.com/7.0.0_r1/xref/frameworks/base/core/java/android/app/ActivityThread.java#6041)

```
```
我们知道，Android应用程序是以`Message`（消息）驱动的，在应用程序的[`ActivityThread`](http://androidxref.com/7.0.0_r1/xref/frameworks/base/core/java/android/app/ActivityThread.java#6041)（主线程或称UI线程）内部有个`Looper`（循环）对`MessageQueue`（消息队列）进行处理。



