title: Android studio启动报错：'tools.jar' seems to be not in Android Studio classpath.
date: 2015-05-21 16:05:00
categories: 娱乐
tags: [Android studio, 启动, 报错, tools.jar, classpath]
description:
---
原因可能是安装了不同版本的java，这个错误目前找到的解决方法是：将`%JAVA_HOME%/lib/tools.jar`拷贝到Android studio安装目录的lib包下。
   