title: maven报错Unsupported major.minor version 52.0
date: 2015-05-24 23:01:00
categories: 娱乐
tags: [maven, major.minor, java8, jdk, JAVA_HOME]
description:
---
原因：工程里面有用到java8，但是maven使用的默认jdk不是java8。
解决：安装java8，并配置JAVA_HOME等环境变量。