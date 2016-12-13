---
date: '2016-12-10 22:57 +0800'
published: true
title: Android多线程
category:
  - Android
tags:
  - Android
  - 多线程
---
## 线程是什么？

线程是进程内一个相对独立、可调度的执行单元，是系统调度和分配CPU的基本单位。一个线程包含四项：线程ID、当前指令指针、寄存器、堆栈。线程共享其所在进程的系统资源。线程有如下几种状态。

{% fi http://afirsraftgarrier.qiniudn.com/thread-status.png %}

## 多线程是什么？

多线程顾名思义是多个线程。为什么要有多线程？简单讲就是单线程只能做一件事，而多线程能同时做很多事。多个线程并发执行，可充分利用系统处理器资源，提升程序整体处理性能。比如在Android里面，我们有个耗时的下载任务，这件事不能放在主线程（UI线程）里面执行呢？答案显然不能，我们知道Android的UI线程是一个特殊的线程，不能在里面执行耗时的操作比如网络请求、I/O等，不然会出现比如[`ANR`](/2016/12/12/2016-12-12-andriod-anr)等错误，另外当UI线程在收到刷新界面信号的时候，如果之中执行了某个耗时操作，导致无法完成这次刷新操作，就会出现`掉帧`现象，也就是我们常说的卡顿（一般降到20fps的时候用户就明显感觉到），这样对于用户体验是非常不好的。于是想到要将耗时操作放到其他线程里面执行，而UI线程则可专注于UI的绘制。

## 有哪些方式实现Android多线程？

* 使用线程池。可以看[例子分析java.util.concurrent.ExecutorService](/2015/07/15/例子分析java.util.concurrent.ExecutorService/)做进一步了解。

## 工作线程与UI线程如何通信？

## Android多线程要注意什么问题？

* 在工作线程里面不能更新UI。Android里面通过[`ViewRootImpl.checkThread`](http://androidxref.com/7.0.0_r1/xref/frameworks/base/core/java/android/view/ViewRootImpl.java#checkThread)来确保这点。下面为为什么不能这么做的一些原因。
	* 程序领域的解耦。
   * 线程同步开销。
   * 容易出现死锁。
* 注意降低设置工作线程的优先级，这样减少影响UI线程。
* 注意线程安全问题，保证数据一致性。
* 注意使用`synchronized`的方式，能少就少，因为同步会影响性能。
* 注意避免死锁问题。
* 线程不是越多越好，要注意管理好线程，达到效益最大化。
	* 为什么不能过多原因如下。
		* 一个线程至少消耗掉64k内存。
      * 和UI线程抢CPU资源。
      * CPU在线程间切换的消耗。
   * 如何制定线程使用策略。
		* 比如AsyncTask，所有的AsyncTask使用的是同一个任务队列，默认这个队列是以普通线程方式线性执行的，可以通过接口`AsyncTask.executeOnExecutor`来用线程池。
      * 对于线程池，要根据自己的情况选用合理的线程池策略，控制好并发数量，既能充分利用系统资源，也不会对UI线程造成太大影响。
 * 注意`AsycTask`和`cancel`其实并没有真正可以取消任务，要通过`isCancelled`来判断是否已经退出任务。
 * 注意内存泄漏问题。根据GC规则，Thread属于[GC root](http://stackoverflow.com/questions/6366211/what-are-the-roots)，如果正在运行中是不能被回收的，如果工作线程持有UI线程对象，该对象也不会得到回收。这里面涉及到显式引用和隐式引用的问题。
 	* 显示引用，比如将View或者Activity传至工作线程。这样很可能由于工作线程还在使用当中，其里面的引用的Activity退出后并没有得到回收，产生内存泄漏。（传View还有个常见问题是，当在UI线程里面从ViewHierarchy移除该View后，在工作线程里面再操作该View就会出现问题。对于这部分，有个准则就是，尽量不要在工作线程持有View引用）
    	* 对于需要`context`的，可以传`Application`的`context`。
    	* 可以用弱引用，这样的引用是可以随时被回收的。
 	* 隐式引用，由于非静态内部类会隐式持有其外部类的引用，所以也会有可能产生内存泄漏问题。比如某个AsyncTask如果是作为非静态内部类来使用，如果这个AsyncTask还在运行当中，就算其外部类Activity退出了也不会被回收。
    	* 解决方法是用静态内部类代替。
* 
   
 
