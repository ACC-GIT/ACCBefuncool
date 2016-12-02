title: 例子分析java.util.concurrent.ExecutorService
date: 2015-07-15 14:33:00
categories: 娱乐
tags: [ExecutorService, 线程, Thread, newSingleThreadExecu, newCachedThreadPool]
description:
---
前言：ExecutorService是一个Executor，官方解释是An object that executes submitted Runnable tasks...This interface provides a way of decoupling task submission from the mechanics of how each task will be run, including details of thread
 use, scheduling, etc....，大概意思是用来执行提交的Runnable，可以代替对Thread的一系列创建、执行、销毁等操作。简单说它就是一个线程池，为方便管理线程而生。
例子：下面先给出例子的代码，后面再分析：


```java
	private static int BEGIN = 0;

	public static void excute(ExecutorService executorService, int excuteSize) {
		for (int i = 0; i < excuteSize; i++) {
			final int index = i;
			final int indexName = BEGIN + index;
			try {
				executorService.execute(new Runnable() {

					@Override
					public void run() {
						try {
							Thread.sleep(100);
							System.out.println("success:" + indexName);
						} catch (InterruptedException interruptedException) {
							System.out.println("InterruptedException:"
									+ indexName);
						}
					}
				});
			} catch (RejectedExecutionException rejectedExecutionException) {
				System.out.println("RejectedExecutionException:" + indexName);
			}
		}
		BEGIN += excuteSize;
	}

	private static void shutdown(ExecutorService executorService) {
		System.out.println("shut down");
		executorService.shutdown();
	}

	private static void shutdownnow(ExecutorService executorService) {
		System.out.println("shut down now with rest size:"
				+ executorService.shutdownNow().size());
	}

	private static void test(ExecutorService executorService,
			boolean isShutdownnow, int size) {
		excute(executorService, size);
		try {
			Thread.sleep(50);
		} catch (InterruptedException e) {
		}
		if (isShutdownnow) {
			shutdownnow(executorService);
		} else {
			shutdown(executorService);
		}
		excute(executorService, 2);
	}

	private static void testShutdown(ExecutorService executorService, int size) {
		test(executorService, false, size);
	}

	private static void testShutdownnow(ExecutorService executorService,
			int size) {
		test(executorService, true, size);
	}
```
（这个例子excute(ExecutorService executorService, int excuteSize)方法会对一个executorService提交excuteSize个任务，testShutdown是测试shutdown方法，testShutdownnow是测试shutdownnow方法。）
分析：1 先来看ExecutorService的创建方法。
a) newSingleThreadExecutor顾名思义是管理单个Thread的Executor，也就是说线程池里面只有一个Thread，这样提交的任务按顺序依次执行。
    测试一下，执行excute(Executors.newSingleThreadExecutor(), 10000)将得到下面的打印信息：


```html
	success:0
	success:1
	success:2
	success:3
	success:4
	...
	success:97
	success:98
	success:99
```
这样可以清楚的看到它是严格按照Runnable提交的顺序执行的，并且看下调试得到的线程使用情况：
 ![](http://img.blog.csdn.net/20150708151734356?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
可以看到一只是只有一个Thread，并且注意到当程序执行完成时，Thread并没有停止，可见Thread仍然被ExecutorService管理着。
b) newFixedThreadPool 可以猜想是一个固定线程数量的线程池，相比newSingleThreadExecutor可以设定线程数量。
    测试一下，执行excute(Executors.newFixedThreadPool (3), 100)将得到下面的打印信息：


```html
	success:0
	success:1
	success:2
	success:4
	success:3
	success:5
	success:6
	success:8
	success:7
	...
	success:94
	success:93
	success:96
	success:98
	success:97
	success:99
```
可以看到0、1、2虽然按照顺序，4、3、5就乱了，也就是说，其实是形成了一个队列，有三个活动的线程提供执行，当某个线程执行完后，执行下一个队列里面的。
看下调试得到的线程使用情况：

![](http://img.blog.csdn.net/20150708154132044?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
可以看到一直有三个活动的线程。
c)  newCachedThreadPool 来看它的解释：Creates a thread pool that creates new threads as needed, but will reuse previously constructed threads when they are available. These pools will typically improve the performance of programs
 that execute many short-lived asynchronous tasks.就是说来一个Runnable，首先看有没有可用的Thread，如果没有，就创建一个Thread来执行。这样确实只适合短期Runnable，如果是长期的话，很容易出现创建线程数量超过限制，导致程序崩溃。
题外：我们都知道JVM可开的线程数肯定是有限制的，主要受下面因素限制：


```html
	-Xms		intial java heap size
	-Xmx		maximum java heap size
	-Xss		the stack size for each thread
	系统限制	系统最大线程数
```
（也就是由于JVM堆和栈以及其所在系统的限定，具体不实验，可以自己查阅相关资料深入了解）
测试一下，执行excute(Executors.newCachedThreadPool (), 100)将得到下面的打印信息：


```html
	success:0
	success:1
	success:6
	success:2
	success:3
	success:4
	success:8
	...
	success:99
	success:79
	success:83
	success:92
	success:88
```


可以看到0~99都没有顺序，也就是说，至少形成了100个线程。
可以看下调试得到的线程使用情况：
![](http://img.blog.csdn.net/20150714152856658?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
......这里省略......
![](http://img.blog.csdn.net/20150714152905046?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
特别提醒：非常奇妙的一点，与newSingleThreadExecutor和newFixedThreadPool不同，newCachedThreadPool产生的Thread经过一段时间空闲后，会自动destroy。
这也许是跟newCachedThreadPool的特性有关，如果不自动destroy，则可想而知这个线程池积累的线程有可能越来越多，最后系统崩溃。
d) newCachedThreadPool(ThreadFactory threadFactory),newSingleThreadExecutor(ThreadFactory threadFactory),newFixedThreadPool(int nThreads, ThreadFactory threadFactory)
解释：这种方法我们可以提供给我们创建Thread的方法，同时又具有对应的接口特性。
测试：执行
excute(Executors.newCachedThreadPool(new ThreadFactory() {


@Override
public Thread newThread(Runnable r) {
return new Thread(r);
}
}), 5);
      将得到下面打印信息：


```html
	success:1
	success:0
	success:3
	success:2
	success:4
```
结论：我们可以看到上面每来一个Runnable r就简单的return new Thread(r)，我们看到打印信息具有newCachedThreadPool的特性，超过一定的时间后自动destroy。
2 再来看ExecutorService的销毁方法。
a) shutdown
解释：Initiates an orderly shutdown in which previously submitted tasks are executed, but no new tasks will be accepted. 这个方法有点坑，他只是拒绝shutdown调用后提交的Runnable，已经提交的还是要执行完。
测试：执行testShutdown(Executors.newSingleThreadExecutor(), 5)将得到下面打印信息：

```html
	shut down
	RejectedExecutionException:5
	RejectedExecutionException:6
	success:0
	success:1
	success:2
	success:3
	success:4
```
结论：完全验证上面的解释，后面提交的5、6序号的Runnable报错RejectedExecutionException，而前面提交的都执行了，虽然还没执行完就执行了shut down。
b) shutdownnow
解释：Attempts to stop all actively executing tasks, halts the processing of waiting tasks, and returns a list of the tasks that were awaiting execution. 可以看到它会尝试关闭正在执行的Runnable，停止执行等待的Runnable，最后也像
shutdown一样，拒绝shutdownnow调用后提交的Runnable。
测试：执行testShutdownnow(Executors.newSingleThreadExecutor(), 100)将得到下面打印信息：

```html
	InterruptedException:0
	shut down now with rest size:4
	RejectedExecutionException:5
	RejectedExecutionException:6
```
结论：可以看到首先是停止正在执行的序号为0的Runnable被interupt了，正在等待的1，2，3，4的Runnable没有执行，直接返回shut down now with rest size:4，shutdownnow后提交的5，6被拒绝了。源码：[请多关注。](https://github.com/AfirSraftGarrier/ACCDemoJava/blob/master/src/com/acc/demo/java/pre/ExecutorServiceTest.java)
