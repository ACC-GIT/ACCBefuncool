title: 简单图解JVM
date: 2016-11-27 10:42:18
tags: [java, JVM]
category: JVM
---

![](http://afirsraftgarrier.qiniudn.com/right.jpg?attname=&e=1480236491&token=_bRGh5Foxbj_EBD_6qKWwYFEIVjx7PZSluciwDIT:ARXkMyMEh5rAm_JXDJKVj1VQjVI)

# 前言

写了多年Java程序，有没有想过我们的程序的加载和执行流程是怎样的呢？里面有哪些结构呢？本文尝试总结一下这些内容。

# 我们的代码

先来看看一个简单的Java程序`Hello.java`：
```java
package com.acc.demo.java.hello;

/**
 * Created by AfirSraftGarrier on 2016/11/27 0027.
 */
public class Hello {
    public static void main(String args[]) {
        System.out.println("Hello, world!");
    }
}
```
平时我们觉得很简单，只需要点击开发工具上的`run`按钮，结果便出来了：
```
Hello, world!
```
但如果麻烦一点，用命令行的话，是这么个流程：
```shell
# 首先配置好java开发环境
# 编辑好Hello.java文件
javac Hello.java
java Hello
```
的到的结果是一样的。其实开发工具的`run`按钮，也就是命令行下执行`java`命令。这个命令将一切秘密打包了，直接给出我们想要的结果。这个背后的秘密，就是JVM。`java`这个命令，将会创建一个JVM实例，并将`javac`产生的`.class`字节码交给JVM做接下来的工作。好的，接下来正是进入JVM流程。

# JVM结构图解

###### JVM大致图解

###### JVM进一步图解

###### ClassLoader
###### 堆内存结构简述