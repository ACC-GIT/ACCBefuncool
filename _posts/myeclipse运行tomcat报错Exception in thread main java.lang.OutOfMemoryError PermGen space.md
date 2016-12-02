title: myeclipse运行tomcat报错Exception in thread "main" java.lang.OutOfMemoryError->PermGen space
date: 2014-11-12 09:38:00
categories: 娱乐
tags: 
description:
---
将myeclipse所配置的tomcat的jdk进行设置：-Xms512m -Xmx512m -XX:MaxNewSize=512m -XX:MaxPermSize=512m，如下图：
![](http://img.blog.csdn.net/20141112093835890?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQWZpclNyYWZ0R2Fycmllcg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
